const fetch = require('node-fetch');

// Configuration
const SUPABASE_URL = process.env.SUPABASE_URL || 'http://127.0.0.1:54321';
const SUPABASE_ANON_KEY = process.env.SUPABASE_ANON_KEY || 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZS1kZW1vIiwicm9sZSI6ImFub24iLCJleHAiOjE5ODM4MTI5OTZ9.CRXP1A7WOeoJeXxjNni43kdQwgnWNReilDMblYTn_I0';
const IMAGE_SERVER_URL = 'http://localhost:4000';

// Fitness categories
const FITNESS_CATEGORIES = [
  {
    id: 'strength-building',
    name: 'Strength Training & Muscle Building',
    description: 'Build muscle mass, increase strength, and develop powerful physique'
  },
  {
    id: 'weight-loss',
    name: 'Weight Loss & Fat Burning',
    description: 'Burn calories, lose fat, and improve cardiovascular health'
  },
  {
    id: 'calisthenics',
    name: 'Calisthenics & Bodyweight',
    description: 'Master bodyweight movements and functional strength'
  },
  {
    id: 'bulking',
    name: 'Bulking & Mass Gain',
    description: 'Maximize muscle growth and overall body mass'
  },
  {
    id: 'functional',
    name: 'Functional Fitness',
    description: 'Improve real-world movement patterns and athletic performance'
  },
  {
    id: 'flexibility',
    name: 'Flexibility & Recovery',
    description: 'Enhance mobility, reduce tension, and promote recovery'
  }
];

async function generateExercisesForCategory(categoryId, categoryName, count = 5) {
  try {
    console.log(`\n🏋️ Generating ${count} exercises for: ${categoryName} (${categoryId})`);
    
    // Call the AI exercise generation function
    const response = await fetch(`${SUPABASE_URL}/functions/v1/generate-ai-exercises`, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'Authorization': `Bearer ${SUPABASE_ANON_KEY}`
      },
      body: JSON.stringify({
        goalCategory: categoryId,
        exerciseCount: count,
        forceRefresh: true
      })
    });

    if (!response.ok) {
      const errorText = await response.text();
      console.error(`❌ Failed to generate exercises for ${categoryName}:`, errorText);
      return [];
    }

    const data = await response.json();
    
    if (!data.exercises || !Array.isArray(data.exercises)) {
      console.error(`❌ Invalid response for ${categoryName}:`, data);
      return [];
    }

    console.log(`✅ Generated ${data.exercises.length} exercises for ${categoryName}`);
    return data.exercises;
  } catch (error) {
    console.error(`❌ Error generating exercises for ${categoryName}:`, error.message);
    return [];
  }
}

async function generateImagesForExercises(exercises) {
  console.log(`\n🖼️ Generating images for ${exercises.length} exercises...`);
  
  const exercisesWithImages = [];
  
  for (const exercise of exercises) {
    try {
      console.log(`  Generating image for: ${exercise.name}`);
      
      const response = await fetch(`${IMAGE_SERVER_URL}/api/exercise-image`, {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({
          name: exercise.name,
          description: exercise.instructions || '',
          category: exercise.category
        })
      });

      if (response.ok) {
        const data = await response.json();
        exercise.image_url = data.imageUrl;
        console.log(`    ✅ Image: ${data.imageUrl}`);
      } else {
        console.warn(`    ⚠️ Failed to generate image for ${exercise.name}`);
        exercise.image_url = '/images/exercise/default.png';
      }
    } catch (error) {
      console.error(`    ❌ Error generating image for ${exercise.name}:`, error.message);
      exercise.image_url = '/images/exercise/default.png';
    }
    
    exercisesWithImages.push(exercise);
    
    // Add delay to avoid overwhelming the API
    await new Promise(resolve => setTimeout(resolve, 1000));
  }

  return exercisesWithImages;
}

async function storeExercisesInDatabase(categoryId, exercises) {
  try {
    console.log(`\n💾 Storing ${exercises.length} exercises in database for category: ${categoryId}`);
    
    // First, delete existing exercises for this category
    const deleteResponse = await fetch(`${SUPABASE_URL}/rest/v1/category_exercises?category_id=eq.${categoryId}`, {
      method: 'DELETE',
      headers: {
        'Content-Type': 'application/json',
        'Authorization': `Bearer ${SUPABASE_ANON_KEY}`,
        'apikey': SUPABASE_ANON_KEY
      }
    });

    if (!deleteResponse.ok) {
      console.warn(`⚠️ Failed to delete existing exercises for ${categoryId}:`, await deleteResponse.text());
    }

    // Insert new exercises
    const exercisesToInsert = exercises.map(exercise => ({
      category_id: categoryId,
      exercise_name: exercise.name,
      exercise_data: exercise,
      created_at: new Date().toISOString()
    }));

    const insertResponse = await fetch(`${SUPABASE_URL}/rest/v1/category_exercises`, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'Authorization': `Bearer ${SUPABASE_ANON_KEY}`,
        'apikey': SUPABASE_ANON_KEY
      },
      body: JSON.stringify(exercisesToInsert)
    });

    if (!insertResponse.ok) {
      const errorText = await insertResponse.text();
      console.error(`❌ Failed to store exercises for ${categoryId}:`, errorText);
      return false;
    }

    console.log(`✅ Successfully stored ${exercises.length} exercises for category: ${categoryId}`);
    return true;
  } catch (error) {
    console.error(`❌ Error storing exercises for ${categoryId}:`, error.message);
    return false;
  }
}

async function checkImageServer() {
  try {
    const response = await fetch(`${IMAGE_SERVER_URL}/api/exercise-image`, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ name: 'test', description: 'test' })
    });
    
    if (response.ok) {
      console.log('✅ Image generation server is running');
      return true;
    }
  } catch (error) {
    console.error('❌ Image generation server is not running on port 4000');
    console.log('Please start the server with: GEMINI_API_KEY=YOUR_KEY node generate-exercise-image-api.cjs');
    return false;
  }
}

async function main() {
  console.log('🚀 Starting generation of exercises for all fitness categories...');
  
  // Check if image server is running
  const imageServerRunning = await checkImageServer();
  if (!imageServerRunning) {
    console.log('❌ Cannot proceed without image generation server');
    return;
  }

  const results = [];
  
  for (const category of FITNESS_CATEGORIES) {
    try {
      console.log(`\n${'='.repeat(60)}`);
      console.log(`Processing: ${category.name}`);
      console.log(`${'='.repeat(60)}`);
      
      // Generate exercises
      const exercises = await generateExercisesForCategory(category.id, category.name, 5);
      
      if (exercises.length === 0) {
        console.log(`❌ No exercises generated for ${category.name}`);
        results.push({ category: category.name, status: 'failed', count: 0 });
        continue;
      }
      
      // Generate images for exercises
      const exercisesWithImages = await generateImagesForExercises(exercises);
      
      // Store in database
      const stored = await storeExercisesInDatabase(category.id, exercisesWithImages);
      
      results.push({
        category: category.name,
        status: stored ? 'success' : 'failed',
        count: exercisesWithImages.length,
        exercisesWithImages: exercisesWithImages.length,
        exercisesWithoutImages: exercises.length - exercisesWithImages.length
      });
      
      console.log(`✅ Completed category: ${category.name} - ${exercisesWithImages.length} exercises`);
      
      // Add delay between categories to avoid rate limiting
      console.log('⏳ Waiting 5 seconds before next category...');
      await new Promise(resolve => setTimeout(resolve, 5000));
      
    } catch (error) {
      console.error(`❌ Error processing category ${category.name}:`, error.message);
      results.push({ category: category.name, status: 'error', count: 0, error: error.message });
    }
  }
  
  // Print summary
  console.log(`\n${'='.repeat(60)}`);
  console.log('🎉 GENERATION COMPLETE - SUMMARY');
  console.log(`${'='.repeat(60)}`);
  
  results.forEach(result => {
    const statusIcon = result.status === 'success' ? '✅' : result.status === 'failed' ? '❌' : '⚠️';
    console.log(`${statusIcon} ${result.category}: ${result.count} exercises`);
    if (result.exercisesWithImages !== undefined) {
      console.log(`   - With images: ${result.exercisesWithImages}`);
      console.log(`   - Without images: ${result.exercisesWithoutImages}`);
    }
  });
  
  const totalExercises = results.reduce((sum, r) => sum + r.count, 0);
  const successfulCategories = results.filter(r => r.status === 'success').length;
  
  console.log(`\n📊 Total: ${totalExercises} exercises across ${successfulCategories}/${FITNESS_CATEGORIES.length} categories`);
  
  // Save results to file
  const fs = require('fs');
  fs.writeFileSync('category-generation-results.json', JSON.stringify(results, null, 2));
  console.log('\n💾 Results saved to category-generation-results.json');
}

// Check environment variables
if (!SUPABASE_URL || SUPABASE_URL === 'YOUR_SUPABASE_URL') {
  console.error('❌ Please set SUPABASE_URL environment variable');
  process.exit(1);
}

if (!SUPABASE_ANON_KEY || SUPABASE_ANON_KEY === 'YOUR_SUPABASE_ANON_KEY') {
  console.error('❌ Please set SUPABASE_ANON_KEY environment variable');
  process.exit(1);
}

main().catch(console.error); 