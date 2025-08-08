-- Create category_exercises table for storing AI-generated exercises by category
CREATE TABLE IF NOT EXISTS "public"."category_exercises" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "category_id" "text" NOT NULL,
    "exercise_name" "text" NOT NULL,
    "exercise_data" "jsonb" NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    CONSTRAINT "category_exercises_pkey" PRIMARY KEY ("id")
);

-- Add indexes for better performance
CREATE INDEX IF NOT EXISTS "category_exercises_category_id_idx" ON "public"."category_exercises" ("category_id");
CREATE INDEX IF NOT EXISTS "category_exercises_created_at_idx" ON "public"."category_exercises" ("created_at");

-- Disable RLS for batch operations (can be enabled later for production)
ALTER TABLE "public"."category_exercises" DISABLE ROW LEVEL SECURITY; 