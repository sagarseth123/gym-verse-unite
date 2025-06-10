
-- Create user exercise history table
CREATE TABLE public.user_exercise_history (
  id UUID NOT NULL DEFAULT gen_random_uuid() PRIMARY KEY,
  user_id UUID REFERENCES auth.users NOT NULL,
  exercise_id UUID,
  exercise_name TEXT NOT NULL,
  goal_category TEXT NOT NULL,
  viewed_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now(),
  performed BOOLEAN DEFAULT false,
  notes TEXT,
  created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now()
);

-- Create user exercise preferences table
CREATE TABLE public.user_exercise_preferences (
  id UUID NOT NULL DEFAULT gen_random_uuid() PRIMARY KEY,
  user_id UUID REFERENCES auth.users NOT NULL,
  preferred_goal_categories TEXT[] DEFAULT '{}',
  favorite_exercises TEXT[] DEFAULT '{}',
  equipment_available TEXT[] DEFAULT '{}',
  difficulty_preference TEXT DEFAULT 'intermediate',
  workout_frequency_per_week INTEGER DEFAULT 3,
  session_duration_minutes INTEGER DEFAULT 45,
  created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now(),
  updated_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now(),
  UNIQUE(user_id)
);

-- Create AI generated exercises cache table
CREATE TABLE public.ai_exercises_cache (
  id UUID NOT NULL DEFAULT gen_random_uuid() PRIMARY KEY,
  goal_category TEXT NOT NULL,
  exercise_name TEXT NOT NULL,
  exercise_data JSONB NOT NULL,
  generated_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now(),
  created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now()
);

-- Add Row Level Security (RLS)
ALTER TABLE public.user_exercise_history ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.user_exercise_preferences ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.ai_exercises_cache ENABLE ROW LEVEL SECURITY;

-- RLS Policies for user_exercise_history
CREATE POLICY "Users can view their own exercise history" 
  ON public.user_exercise_history 
  FOR SELECT 
  USING (auth.uid() = user_id);

CREATE POLICY "Users can create their own exercise history" 
  ON public.user_exercise_history 
  FOR INSERT 
  WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can update their own exercise history" 
  ON public.user_exercise_history 
  FOR UPDATE 
  USING (auth.uid() = user_id);

-- RLS Policies for user_exercise_preferences
CREATE POLICY "Users can view their own exercise preferences" 
  ON public.user_exercise_preferences 
  FOR SELECT 
  USING (auth.uid() = user_id);

CREATE POLICY "Users can create their own exercise preferences" 
  ON public.user_exercise_preferences 
  FOR INSERT 
  WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can update their own exercise preferences" 
  ON public.user_exercise_preferences 
  FOR UPDATE 
  USING (auth.uid() = user_id);

-- RLS Policies for ai_exercises_cache (public read access)
CREATE POLICY "Everyone can view cached AI exercises" 
  ON public.ai_exercises_cache 
  FOR SELECT 
  TO public
  USING (true);

CREATE POLICY "Service role can manage AI exercises cache" 
  ON public.ai_exercises_cache 
  FOR ALL 
  TO service_role
  USING (true);

-- Create indexes for better performance
CREATE INDEX idx_user_exercise_history_user_id ON public.user_exercise_history(user_id);
CREATE INDEX idx_user_exercise_history_goal_category ON public.user_exercise_history(goal_category);
CREATE INDEX idx_user_exercise_preferences_user_id ON public.user_exercise_preferences(user_id);
CREATE INDEX idx_ai_exercises_cache_goal_category ON public.ai_exercises_cache(goal_category);
