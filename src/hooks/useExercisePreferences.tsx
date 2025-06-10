
import { useState, useEffect } from 'react';
import { supabase } from '@/integrations/supabase/client';
import { useToast } from '@/hooks/use-toast';

export interface ExercisePreferences {
  id?: string;
  preferred_goal_categories: string[];
  favorite_exercises: string[];
  equipment_available: string[];
  difficulty_preference: string;
  workout_frequency_per_week: number;
  session_duration_minutes: number;
}

export function useExercisePreferences() {
  const [preferences, setPreferences] = useState<ExercisePreferences | null>(null);
  const [loading, setLoading] = useState(true);
  const { toast } = useToast();

  const loadPreferences = async () => {
    try {
      const { data: { user } } = await supabase.auth.getUser();
      if (!user) {
        setLoading(false);
        return;
      }

      const { data, error } = await supabase
        .from('user_exercise_preferences')
        .select('*')
        .eq('user_id', user.id)
        .maybeSingle();

      if (error) throw error;
      
      if (data) {
        setPreferences(data);
      } else {
        // Create default preferences
        const defaultPrefs = {
          preferred_goal_categories: ['strength-building'],
          favorite_exercises: [],
          equipment_available: ['bodyweight'],
          difficulty_preference: 'intermediate',
          workout_frequency_per_week: 3,
          session_duration_minutes: 45
        };
        setPreferences(defaultPrefs);
      }
    } catch (error: any) {
      console.error('Error loading exercise preferences:', error);
      toast({
        title: "Error",
        description: "Failed to load exercise preferences",
        variant: "destructive",
      });
    } finally {
      setLoading(false);
    }
  };

  const updatePreferences = async (updates: Partial<ExercisePreferences>) => {
    try {
      const { data: { user } } = await supabase.auth.getUser();
      if (!user) return;

      const updatedPrefs = { ...preferences, ...updates };
      
      const { data, error } = await supabase
        .from('user_exercise_preferences')
        .upsert({
          user_id: user.id,
          ...updatedPrefs,
          updated_at: new Date().toISOString()
        })
        .select()
        .single();

      if (error) throw error;
      
      setPreferences(data);
      toast({
        title: "Success",
        description: "Exercise preferences updated!",
      });
    } catch (error: any) {
      console.error('Error updating exercise preferences:', error);
      toast({
        title: "Error",
        description: "Failed to update exercise preferences",
        variant: "destructive",
      });
    }
  };

  const addFavoriteExercise = async (exerciseName: string) => {
    if (!preferences) return;
    
    const newFavorites = [...preferences.favorite_exercises];
    if (!newFavorites.includes(exerciseName)) {
      newFavorites.push(exerciseName);
      await updatePreferences({ favorite_exercises: newFavorites });
    }
  };

  const removeFavoriteExercise = async (exerciseName: string) => {
    if (!preferences) return;
    
    const newFavorites = preferences.favorite_exercises.filter(name => name !== exerciseName);
    await updatePreferences({ favorite_exercises: newFavorites });
  };

  useEffect(() => {
    loadPreferences();
  }, []);

  return {
    preferences,
    loading,
    updatePreferences,
    addFavoriteExercise,
    removeFavoriteExercise,
    refreshPreferences: loadPreferences
  };
}
