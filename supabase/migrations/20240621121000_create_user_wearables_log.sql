-- Create user_wearables_log table
CREATE TABLE IF NOT EXISTS user_wearables_log (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id uuid REFERENCES auth.users(id) ON DELETE CASCADE,
  date date NOT NULL,
  steps integer,
  sleep numeric, -- hours
  heart_rate integer, -- bpm
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now(),
  UNIQUE (user_id, date)
);

-- Trigger to update updated_at on row update
CREATE OR REPLACE FUNCTION update_user_wearables_log_updated_at()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = now();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS set_user_wearables_log_updated_at ON user_wearables_log;
CREATE TRIGGER set_user_wearables_log_updated_at
BEFORE UPDATE ON user_wearables_log
FOR EACH ROW EXECUTE FUNCTION update_user_wearables_log_updated_at(); 