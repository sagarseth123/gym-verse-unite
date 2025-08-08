const fs = require('fs');
const path = require('path');

// Configuration
const IMAGE_DIR = path.join(__dirname, 'public/images/exercise');
const SERVER_URL = 'http://localhost:4000';
const BATCH_RESULTS_FILE = '40-exercises-batched-results.json';

// Enhanced mapping dictionary with fuzzy matching support
const EXERCISE_MAPPINGS = {
  // Direct matches
  'push_ups': 'push_ups.png',
  'push_ups_bodyweight': 'push_ups.png',
  'standard_push_ups': 'push_ups.png',
  'pull_ups': 'pull_ups.png',
  'pull_ups_bodyweight': 'pull_ups.png',
  'chin_ups': 'pull_ups.png',
  'squats': 'squats.png',
  'bodyweight_squats': 'squats.png',
  'air_squats': 'squats.png',
  'bench_press': 'bench_press.png',
  'barbell_bench_press': 'bench_press.png',
  'flat_bench_press': 'bench_press.png',
  'deadlift': 'deadlift.png',
  'barbell_deadlift': 'deadlift.png',
  'conventional_deadlift': 'deadlift.png',
  'plank': 'plank.png',
  'forearm_plank': 'plank.png',
  'high_plank': 'plank.png',
  'burpees': 'burpees.png',
  'burpee': 'burpees.png',
  'lunges': 'lunges.png',
  'forward_lunges': 'lunges.png',
  'walking_lunges': 'lunges.png',
  'mountain_climbers': 'mountain_climbers.png',
  'mountain_climber': 'mountain_climbers.png',
  'jumping_jacks': 'jumping_jacks.png',
  'jumping_jack': 'jumping_jacks.png',
  'sit_ups': 'sit_ups.png',
  'sit_up': 'sit_ups.png',
  'crunches': 'crunches.png',
  'crunch': 'crunches.png',
  'dumbbell_curls': 'dumbbell_curls.png',
  'bicep_curls': 'dumbbell_curls.png',
  'shoulder_press': 'shoulder_press.png',
  'overhead_press': 'shoulder_press.png',
  'rows': 'rows.png',
  'bent_over_rows': 'rows.png',
  'lat_pulldowns': 'lat_pulldowns.png',
  'lat_pull_down': 'lat_pulldowns.png',
  'leg_press': 'leg_press.png',
  'leg_press_machine': 'leg_press.png',
  
  // Fuzzy matches for common variations
  'chest_press': 'bench_press.png',
  'incline_bench_press': 'bench_press.png',
  'decline_bench_press': 'bench_press.png',
  'dumbbell_bench_press': 'bench_press.png',
  'incline_dumbbell_press': 'bench_press.png',
  'decline_dumbbell_press': 'bench_press.png',
  'chest_press_incline': 'bench_press.png',
  'chest_press_decline': 'bench_press.png',
  
  'barbell_squat': 'squats.png',
  'back_squat': 'squats.png',
  'front_squat': 'squats.png',
  'goblet_squat': 'squats.png',
  'sumo_squat': 'squats.png',
  'overhead_squat': 'squats.png',
  'barbel_squat': 'squats.png',
  'barbell_back_squat': 'squats.png',
  'front_squats': 'squats.png',
  'back_squats': 'squats.png',
  'barbell_back_squats': 'squats.png',
  
  'romanian_deadlift': 'deadlift.png',
  'sumo_deadlift': 'deadlift.png',
  'barbell_romanian_deadlift_rdl': 'deadlift.png',
  'bodyweight_romanian_deadlift': 'deadlift.png',
  'kettlebell_deadlift': 'deadlift.png',
  'dumbbell_deadlift': 'deadlift.png',
  'romanian_deadlifts': 'deadlift.png',
  
  'bent_over_rows_barbell': 'rows.png',
  'barbell_bent_over_rows': 'rows.png',
  'seated_cable_rows': 'rows.png',
  't_bar_rows': 'rows.png',
  'single_arm_rows': 'rows.png',
  'dumbbell_rows': 'rows.png',
  'barbell_rows': 'rows.png',
  'barbell_bent_over_row': 'rows.png',
  
  'lat_pull_down': 'lat_pulldowns.png',
  'lat_machine': 'lat_pulldowns.png',
  'lat_close_grip': 'lat_pulldowns.png',
  'assisted_pull_ups': 'lat_pulldowns.png',
  
  'bicep_curl': 'dumbbell_curls.png',
  'biceps_curl': 'dumbbell_curls.png',
  'hammer_curl': 'dumbbell_curls.png',
  'biceps_curl_barbel': 'dumbbell_curls.png',
  'biceps_machine': 'dumbbell_curls.png',
  'barbell_curl': 'dumbbell_curls.png',
  'dumbbell_bicep_curls': 'dumbbell_curls.png',
  'dumbbell_bicep_curl': 'dumbbell_curls.png',
  'barbell_bicep_curls': 'dumbbell_curls.png',
  
  'overhead_press_barbell': 'shoulder_press.png',
  'dumbbell_shoulder_press': 'shoulder_press.png',
  'military_press': 'shoulder_press.png',
  'arnold_press': 'shoulder_press.png',
  'overhead_press__dumbbell_': 'shoulder_press.png',
  'barbell_overhead_press': 'shoulder_press.png',
  'dumbbell_overhead_press': 'shoulder_press.png',
  
  'leg_extension': 'leg_press.png',
  'leg_curl': 'leg_press.png',
  'leg_press_machine': 'leg_press.png',
  'hack_squat': 'leg_press.png',
  
  // Core exercises
  'russian_twists': 'crunches.png',
  'bicycle_crunches': 'crunches.png',
  'leg_raises': 'crunches.png',
  'flutter_kicks': 'crunches.png',
  'v_ups': 'crunches.png',
  'superman': 'crunches.png',
  'bird_dogs': 'crunches.png',
  'dead_bug': 'crunches.png',
  'glute_bridges': 'crunches.png',
  'hip_thrusts': 'crunches.png',
  'side_plank': 'crunches.png',
  'leg_raise': 'crunches.png',
  
  // Cardio exercises
  'running': 'jumping_jacks.png',
  'jogging': 'jumping_jacks.png',
  'cycling': 'jumping_jacks.png',
  'elliptical': 'jumping_jacks.png',
  'eliptical': 'jumping_jacks.png',
  'treadmill': 'jumping_jacks.png',
  'rowing': 'jumping_jacks.png',
  'rowing_machine': 'jumping_jacks.png',
  'concept_2_rower': 'jumping_jacks.png',
  'ski_erg': 'jumping_jacks.png',
  'air_bike': 'jumping_jacks.png',
  'assault_bike': 'jumping_jacks.png',
  'stairmaster': 'jumping_jacks.png',
  
  // Stretching and mobility
  'child_s_pose': 'plank.png',
  'cat_cow_pose': 'plank.png',
  'downward_facing_dog': 'plank.png',
  'pigeon_pose': 'plank.png',
  'standing_quadriceps_stretch': 'plank.png',
  
  // Equipment-based exercises
  'kettlebell_swing': 'deadlift.png',
  'kettlebell_swings': 'deadlift.png',
  'kettlebell_goblet_squat': 'squats.png',
  'battle_rope_waves': 'jumping_jacks.png',
  'battle_ropes': 'jumping_jacks.png',
  'medicine_ball_slams': 'jumping_jacks.png',
  'medicine_ball_russian_twist': 'crunches.png',
  'wall_balls': 'squats.png',
  'box_jumps': 'jumping_jacks.png',
  'thrusters': 'squats.png',
  'clean_and_jerk': 'deadlift.png',
  'snatch': 'deadlift.png',
  'turkish_get_up': 'deadlift.png',
  'renegade_rows': 'rows.png',
  'diamond_push_ups': 'push_ups.png',
  'wide_push_ups': 'push_ups.png',
  'close_grip_bench_press': 'bench_press.png',
  'incline_bench_press': 'bench_press.png',
  'decline_bench_press': 'bench_press.png',
  'pec_fly': 'bench_press.png',
  'chest_fly': 'bench_press.png',
  'cable_chest_flyes': 'bench_press.png',
  'cable_flyes': 'bench_press.png',
  'cable_face_pulls': 'rows.png',
  'cable_woodchops': 'crunches.png',
  'anti_rotation_press': 'crunches.png',
  'pallof_press': 'crunches.png',
  
  // Advanced movements
  'plyometric_burpee_with_shoulder_tap': 'burpees.png',
  'mountain_climbers_with_knee_drive_and_rotation': 'mountain_climbers.png',
  'incline_treadmill_sprint_intervals': 'jumping_jacks.png',
  'resistance_band_lateral_walks': 'lunges.png',
  
  // Additional mappings based on movement patterns
  'step_ups': 'lunges.png',
  'split_squats': 'lunges.png',
  'bulgarian_split_squats': 'lunges.png',
  'calf_raises': 'squats.png',
  'calves_seated': 'squats.png',
  'calves_standing': 'squats.png',
  'front_raise': 'shoulder_press.png',
  'lateral_raise': 'shoulder_press.png',
  'rear_delt': 'shoulder_press.png',
  'tricep_pushdown': 'dumbbell_curls.png',
  'cable_triceps_pushdowns': 'dumbbell_curls.png',
  'overhead_extension': 'dumbbell_curls.png',
  'single_head_extension': 'dumbbell_curls.png',
  'triceps_machine': 'dumbbell_curls.png',
  'hyperextension': 'deadlift.png',
  'mid_rowing': 'rows.png',
  'barbel_sides': 'crunches.png',
  'dumbel_sides': 'crunches.png',
  'barbell_sides': 'crunches.png',
  'pec_fly': 'bench_press.png',
  'front_squat': 'squats.png',
  'leg_extension': 'leg_press.png',
  'leg_curl': 'leg_press.png',
  'calves_seated': 'squats.png',
  'eliptical': 'jumping_jacks.png',
  'cycling': 'jumping_jacks.png',
  
  // Dips and related exercises
  'dips': 'dips.png',
  'parallel_bar_dips': 'parallel_bar_dips.png',
  'dips_parallel_bars': 'parallel_bar_dips.png',
  'weighted_dips': 'weighted_dips.png',
  'dips_weighted': 'weighted_dips.png',
  
  // Additional specific mappings
  'pull_ups': 'pull_ups.png',
  'pull_ups_bodyweight': 'pull_ups.png',
  'barbell_overhead_press': 'barbell_overhead_press.png',
  'kettlebell_goblet_squat': 'kettlebell_goblet_squat.png',
  'bodyweight_romanian_deadlift': 'bodyweight_romanian_deadlift.png',
  'medicine_ball_russian_twist': 'medicine_ball_russian_twist.png',
  'kettlebell_swing': 'kettlebell_swing.png',
  'resistance_band_lateral_walks': 'resistance_band_lateral_walks.png',
  'child_s_pose': 'child_s_pose.png',
  'cat_cow_pose': 'cat_cow_pose.png',
  'downward_facing_dog': 'downward_facing_dog.png',
  'pigeon_pose': 'pigeon_pose.png',
  'standing_quadriceps_stretch': 'standing_quadriceps_stretch.png',
  'battle_rope_waves': 'battle_rope_waves.png',
  'plyometric_burpee_with_shoulder_tap': 'plyometric_burpee_with_shoulder_tap.png',
  'incline_treadmill_sprint_intervals': 'incline_treadmill_sprint_intervals.png',
  'mountain_climbers_with_knee_drive_and_rotation': 'mountain_climbers_with_knee_drive_and_rotation.png',
  'overhead_press__dumbbell_': 'overhead_press__dumbbell_.png',
  'barbell_bent_over_rows': 'barbell_bent_over_rows.png'
};

// Fuzzy matching function
function fuzzyMatch(exerciseName, availableImages) {
  // Remove batch information from exercise name
  const cleanName = exerciseName.replace(/\s*\(Batch\s*\d+\)/gi, '');
  
  // Special handling for pull-ups variations
  if (cleanName.toLowerCase().includes('pull') && cleanName.toLowerCase().includes('up')) {
    return 'pull_ups.png';
  }
  
  const normalizedName = cleanName.toLowerCase()
    .replace(/[^a-z0-9\s]/g, '')
    .replace(/\s+/g, '_');
  
  // Direct match
  if (EXERCISE_MAPPINGS[normalizedName]) {
    return EXERCISE_MAPPINGS[normalizedName];
  }
  
  // Partial matching
  for (const [key, value] of Object.entries(EXERCISE_MAPPINGS)) {
    if (normalizedName.includes(key) || key.includes(normalizedName)) {
      return value;
    }
  }
  
  // Word-based matching
  const words = normalizedName.split('_');
  for (const word of words) {
    if (word.length > 3) { // Only consider words longer than 3 characters
      for (const [key, value] of Object.entries(EXERCISE_MAPPINGS)) {
        if (key.includes(word) || word.includes(key)) {
          return value;
        }
      }
    }
  }
  
  return null;
}

// Generate image using server API
async function generateExerciseImage(exerciseName) {
  try {
    console.log(`🎨 Generating image for: ${exerciseName}`);
    
    const response = await fetch(`${SERVER_URL}/api/exercise-image?name=${encodeURIComponent(exerciseName)}`, {
      method: 'GET',
      headers: {
        'Content-Type': 'application/json',
      }
    });
    
    if (!response.ok) {
      console.log(`❌ Server API error for ${exerciseName}: ${response.status}`);
      return null;
    }
    
    const data = await response.json();
    if (data.imageUrl && !data.imageUrl.includes('push_ups.png')) {
      console.log(`✅ Generated image for ${exerciseName}: ${data.imageUrl}`);
      return data.imageUrl;
    } else {
      console.log(`❌ Generated placeholder for ${exerciseName}`);
      return null;
    }
    
  } catch (error) {
    console.log(`❌ Error generating image for ${exerciseName}:`, error.message);
    return null;
  }
}

// Main mapping function
async function mapExerciseToImage(exerciseName) {
  console.log(`🔍 Mapping exercise: "${exerciseName}"`);
  
  // Get available images
  const availableImages = fs.readdirSync(IMAGE_DIR)
    .filter(file => file.endsWith('.png'))
    .map(file => file);
  
  // Try fuzzy matching first
  const fuzzyMatchResult = fuzzyMatch(exerciseName, availableImages);
  if (fuzzyMatchResult && availableImages.includes(fuzzyMatchResult)) {
    console.log(`✅ Fuzzy match found: ${fuzzyMatchResult}`);
    return `/images/exercise/${fuzzyMatchResult}`;
  }
  
  // Try to generate the image using server API
  const generatedImage = await generateExerciseImage(exerciseName);
  if (generatedImage) {
    return generatedImage;
  }
  
  // Fallback to placeholder
  console.log(`❌ No match found, using placeholder`);
  return '/images/exercise/push_ups.png';
}

// Process all exercises from batch results
async function processBatchResults() {
  try {
    console.log('🚀 Starting comprehensive exercise mapping...');
    
    // Read batch results
    const batchData = JSON.parse(fs.readFileSync(BATCH_RESULTS_FILE, 'utf8'));
    
    let totalExercises = 0;
    let matchedCount = 0;
    let generatedCount = 0;
    const unmatchedExercises = [];
    const updatedResults = { ...batchData };
    
    // Process each category
    for (const category of batchData.categories) {
      console.log(`\n📂 Processing category: ${category.categoryName}`);
      
      for (const exercise of category.exercises) {
        totalExercises++;
        console.log(`\n--- Processing: ${exercise.name} ---`);
        
        // Skip if already has a proper image
        if (exercise.imageUrl && !exercise.imageUrl.includes('push_ups.png')) {
          console.log(`⏭️  Already has image: ${exercise.imageUrl}`);
          continue;
        }
        
        const newImageUrl = await mapExerciseToImage(exercise.name);
        
        if (newImageUrl && !newImageUrl.includes('push_ups.png')) {
          // Update the exercise in results
          exercise.imageUrl = newImageUrl;
          console.log(`✅ Updated ${exercise.name} with ${newImageUrl}`);
          matchedCount++;
          
          if (newImageUrl.includes('generated')) {
            generatedCount++;
          }
        } else {
          unmatchedExercises.push(exercise.name);
        }
        
        // Add delay to avoid rate limiting
        await new Promise(resolve => setTimeout(resolve, 200));
      }
    }
    
    // Save updated results
    fs.writeFileSync('updated-exercise-mapping-results.json', JSON.stringify(updatedResults, null, 2));
    
    console.log(`\n🎉 Mapping complete!`);
    console.log(`📊 Total exercises processed: ${totalExercises}`);
    console.log(`📈 Successfully mapped: ${matchedCount} exercises`);
    console.log(`🎨 Generated: ${generatedCount} new images`);
    console.log(`❌ Unmatched: ${unmatchedExercises.length} exercises`);
    
    if (unmatchedExercises.length > 0) {
      console.log('\n📋 Unmatched exercises:');
      unmatchedExercises.forEach(exercise => console.log(`  - ${exercise}`));
    }
    
    // Calculate success rate
    const successRate = ((matchedCount / totalExercises) * 100).toFixed(1);
    console.log(`\n📊 Success rate: ${successRate}%`);
    
  } catch (error) {
    console.error('❌ Error in processBatchResults:', error);
  }
}

// Run the script
if (require.main === module) {
  processBatchResults();
}

module.exports = {
  mapExerciseToImage,
  fuzzyMatch,
  processBatchResults
}; 