

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;


COMMENT ON SCHEMA "public" IS 'standard public schema';



CREATE EXTENSION IF NOT EXISTS "pg_graphql" WITH SCHEMA "graphql";






CREATE EXTENSION IF NOT EXISTS "pg_stat_statements" WITH SCHEMA "extensions";






CREATE EXTENSION IF NOT EXISTS "pgcrypto" WITH SCHEMA "extensions";






CREATE EXTENSION IF NOT EXISTS "supabase_vault" WITH SCHEMA "vault";






CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA "extensions";






CREATE TYPE "public"."fitness_goal" AS ENUM (
    'gain_muscle',
    'lose_weight',
    'calisthenics',
    'bulking',
    'basic_fitness',
    'bodybuilding',
    'heavy_lifting'
);


ALTER TYPE "public"."fitness_goal" OWNER TO "postgres";


CREATE TYPE "public"."subscription_status" AS ENUM (
    'active',
    'inactive',
    'cancelled',
    'expired'
);


ALTER TYPE "public"."subscription_status" OWNER TO "postgres";


CREATE TYPE "public"."training_type" AS ENUM (
    'strength',
    'cardio',
    'yoga',
    'pilates',
    'crossfit',
    'martial_arts',
    'swimming',
    'cycling'
);


ALTER TYPE "public"."training_type" OWNER TO "postgres";


CREATE TYPE "public"."user_role" AS ENUM (
    'gym_admin',
    'gym_user'
);


ALTER TYPE "public"."user_role" OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."handle_new_user"() RETURNS "trigger"
    LANGUAGE "plpgsql" SECURITY DEFINER
    AS $$
BEGIN
    -- Insert into profiles table
    INSERT INTO public.profiles (id, email, full_name, user_role)
    VALUES (
        new.id,
        new.email,
        COALESCE(new.raw_user_meta_data->>'full_name', ''),
        COALESCE((new.raw_user_meta_data->>'user_role')::user_role, 'gym_user'::user_role)
    );
    
    -- If user is a gym_user, also create gym_user_profile
    IF COALESCE((new.raw_user_meta_data->>'user_role')::user_role, 'gym_user'::user_role) = 'gym_user'::user_role THEN
        INSERT INTO public.gym_user_profiles (id)
        VALUES (new.id);
    END IF;
    
    RETURN new;
EXCEPTION
    WHEN OTHERS THEN
        -- Log the error but don't block user creation
        RAISE LOG 'Error in handle_new_user trigger: %', SQLERRM;
        RETURN new;
END;
$$;


ALTER FUNCTION "public"."handle_new_user"() OWNER TO "postgres";

SET default_tablespace = '';

SET default_table_access_method = "heap";


CREATE TABLE IF NOT EXISTS "public"."ai_exercises_cache" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "goal_category" "text" NOT NULL,
    "exercise_name" "text" NOT NULL,
    "exercise_data" "jsonb" NOT NULL,
    "generated_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL
);


ALTER TABLE "public"."ai_exercises_cache" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."exercises" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "name" "text" NOT NULL,
    "category" "text" NOT NULL,
    "muscle_groups" "text"[],
    "equipment_needed" "text"[],
    "difficulty_level" "text",
    "instructions" "text",
    "tips" "text",
    "image_url" "text",
    "video_url" "text",
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL
);


ALTER TABLE "public"."exercises" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."gym_equipment" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "gym_id" "uuid" NOT NULL,
    "name" "text" NOT NULL,
    "quantity" integer DEFAULT 1 NOT NULL,
    "condition" "text",
    "description" "text",
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL
);


ALTER TABLE "public"."gym_equipment" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."gym_subscriptions" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "user_id" "uuid" NOT NULL,
    "gym_id" "uuid" NOT NULL,
    "plan_id" "uuid" NOT NULL,
    "start_date" "date" NOT NULL,
    "end_date" "date" NOT NULL,
    "status" "public"."subscription_status" DEFAULT 'active'::"public"."subscription_status" NOT NULL,
    "trainer_id" "uuid",
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL
);


ALTER TABLE "public"."gym_subscriptions" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."gym_user_profiles" (
    "id" "uuid" NOT NULL,
    "weight" numeric(5,2),
    "height" numeric(5,2),
    "bmi" numeric(4,2),
    "fitness_goals" "public"."fitness_goal"[],
    "current_gym_id" "uuid",
    "fitness_level" "text",
    "medical_conditions" "text"[],
    "preferred_training_types" "public"."training_type"[],
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "updated_at" timestamp with time zone DEFAULT "now"() NOT NULL
);


ALTER TABLE "public"."gym_user_profiles" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."gyms" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "admin_id" "uuid" NOT NULL,
    "name" "text" NOT NULL,
    "description" "text",
    "area_sqft" integer,
    "address" "text" NOT NULL,
    "city" "text" NOT NULL,
    "state" "text" NOT NULL,
    "postal_code" "text",
    "phone" "text",
    "email" "text",
    "website" "text",
    "operating_hours" "jsonb",
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "updated_at" timestamp with time zone DEFAULT "now"() NOT NULL
);


ALTER TABLE "public"."gyms" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."nutrition" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "name" "text" NOT NULL,
    "category" "text" NOT NULL,
    "calories_per_100g" integer,
    "protein_per_100g" numeric(5,2),
    "carbs_per_100g" numeric(5,2),
    "fat_per_100g" numeric(5,2),
    "fiber_per_100g" numeric(5,2),
    "vitamins" "jsonb",
    "minerals" "jsonb",
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL
);


ALTER TABLE "public"."nutrition" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."personal_trainers" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "gym_id" "uuid" NOT NULL,
    "name" "text" NOT NULL,
    "experience_years" integer,
    "specializations" "text"[],
    "hourly_rate" numeric(10,2),
    "bio" "text",
    "certifications" "text"[],
    "available_hours" "jsonb",
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL
);


ALTER TABLE "public"."personal_trainers" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."products" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "name" "text" NOT NULL,
    "description" "text",
    "price" numeric(10,2) NOT NULL,
    "category" "text" NOT NULL,
    "brand" "text",
    "image_url" "text",
    "in_stock" boolean DEFAULT true,
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL
);


ALTER TABLE "public"."products" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."profiles" (
    "id" "uuid" NOT NULL,
    "email" "text" NOT NULL,
    "full_name" "text",
    "user_role" "public"."user_role" DEFAULT 'gym_user'::"public"."user_role" NOT NULL,
    "phone" "text",
    "address" "text",
    "city" "text",
    "state" "text",
    "postal_code" "text",
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "updated_at" timestamp with time zone DEFAULT "now"() NOT NULL
);


ALTER TABLE "public"."profiles" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."subscription_plans" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "gym_id" "uuid" NOT NULL,
    "name" "text" NOT NULL,
    "description" "text",
    "price" numeric(10,2) NOT NULL,
    "duration_months" integer NOT NULL,
    "features" "text"[],
    "trainer_sessions_included" integer DEFAULT 0,
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL
);


ALTER TABLE "public"."subscription_plans" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."user_exercise_history" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "user_id" "uuid" NOT NULL,
    "exercise_id" "uuid",
    "exercise_name" "text" NOT NULL,
    "goal_category" "text" NOT NULL,
    "viewed_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "performed" boolean DEFAULT false,
    "notes" "text",
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL
);


ALTER TABLE "public"."user_exercise_history" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."user_exercise_preferences" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "user_id" "uuid" NOT NULL,
    "preferred_goal_categories" "text"[] DEFAULT '{}'::"text"[],
    "favorite_exercises" "text"[] DEFAULT '{}'::"text"[],
    "equipment_available" "text"[] DEFAULT '{}'::"text"[],
    "difficulty_preference" "text" DEFAULT 'intermediate'::"text",
    "workout_frequency_per_week" integer DEFAULT 3,
    "session_duration_minutes" integer DEFAULT 45,
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "updated_at" timestamp with time zone DEFAULT "now"() NOT NULL
);


ALTER TABLE "public"."user_exercise_preferences" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."user_nutrition_log" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "user_id" "uuid" NOT NULL,
    "food_id" "uuid" NOT NULL,
    "quantity_grams" numeric(6,2) NOT NULL,
    "meal_type" "text" NOT NULL,
    "log_date" "date" DEFAULT CURRENT_DATE NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL
);


ALTER TABLE "public"."user_nutrition_log" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."user_workouts" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "user_id" "uuid" NOT NULL,
    "exercise_id" "uuid" NOT NULL,
    "sets" integer,
    "reps" integer,
    "weight" numeric(5,2),
    "duration_minutes" integer,
    "notes" "text",
    "workout_date" "date" DEFAULT CURRENT_DATE NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL
);


ALTER TABLE "public"."user_workouts" OWNER TO "postgres";


ALTER TABLE ONLY "public"."ai_exercises_cache"
    ADD CONSTRAINT "ai_exercises_cache_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."exercises"
    ADD CONSTRAINT "exercises_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."gym_equipment"
    ADD CONSTRAINT "gym_equipment_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."gym_subscriptions"
    ADD CONSTRAINT "gym_subscriptions_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."gym_user_profiles"
    ADD CONSTRAINT "gym_user_profiles_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."gyms"
    ADD CONSTRAINT "gyms_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."nutrition"
    ADD CONSTRAINT "nutrition_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."personal_trainers"
    ADD CONSTRAINT "personal_trainers_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."products"
    ADD CONSTRAINT "products_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."profiles"
    ADD CONSTRAINT "profiles_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."subscription_plans"
    ADD CONSTRAINT "subscription_plans_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."user_exercise_history"
    ADD CONSTRAINT "user_exercise_history_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."user_exercise_preferences"
    ADD CONSTRAINT "user_exercise_preferences_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."user_exercise_preferences"
    ADD CONSTRAINT "user_exercise_preferences_user_id_key" UNIQUE ("user_id");



ALTER TABLE ONLY "public"."user_nutrition_log"
    ADD CONSTRAINT "user_nutrition_log_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."user_workouts"
    ADD CONSTRAINT "user_workouts_pkey" PRIMARY KEY ("id");



CREATE INDEX "idx_ai_exercises_cache_goal_category" ON "public"."ai_exercises_cache" USING "btree" ("goal_category");



CREATE INDEX "idx_user_exercise_history_goal_category" ON "public"."user_exercise_history" USING "btree" ("goal_category");



CREATE INDEX "idx_user_exercise_history_user_id" ON "public"."user_exercise_history" USING "btree" ("user_id");



CREATE INDEX "idx_user_exercise_preferences_user_id" ON "public"."user_exercise_preferences" USING "btree" ("user_id");



ALTER TABLE ONLY "public"."gym_equipment"
    ADD CONSTRAINT "gym_equipment_gym_id_fkey" FOREIGN KEY ("gym_id") REFERENCES "public"."gyms"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."gym_subscriptions"
    ADD CONSTRAINT "gym_subscriptions_gym_id_fkey" FOREIGN KEY ("gym_id") REFERENCES "public"."gyms"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."gym_subscriptions"
    ADD CONSTRAINT "gym_subscriptions_plan_id_fkey" FOREIGN KEY ("plan_id") REFERENCES "public"."subscription_plans"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."gym_subscriptions"
    ADD CONSTRAINT "gym_subscriptions_trainer_id_fkey" FOREIGN KEY ("trainer_id") REFERENCES "public"."personal_trainers"("id");



ALTER TABLE ONLY "public"."gym_subscriptions"
    ADD CONSTRAINT "gym_subscriptions_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "public"."gym_user_profiles"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."gym_user_profiles"
    ADD CONSTRAINT "gym_user_profiles_current_gym_id_fkey" FOREIGN KEY ("current_gym_id") REFERENCES "public"."gyms"("id");



ALTER TABLE ONLY "public"."gym_user_profiles"
    ADD CONSTRAINT "gym_user_profiles_id_fkey" FOREIGN KEY ("id") REFERENCES "public"."profiles"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."gyms"
    ADD CONSTRAINT "gyms_admin_id_fkey" FOREIGN KEY ("admin_id") REFERENCES "public"."profiles"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."personal_trainers"
    ADD CONSTRAINT "personal_trainers_gym_id_fkey" FOREIGN KEY ("gym_id") REFERENCES "public"."gyms"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."profiles"
    ADD CONSTRAINT "profiles_id_fkey" FOREIGN KEY ("id") REFERENCES "auth"."users"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."subscription_plans"
    ADD CONSTRAINT "subscription_plans_gym_id_fkey" FOREIGN KEY ("gym_id") REFERENCES "public"."gyms"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."user_exercise_history"
    ADD CONSTRAINT "user_exercise_history_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "auth"."users"("id");



ALTER TABLE ONLY "public"."user_exercise_preferences"
    ADD CONSTRAINT "user_exercise_preferences_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "auth"."users"("id");



ALTER TABLE ONLY "public"."user_nutrition_log"
    ADD CONSTRAINT "user_nutrition_log_food_id_fkey" FOREIGN KEY ("food_id") REFERENCES "public"."nutrition"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."user_nutrition_log"
    ADD CONSTRAINT "user_nutrition_log_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "public"."gym_user_profiles"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."user_workouts"
    ADD CONSTRAINT "user_workouts_exercise_id_fkey" FOREIGN KEY ("exercise_id") REFERENCES "public"."exercises"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."user_workouts"
    ADD CONSTRAINT "user_workouts_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "public"."gym_user_profiles"("id") ON DELETE CASCADE;



CREATE POLICY "Anyone can view exercises" ON "public"."exercises" FOR SELECT TO "authenticated" USING (true);



CREATE POLICY "Anyone can view nutrition data" ON "public"."nutrition" FOR SELECT TO "authenticated" USING (true);



CREATE POLICY "Anyone can view products" ON "public"."products" FOR SELECT TO "authenticated" USING (true);



CREATE POLICY "Everyone can view cached AI exercises" ON "public"."ai_exercises_cache" FOR SELECT USING (true);



CREATE POLICY "Gym admins can manage their equipment" ON "public"."gym_equipment" USING (("gym_id" IN ( SELECT "gyms"."id"
   FROM "public"."gyms"
  WHERE ("gyms"."admin_id" = "auth"."uid"()))));



CREATE POLICY "Gym admins can manage their gyms" ON "public"."gyms" USING (("admin_id" = "auth"."uid"()));



CREATE POLICY "Gym admins can manage their plans" ON "public"."subscription_plans" USING (("gym_id" IN ( SELECT "gyms"."id"
   FROM "public"."gyms"
  WHERE ("gyms"."admin_id" = "auth"."uid"()))));



CREATE POLICY "Gym admins can manage their trainers" ON "public"."personal_trainers" USING (("gym_id" IN ( SELECT "gyms"."id"
   FROM "public"."gyms"
  WHERE ("gyms"."admin_id" = "auth"."uid"()))));



CREATE POLICY "Gym admins can view their gym subscriptions" ON "public"."gym_subscriptions" FOR SELECT USING (("gym_id" IN ( SELECT "gyms"."id"
   FROM "public"."gyms"
  WHERE ("gyms"."admin_id" = "auth"."uid"()))));



CREATE POLICY "Gym admins can view their subscribers" ON "public"."gym_user_profiles" FOR SELECT USING (("current_gym_id" IN ( SELECT "gyms"."id"
   FROM "public"."gyms"
  WHERE ("gyms"."admin_id" = "auth"."uid"()))));



CREATE POLICY "Service role can manage AI exercises cache" ON "public"."ai_exercises_cache" TO "service_role" USING (true);



CREATE POLICY "Users can create subscriptions" ON "public"."gym_subscriptions" FOR INSERT WITH CHECK (("user_id" = "auth"."uid"()));



CREATE POLICY "Users can create their own exercise history" ON "public"."user_exercise_history" FOR INSERT WITH CHECK (("auth"."uid"() = "user_id"));



CREATE POLICY "Users can create their own exercise preferences" ON "public"."user_exercise_preferences" FOR INSERT WITH CHECK (("auth"."uid"() = "user_id"));



CREATE POLICY "Users can insert their own gym profile" ON "public"."gym_user_profiles" FOR INSERT WITH CHECK (("auth"."uid"() = "id"));



CREATE POLICY "Users can insert their own profile" ON "public"."profiles" FOR INSERT WITH CHECK (("auth"."uid"() = "id"));



CREATE POLICY "Users can manage their own gym profile" ON "public"."gym_user_profiles" USING (("id" = "auth"."uid"()));



CREATE POLICY "Users can manage their own nutrition log" ON "public"."user_nutrition_log" USING (("user_id" = "auth"."uid"()));



CREATE POLICY "Users can manage their own workouts" ON "public"."user_workouts" USING (("user_id" = "auth"."uid"()));



CREATE POLICY "Users can update their own exercise history" ON "public"."user_exercise_history" FOR UPDATE USING (("auth"."uid"() = "user_id"));



CREATE POLICY "Users can update their own exercise preferences" ON "public"."user_exercise_preferences" FOR UPDATE USING (("auth"."uid"() = "user_id"));



CREATE POLICY "Users can update their own gym profile" ON "public"."gym_user_profiles" FOR UPDATE USING (("auth"."uid"() = "id"));



CREATE POLICY "Users can update their own profile" ON "public"."profiles" FOR UPDATE USING (("auth"."uid"() = "id"));



CREATE POLICY "Users can view all gyms" ON "public"."gyms" FOR SELECT TO "authenticated" USING (true);



CREATE POLICY "Users can view gym equipment" ON "public"."gym_equipment" FOR SELECT TO "authenticated" USING (true);



CREATE POLICY "Users can view subscription plans" ON "public"."subscription_plans" FOR SELECT TO "authenticated" USING (true);



CREATE POLICY "Users can view their own exercise history" ON "public"."user_exercise_history" FOR SELECT USING (("auth"."uid"() = "user_id"));



CREATE POLICY "Users can view their own exercise preferences" ON "public"."user_exercise_preferences" FOR SELECT USING (("auth"."uid"() = "user_id"));



CREATE POLICY "Users can view their own gym profile" ON "public"."gym_user_profiles" FOR SELECT USING (("auth"."uid"() = "id"));



CREATE POLICY "Users can view their own profile" ON "public"."profiles" FOR SELECT USING (("auth"."uid"() = "id"));



CREATE POLICY "Users can view their own subscriptions" ON "public"."gym_subscriptions" FOR SELECT USING (("user_id" = "auth"."uid"()));



CREATE POLICY "Users can view trainers" ON "public"."personal_trainers" FOR SELECT TO "authenticated" USING (true);



ALTER TABLE "public"."ai_exercises_cache" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."exercises" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."gym_equipment" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."gym_subscriptions" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."gym_user_profiles" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."gyms" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."nutrition" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."personal_trainers" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."products" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."profiles" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."subscription_plans" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."user_exercise_history" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."user_exercise_preferences" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."user_nutrition_log" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."user_workouts" ENABLE ROW LEVEL SECURITY;




ALTER PUBLICATION "supabase_realtime" OWNER TO "postgres";


GRANT USAGE ON SCHEMA "public" TO "postgres";
GRANT USAGE ON SCHEMA "public" TO "anon";
GRANT USAGE ON SCHEMA "public" TO "authenticated";
GRANT USAGE ON SCHEMA "public" TO "service_role";

























































































































































GRANT ALL ON FUNCTION "public"."handle_new_user"() TO "anon";
GRANT ALL ON FUNCTION "public"."handle_new_user"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."handle_new_user"() TO "service_role";


















GRANT ALL ON TABLE "public"."ai_exercises_cache" TO "anon";
GRANT ALL ON TABLE "public"."ai_exercises_cache" TO "authenticated";
GRANT ALL ON TABLE "public"."ai_exercises_cache" TO "service_role";



GRANT ALL ON TABLE "public"."exercises" TO "anon";
GRANT ALL ON TABLE "public"."exercises" TO "authenticated";
GRANT ALL ON TABLE "public"."exercises" TO "service_role";



GRANT ALL ON TABLE "public"."gym_equipment" TO "anon";
GRANT ALL ON TABLE "public"."gym_equipment" TO "authenticated";
GRANT ALL ON TABLE "public"."gym_equipment" TO "service_role";



GRANT ALL ON TABLE "public"."gym_subscriptions" TO "anon";
GRANT ALL ON TABLE "public"."gym_subscriptions" TO "authenticated";
GRANT ALL ON TABLE "public"."gym_subscriptions" TO "service_role";



GRANT ALL ON TABLE "public"."gym_user_profiles" TO "anon";
GRANT ALL ON TABLE "public"."gym_user_profiles" TO "authenticated";
GRANT ALL ON TABLE "public"."gym_user_profiles" TO "service_role";



GRANT ALL ON TABLE "public"."gyms" TO "anon";
GRANT ALL ON TABLE "public"."gyms" TO "authenticated";
GRANT ALL ON TABLE "public"."gyms" TO "service_role";



GRANT ALL ON TABLE "public"."nutrition" TO "anon";
GRANT ALL ON TABLE "public"."nutrition" TO "authenticated";
GRANT ALL ON TABLE "public"."nutrition" TO "service_role";



GRANT ALL ON TABLE "public"."personal_trainers" TO "anon";
GRANT ALL ON TABLE "public"."personal_trainers" TO "authenticated";
GRANT ALL ON TABLE "public"."personal_trainers" TO "service_role";



GRANT ALL ON TABLE "public"."products" TO "anon";
GRANT ALL ON TABLE "public"."products" TO "authenticated";
GRANT ALL ON TABLE "public"."products" TO "service_role";



GRANT ALL ON TABLE "public"."profiles" TO "anon";
GRANT ALL ON TABLE "public"."profiles" TO "authenticated";
GRANT ALL ON TABLE "public"."profiles" TO "service_role";



GRANT ALL ON TABLE "public"."subscription_plans" TO "anon";
GRANT ALL ON TABLE "public"."subscription_plans" TO "authenticated";
GRANT ALL ON TABLE "public"."subscription_plans" TO "service_role";



GRANT ALL ON TABLE "public"."user_exercise_history" TO "anon";
GRANT ALL ON TABLE "public"."user_exercise_history" TO "authenticated";
GRANT ALL ON TABLE "public"."user_exercise_history" TO "service_role";



GRANT ALL ON TABLE "public"."user_exercise_preferences" TO "anon";
GRANT ALL ON TABLE "public"."user_exercise_preferences" TO "authenticated";
GRANT ALL ON TABLE "public"."user_exercise_preferences" TO "service_role";



GRANT ALL ON TABLE "public"."user_nutrition_log" TO "anon";
GRANT ALL ON TABLE "public"."user_nutrition_log" TO "authenticated";
GRANT ALL ON TABLE "public"."user_nutrition_log" TO "service_role";



GRANT ALL ON TABLE "public"."user_workouts" TO "anon";
GRANT ALL ON TABLE "public"."user_workouts" TO "authenticated";
GRANT ALL ON TABLE "public"."user_workouts" TO "service_role";









ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON SEQUENCES  TO "postgres";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON SEQUENCES  TO "anon";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON SEQUENCES  TO "authenticated";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON SEQUENCES  TO "service_role";






ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON FUNCTIONS  TO "postgres";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON FUNCTIONS  TO "anon";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON FUNCTIONS  TO "authenticated";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON FUNCTIONS  TO "service_role";






ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON TABLES  TO "postgres";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON TABLES  TO "anon";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON TABLES  TO "authenticated";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON TABLES  TO "service_role";






























RESET ALL;
