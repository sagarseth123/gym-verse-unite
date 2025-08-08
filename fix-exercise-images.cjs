const fetch = require('node-fetch');
const fs = require('fs').promises;

// Configuration
const SUPABASE_URL = process.env.SUPABASE_URL || 'http://127.0.0.1:54321';
const SUPABASE_ANON_KEY = process.env.SUPABASE_ANON_KEY || 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZS1kZW1vIiwicm9sZSI6ImFub24iLCJleHAiOjE5ODM4MTI5OTZ9.CRXP1A7WOeoJeXxjNni43kdQwgnWNReilDMblYTn_I0';

// Exercise name to image mapping
const EXERCISE_IMAGE_MAPPING = {
  // Squats
  'barbell back squat': '/images/exercise/barbell_back_squat.png',
  'back squat': '/images/exercise/barbell_back_squat.png',
  'squat': '/images/exercise/barbel_squat.png',
  'front squat': '/images/exercise/front_squat.png',
  'goblet squat': '/images/exercise/goblet_squat.png',
  'sumo squat': '/images/exercise/sumo_squat.png',
  'split squat': '/images/exercise/split_squats.png',
  'bulgarian split squat': '/images/exercise/split_squats.png',
  
  // Deadlifts
  'deadlift': '/images/exercise/romanian_deadlift.png',
  'barbell deadlift': '/images/exercise/romanian_deadlift.png',
  'conventional deadlift': '/images/exercise/romanian_deadlift.png',
  'romanian deadlift': '/images/exercise/barbell_romanian_deadlift_rdl.png',
  'rdl': '/images/exercise/barbell_romanian_deadlift_rdl.png',
  
  // Bench Press
  'bench press': '/images/exercise/chest_press.png',
  'barbell bench press': '/images/exercise/chest_press.png',
  'dumbbell bench press': '/images/exercise/chest_press.png',
  'incline bench press': '/images/exercise/chest_press_incline.png',
  'decline bench press': '/images/exercise/chest_press_decline.png',
  'incline dumbbell press': '/images/exercise/incline_dumbbell_press.png',
  'decline dumbbell press': '/images/exercise/decline_dumbbell_press.png',
  'close grip bench press': '/images/exercise/close_grip_bench_press.png',
  
  // Rows
  'barbell row': '/images/exercise/bent_over_rows_barbell.png',
  'barbell bent-over row': '/images/exercise/bent_over_rows_barbell.png',
  'bent-over barbell row': '/images/exercise/bent_over_rows_barbell.png',
  'dumbbell row': '/images/exercise/bent_over_rows_barbell.png',
  'seated cable row': '/images/exercise/seated_cable_rows.png',
  'cable row': '/images/exercise/seated_cable_rows.png',
  'lat pulldown': '/images/exercise/lat_pull_down.png',
  'pull-up': '/images/exercise/pull_ups_bodyweight.png',
  'pull-ups': '/images/exercise/pull_ups_bodyweight.png',
  
  // Shoulder Press
  'overhead press': '/images/exercise/overhead_press_barbell.png',
  'barbell overhead press': '/images/exercise/overhead_press_barbell.png',
  'shoulder press': '/images/exercise/dumbbell_shoulder_press.png',
  'dumbbell shoulder press': '/images/exercise/dumbbell_shoulder_press.png',
  'dumbbell overhead press': '/images/exercise/dumbbell_shoulder_press.png',
  'lateral raise': '/images/exercise/lateral_raise.png',
  'front raise': '/images/exercise/front_raise.png',
  'rear delt': '/images/exercise/rear_delt.png',
  
  // Dips
  'dip': '/images/exercise/tricep_pushdown.png',
  'dips': '/images/exercise/tricep_pushdown.png',
  'parallel bar dip': '/images/exercise/tricep_pushdown.png',
  'parallel bar dips': '/images/exercise/tricep_pushdown.png',
  
  // Curls
  'bicep curl': '/images/exercise/biceps_curl.png',
  'biceps curl': '/images/exercise/biceps_curl.png',
  'dumbbell bicep curl': '/images/exercise/biceps_curl.png',
  'barbell bicep curl': '/images/exercise/biceps_curl_barbel.png',
  'hammer curl': '/images/exercise/hammer_curl.png',
  'incline dumbbell curl': '/images/exercise/biceps_curl.png',
  
  // Triceps
  'tricep pushdown': '/images/exercise/tricep_pushdown.png',
  'triceps pushdown': '/images/exercise/tricep_pushdown.png',
  'cable triceps pushdown': '/images/exercise/tricep_pushdown.png',
  'overhead extension': '/images/exercise/overhead_extension.png',
  'single head extension': '/images/exercise/single_head_extension.png',
  
  // Legs
  'leg press': '/images/exercise/leg_press.png',
  'leg extension': '/images/exercise/leg_extension.png',
  'leg curl': '/images/exercise/leg_curl.png',
  'calf raise': '/images/exercise/calf_raises.png',
  'calves standing': '/images/exercise/calves_standing.png',
  'calves seated': '/images/exercise/calves_seated.png',
  
  // Cardio
  'treadmill': '/images/exercise/treadmill.png',
  'elliptical': '/images/exercise/elliptical.png',
  'cycling': '/images/exercise/cycling.png',
  'rowing': '/images/exercise/rowing_machine.png',
  'rower': '/images/exercise/rowing_machine.png',
  'stairmaster': '/images/exercise/stairmaster.png',
  
  // Core
  'crunch': '/images/exercise/crunches.png',
  'crunches': '/images/exercise/crunches.png',
  'leg raise': '/images/exercise/leg_raise.png',
  'leg raises': '/images/exercise/leg_raises.png',
  'plank': '/images/exercise/plank.png',
  'side plank': '/images/exercise/side_plank.png',
  'russian twist': '/images/exercise/russian_twists.png',
  'bicycle crunch': '/images/exercise/bicycle_crunches.png',
  'v-up': '/images/exercise/v_ups.png',
  'superman': '/images/exercise/superman.png',
  'glute bridge': '/images/exercise/glute_bridges.png',
  'hip thrust': '/images/exercise/hip_thrusts.png',
  
  // Functional
  'kettlebell swing': '/images/exercise/kettlebell_swings.png',
  'box jump': '/images/exercise/box_jumps.png',
  'wall ball': '/images/exercise/wall_balls.png',
  'thruster': '/images/exercise/thrusters.png',
  'clean and jerk': '/images/exercise/clean_and_jerk.png',
  'snatch': '/images/exercise/snatch.png',
  'turkish get up': '/images/exercise/turkish_get_up.png',
  'renegade row': '/images/exercise/renegade_rows.png',
  
  // Push-ups
  'push-up': '/images/exercise/push_ups.png',
  'push-ups': '/images/exercise/push_ups.png',
  'wide push-up': '/images/exercise/wide_push_ups.png',
  'diamond push-up': '/images/exercise/diamond_push_ups.png',
  
  // Face pulls
  'face pull': '/images/exercise/cable_face_pulls.png',
  'cable face pull': '/images/exercise/cable_face_pulls.png',
  
  // Flyes
  'chest fly': '/images/exercise/chest_fly.png',
  'cable fly': '/images/exercise/cable_chest_flyes.png',
  'cable flye': '/images/exercise/cable_chest_flyes.png',
  'pec fly': '/images/exercise/pec_fly.png',
  
  // Lunges
  'lunge': '/images/exercise/dumbbell_lunges.png',
  'dumbbell lunge': '/images/exercise/dumbbell_lunges.png',
  'walking lunge': '/images/exercise/dumbbell_lunges.png',
  
  // Good mornings
  'good morning': '/images/exercise/barbell_good_mornings.png',
  'barbell good morning': '/images/exercise/barbell_good_mornings.png',
  
  // Step ups
  'step up': '/images/exercise/step_ups.png',
  'step-up': '/images/exercise/step_ups.png',
  
  // Battle ropes
  'battle rope': '/images/exercise/battle_ropes.png',
  'battle ropes': '/images/exercise/battle_ropes.png',
  
  // Medicine ball
  'medicine ball slam': '/images/exercise/medicine_ball_slams.png',
  'medicine ball': '/images/exercise/medicine_ball_slams.png',
  
  // Cable exercises
  'cable woodchop': '/images/exercise/cable_woodchops.png',
  'pallof press': '/images/exercise/pallof_press.png',
  'anti-rotation press': '/images/exercise/anti_rotation_press.png',
  
  // Core stability
  'dead bug': '/images/exercise/dead_bug.png',
  'bird dog': '/images/exercise/bird_dogs.png',
  'flutter kick': '/images/exercise/flutter_kicks.png',
  
  // Machines
  'biceps machine': '/images/exercise/biceps_machine.png',
  'triceps machine': '/images/exercise/triceps_machine.png',
  'lat machine': '/images/exercise/lat_machine.png',
  'leg press machine': '/images/exercise/leg_press.png',
  
  // Sides
  'barbell side': '/images/exercise/barbell_sides.png',
  'dumbbell side': '/images/exercise/dumbel_sides.png',
  'barbell sides': '/images/exercise/barbel_sides.png',
  
  // Hyperextension
  'hyperextension': '/images/exercise/hyperextension.png',
  'back extension': '/images/exercise/hyperextension.png'
};

function findBestImageMatch(exerciseName) {
  const normalizedName = exerciseName.toLowerCase().replace(/\([^)]*\)/g, '').trim();
  
  // Direct match
  if (EXERCISE_IMAGE_MAPPING[normalizedName]) {
    return EXERCISE_IMAGE_MAPPING[normalizedName];
  }
  
  // Partial matches
  for (const [key, image] of Object.entries(EXERCISE_IMAGE_MAPPING)) {
    if (normalizedName.includes(key) || key.includes(normalizedName)) {
      return image;
    }
  }
  
  // Word-based matching
  const words = normalizedName.split(/\s+/);
  for (const word of words) {
    if (word.length > 3) { // Only match words longer than 3 characters
      for (const [key, image] of Object.entries(EXERCISE_IMAGE_MAPPING)) {
        if (key.includes(word) || word.includes(key)) {
          return image;
        }
      }
    }
  }
  
  // Default fallbacks based on exercise type
  if (normalizedName.includes('squat')) return '/images/exercise/barbell_back_squat.png';
  if (normalizedName.includes('deadlift')) return '/images/exercise/romanian_deadlift.png';
  if (normalizedName.includes('bench') || normalizedName.includes('press')) return '/images/exercise/chest_press.png';
  if (normalizedName.includes('row')) return '/images/exercise/bent_over_rows_barbell.png';
  if (normalizedName.includes('curl')) return '/images/exercise/biceps_curl.png';
  if (normalizedName.includes('press') || normalizedName.includes('shoulder')) return '/images/exercise/dumbbell_shoulder_press.png';
  if (normalizedName.includes('dip')) return '/images/exercise/tricep_pushdown.png';
  if (normalizedName.includes('pull')) return '/images/exercise/pull_ups_bodyweight.png';
  if (normalizedName.includes('leg')) return '/images/exercise/leg_press.png';
  if (normalizedName.includes('cardio') || normalizedName.includes('run')) return '/images/exercise/treadmill.png';
  if (normalizedName.includes('core') || normalizedName.includes('ab')) return '/images/exercise/crunches.png';
  
  // Ultimate fallback
  return '/images/exercise/push_ups.png';
}

async function updateExerciseImages() {
  console.log('🔄 Updating exercise images with proper mappings...');
  
  try {
    // Get all exercises from database
    const response = await fetch(`${SUPABASE_URL}/rest/v1/category_exercises?select=*`, {
      headers: {
        'Authorization': `Bearer ${SUPABASE_ANON_KEY}`,
        'apikey': SUPABASE_ANON_KEY
      }
    });

    if (!response.ok) {
      throw new Error(`Failed to fetch exercises: ${response.status}`);
    }

    const exercises = await response.json();
    console.log(`📊 Found ${exercises.length} exercises to update`);

    let updatedCount = 0;
    const updatePromises = exercises.map(async (exercise) => {
      try {
        const exerciseName = exercise.exercise_name.replace(/\s*\(Batch \d+\)/, ''); // Remove batch info
        const properImageUrl = findBestImageMatch(exerciseName);
        
        // Update the exercise data with proper image
        const updatedExerciseData = {
          ...exercise.exercise_data,
          imageUrl: properImageUrl
        };

        // Update in database
        const updateResponse = await fetch(`${SUPABASE_URL}/rest/v1/category_exercises?id=eq.${exercise.id}`, {
          method: 'PATCH',
          headers: {
            'Content-Type': 'application/json',
            'Authorization': `Bearer ${SUPABASE_ANON_KEY}`,
            'apikey': SUPABASE_ANON_KEY
          },
          body: JSON.stringify({
            exercise_data: updatedExerciseData
          })
        });

        if (updateResponse.ok) {
          updatedCount++;
          console.log(`✅ Updated: ${exerciseName} -> ${properImageUrl}`);
        } else {
          console.log(`❌ Failed to update: ${exerciseName}`);
        }
      } catch (error) {
        console.log(`❌ Error updating ${exercise.exercise_name}:`, error.message);
      }
    });

    await Promise.all(updatePromises);
    console.log(`\n🎉 Successfully updated ${updatedCount} exercises with proper images!`);

  } catch (error) {
    console.error('❌ Error updating exercise images:', error.message);
  }
}

// Run the update
updateExerciseImages(); 