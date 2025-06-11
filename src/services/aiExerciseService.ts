
import { supabase } from '@/integrations/supabase/client';

export interface AIGeneratedExercise {
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
}

export class AIExerciseService {
  static async generateExercisesForGoalCategory(
    goalCategory: string, 
    forceRefresh: boolean = false
  ): Promise<AIGeneratedExercise[]> {
    try {
      const { data, error } = await supabase.functions.invoke('generate-ai-exercises', {
        body: {
          goalCategory,
          forceRefresh
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
      console.error('Error in generateExercisesForGoalCategory:', error);
      throw error;
    }
  }

  static async getCachedExercises(goalCategory: string): Promise<AIGeneratedExercise[]> {
    try {
      const { data, error } = await supabase
        .from('ai_exercises_cache')
        .select('exercise_data')
        .eq('goal_category', goalCategory)
        .gte('generated_at', new Date(Date.now() - 24 * 60 * 60 * 1000).toISOString());

      if (error) throw error;

      // Safely cast Json to AIGeneratedExercise via unknown
      return (data || []).map(cache => cache.exercise_data as unknown as AIGeneratedExercise);
    } catch (error) {
      console.error('Error getting cached exercises:', error);
      return [];
    }
  }

  static async getPersonalizedRecommendations(
    userPreferences: any,
    userHistory: any[]
  ): Promise<{
    recommendedCategories: string[];
    suggestedExercises: AIGeneratedExercise[];
  }> {
    try {
      // Get exercises from user's preferred categories
      const preferredCategories = userPreferences?.preferred_goal_categories || ['strength-building'];
      
      // Get recently viewed categories to suggest variety
      const recentCategories = userHistory
        .slice(0, 10)
        .map(h => h.goal_category)
        .filter((cat, index, arr) => arr.indexOf(cat) === index);

      // Suggest new categories not recently explored
      const allCategories = ['strength-building', 'weight-loss', 'calisthenics', 'bulking', 'functional', 'flexibility'];
      const unexploredCategories = allCategories.filter(cat => !recentCategories.includes(cat));

      const recommendedCategories = [
        ...preferredCategories,
        ...unexploredCategories.slice(0, 2)
      ].slice(0, 3);

      // Get suggested exercises from the recommended categories
      const exercisePromises = recommendedCategories.map(category =>
        this.getCachedExercises(category)
      );

      const exerciseArrays = await Promise.all(exercisePromises);
      const allExercises = exerciseArrays.flat();

      // Filter based on user's equipment and difficulty preference
      const userEquipment = userPreferences?.equipment_available || ['bodyweight'];
      const userDifficulty = userPreferences?.difficulty_preference || 'intermediate';

      const suggestedExercises = allExercises
        .filter(exercise => {
          // Check if user has required equipment
          const hasEquipment = exercise.equipment_needed.some(equipment =>
            userEquipment.includes(equipment) || equipment === 'bodyweight'
          );
          
          // Match difficulty preference or allow one level up/down
          const difficultyLevels = ['beginner', 'intermediate', 'advanced'];
          const userDiffIndex = difficultyLevels.indexOf(userDifficulty);
          const exerciseDiffIndex = difficultyLevels.indexOf(exercise.difficulty);
          const difficultyMatch = Math.abs(userDiffIndex - exerciseDiffIndex) <= 1;

          return hasEquipment && difficultyMatch;
        })
        .slice(0, 12); // Limit to 12 suggestions

      return {
        recommendedCategories,
        suggestedExercises
      };
    } catch (error) {
      console.error('Error getting personalized recommendations:', error);
      return {
        recommendedCategories: ['strength-building'],
        suggestedExercises: []
      };
    }
  }
}
