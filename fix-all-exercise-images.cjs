const fs = require('fs');
const path = require('path');

// Configuration
const IMAGE_DIR = path.join(__dirname, 'public/images/exercise');
const BATCH_RESULTS_FILE = '40-exercises-batched-results.json';

// Enhanced mapping dictionary with comprehensive coverage
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
  
  // Cable exercises
  'cable_flyes': 'cable_chest_flyes.png',
  'cable_fly': 'cable_chest_flyes.png',
  'cable_chest_flyes': 'cable_chest_flyes.png',
  'cable_triceps_pushdowns': 'tricep_pushdown.png',
  'cable_triceps_pushdown': 'tricep_pushdown.png',
  'triceps_pushdowns': 'tricep_pushdown.png',
  'triceps_pushdown': 'tricep_pushdown.png',
  'cable_rows': 'seated_cable_rows.png',
  'cable_face_pulls': 'cable_face_pulls.png',
  'cable_face_pull': 'cable_face_pulls.png',
  
  // Barbell exercises
  'barbell_bicep_curls': 'biceps_curl_barbel.png',
  'barbell_bicep_curl': 'biceps_curl_barbel.png',
  'barbell_bent_over_row': 'bent_over_rows_barbell.png',
  'barbell_bent_over_rows': 'bent_over_rows_barbell.png',
  'bent_over_barbell_row': 'bent_over_rows_barbell.png',
  'bent_over_barbell_rows': 'bent_over_rows_barbell.png',
  'barbell_overhead_press': 'overhead_press_barbell.png',
  'overhead_barbell_press': 'overhead_press_barbell.png',
  'barbell_back_squat': 'barbell_back_squat.png',
  'barbell_back_squats': 'barbell_back_squat.png',
  
  // Dumbbell exercises
  'dumbbell_overhead_press': 'dumbbell_shoulder_press.png',
  'dumbbell_shoulder_press': 'dumbbell_shoulder_press.png',
  'dumbbell_bench_press': 'incline_dumbbell_press.png',
  'dumbbell_bicep_curl': 'biceps_curl.png',
  'dumbbell_bicep_curls': 'biceps_curl.png',
  'dumbbell_rows': 'seated_cable_rows.png',
  'dumbbell_romanian_deadlift': 'barbell_romanian_deadlift_rdl.png',
  'dumbbell_romanian_deadlifts': 'barbell_romanian_deadlift_rdl.png',
  'dumbbell_lunges': 'dumbbell_lunges.png',
  'dumbbell_walking_lunges': 'dumbbell_lunges.png',
  
  // Dips variations
  'dips': 'dips.png',
  'parallel_bar_dips': 'parallel_bar_dips.png',
  'dips_parallel_bars': 'parallel_bar_dips.png',
  'weighted_dips': 'weighted_dips.png',
  'dips_weighted': 'weighted_dips.png',
  
  // Romanian deadlift variations
  'romanian_deadlift': 'barbell_romanian_deadlift_rdl.png',
  'romanian_deadlifts': 'barbell_romanian_deadlift_rdl.png',
  'rdl': 'barbell_romanian_deadlift_rdl.png',
  
  // Additional specific mappings
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
  'barbell_bent_over_rows': 'barbell_bent_over_rows.png',
  
  // Fuzzy matches for common variations
  'chest_press': 'bench_press.png',
  'incline_bench_press': 'bench_press.png',
  'decline_bench_press': 'bench_press.png',
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
  'front_squats': 'squats.png',
  'back_squats': 'squats.png',
  
  'sumo_deadlift': 'deadlift.png',
  'kettlebell_deadlift': 'deadlift.png',
  'dumbbell_deadlift': 'deadlift.png',
  
  'bent_over_rows_barbell': 'rows.png',
  'seated_cable_rows': 'rows.png',
  't_bar_rows': 'rows.png',
  'single_arm_rows': 'rows.png',
  'barbell_rows': 'rows.png',
  
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
  'barbell_bicep_curls': 'dumbbell_curls.png',
  
  'military_press': 'shoulder_press.png',
  'arnold_press': 'shoulder_press.png',
  'dumbbell_overhead_press': 'shoulder_press.png',
  
  'leg_extension': 'leg_press.png',
  'leg_curl': 'leg_press.png',
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
  
  // Equipment-based exercises
  'kettlebell_swings': 'deadlift.png',
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
  'pec_fly': 'bench_press.png',
  'chest_fly': 'bench_press.png',
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
  'overhead_extension': 'dumbbell_curls.png',
  'single_head_extension': 'dumbbell_curls.png',
  'triceps_machine': 'dumbbell_curls.png',
  'hyperextension': 'deadlift.png',
  'mid_rowing': 'rows.png',
  'barbel_sides': 'crunches.png',
  'dumbel_sides': 'crunches.png',
  'barbell_sides': 'crunches.png',
  'front_squat': 'squats.png',
  'leg_extension': 'leg_press.png',
  'leg_curl': 'leg_press.png',
  'eliptical': 'jumping_jacks.png',
  'cycling': 'jumping_jacks.png'
};

// Fuzzy matching function with enhanced logic
function fuzzyMatch(exerciseName) {
  // Remove batch information from exercise name
  const cleanName = exerciseName.replace(/\s*\(Batch\s*\d+\)/gi, '');
  
  // Special handling for pull-ups variations
  if (cleanName.toLowerCase().includes('pull') && cleanName.toLowerCase().includes('up')) {
    return 'pull_ups.png';
  }
  
  // Special handling for dips variations
  if (cleanName.toLowerCase().includes('dip')) {
    if (cleanName.toLowerCase().includes('weighted')) {
      return 'weighted_dips.png';
    } else if (cleanName.toLowerCase().includes('parallel')) {
      return 'parallel_bar_dips.png';
    } else {
      return 'dips.png';
    }
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

// Copy existing image as fallback
function copyExistingImage(sourceName, targetName) {
  try {
    const sourcePath = path.join(IMAGE_DIR, sourceName);
    const targetPath = path.join(IMAGE_DIR, targetName);
    
    if (fs.existsSync(sourcePath)) {
      fs.copyFileSync(sourcePath, targetPath);
      console.log(`✅ Copied ${sourceName} to ${targetName}`);
      return true;
    } else {
      console.log(`❌ Source image not found: ${sourceName}`);
      return false;
    }
  } catch (error) {
    console.log(`❌ Error copying image:`, error.message);
    return false;
  }
}

// Create missing images using fallbacks
function createMissingImages() {
  console.log('\n🔄 Creating missing images using fallbacks...');
  
  const fallbackMappings = [
    // Cable exercises
    { source: 'cable_chest_flyes.png', target: 'cable_flyes.png' },
    { source: 'tricep_pushdown.png', target: 'cable_triceps_pushdowns.png' },
    { source: 'biceps_curl_barbel.png', target: 'barbell_bicep_curls.png' },
    { source: 'bent_over_rows_barbell.png', target: 'barbell_bent_over_row.png' },
    { source: 'dumbbell_shoulder_press.png', target: 'dumbbell_overhead_press.png' },
    { source: 'barbell_romanian_deadlift_rdl.png', target: 'romanian_deadlift.png' },
    { source: 'weighted_dips.png', target: 'dips_weighted.png' },
    { source: 'pull_ups.png', target: 'pull_ups_batch.png' },
    
    // Additional fallbacks for common missing images
    { source: 'seated_cable_rows.png', target: 'cable_rows.png' },
    { source: 'cable_face_pulls.png', target: 'cable_face_pull.png' },
    { source: 'incline_dumbbell_press.png', target: 'dumbbell_bench_press.png' },
    { source: 'biceps_curl.png', target: 'dumbbell_bicep_curl.png' },
    { source: 'dumbbell_lunges.png', target: 'dumbbell_walking_lunges.png' },
    { source: 'overhead_press_barbell.png', target: 'barbell_overhead_press.png' },
    { source: 'barbell_back_squat.png', target: 'barbell_back_squats.png' }
  ];
  
  for (const mapping of fallbackMappings) {
    const targetPath = path.join(IMAGE_DIR, mapping.target);
    if (!fs.existsSync(targetPath)) {
      copyExistingImage(mapping.source, mapping.target);
    }
  }
}

// Main mapping function
function mapExerciseToImage(exerciseName) {
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
  
  // Fallback to placeholder
  console.log(`❌ No match found, using placeholder`);
  return '/images/exercise/push_ups.png';
}

// Process all exercises from batch results
function processBatchResults() {
  try {
    console.log('🚀 Starting comprehensive exercise mapping for all categories...');
    
    // Read batch results
    const batchData = JSON.parse(fs.readFileSync(BATCH_RESULTS_FILE, 'utf8'));
    
    let totalExercises = 0;
    let matchedCount = 0;
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
        
        const newImageUrl = mapExerciseToImage(exercise.name);
        
        if (newImageUrl && !newImageUrl.includes('push_ups.png')) {
          // Update the exercise in results
          exercise.imageUrl = newImageUrl;
          console.log(`✅ Updated ${exercise.name} with ${newImageUrl}`);
          matchedCount++;
        } else {
          unmatchedExercises.push(exercise.name);
        }
      }
    }
    
    // Create missing images using fallbacks
    createMissingImages();
    
    // Save updated results
    fs.writeFileSync('fixed-exercise-mapping-results.json', JSON.stringify(updatedResults, null, 2));
    
    console.log(`\n🎉 Mapping complete!`);
    console.log(`📊 Total exercises processed: ${totalExercises}`);
    console.log(`📈 Successfully mapped: ${matchedCount} exercises`);
    console.log(`❌ Unmatched: ${unmatchedExercises.length} exercises`);
    
    if (unmatchedExercises.length > 0) {
      console.log('\n📋 Unmatched exercises:');
      unmatchedExercises.forEach(exercise => console.log(`  - ${exercise}`));
    }
    
    console.log(`\n📊 Success rate: ${((matchedCount / totalExercises) * 100).toFixed(1)}%`);
    
    // Check Gemini API status
    console.log(`\n⚠️  Gemini API Status: OUT OF QUOTA`);
    console.log(`📝 Manual actions needed:`);
    console.log(`   1. Wait for API quota reset or upgrade to paid plan`);
    console.log(`   2. Generate images for unmatched exercises when quota is available`);
    console.log(`   3. Or manually add specific images for unmatched exercises`);
    
  } catch (error) {
    console.error('❌ Error processing batch results:', error);
  }
}

// Run the script
if (require.main === module) {
  processBatchResults();
}

module.exports = {
  fuzzyMatch,
  copyExistingImage,
  createMissingImages,
  mapExerciseToImage,
  processBatchResults
}; 