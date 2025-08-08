const express = require('express');
const fs = require('fs');
const path = require('path');
const fetch = require('node-fetch');

const GEMINI_API_KEY = process.env.GEMINI_API_KEY || 'AIzaSyB5VwcpawV1ntLKhghoarAx2x1PJwlte8w';
const IMAGE_DIR = path.join(__dirname, 'public', 'images', 'exercise');

const app = express();
app.use(express.json());

// Serve static images
app.use('/images/exercise', express.static(IMAGE_DIR));

// Utility: Generate or fetch local image for an exercise
async function getOrGenerateExerciseImage(exerciseName, description = '') {
  try {
    // Sanitize exercise name for URL
    const sanitizedName = exerciseName.toLowerCase()
      .replace(/[^a-z0-9]/g, '_')
      .replace(/_+/g, '_')
      .replace(/^_|_$/g, '');
    
    // Common exercise name mappings for better matching
    const exerciseMappings = {
      // Push-ups variations
      'push_ups': 'push_ups',
      'pushup': 'push_ups',
      
      // Pull-ups variations
      'pull_ups': 'pull_ups',
      'pullup': 'pull_ups',
      
      // Squats variations
      'squats': 'squats',
      'squat': 'squats',
      'jump_squats': 'squats',
      'jump_squat': 'squats',
      'jumping_squats': 'squats',
      'jumping_squat': 'squats',
      'bodyweight_squats': 'squats',
      'bodyweight_squat': 'squats',
      
      // Bench press variations
      'bench_press': 'bench_press',
      'barbell_bench_press': 'bench_press',
      'dumbbell_bench_press': 'bench_press',
      'dumbbell_press': 'bench_press',
      
      // Deadlift variations
      'deadlift': 'deadlift',
      'barbell_deadlift': 'deadlift',
      
      // Plank variations
      'plank': 'plank',
      'forearm_plank': 'plank',
      
      // Burpees variations
      'burpees': 'burpees',
      'burpee': 'burpees',
      
      // Lunges variations
      'lunges': 'lunges',
      'lunge': 'lunges',
      'walking_lunges': 'lunges',
      'reverse_lunges': 'lunges',
      
      // Mountain climbers variations
      'mountain_climbers': 'mountain_climbers',
      'mountain_climber': 'mountain_climbers',
      
      // Jumping jacks variations
      'jumping_jacks': 'jumping_jacks',
      'jumping_jack': 'jumping_jacks',
      'jump_jacks': 'jumping_jacks',
      'jump_jack': 'jumping_jacks',
      
      // Sit-ups variations
      'sit_ups': 'sit_ups',
      'situp': 'sit_ups',
      'sit_up': 'sit_ups',
      
      // Crunches variations
      'crunches': 'crunches',
      'crunch': 'crunches',
      
      // Dumbbell curls variations
      'dumbbell_curls': 'dumbbell_curls',
      'dumbbell_curl': 'dumbbell_curls',
      'bicep_curls': 'dumbbell_curls',
      'bicep_curl': 'dumbbell_curls',
      
      // Shoulder press variations
      'shoulder_press': 'shoulder_press',
      'overhead_press': 'shoulder_press',
      'military_press': 'shoulder_press',
      
      // Rows variations
      'rows': 'rows',
      'row': 'rows',
      'barbell_rows': 'rows',
      'dumbbell_rows': 'rows',
      
      // Lat pulldowns variations
      'lat_pulldowns': 'lat_pulldowns',
      'lat_pulldown': 'lat_pulldowns',
      'pull_down': 'lat_pulldowns',
      
      // Leg press variations
      'leg_press': 'leg_press'
    };
    
    // Try to find a matching exercise name
    const matchedName = exerciseMappings[sanitizedName] || sanitizedName;
    const fileName = matchedName + '.png';
    const filePath = path.join(IMAGE_DIR, fileName);
    const publicPath = `/images/exercise/${fileName}`;

    // Ensure the directory exists
    if (!fs.existsSync(IMAGE_DIR)) {
      fs.mkdirSync(IMAGE_DIR, { recursive: true });
    }

    // Check if image exists
    if (fs.existsSync(filePath)) {
      console.log(`Found existing image for ${exerciseName}: ${publicPath}`);
      return publicPath;
    }

    // Generate image with Gemini
    console.log(`Generating image for exercise: ${exerciseName}`);
    const prompt = `Create a high-quality, professional, app-ready illustration of a person performing the exercise: ${exerciseName}. The background should be white. The person should be clearly demonstrating the correct form for: ${exerciseName}. Highlight the main muscles worked. Style: clear, anatomical, instructional. Description: ${description}`;
    
    const geminiUrl = `https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash-preview-image-generation:generateContent?key=${GEMINI_API_KEY}`;
    const body = {
      contents: [{ parts: [{ text: prompt }] }],
      generationConfig: {
        responseModalities: ["IMAGE", "TEXT"],
        temperature: 0.7
      }
    };
    
    const response = await fetch(geminiUrl, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify(body),
    });
    
    if (!response.ok) {
      const errorText = await response.text();
      console.error('Gemini image API error:', errorText);
      return '/images/exercise/default.png';
    }
    
    const data = await response.json();
    console.log(`Gemini API response for ${exerciseName}:`, JSON.stringify(data, null, 2));
    
    // Check for image data in the response
    const candidates = data.candidates || [];
    for (const candidate of candidates) {
      const parts = candidate.content?.parts || [];
      for (const part of parts) {
        if (part.inlineData && part.inlineData.data) {
          // Save the base64 image data to file
          fs.writeFileSync(filePath, Buffer.from(part.inlineData.data, 'base64'));
          console.log(`Generated and saved image for ${exerciseName}: ${publicPath}`);
          return publicPath;
        }
      }
    }
    
    console.log(`No image data found in response for ${exerciseName}`);
    return '/images/exercise/default.png';
  } catch (error) {
    console.error(`Error processing image for ${exerciseName}:`, error);
    return '/images/exercise/default.png';
  }
}

// Utility: Process a fitness plan and add image URLs to all exercises
async function processPlanWithImages(plan) {
  const processedPlan = { ...plan };
  
  for (const day of Object.keys(processedPlan)) {
    if (Array.isArray(processedPlan[day]?.exercises)) {
      for (const ex of processedPlan[day].exercises) {
        ex.imageUrl = await getOrGenerateExerciseImage(ex.name, ex.description || '');
      }
    }
  }
  
  return processedPlan;
}

// API: Generate exercise image
app.post('/api/exercise-image', async (req, res) => {
  try {
    const { name, description, category } = req.body;
    
    if (!name) {
      return res.status(400).json({ error: 'Exercise name is required' });
    }

    const imageUrl = await getOrGenerateExerciseImage(name, description || '');
    
    res.json({ 
      imageUrl,
      exerciseName: name,
      category: category || 'general'
    });
  } catch (error) {
    console.error('Error generating exercise image:', error);
    res.status(500).json({ error: 'Failed to generate exercise image' });
  }
});

// API: Generate plan and attach images
app.post('/api/generate-plan', async (req, res) => {
  try {
    const { userProfile, preferences } = req.body;
    let plan = generatePlan(userProfile, preferences);
    
    // Process the plan to add image URLs
    const processedPlan = await processPlanWithImages(plan);
    
    res.json({ 
      plan: processedPlan,
      success: true,
      message: 'Plan generated with images attached'
    });
  } catch (error) {
    console.error('Error generating plan:', error);
    res.status(500).json({ 
      error: 'Failed to generate plan',
      success: false 
    });
  }
});

// API: Get or generate image for a specific exercise
app.get('/api/exercise-image', async (req, res) => {
  const { name, description } = req.query;
  if (!name) {
    return res.status(400).json({ error: 'Exercise name is required' });
  }
  
  try {
    const imageUrl = await getOrGenerateExerciseImage(name, description || '');
    res.json({ 
      imageUrl,
      success: true,
      exerciseName: name
    });
  } catch (error) {
    console.error('Error generating exercise image:', error);
    res.status(500).json({ 
      error: 'Failed to generate image', 
      imageUrl: '/images/exercise/default.png',
      success: false 
    });
  }
});

// API: Process multiple exercises and generate images
app.post('/api/batch-process-exercises', async (req, res) => {
  try {
    const { exercises } = req.body;
    
    if (!Array.isArray(exercises)) {
      return res.status(400).json({ 
        error: 'Exercises must be an array',
        success: false 
      });
    }
    
    const results = [];
    
    for (const exercise of exercises) {
      const { name, description } = exercise;
      if (!name) {
        results.push({ 
          name: 'unknown', 
          imageUrl: '/images/exercise/default.png',
          success: false,
          error: 'Exercise name is required'
        });
        continue;
      }
      
      try {
        const imageUrl = await getOrGenerateExerciseImage(name, description || '');
        results.push({ 
          name, 
          imageUrl,
          success: true 
        });
      } catch (error) {
        console.error(`Error processing exercise ${name}:`, error);
        results.push({ 
          name, 
          imageUrl: '/images/exercise/default.png',
          success: false,
          error: error.message
        });
      }
    }
    
    res.json({ 
      results,
      success: true,
      message: `Processed ${results.length} exercises`
    });
  } catch (error) {
    console.error('Error in batch processing:', error);
    res.status(500).json({ 
      error: 'Failed to process exercises',
      success: false 
    });
  }
});

// API: Get list of available exercise images
app.get('/api/available-images', async (req, res) => {
  try {
    if (!fs.existsSync(IMAGE_DIR)) {
      return res.json({ 
        images: [],
        success: true,
        message: 'No images directory found'
      });
    }
    
    const files = fs.readdirSync(IMAGE_DIR);
    const images = files
      .filter(file => file.endsWith('.png'))
      .map(file => ({
        name: file.replace('.png', ''),
        path: `/images/exercise/${file}`,
        size: fs.statSync(path.join(IMAGE_DIR, file)).size
      }));
    
    res.json({ 
      images,
      success: true,
      count: images.length
    });
  } catch (error) {
    console.error('Error getting available images:', error);
    res.status(500).json({ 
      error: 'Failed to get available images',
      success: false 
    });
  }
});

// Example plan generator (replace with your real logic)
function generatePlan(userProfile, preferences) {
  // Dummy plan for demonstration
  return {
    monday: {
      focus: 'Upper Body',
      exercises: [
        { name: 'Push-ups', sets: 3, reps: 'AMRAP', rest: '45 seconds', description: 'Standard push-up with correct form, highlighting chest, triceps, and core.' },
        { name: 'Pull-ups', sets: 3, reps: 8, rest: '60 seconds', description: 'Pull-up with correct form, highlighting back and biceps.' }
      ]
    },
    tuesday: {
      focus: 'Lower Body',
      exercises: [
        { name: 'Squats', sets: 4, reps: 12, rest: '60 seconds', description: 'Barbell squat with correct form, highlighting quads, glutes, and core.' }
      ]
    }
    // ... add more days as needed
  };
}

const PORT = process.env.PORT || 4000;
app.listen(PORT, () => {
  console.log(`Node.js fitness planner API running on http://localhost:${PORT}`);
  console.log(`Image directory: ${IMAGE_DIR}`);
  console.log(`Available endpoints:`);
  console.log(`  POST /api/generate-plan - Generate plan with images`);
  console.log(`  GET  /api/exercise-image?name=<exercise> - Get/generate single exercise image`);
  console.log(`  POST /api/batch-process-exercises - Process multiple exercises`);
  console.log(`  GET  /api/available-images - List available images`);
}); 