const fs = require('fs');
const path = require('path');
const { createClient } = require('@supabase/supabase-js');

// Configuration
const SUPABASE_URL = process.env.SUPABASE_URL || 'http://127.0.0.1:54321';
const SUPABASE_SERVICE_ROLE_KEY = process.env.SUPABASE_SERVICE_ROLE_KEY || 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZS1kZW1vIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImV4cCI6MTk4MzgxMjk5Nn0.EGIM96RAZx35lJzdJsyH-qQwv8Hdp7fsn3W0YpN81IU';
const MAPPING_RESULTS_FILE = 'updated-exercise-mapping-results.json';

// Initialize Supabase client
const supabase = createClient(SUPABASE_URL, SUPABASE_SERVICE_ROLE_KEY);

// Load mapping results
const mappingResults = JSON.parse(fs.readFileSync(MAPPING_RESULTS_FILE, 'utf8'));

// Create a map of exercise names to image URLs
const exerciseImageMap = new Map();

// Process all categories and exercises
mappingResults.categories.forEach(category => {
  category.exercises.forEach(exercise => {
    // Remove batch information for matching
    const cleanName = exercise.name.replace(/\s*\(Batch\s*\d+\)/gi, '');
    exerciseImageMap.set(cleanName.toLowerCase(), exercise.imageUrl);
  });
});

console.log(`📊 Loaded ${exerciseImageMap.size} exercise mappings`);

async function updateSupabaseExercises() {
  try {
    console.log('🔄 Starting Supabase exercise image updates...');
    
    // Get all exercises from category_exercises table
    const { data: exercises, error } = await supabase
      .from('category_exercises')
      .select('*');
    
    if (error) {
      console.error('❌ Error fetching exercises:', error);
      return;
    }
    
    console.log(`📋 Found ${exercises.length} exercises in database`);
    
    let updatedCount = 0;
    let skippedCount = 0;
    
    for (const exercise of exercises) {
      try {
        const exerciseData = exercise.exercise_data;
        const exerciseName = exercise.exercise_name;
        
        // Clean the exercise name for matching
        const cleanName = exerciseName.replace(/\s*\(Batch\s*\d+\)/gi, '');
        const mappedImageUrl = exerciseImageMap.get(cleanName.toLowerCase());
        
        if (mappedImageUrl && exerciseData.image_url !== mappedImageUrl) {
          // Update the exercise data with new image URL
          const updatedExerciseData = {
            ...exerciseData,
            image_url: mappedImageUrl
          };
          
          // Update the database record
          const { error: updateError } = await supabase
            .from('category_exercises')
            .update({
              exercise_data: updatedExerciseData
            })
            .eq('id', exercise.id);
          
          if (updateError) {
            console.error(`❌ Error updating ${exerciseName}:`, updateError);
          } else {
            console.log(`✅ Updated ${exerciseName} with ${mappedImageUrl}`);
            updatedCount++;
          }
        } else {
          if (mappedImageUrl) {
            console.log(`⏭️  ${exerciseName} already has correct image: ${exerciseData.image_url}`);
          } else {
            console.log(`❓ No mapping found for: ${exerciseName}`);
          }
          skippedCount++;
        }
        
        // Add a small delay to avoid overwhelming the database
        await new Promise(resolve => setTimeout(resolve, 100));
        
      } catch (error) {
        console.error(`❌ Error processing ${exercise.exercise_name}:`, error);
      }
    }
    
    console.log('\n🎉 Update complete!');
    console.log(`✅ Updated: ${updatedCount} exercises`);
    console.log(`⏭️  Skipped: ${skippedCount} exercises`);
    console.log(`📊 Total processed: ${exercises.length} exercises`);
    
  } catch (error) {
    console.error('❌ Error in updateSupabaseExercises:', error);
  }
}

// Run the update
updateSupabaseExercises(); 