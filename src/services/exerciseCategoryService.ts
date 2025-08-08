import { supabase } from '@/integrations/supabase/client';
import { FITNESS_GOAL_CATEGORIES } from '@/types/fitness';

export interface CategoryExercise {
  id: string;
  name: string;
  category: string;
  muscle_groups: string[];
  equipment_needed: string[];
  difficulty: 'beginner' | 'intermediate' | 'advanced';
  instructions: string;
  benefits: string[];
  common_mistakes: string[];
  progressions: string[];
  modifications: string[];
  safety_tips: string[];
  sets_reps_guidance: string;
  rest_periods: string;
  tips: string;
  image_url?: string;
  created_at: string;
}

export interface CategoryExerciseData {
  category_id: string;
  exercises: CategoryExercise[];
  total_count: number;
  last_updated: string;
}

export class ExerciseCategoryService {
  static async generateTopExercisesForCategory(
    categoryId: string,
    count: number = 40
  ): Promise<CategoryExercise[]> {
    try {
      console.log(`Generating ${count} exercises for category: ${categoryId}`);
      
      const { data, error } = await supabase.functions.invoke('generate-ai-exercises', {
        body: {
          goalCategory: categoryId,
          exerciseCount: count,
          forceRefresh: true
        }
      });

      if (error) {
        console.error('Error calling generate-ai-exercises function:', error);
        throw error;
      }

      if (data?.exercises) {
        return data.exercises;
      }

      throw new Error('No exercises generated');
    } catch (error) {
      console.error('Error in generateTopExercisesForCategory:', error);
      throw error;
    }
  }

  static async storeExercisesInDatabase(
    categoryId: string,
    exercises: CategoryExercise[]
  ): Promise<void> {
    try {
      console.log(`Storing ${exercises.length} exercises for category: ${categoryId}`);
      
      // First, delete existing exercises for this category
      const { error: deleteError } = await supabase
        .from('category_exercises')
        .delete()
        .eq('category_id', categoryId);

      if (deleteError) {
        console.error('Error deleting existing exercises:', deleteError);
      }

      // Insert new exercises
      const exercisesToInsert = exercises.map(exercise => ({
        category_id: categoryId,
        exercise_data: exercise,
        exercise_name: exercise.name,
        created_at: new Date().toISOString()
      }));

      const { error: insertError } = await supabase
        .from('category_exercises')
        .insert(exercisesToInsert);

      if (insertError) {
        console.error('Error inserting exercises:', insertError);
        throw insertError;
      }

      console.log(`Successfully stored ${exercises.length} exercises for category: ${categoryId}`);
    } catch (error) {
      console.error('Error storing exercises in database:', error);
      throw error;
    }
  }

  static async generateAndStoreImagesForExercises(
    exercises: CategoryExercise[]
  ): Promise<CategoryExercise[]> {
    try {
      console.log(`Generating images for ${exercises.length} exercises`);
      
      const updatedExercises = [];
      
      for (const exercise of exercises) {
        try {
          // Call the image generation API
          const response = await fetch(`http://localhost:4000/api/exercise-image`, {
            method: 'POST',
            headers: {
              'Content-Type': 'application/json',
            },
            body: JSON.stringify({
              name: exercise.name,
              description: exercise.instructions || '',
              category: exercise.category
            })
          });

          if (response.ok) {
            const data = await response.json();
            exercise.image_url = data.imageUrl;
            console.log(`Generated image for ${exercise.name}: ${data.imageUrl}`);
          } else {
            console.warn(`Failed to generate image for ${exercise.name}`);
            exercise.image_url = '/images/exercise/default.png';
          }
        } catch (error) {
          console.error(`Error generating image for ${exercise.name}:`, error);
          exercise.image_url = '/images/exercise/default.png';
        }
        
        updatedExercises.push(exercise);
        
        // Add a small delay to avoid overwhelming the API
        await new Promise(resolve => setTimeout(resolve, 1000));
      }

      return updatedExercises;
    } catch (error) {
      console.error('Error generating images for exercises:', error);
      throw error;
    }
  }

  static async getExercisesForCategory(categoryId: string): Promise<CategoryExercise[]> {
    try {
      const { data, error } = await supabase
        .from('category_exercises')
        .select('exercise_data')
        .eq('category_id', categoryId)
        .order('created_at', { ascending: false });

      if (error) throw error;

      return (data || []).map(item => item.exercise_data as CategoryExercise);
    } catch (error) {
      console.error('Error getting exercises for category:', error);
      return [];
    }
  }

  static async getAllCategoryExercises(): Promise<{ [categoryId: string]: CategoryExercise[] }> {
    try {
      const { data, error } = await supabase
        .from('category_exercises')
        .select('category_id, exercise_data')
        .order('created_at', { ascending: false });

      if (error) throw error;

      const exercisesByCategory: { [categoryId: string]: CategoryExercise[] } = {};
      
      (data || []).forEach(item => {
        const categoryId = item.category_id;
        const exercise = item.exercise_data as CategoryExercise;
        
        if (!exercisesByCategory[categoryId]) {
          exercisesByCategory[categoryId] = [];
        }
        
        exercisesByCategory[categoryId].push(exercise);
      });

      return exercisesByCategory;
    } catch (error) {
      console.error('Error getting all category exercises:', error);
      return {};
    }
  }

  static async generateAllCategoryExercises(): Promise<void> {
    try {
      console.log('Starting generation of exercises for all categories...');
      
      for (const category of FITNESS_GOAL_CATEGORIES) {
        try {
          console.log(`Processing category: ${category.name} (${category.id})`);
          
          // Generate exercises
          const exercises = await this.generateTopExercisesForCategory(category.id, 40);
          
          // Generate images for exercises
          const exercisesWithImages = await this.generateAndStoreImagesForExercises(exercises);
          
          // Store in database
          await this.storeExercisesInDatabase(category.id, exercisesWithImages);
          
          console.log(`✅ Completed category: ${category.name} - ${exercisesWithImages.length} exercises`);
          
          // Add delay between categories to avoid rate limiting
          await new Promise(resolve => setTimeout(resolve, 5000));
          
        } catch (error) {
          console.error(`❌ Error processing category ${category.name}:`, error);
        }
      }
      
      console.log('🎉 Completed generation of exercises for all categories!');
    } catch (error) {
      console.error('Error generating all category exercises:', error);
      throw error;
    }
  }

  static async checkCategoryExerciseStatus(): Promise<{ [categoryId: string]: number }> {
    try {
      const { data, error } = await supabase
        .from('category_exercises')
        .select('category_id')
        .order('created_at', { ascending: false });

      if (error) throw error;

      const counts: { [categoryId: string]: number } = {};
      
      (data || []).forEach(item => {
        const categoryId = item.category_id;
        counts[categoryId] = (counts[categoryId] || 0) + 1;
      });

      return counts;
    } catch (error) {
      console.error('Error checking category exercise status:', error);
      return {};
    }
  }
} 