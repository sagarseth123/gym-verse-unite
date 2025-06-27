-- Create user_goals table
CREATE TABLE IF NOT EXISTS user_goals (
  user_id uuid PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,
  weekly_workouts integer,
  weight_goal numeric,
  streak_goal integer,
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now()
);

-- Trigger to update updated_at on row update
CREATE OR REPLACE FUNCTION update_user_goals_updated_at()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = now();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS set_user_goals_updated_at ON user_goals;
CREATE TRIGGER set_user_goals_updated_at
BEFORE UPDATE ON user_goals
FOR EACH ROW EXECUTE FUNCTION update_user_goals_updated_at(); 