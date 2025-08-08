const fetch = require('node-fetch');

// Configuration
const SUPABASE_URL = process.env.SUPABASE_URL || 'http://127.0.0.1:54321';
const SUPABASE_ANON_KEY = process.env.SUPABASE_ANON_KEY || 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZS1kZW1vIiwicm9sZSI6ImFub24iLCJleHAiOjE5ODM4MTI5OTZ9.CRXP1A7WOeoJeXxjNni43kdQwgnWNReilDMblYTn_I0';

async function testCategory(categoryId, categoryName) {
  try {
    console.log(`\n🔍 Testing category: ${categoryName} (${categoryId})`);
    
    // Call the AI exercise generation function
    const response = await fetch(`${SUPABASE_URL}/functions/v1/generate-ai-exercises`, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'Authorization': `Bearer ${SUPABASE_ANON_KEY}`
      },
      body: JSON.stringify({
        goalCategory: categoryId,
        exerciseCount: 10, // Test with 10 exercises
        forceRefresh: true
      })
    });

    console.log(`Response status: ${response.status}`);
    
    if (!response.ok) {
      const errorText = await response.text();
      console.error(`❌ HTTP Error:`, errorText);
      return;
    }

    const data = await response.json();
    console.log(`Response data keys:`, Object.keys(data));
    
    if (data.error) {
      console.error(`❌ API Error:`, data.error);
      return;
    }
    
    if (!data.exercises || !Array.isArray(data.exercises)) {
      console.error(`❌ Invalid response structure:`, data);
      return;
    }

    console.log(`✅ Successfully generated ${data.exercises.length} exercises`);
    
    // Show all exercises
    data.exercises.forEach((exercise, index) => {
      console.log(`\n${index + 1}. ${exercise.name}`);
      console.log(`   Category: ${exercise.category}`);
      console.log(`   Difficulty: ${exercise.difficulty}`);
      console.log(`   Muscles: ${exercise.muscle_groups?.join(', ') || 'N/A'}`);
      console.log(`   Equipment: ${exercise.equipment_needed?.join(', ') || 'N/A'}`);
    });
    
  } catch (error) {
    console.error(`❌ Exception:`, error.message);
  }
}

// Test the Weight Loss category which was failing
testCategory('weight-loss', 'Weight Loss & Fat Burning'); 