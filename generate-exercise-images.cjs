const fetch = require('node-fetch');

// Common exercises to generate images for
const exercises = [
  { name: 'Bench Press', description: 'Barbell bench press for chest development' },
  { name: 'Deadlift', description: 'Barbell deadlift for back and legs' },
  { name: 'Plank', description: 'Core stability exercise' },
  { name: 'Burpees', description: 'Full body cardio exercise' },
  { name: 'Lunges', description: 'Leg strength and balance exercise' },
  { name: 'Mountain Climbers', description: 'Cardio and core exercise' },
  { name: 'Jumping Jacks', description: 'Cardio warm-up exercise' },
  { name: 'Sit-ups', description: 'Core strengthening exercise' },
  { name: 'Crunches', description: 'Abdominal exercise' },
  { name: 'Dumbbell Curls', description: 'Bicep strengthening exercise' },
  { name: 'Shoulder Press', description: 'Overhead press for shoulders' },
  { name: 'Rows', description: 'Back strengthening exercise' },
  { name: 'Lat Pulldowns', description: 'Upper back exercise' },
  { name: 'Leg Press', description: 'Machine leg exercise' }
];

async function generateImages() {
  console.log('Starting image generation for exercises...');
  
  for (const exercise of exercises) {
    try {
      console.log(`Generating image for: ${exercise.name}`);
      
      const params = new URLSearchParams({
        name: exercise.name,
        description: exercise.description
      });
      
      const response = await fetch(`http://localhost:4000/api/exercise-image?${params.toString()}`);
      const data = await response.json();
      
      console.log(`✅ Generated: ${data.imageUrl}`);
      
      // Wait a bit between requests to avoid rate limiting
      await new Promise(resolve => setTimeout(resolve, 2000));
      
    } catch (error) {
      console.error(`❌ Failed to generate image for ${exercise.name}:`, error.message);
    }
  }
  
  console.log('Image generation complete!');
}

// Check if server is running
async function checkServer() {
  try {
    const response = await fetch('http://localhost:4000/api/generate-plan', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({})
    });
    
    if (response.ok) {
      console.log('✅ Node.js server is running');
      return true;
    }
  } catch (error) {
    console.error('❌ Node.js server is not running on port 4000');
    console.log('Please start the server with: GEMINI_API_KEY=YOUR_KEY node server.cjs');
    return false;
  }
}

async function main() {
  const serverRunning = await checkServer();
  if (serverRunning) {
    await generateImages();
  }
}

main().catch(console.error); 