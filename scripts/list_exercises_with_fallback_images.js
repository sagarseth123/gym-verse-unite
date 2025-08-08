// scripts/list_exercises_with_fallback_images.js
require('dotenv').config();
const { createClient } = require('@supabase/supabase-js');

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

async function main() {
  const supabase = createClient(SUPABASE_URL, SUPABASE_ANON_KEY);
  const { data, error } = await supabase
    .from('category_exercises')
    .select('exercise_name, exercise_data');

  if (error) {
    console.error('Error fetching exercises:', error);
    process.exit(1);
  }

  let fallbackCount = 0;
  let missingCount = 0;
  let total = data.length;
  const fallbackExercises = [];
  const missingExercises = [];

  for (const row of data) {
    const name = row.exercise_name;
    const imageUrl = row.exercise_data?.image_url;
    if (FALLBACK_IMAGES.includes(imageUrl)) {
      fallbackCount++;
      fallbackExercises.push({ name, imageUrl });
    } else if (!imageUrl) {
      missingCount++;
      missingExercises.push({ name, imageUrl });
    }
  }

  console.log(`\nTotal exercises: ${total}`);
  console.log(`Exercises with fallback image: ${fallbackCount}`);
  console.log(`Exercises with missing image: ${missingCount}`);

  if (fallbackExercises.length > 0) {
    console.log('\n--- Exercises with fallback image ---');
    fallbackExercises.forEach(e => console.log(`- ${e.name} (${e.imageUrl})`));
  }
  if (missingExercises.length > 0) {
    console.log('\n--- Exercises with missing image ---');
    missingExercises.forEach(e => console.log(`- ${e.name}`));
  }
}

main(); 