const express = require('express');
const fs = require('fs');
const path = require('path');
const fetch = require('node-fetch');
const cors = require('cors');

const GEMINI_API_KEY = process.env.GEMINI_API_KEY || 'AIzaSyB5VwcpawV1ntLKhghoarAx2x1PJwlte8w';
const IMAGE_DIR = path.join(__dirname, 'public', 'images', 'exercise');

const app = express();

// Enable CORS for all routes
app.use(cors());

app.use(express.json());

// Mapping from common AI exercise names to actual image filenames
const exerciseImageMap = {
  // Squats
  "barbell back squat": "barbell_back_squat.png",
  "back squat": "barbell_back_squat.png",
  "barbell squat": "barbell_back_squat.png",
  "front squat": "front_squat.png",
  "front squats": "front_squats.png",
  "sumo squat": "sumo_squat.png",
  "goblet squat": "goblet_squat.png",
  "overhead squat": "overhead_squat.png",
  "split squats": "split_squats.png",
  "step ups": "step_ups.png",
  "box jumps": "box_jumps.png",
  "romanian deadlift": "romanian_deadlift.png",
  "romanian deadlifts (rdls)": "barbell_romanian_deadlift_rdl.png",
  "romanian deadlifts (rdls)": "barbell_romanian_deadlift_rdl.png",
  "romanian deadlifts rdls": "barbell_romanian_deadlift_rdl.png",
  "romanian deadlifts": "barbell_romanian_deadlift_rdl.png",
  "barbell romanian deadlift": "barbell_romanian_deadlift_rdl.png",
  "rdl": "barbell_romanian_deadlift_rdl.png",
  "sumo deadlift": "sumo_deadlift.png",
  "sumo deadlifts": "sumo_deadlift.png",
  "deadlift": "barbell_romanian_deadlift_rdl.png",
  "barbell deadlift": "barbell_romanian_deadlift_rdl.png",
  "good mornings": "barbell_good_mornings.png",
  // Presses
  "barbell bench press": "chest_press.png",
  "dumbbell bench press": "dumbbell_shoulder_press.png",
  "bench press": "chest_press.png",
  "incline dumbbell press": "incline_dumbbell_press.png",
  "decline dumbbell press": "decline_dumbbell_press.png",
  "decline dumbbell press": "decline_dumbbell_press.png",
  "chest press": "chest_press.png",
  "chest press incline": "chest_press_incline.png",
  "chest press decline": "chest_press_decline.png",
  "close-grip bench press": "close_grip_bench_press.png",
  // Rows & Pulls
  "barbell rows": "bent_over_rows_barbell.png",
  "dumbbell rows": "seated_cable_rows.png",
  "cable face pulls": "cable_face_pulls.png",
  "mid rowing": "mid_rowing.png",
  "pull-ups": "pull_ups_bodyweight.png",
  "pull ups": "pull_ups_bodyweight.png",
  "pullup": "pull_ups_bodyweight.png",
  "pullups": "pull_ups_bodyweight.png",
  "pendlay rows": "bent_over_rows_barbell.png",
  // Shoulder
  "overhead press": "overhead_press_barbell.png",
  "overhead press (barbell)": "overhead_press_barbell.png",
  "shoulder press": "dumbbell_shoulder_press.png",
  "lateral raise": "lateral_raise.png",
  "front raise": "front_raise.png",
  "rear delt": "rear_delt.png",
  // Arms
  "bicep curls (barbell)": "biceps_curl_barbel.png",
  "biceps curl": "biceps_curl.png",
  "dumbbell bicep curls": "biceps_curl.png",
  "hammer curls": "hammer_curl.png",
  "hammer curl": "hammer_curl.png",
  "hammer curls (dumbbells)": "hammer_curl.png",
  "hammer curls dumbbells": "hammer_curl.png",
  "triceps pushdowns": "tricep_pushdown.png",
  "tricep pushdown": "tricep_pushdown.png",
  "overhead extension": "overhead_extension.png",
  "single head extension": "single_head_extension.png",
  "triceps machine": "triceps_machine.png",
  // Chest fly
  "cable chest flyes": "cable_chest_flyes.png",
  "pec fly": "pec_fly.png",
  "chest fly": "chest_fly.png",
  // Core
  "crunches": "crunches.png",
  "plank": "plank.png",
  "side plank": "side_plank.png",
  "leg raise": "leg_raise.png",
  // Legs
  "leg press": "leg_press.png",
  "leg extension": "leg_extension.png",
  "leg curl": "leg_curl.png",
  "lying leg curls": "leg_curl.png",
  "calf raises (standing)": "calves_standing.png",
  "standing calf raises": "calves_standing.png",
  "calf raises (standing)": "calves_standing.png",
  "calf raises standing": "calves_standing.png",
  "calves standing": "calves_standing.png",
  "calves seated": "calves_seated.png",
  "hyperextensions": "hyperextension.png",
  // Cardio
  "eliptical": "eliptical.png",
  "cycling": "cycling.png",
  // Add more as needed
};

// Utility: Generate image using Gemini API
async function generateExerciseImage(exerciseName, description) {
  const prompt = `Create a high-quality, professional, app-ready illustration of a person performing the exercise: ${exerciseName}. The background should be white. The person should be clearly demonstrating the correct form for: ${exerciseName}. Highlight the main muscles worked. Style: clear, anatomical, instructional.` + (description ? ` Description: ${description}` : '');
  const geminiUrl = `https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash:generateContent?key=${GEMINI_API_KEY}`;
  const body = {
    contents: [{ parts: [{ text: prompt }] }]
  };
  const response = await fetch(geminiUrl, {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify(body),
  });
  if (!response.ok) {
    console.error('Gemini image API error:', await response.text());
    return null;
  }
  const data = await response.json();
  const parts = data.candidates?.[0]?.content?.parts || [];
  for (const part of parts) {
    if (part.inlineData && part.inlineData.data) {
      return Buffer.from(part.inlineData.data, 'base64');
    }
  }
  return null;
}

// API: Get or generate exercise image
app.get('/api/exercise-image', async (req, res) => {
  // Add CORS headers manually
  res.header('Access-Control-Allow-Origin', '*');
  res.header('Access-Control-Allow-Methods', 'GET, POST, PUT, DELETE, OPTIONS');
  res.header('Access-Control-Allow-Headers', 'Origin, X-Requested-With, Content-Type, Accept, Authorization');
  
  const name = req.query.name;
  const description = req.query.description || '';
  console.log(`🔍 API Request for exercise: "${name}"`);
  
  if (!name) return res.status(400).json({ error: 'Missing exercise name' });
  // --- MAPPING LOGIC ---
  const nameKey = name.toLowerCase().replace(/[^a-z0-9]/g, ' ').replace(/\s+/g, ' ').trim();
  const mappedFile = exerciseImageMap[nameKey];
  const fileName = mappedFile || name.toLowerCase().replace(/[^a-z0-9]/g, '_') + '.png';
  const filePath = path.join(IMAGE_DIR, fileName);
  const publicPath = `/images/exercise/${fileName}`;
  
  console.log(`📁 Looking for file: ${filePath}`);
  console.log(`🌐 Public path: ${publicPath}`);

  // Check if image exists
  if (fs.existsSync(filePath)) {
    console.log(`✅ Image found: ${filePath}`);
    return res.json({ imageUrl: publicPath });
  }

  console.log(`❌ Image not found, generating: ${filePath}`);
  // Generate image with Gemini
  try {
    const imageBuffer = await generateExerciseImage(name, description);
    if (imageBuffer) {
      fs.writeFileSync(filePath, imageBuffer);
      console.log(`✅ Image generated and saved: ${filePath}`);
      return res.json({ imageUrl: publicPath });
    } else {
      console.log(`❌ Failed to generate image for: ${name} - returning placeholder`);
      // Return a placeholder image URL instead of error
      return res.json({ imageUrl: '/images/exercise/push_ups.png' });
    }
  } catch (err) {
    console.error('Image generation error:', err);
    console.log(`❌ Image generation failed for: ${name} - returning placeholder`);
    // Return a placeholder image URL instead of error
    return res.json({ imageUrl: '/images/exercise/push_ups.png' });
  }
});

// API: POST endpoint for exercise image generation
app.post('/api/exercise-image', async (req, res) => {
  // Add CORS headers manually
  res.header('Access-Control-Allow-Origin', '*');
  res.header('Access-Control-Allow-Methods', 'GET, POST, PUT, DELETE, OPTIONS');
  res.header('Access-Control-Allow-Headers', 'Origin, X-Requested-With, Content-Type, Accept, Authorization');
  
  const { name, description, category } = req.body;
  console.log(`🔍 POST API Request for exercise: "${name}"`);
  
  if (!name) return res.status(400).json({ error: 'Missing exercise name' });
  
  // --- MAPPING LOGIC ---
  const nameKey = name.toLowerCase().replace(/[^a-z0-9]/g, ' ').replace(/\s+/g, ' ').trim();
  const mappedFile = exerciseImageMap[nameKey];
  const fileName = mappedFile || name.toLowerCase().replace(/[^a-z0-9]/g, '_') + '.png';
  const filePath = path.join(IMAGE_DIR, fileName);
  const publicPath = `/images/exercise/${fileName}`;
  
  console.log(`📁 Looking for file: ${filePath}`);
  console.log(`🌐 Public path: ${publicPath}`);

  // Check if image exists
  if (fs.existsSync(filePath)) {
    console.log(`✅ Image found: ${filePath}`);
    return res.json({ 
      imageUrl: publicPath,
      exerciseName: name,
      category: category || 'general'
    });
  }

  console.log(`❌ Image not found, generating: ${filePath}`);
  // Generate image with Gemini
  try {
    const imageBuffer = await generateExerciseImage(name, description);
    if (imageBuffer) {
      fs.writeFileSync(filePath, imageBuffer);
      console.log(`✅ Image generated and saved: ${filePath}`);
      return res.json({ 
        imageUrl: publicPath,
        exerciseName: name,
        category: category || 'general'
      });
    } else {
      console.log(`❌ Failed to generate image for: ${name} - returning placeholder`);
      // Return a placeholder image URL instead of error
      return res.json({ 
        imageUrl: '/images/exercise/push_ups.png',
        exerciseName: name,
        category: category || 'general'
      });
    }
  } catch (err) {
    console.error('Image generation error:', err);
    console.log(`❌ Image generation failed for: ${name} - returning placeholder`);
    // Return a placeholder image URL instead of error
    return res.json({ 
      imageUrl: '/images/exercise/push_ups.png',
      exerciseName: name,
      category: category || 'general'
    });
  }
});

// Serve static images
app.use('/images', express.static(path.join(__dirname, 'public', 'images')));

const PORT = process.env.PORT || 4000;
app.listen(PORT, () => {
  console.log(`Exercise image API running on http://localhost:${PORT}`);
}); 