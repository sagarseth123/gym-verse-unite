const fetch = require('node-fetch');

// Configuration
const SUPABASE_URL = process.env.SUPABASE_URL || 'http://127.0.0.1:54321';
const SUPABASE_ANON_KEY = process.env.SUPABASE_ANON_KEY || 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZS1kZW1vIiwicm9sZSI6ImFub24iLCJleHAiOjE5ODM4MTI5OTZ9.CRXP1A7WOeoJeXxjNni43kdQwgnWNReilDMblYTn_I0';
const IMAGE_SERVER_URL = 'http://localhost:4000';

async function testCategoryGeneration() {
  try {
    console.log('🧪 Testing category exercise generation...');
    
    // Test 1: Generate exercises for strength-building category
    console.log('\n1️⃣ Testing AI exercise generation...');
    const response = await fetch(`${SUPABASE_URL}/functions/v1/generate-ai-exercises`, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'Authorization': `Bearer ${SUPABASE_ANON_KEY}`
      },
      body: JSON.stringify({
        goalCategory: 'strength-building',
        exerciseCount: 5, // Start with just 5 for testing
        forceRefresh: true
      })
    });

    if (!response.ok) {
      const errorText = await response.text();
      console.error('❌ Failed to generate exercises:', errorText);
      return;
    }

    const data = await response.json();
    console.log(`✅ Generated ${data.exercises?.length || 0} exercises`);
    
    if (!data.exercises || data.exercises.length === 0) {
      console.log('❌ No exercises generated');
      return;
    }

    // Test 2: Generate images for the exercises
    console.log('\n2️⃣ Testing image generation...');
    const exercisesWithImages = [];
    
    for (const exercise of data.exercises.slice(0, 3)) { // Test with first 3 exercises
      try {
        console.log(`  Generating image for: ${exercise.name}`);
        
        const imageResponse = await fetch(`${IMAGE_SERVER_URL}/api/exercise-image`, {
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

        if (imageResponse.ok) {
          const imageData = await imageResponse.json();
          exercise.image_url = imageData.imageUrl;
          console.log(`    ✅ Image: ${imageData.imageUrl}`);
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

    // Test 3: Display the results
    console.log('\n3️⃣ Generated exercises with images:');
    exercisesWithImages.forEach((exercise, index) => {
      console.log(`\n${index + 1}. ${exercise.name}`);
      console.log(`   Category: ${exercise.category}`);
      console.log(`   Difficulty: ${exercise.difficulty}`);
      console.log(`   Muscles: ${exercise.muscle_groups?.join(', ') || 'N/A'}`);
      console.log(`   Equipment: ${exercise.equipment_needed?.join(', ') || 'N/A'}`);
      console.log(`   Image: ${exercise.image_url}`);
      console.log(`   Instructions: ${exercise.instructions?.substring(0, 100)}...`);
    });

    console.log('\n🎉 Test completed successfully!');
    console.log(`Generated ${exercisesWithImages.length} exercises with images`);
    
    // Save results to file
    const fs = require('fs');
    fs.writeFileSync('test-category-results.json', JSON.stringify({
      category: 'strength-building',
      exercises: exercisesWithImages,
      timestamp: new Date().toISOString()
    }, null, 2));
    console.log('\n💾 Results saved to test-category-results.json');

  } catch (error) {
    console.error('❌ Test failed:', error.message);
  }
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

testCategoryGeneration().catch(console.error); 