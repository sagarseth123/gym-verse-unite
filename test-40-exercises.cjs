const fetch = require('node-fetch');

// Configuration
const SUPABASE_URL = process.env.SUPABASE_URL || 'http://127.0.0.1:54321';
const SUPABASE_ANON_KEY = process.env.SUPABASE_ANON_KEY || 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZS1kZW1vIiwicm9sZSI6ImFub24iLCJleHAiOjE5ODM4MTI5OTZ9.CRXP1A7WOeoJeXxjNni43kdQwgnWNReilDMblYTn_I0';

async function test40Exercises() {
  try {
    console.log('🧪 Testing 40 exercises generation for Weight Loss & Fat Burning...');
    
    // Call the AI exercise generation function
    const response = await fetch(`${SUPABASE_URL}/functions/v1/generate-ai-exercises`, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'Authorization': `Bearer ${SUPABASE_ANON_KEY}`
      },
      body: JSON.stringify({
        goalCategory: 'Weight Loss & Fat Burning',
        exerciseCount: 40
      })
    });

    console.log(`Response status: ${response.status}`);
    
    if (!response.ok) {
      const errorText = await response.text();
      console.error(`❌ HTTP ${response.status}: ${errorText}`);
      return;
    }

    const data = await response.json();
    
    if (data.success && data.exercises) {
      console.log(`✅ Successfully generated ${data.exercises.length} exercises!`);
      console.log('First 3 exercises:');
      data.exercises.slice(0, 3).forEach((exercise, index) => {
        console.log(`${index + 1}. ${exercise.name} - ${exercise.difficulty}`);
      });
    } else {
      console.error(`❌ Failed to generate exercises:`, data.error || 'Unknown error');
    }
  } catch (error) {
    console.error(`❌ Error:`, error.message);
  }
}

test40Exercises(); 