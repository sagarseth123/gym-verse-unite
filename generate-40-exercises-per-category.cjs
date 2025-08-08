const fetch = require('node-fetch');
const fs = require('fs').promises;

// Configuration
const SUPABASE_URL = process.env.SUPABASE_URL || 'http://127.0.0.1:54321';
const SUPABASE_ANON_KEY = process.env.SUPABASE_ANON_KEY || 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZS1kZW1vIiwicm9sZSI6ImFub24iLCJleHAiOjE5ODM4MTI5OTZ9.CRXP1A7WOeoJeXxjNni43kdQwgnWNReilDMblYTn_I0';

// Categories to generate exercises for
const CATEGORIES = [
  {
    id: 'strength-building',
    name: 'Strength Training & Muscle Building'
  },
  {
    id: 'weight-loss',
    name: 'Weight Loss & Fat Burning'
  },
  {
    id: 'calisthenics',
    name: 'Calisthenics & Bodyweight'
  },
  {
    id: 'bulking',
    name: 'Bulking & Mass Gain'
  },
  {
    id: 'functional',
    name: 'Functional Fitness'
  },
  {
    id: 'flexibility',
    name: 'Flexibility & Recovery'
  }
];

async function generateExercisesForCategory(categoryId, categoryName, count = 40) {
  try {
    console.log(`\n🏋️ Generating ${count} exercises for: ${categoryName}`);
    
    // Call the AI exercise generation function
    const response = await fetch(`${SUPABASE_URL}/functions/v1/generate-ai-exercises`, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'Authorization': `Bearer ${SUPABASE_ANON_KEY}`
      },
      body: JSON.stringify({
        goalCategory: categoryName,
        exerciseCount: count
      })
    });

    if (!response.ok) {
      const errorText = await response.text();
      console.error(`❌ HTTP ${response.status}: ${errorText}`);
      return null;
    }

    const data = await response.json();
    
    if (data.success && data.exercises) {
      console.log(`✅ Successfully generated ${data.exercises.length} exercises for ${categoryName}`);
      return data.exercises;
    } else {
      console.error(`❌ Failed to generate exercises for ${categoryName}:`, data.error || 'Unknown error');
      return null;
    }
  } catch (error) {
    console.error(`❌ Error generating exercises for ${categoryName}:`, error.message);
    return null;
  }
}

async function storeExercisesInDatabase(categoryId, exercises) {
  try {
    console.log(`💾 Storing ${exercises.length} exercises in database for category: ${categoryId}`);
    
    // Store in category_exercises table
    const response = await fetch(`${SUPABASE_URL}/rest/v1/category_exercises`, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'Authorization': `Bearer ${SUPABASE_ANON_KEY}`,
        'apikey': SUPABASE_ANON_KEY
      },
      body: JSON.stringify(
        exercises.map(exercise => ({
          category_id: categoryId,
          exercise_name: exercise.name,
          exercise_data: exercise,
          created_at: new Date().toISOString()
        }))
      )
    });

    if (!response.ok) {
      const errorText = await response.text();
      console.error(`❌ Failed to store exercises: ${errorText}`);
      return false;
    }

    console.log(`✅ Successfully stored ${exercises.length} exercises in database`);
    return true;
  } catch (error) {
    console.error(`❌ Error storing exercises:`, error.message);
    return false;
  }
}

async function generateImagesForExercises(exercises) {
  console.log(`🖼️ Generating images for ${exercises.length} exercises...`);
  
  const imagePromises = exercises.map(async (exercise, index) => {
    try {
      // Add delay to avoid rate limiting
      await new Promise(resolve => setTimeout(resolve, index * 1000)); // 1 second delay between requests
      
      const response = await fetch('http://localhost:4000/api/exercise-image', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json'
        },
        body: JSON.stringify({
          name: exercise.name,
          description: exercise.description || exercise.name
        })
      });

      if (response.ok) {
        const data = await response.json();
        console.log(`✅ Image generated for: ${exercise.name}`);
        return { ...exercise, imageUrl: data.imageUrl };
      } else {
        console.log(`⚠️ Image generation failed for: ${exercise.name} - using placeholder`);
        return { ...exercise, imageUrl: '/images/exercise/push_ups.png' };
      }
    } catch (error) {
      console.log(`⚠️ Image generation error for: ${exercise.name} - using placeholder`);
      return { ...exercise, imageUrl: '/images/exercise/push_ups.png' };
    }
  });

  return Promise.all(imagePromises);
}

async function main() {
  console.log('🚀 Starting 40 exercises per category generation...');
  
  const results = {
    timestamp: new Date().toISOString(),
    categories: []
  };

  for (const category of CATEGORIES) {
    console.log(`\n📋 Processing category: ${category.name} (${category.id})`);
    
    // Generate 40 exercises
    const exercises = await generateExercisesForCategory(category.id, category.name, 40);
    
    if (exercises && exercises.length > 0) {
      // Generate images for exercises
      const exercisesWithImages = await generateImagesForExercises(exercises);
      
      // Store in database
      const stored = await storeExercisesInDatabase(category.id, exercisesWithImages);
      
      results.categories.push({
        categoryId: category.id,
        categoryName: category.name,
        exerciseCount: exercisesWithImages.length,
        success: stored,
        exercises: exercisesWithImages.map(ex => ({
          name: ex.name,
          description: ex.description,
          imageUrl: ex.imageUrl
        }))
      });
      
      console.log(`✅ Completed ${category.name}: ${exercisesWithImages.length} exercises`);
    } else {
      results.categories.push({
        categoryId: category.id,
        categoryName: category.name,
        exerciseCount: 0,
        success: false,
        error: 'Failed to generate exercises'
      });
      
      console.log(`❌ Failed to generate exercises for ${category.name}`);
    }
    
    // Add delay between categories to avoid rate limiting
    console.log('⏳ Waiting 5 seconds before next category...');
    await new Promise(resolve => setTimeout(resolve, 5000));
  }

  // Save results to file
  await fs.writeFile('40-exercises-per-category-results.json', JSON.stringify(results, null, 2));
  console.log('\n📄 Results saved to: 40-exercises-per-category-results.json');
  
  // Summary
  const successfulCategories = results.categories.filter(c => c.success);
  const totalExercises = successfulCategories.reduce((sum, c) => sum + c.exerciseCount, 0);
  
  console.log('\n🎉 Generation Complete!');
  console.log(`✅ Successful categories: ${successfulCategories.length}/${CATEGORIES.length}`);
  console.log(`📊 Total exercises generated: ${totalExercises}`);
  
  results.categories.forEach(cat => {
    const status = cat.success ? '✅' : '❌';
    console.log(`${status} ${cat.categoryName}: ${cat.exerciseCount} exercises`);
  });
}

// Start the generation
main().catch(console.error); 