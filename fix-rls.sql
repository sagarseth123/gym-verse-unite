-- Disable RLS for category_exercises table to allow batch inserts
ALTER TABLE public.category_exercises DISABLE ROW LEVEL SECURITY;

-- Or alternatively, create a policy to allow anon inserts
-- CREATE POLICY "Allow anon insert" ON public.category_exercises
--   FOR INSERT WITH CHECK (true);
-- 
-- CREATE POLICY "Allow anon select" ON public.category_exercises
--   FOR SELECT USING (true); 