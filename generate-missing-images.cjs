const fs = require('fs');
const path = require('path');

// Configuration
const IMAGE_DIR = path.join(__dirname, 'public/images/exercise');
const GEMINI_API_KEY = process.env.GEMINI_API_KEY;

// List of missing images to generate
const MISSING_IMAGES = [
  'pull_ups.png',
  'dips.png',
  'parallel_bar_dips.png',
  'weighted_dips.png',
  'barbell_overhead_press.png',
  'kettlebell_goblet_squat.png',
  'bodyweight_romanian_deadlift.png',
  'medicine_ball_russian_twist.png',
  'kettlebell_swing.png',
  'resistance_band_lateral_walks.png',
  'child_s_pose.png',
  'cat_cow_pose.png',
  'downward_facing_dog.png',
  'pigeon_pose.png',
  'standing_quadriceps_stretch.png',
  'battle_rope_waves.png',
  'plyometric_burpee_with_shoulder_tap.png',
  'incline_treadmill_sprint_intervals.png',
  'mountain_climbers_with_knee_drive_and_rotation.png',
  'overhead_press__dumbbell_.png',
  'barbell_bent_over_rows.png'
];

// Generate image using Gemini API
async function generateExerciseImage(exerciseName, fileName) {
  if (!GEMINI_API_KEY) {
    console.log('❌ No Gemini API key provided, skipping image generation');
    return null;
  }
  
  try {
    console.log(`🎨 Generating image for: ${exerciseName} -> ${fileName}`);
    
    const prompt = `Create a simple, clean illustration of a person performing the exercise "${exerciseName}". The image should be:
    - Clear and easy to understand
    - Show proper form
    - Use simple lines and shapes
    - Be suitable for a fitness app
    - Show the exercise from a good angle to demonstrate the movement
    - Use a clean, minimalist style with good contrast`;
    
    const response = await fetch(`https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash:generateContent?key=${GEMINI_API_KEY}`, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify({
        contents: [{
          parts: [{
            text: prompt
          }]
        }],
        generationConfig: {
          temperature: 0.7,
          topK: 40,
          topP: 0.95,
          maxOutputTokens: 2048,
        }
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
    
    // Save the generated image
    const filePath = path.join(IMAGE_DIR, fileName);
    fs.writeFileSync(filePath, imageBuffer);
    
    console.log(`✅ Generated and saved image: ${fileName}`);
    return fileName;
    
  } catch (error) {
    console.log(`❌ Error generating image for ${exerciseName}:`, error.message);
    return null;
  }
}

// Copy existing image as fallback
function copyExistingImage(sourceName, targetName) {
  try {
    const sourcePath = path.join(IMAGE_DIR, sourceName);
    const targetPath = path.join(IMAGE_DIR, targetName);
    
    if (fs.existsSync(sourcePath)) {
      fs.copyFileSync(sourcePath, targetPath);
      console.log(`✅ Copied ${sourceName} to ${targetName}`);
      return true;
    } else {
      console.log(`❌ Source image not found: ${sourceName}`);
      return false;
    }
  } catch (error) {
    console.log(`❌ Error copying image:`, error.message);
    return false;
  }
}

// Generate all missing images
async function generateAllMissingImages() {
  console.log('🚀 Starting generation of missing exercise images...');
  
  let successCount = 0;
  let failureCount = 0;
  const failures = [];
  
  for (const fileName of MISSING_IMAGES) {
    console.log(`\n--- Processing: ${fileName} ---`);
    
    // Check if file already exists
    const filePath = path.join(IMAGE_DIR, fileName);
    if (fs.existsSync(filePath)) {
      console.log(`⏭️  Image already exists: ${fileName}`);
      continue;
    }
    
    // Extract exercise name from filename
    const exerciseName = fileName
      .replace('.png', '')
      .replace(/_/g, ' ')
      .replace(/\b\w/g, l => l.toUpperCase());
    
    // Try to generate the image
    const result = await generateExerciseImage(exerciseName, fileName);
    
    if (result) {
      successCount++;
    } else {
      failureCount++;
      failures.push(fileName);
    }
    
    // Add delay to avoid rate limiting
    await new Promise(resolve => setTimeout(resolve, 2000));
  }
  
  console.log(`\n🎉 Generation complete!`);
  console.log(`✅ Successfully generated: ${successCount} images`);
  console.log(`❌ Failed to generate: ${failureCount} images`);
  
  if (failures.length > 0) {
    console.log('\n📋 Failed images:');
    failures.forEach(file => console.log(`  - ${file}`));
  }
  
  // Create fallback copies for common exercises
  console.log('\n🔄 Creating fallback copies...');
  const fallbackMappings = [
    { source: 'pull_ups_bodyweight.png', target: 'pull_ups.png' },
    { source: 'push_ups.png', target: 'dips.png' },
    { source: 'push_ups.png', target: 'parallel_bar_dips.png' },
    { source: 'push_ups.png', target: 'weighted_dips.png' },
    { source: 'overhead_press_barbell.png', target: 'barbell_overhead_press.png' },
    { source: 'goblet_squat.png', target: 'kettlebell_goblet_squat.png' },
    { source: 'romanian_deadlift.png', target: 'bodyweight_romanian_deadlift.png' },
    { source: 'russian_twists.png', target: 'medicine_ball_russian_twist.png' },
    { source: 'kettlebell_swings.png', target: 'kettlebell_swing.png' },
    { source: 'lunges.png', target: 'resistance_band_lateral_walks.png' },
    { source: 'plank.png', target: 'child_s_pose.png' },
    { source: 'plank.png', target: 'cat_cow_pose.png' },
    { source: 'plank.png', target: 'downward_facing_dog.png' },
    { source: 'plank.png', target: 'pigeon_pose.png' },
    { source: 'plank.png', target: 'standing_quadriceps_stretch.png' },
    { source: 'battle_ropes.png', target: 'battle_rope_waves.png' },
    { source: 'burpees.png', target: 'plyometric_burpee_with_shoulder_tap.png' },
    { source: 'jumping_jacks.png', target: 'incline_treadmill_sprint_intervals.png' },
    { source: 'mountain_climbers.png', target: 'mountain_climbers_with_knee_drive_and_rotation.png' },
    { source: 'overhead_press_barbell.png', target: 'overhead_press__dumbbell_.png' },
    { source: 'bent_over_rows_barbell.png', target: 'barbell_bent_over_rows.png' }
  ];
  
  for (const mapping of fallbackMappings) {
    const targetPath = path.join(IMAGE_DIR, mapping.target);
    if (!fs.existsSync(targetPath)) {
      copyExistingImage(mapping.source, mapping.target);
    }
  }
}

// Run the script
if (require.main === module) {
  generateAllMissingImages();
}

module.exports = {
  generateExerciseImage,
  copyExistingImage,
  generateAllMissingImages
}; 