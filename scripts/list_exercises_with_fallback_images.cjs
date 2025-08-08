console.log('Script started');
require('dotenv').config();
console.log('SUPABASE_URL:', process.env.SUPABASE_URL);
console.log('SUPABASE_ANON_KEY:', process.env.SUPABASE_ANON_KEY ? '***' : 'MISSING');

const { createClient } = require('@supabase/supabase-js');
const fs = require('fs');
const path = require('path');

const SUPABASE_URL = process.env.SUPABASE_URL || 'http://127.0.0.1:54321';
const SUPABASE_ANON_KEY = process.env.SUPABASE_ANON_KEY;

const FALLBACK_IMAGES = [
  '/images/exercise/push_ups.png',
  '/images/exercise/default.png',
  '/images/default.png',
  '',
  null,
  undefined
];

const IMAGES_DIR = path.join(__dirname, '../public/images/exercise');

function fileExistsSync(filePath) {
  try {
    return fs.existsSync(filePath);
  } catch {
    return false;
  }
}

async function main() {
  const supabase = createClient(SUPABASE_URL, SUPABASE_ANON_KEY);
  const { data, error } = await supabase
    .from('category_exercises')
    .select('exercise_name, exercise_data');

  console.log('Fetch result:', { error, count: data ? data.length : 0 });

  if (error) {
    console.error('Error fetching exercises:', error);
    process.exit(1);
  }

  let fallbackCount = 0;
  let missingCount = 0;
  let total = data.length;
  const fallbackExercises = [];
  const missingExercises = [];
  let mismatchCount = 0;
  const mismatchedExercises = [];
  let updatedCount = 0;
  const updates = [];

  function normalizeName(name) {
    return name
      .toLowerCase()
      .replace(/[^a-z0-9]+/g, '_')
      .replace(/^_+|_+$/g, '') + '.png';
  }

  let autoFixedCount = 0;
  const autoFixed = [];

  for (const row of data) {
    const name = row.exercise_name;
    const imageUrl = row.exercise_data?.image_url;
    // Check for fallback/missing as before
    if (FALLBACK_IMAGES.includes(imageUrl)) {
      fallbackCount++;
      fallbackExercises.push({ name, imageUrl });
      // Try to auto-fix
      const normalized = normalizeName(name);
      const expectedPath = `/images/exercise/${normalized}`;
      const absPath = path.join(IMAGES_DIR, normalized);
      if (fileExistsSync(absPath)) {
        // Update DB if file exists
        const updateRow = async () => {
          const { data: rows, error } = await supabase
            .from('category_exercises')
            .select('id, exercise_data')
            .eq('exercise_name', name);
          if (error || !rows || rows.length === 0) {
            console.error(`Failed to fetch row for auto-fix: ${name}`);
            return;
          }
          const rowToUpdate = rows[0];
          const newExerciseData = { ...rowToUpdate.exercise_data, image_url: expectedPath };
          const { error: updateError } = await supabase
            .from('category_exercises')
            .update({ exercise_data: newExerciseData })
            .eq('id', rowToUpdate.id);
          if (updateError) {
            console.error(`Failed to auto-fix image_url for ${name}:`, updateError);
          } else {
            autoFixedCount++;
            autoFixed.push({ name, oldUrl: imageUrl, newUrl: expectedPath });
            console.log(`Auto-fixed ${name}: ${imageUrl} -> ${expectedPath}`);
          }
        };
        // Schedule update (since for loop can't be async)
        updateRow();
      }
    } else if (!imageUrl) {
      missingCount++;
      missingExercises.push({ name, imageUrl });
    } else {
      // Check for mismatch
      const normalized = normalizeName(name);
      const expectedPath = `/images/exercise/${normalized}`;
      if (imageUrl !== expectedPath) {
        mismatchCount++;
        mismatchedExercises.push({ name, imageUrl, expectedPath, row });
        // Prepare update
        updates.push({ id: row.id, name, oldUrl: imageUrl, newUrl: expectedPath });
      }
    }
  }

  // Wait for all auto-fix updates to complete
  setTimeout(() => {
    console.log(`\nAuto-fixed exercises: ${autoFixedCount}`);
    if (autoFixed.length > 0) {
      console.log('\n--- Auto-fixed exercises ---');
      autoFixed.forEach(e =>
        console.log(`- ${e.name}\n  oldUrl: ${e.oldUrl}\n  newUrl: ${e.newUrl}`)
      );
    }
  }, 2000);

  // Perform updates in DB
  if (updates.length > 0) {
    console.log(`\nUpdating ${updates.length} mismatched image URLs in the database...`);
    for (const update of updates) {
      // Fetch the row again to get the full exercise_data
      const { data: rows, error } = await supabase
        .from('category_exercises')
        .select('id, exercise_data')
        .eq('exercise_name', update.name);
      if (error || !rows || rows.length === 0) {
        console.error(`Failed to fetch row for update: ${update.name}`);
        continue;
      }
      const rowToUpdate = rows[0];
      const newExerciseData = { ...rowToUpdate.exercise_data, image_url: update.newUrl };
      const { error: updateError } = await supabase
        .from('category_exercises')
        .update({ exercise_data: newExerciseData })
        .eq('id', rowToUpdate.id);
      if (updateError) {
        console.error(`Failed to update image_url for ${update.name}:`, updateError);
      } else {
        updatedCount++;
        console.log(`Updated ${update.name}: ${update.oldUrl} -> ${update.newUrl}`);
      }
    }
  }

  console.log(`\nTotal exercises: ${total}`);
  console.log(`Exercises with fallback image: ${fallbackCount}`);
  console.log(`Exercises with missing image: ${missingCount}`);
  console.log(`Exercises with image URL/name mismatch: ${mismatchCount}`);
  console.log(`Exercises updated: ${updatedCount}`);

  if (fallbackExercises.length > 0) {
    console.log('\n--- Exercises with fallback image ---');
    fallbackExercises.forEach(e => console.log(`- ${e.name} (${e.imageUrl})`));
  }
  if (missingExercises.length > 0) {
    console.log('\n--- Exercises with missing image ---');
    missingExercises.forEach(e => console.log(`- ${e.name}`));
  }
  if (mismatchedExercises.length > 0) {
    console.log('\n--- Exercises with image URL not matching normalized name ---');
    mismatchedExercises.forEach(e =>
      console.log(`- ${e.name}\n  imageUrl: ${e.imageUrl}\n  expected: ${e.expectedPath}`)
    );
  }
}

main(); 