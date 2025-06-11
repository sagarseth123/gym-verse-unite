
import { useState, useEffect } from 'react';
import { supabase } from '@/integrations/supabase/client';
import { useToast } from '@/hooks/use-toast';

export interface ExerciseHistoryEntry {
  id: string;
  exercise_id?: string;
  exercise_name: string;
  goal_category: string;
  viewed_at: string;
  performed: boolean;
  notes?: string;
}

export function useExerciseHistory() {
  const [history, setHistory] = useState<ExerciseHistoryEntry[]>([]);
  const [loading, setLoading] = useState(true);
  const { toast } = useToast();

  const loadHistory = async () => {
    try {
      const { data, error } = await supabase
        .from('user_exercise_history')
        .select('*')
        .order('viewed_at', { ascending: false })
        .limit(50);

      if (error) throw error;
      setHistory(data || []);
    } catch (error: any) {
      console.error('Error loading exercise history:', error);
      toast({
        title: "Error",
        description: "Failed to load exercise history",
        variant: "destructive",
      });
    } finally {
      setLoading(false);
    }
  };

  const addToHistory = async (exercise: {
    exercise_id?: string;
    exercise_name: string;
    goal_category: string;
    performed?: boolean;
    notes?: string;
  }) => {
    try {
      const { data: { user } } = await supabase.auth.getUser();
      if (!user) return;

      // Generate a proper UUID if exercise_id is invalid or not provided
      let validExerciseId = null;
      if (exercise.exercise_id && exercise.exercise_id.length >= 32) {
        validExerciseId = exercise.exercise_id;
      }

      const { error } = await supabase
        .from('user_exercise_history')
        .insert({
          user_id: user.id,
          exercise_id: validExerciseId,
          exercise_name: exercise.exercise_name,
          goal_category: exercise.goal_category,
          performed: exercise.performed || false,
          notes: exercise.notes
        });

      if (error) throw error;
      
      // Reload history to show the new entry
      loadHistory();
    } catch (error: any) {
      console.error('Error adding to exercise history:', error);
      toast({
        title: "Error",
        description: "Failed to save exercise to history",
        variant: "destructive",
      });
    }
  };

  const markAsPerformed = async (historyId: string, notes?: string) => {
    try {
      const { error } = await supabase
        .from('user_exercise_history')
        .update({ 
          performed: true,
          notes: notes 
        })
        .eq('id', historyId);

      if (error) throw error;
      
      loadHistory();
      toast({
        title: "Success",
        description: "Exercise marked as performed!",
      });
    } catch (error: any) {
      console.error('Error updating exercise history:', error);
      toast({
        title: "Error",
        description: "Failed to update exercise status",
        variant: "destructive",
      });
    }
  };

  useEffect(() => {
    loadHistory();
  }, []);

  return {
    history,
    loading,
    addToHistory,
    markAsPerformed,
    refreshHistory: loadHistory
  };
}
