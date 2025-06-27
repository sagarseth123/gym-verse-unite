-- Create user_weekly_plans table
CREATE TABLE public.user_weekly_plans (
  id UUID NOT NULL DEFAULT gen_random_uuid() PRIMARY KEY,
  user_id UUID REFERENCES auth.users NOT NULL,
  week_start DATE NOT NULL,
  plan_data JSONB NOT NULL,
  created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now(),
  updated_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now(),
  UNIQUE(user_id, week_start)
);

-- RLS Policies
ALTER TABLE public.user_weekly_plans ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Users can view their own weekly plans"
  ON public.user_weekly_plans
  FOR SELECT
  USING (auth.uid() = user_id);

CREATE POLICY "Users can insert their own weekly plans"
  ON public.user_weekly_plans
  FOR INSERT
  WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can update their own weekly plans"
  ON public.user_weekly_plans
  FOR UPDATE
  USING (auth.uid() = user_id);

-- Index for quick lookup
CREATE INDEX idx_user_weekly_plans_user_id_week_start ON public.user_weekly_plans(user_id, week_start); 