const fs = require('fs');
const path = require('path');
const fetch = require('node-fetch');
const { createClient } = require('@supabase/supabase-js');
require('dotenv').config();

const SUPABASE_URL = process.env.SUPABASE_URL || 'http://127.0.0.1:54321';
const SUPABASE_ANON_KEY = process.env.SUPABASE_ANON_KEY;
const GEMINI_API_KEY = process.env.GEMINI_API_KEY;
const IMAGE_DIR = path.join(__dirname, '../public/images/exercise');

if (!GEMINI_API_KEY) {
  console.error('❌ No GEMINI_API_KEY found in environment. Exiting.');
  process.exit(1);
}

function normalizeName(name) {
  return name
    .toLowerCase()
    .replace(/[^a-z0-9]+/g, '_')
    .replace(/^_+|_+$/g, '') + '.png';
}

async function generateExerciseImage(exerciseName, fileName) {
  try {
    const prompt = `Create a simple, clean illustration of a person performing the exercise "${exerciseName}". The image should be: Clear, easy to understand, proper form, simple lines and shapes, suitable for a fitness app, clean, minimalist style.`;
    const response = await fetch(`https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash:generateContent?key=${GEMINI_API_KEY}`, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({
        contents: [{ parts: [{ text: prompt }] }],
        generationConfig: { temperature: 0.7, topK: 40, topP: 0.95, maxOutputTokens: 2048 }
      })
    });
    if (!response.ok) {
      const error = await response.json();
      console.log(`❌ Gemini API error:`, JSON.stringify(error, null, 2));
      return null;
    }
    const data = await response.json();
    const imageData = data.candidates[0].content.parts[0].inlineData.data;
    const imageBuffer = Buffer.from(imageData, 'base64');
    const filePath = path.join(IMAGE_DIR, fileName);
    fs.writeFileSync(filePath, imageBuffer);
    console.log(`✅ Generated and saved image: ${fileName}`);
    return fileName;
  } catch (error) {
    console.log(`❌ Error generating image for ${exerciseName}:`, error.message);
    return null;
  }
}

async function main() {
  const supabase = createClient(SUPABASE_URL, SUPABASE_ANON_KEY);
  const { data, error } = await supabase
    .from('category_exercises')
    .select('id, exercise_name, exercise_data');
  if (error) {
    console.error('Error fetching exercises:', error);
    process.exit(1);
  }
  const imageFiles = fs.readdirSync(IMAGE_DIR).filter(f => f.endsWith('.png'));
  let mapped = 0, generated = 0, failed = 0;
  for (const row of data) {
    const name = row.exercise_name;
    const normalized = normalizeName(name);
    const expectedPath = `/images/exercise/${normalized}`;
    const absPath = path.join(IMAGE_DIR, normalized);
    let imageUrl = null;
    if (imageFiles.includes(normalized)) {
      imageUrl = expectedPath;
      mapped++;
      console.log(`Mapped: ${name} -> ${imageUrl}`);
    } else {
      // Generate image
      const result = await generateExerciseImage(name, normalized);
      if (result) {
        imageUrl = expectedPath;
        generated++;
      } else {
        failed++;
        continue;
      }
    }
    // Update DB if needed
    if (imageUrl && row.exercise_data?.image_url !== imageUrl) {
      const newExerciseData = { ...row.exercise_data, image_url: imageUrl };
      const { error: updateError } = await supabase
        .from('category_exercises')
        .update({ exercise_data: newExerciseData })
        .eq('id', row.id);
      if (updateError) {
        console.error(`Failed to update DB for ${name}:`, updateError);
      }
    }
  }
  console.log(`\nSummary:`);
  console.log(`Mapped to existing images: ${mapped}`);
  console.log(`Generated new images: ${generated}`);
  console.log(`Failed to generate: ${failed}`);
}

if (require.main === module) {
  main();
} 