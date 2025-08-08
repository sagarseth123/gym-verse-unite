const fetch = require('node-fetch');

// Test different exercises to ensure unique guidance
const testExercises = [
  {
    name: "Push-ups",
    category: "Strength",
    muscle_groups: ["Chest", "Triceps", "Shoulders"],
    difficulty_level: "Intermediate",
    equipment_needed: ["Bodyweight"],
    existing_instructions: "Standard push-up form"
  },
  {
    name: "Squats",
    category: "Strength",
    muscle_groups: ["Quadriceps", "Glutes", "Hamstrings"],
    difficulty_level: "Beginner",
    equipment_needed: ["Bodyweight"],
    existing_instructions: "Basic squat form"
  },
  {
    name: "Bench Press",
    category: "Strength",
    muscle_groups: ["Chest", "Triceps", "Shoulders"],
    difficulty_level: "Advanced",
    equipment_needed: ["Barbell", "Bench"],
    existing_instructions: "Barbell bench press"
  }
];

async function testExerciseGuidance() {
  console.log('Testing exercise guidance generation...\n');
  
  for (const exercise of testExercises) {
    console.log(`\n=== Testing: ${exercise.name} ===`);
    
    try {
      const response = await fetch('http://localhost:54321/functions/v1/generate-fitness-plan', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer test-token' // Add auth header for testing
        },
        body: JSON.stringify({
          type: 'exercise_guidance',
          exercise: exercise
        })
      });
      
      if (response.ok) {
        const data = await response.json();
        if (data.guidance) {
          console.log(`✅ ${exercise.name} - Guidance generated successfully`);
          console.log(`   Instructions: ${data.guidance.instructions?.length || 0} steps`);
          console.log(`   Benefits: ${data.guidance.benefits?.length || 0} benefits`);
          console.log(`   First instruction: ${data.guidance.instructions?.[0]?.substring(0, 50)}...`);
        } else {
          console.log(`❌ ${exercise.name} - No guidance in response`);
        }
      } else {
        const errorText = await response.text();
        console.log(`❌ ${exercise.name} - Error: ${response.status} - ${errorText}`);
      }
    } catch (error) {
      console.log(`❌ ${exercise.name} - Network error: ${error.message}`);
    }
    
    // Wait a bit between requests
    await new Promise(resolve => setTimeout(resolve, 1000));
  }
  
  console.log('\n=== Test Complete ===');
}

// Run the test
testExerciseGuidance().catch(console.error); 