export type Json =
  | string
  | number
  | boolean
  | null
  | { [key: string]: Json | undefined }
  | Json[]

export type Database = {
  public: {
    Tables: {
      exercises: {
        Row: {
          category: string
          created_at: string
          difficulty_level: string | null
          equipment_needed: string[] | null
          id: string
          image_url: string | null
          instructions: string | null
          muscle_groups: string[] | null
          name: string
          tips: string | null
          video_url: string | null
        }
        Insert: {
          category: string
          created_at?: string
          difficulty_level?: string | null
          equipment_needed?: string[] | null
          id?: string
          image_url?: string | null
          instructions?: string | null
          muscle_groups?: string[] | null
          name: string
          tips?: string | null
          video_url?: string | null
        }
        Update: {
          category?: string
          created_at?: string
          difficulty_level?: string | null
          equipment_needed?: string[] | null
          id?: string
          image_url?: string | null
          instructions?: string | null
          muscle_groups?: string[] | null
          name?: string
          tips?: string | null
          video_url?: string | null
        }
        Relationships: []
      }
      gym_equipment: {
        Row: {
          condition: string | null
          created_at: string
          description: string | null
          gym_id: string
          id: string
          name: string
          quantity: number
        }
        Insert: {
          condition?: string | null
          created_at?: string
          description?: string | null
          gym_id: string
          id?: string
          name: string
          quantity?: number
        }
        Update: {
          condition?: string | null
          created_at?: string
          description?: string | null
          gym_id?: string
          id?: string
          name?: string
          quantity?: number
        }
        Relationships: [
          {
            foreignKeyName: "gym_equipment_gym_id_fkey"
            columns: ["gym_id"]
            isOneToOne: false
            referencedRelation: "gyms"
            referencedColumns: ["id"]
          },
        ]
      }
      gym_subscriptions: {
        Row: {
          created_at: string
          end_date: string
          gym_id: string
          id: string
          plan_id: string
          start_date: string
          status: Database["public"]["Enums"]["subscription_status"]
          trainer_id: string | null
          user_id: string
        }
        Insert: {
          created_at?: string
          end_date: string
          gym_id: string
          id?: string
          plan_id: string
          start_date: string
          status?: Database["public"]["Enums"]["subscription_status"]
          trainer_id?: string | null
          user_id: string
        }
        Update: {
          created_at?: string
          end_date?: string
          gym_id?: string
          id?: string
          plan_id?: string
          start_date?: string
          status?: Database["public"]["Enums"]["subscription_status"]
          trainer_id?: string | null
          user_id?: string
        }
        Relationships: [
          {
            foreignKeyName: "gym_subscriptions_gym_id_fkey"
            columns: ["gym_id"]
            isOneToOne: false
            referencedRelation: "gyms"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "gym_subscriptions_plan_id_fkey"
            columns: ["plan_id"]
            isOneToOne: false
            referencedRelation: "subscription_plans"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "gym_subscriptions_trainer_id_fkey"
            columns: ["trainer_id"]
            isOneToOne: false
            referencedRelation: "personal_trainers"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "gym_subscriptions_user_id_fkey"
            columns: ["user_id"]
            isOneToOne: false
            referencedRelation: "gym_user_profiles"
            referencedColumns: ["id"]
          },
        ]
      }
      gym_user_profiles: {
        Row: {
          bmi: number | null
          created_at: string
          current_gym_id: string | null
          fitness_goals: Database["public"]["Enums"]["fitness_goal"][] | null
          fitness_level: string | null
          height: number | null
          id: string
          medical_conditions: string[] | null
          preferred_training_types:
            | Database["public"]["Enums"]["training_type"][]
            | null
          updated_at: string
          weight: number | null
        }
        Insert: {
          bmi?: number | null
          created_at?: string
          current_gym_id?: string | null
          fitness_goals?: Database["public"]["Enums"]["fitness_goal"][] | null
          fitness_level?: string | null
          height?: number | null
          id: string
          medical_conditions?: string[] | null
          preferred_training_types?:
            | Database["public"]["Enums"]["training_type"][]
            | null
          updated_at?: string
          weight?: number | null
        }
        Update: {
          bmi?: number | null
          created_at?: string
          current_gym_id?: string | null
          fitness_goals?: Database["public"]["Enums"]["fitness_goal"][] | null
          fitness_level?: string | null
          height?: number | null
          id?: string
          medical_conditions?: string[] | null
          preferred_training_types?:
            | Database["public"]["Enums"]["training_type"][]
            | null
          updated_at?: string
          weight?: number | null
        }
        Relationships: [
          {
            foreignKeyName: "gym_user_profiles_current_gym_id_fkey"
            columns: ["current_gym_id"]
            isOneToOne: false
            referencedRelation: "gyms"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "gym_user_profiles_id_fkey"
            columns: ["id"]
            isOneToOne: true
            referencedRelation: "profiles"
            referencedColumns: ["id"]
          },
        ]
      }
      gyms: {
        Row: {
          address: string
          admin_id: string
          area_sqft: number | null
          city: string
          created_at: string
          description: string | null
          email: string | null
          id: string
          name: string
          operating_hours: Json | null
          phone: string | null
          postal_code: string | null
          state: string
          updated_at: string
          website: string | null
        }
        Insert: {
          address: string
          admin_id: string
          area_sqft?: number | null
          city: string
          created_at?: string
          description?: string | null
          email?: string | null
          id?: string
          name: string
          operating_hours?: Json | null
          phone?: string | null
          postal_code?: string | null
          state: string
          updated_at?: string
          website?: string | null
        }
        Update: {
          address?: string
          admin_id?: string
          area_sqft?: number | null
          city?: string
          created_at?: string
          description?: string | null
          email?: string | null
          id?: string
          name?: string
          operating_hours?: Json | null
          phone?: string | null
          postal_code?: string | null
          state?: string
          updated_at?: string
          website?: string | null
        }
        Relationships: [
          {
            foreignKeyName: "gyms_admin_id_fkey"
            columns: ["admin_id"]
            isOneToOne: false
            referencedRelation: "profiles"
            referencedColumns: ["id"]
          },
        ]
      }
      nutrition: {
        Row: {
          calories_per_100g: number | null
          carbs_per_100g: number | null
          category: string
          created_at: string
          fat_per_100g: number | null
          fiber_per_100g: number | null
          id: string
          minerals: Json | null
          name: string
          protein_per_100g: number | null
          vitamins: Json | null
        }
        Insert: {
          calories_per_100g?: number | null
          carbs_per_100g?: number | null
          category: string
          created_at?: string
          fat_per_100g?: number | null
          fiber_per_100g?: number | null
          id?: string
          minerals?: Json | null
          name: string
          protein_per_100g?: number | null
          vitamins?: Json | null
        }
        Update: {
          calories_per_100g?: number | null
          carbs_per_100g?: number | null
          category?: string
          created_at?: string
          fat_per_100g?: number | null
          fiber_per_100g?: number | null
          id?: string
          minerals?: Json | null
          name?: string
          protein_per_100g?: number | null
          vitamins?: Json | null
        }
        Relationships: []
      }
      personal_trainers: {
        Row: {
          available_hours: Json | null
          bio: string | null
          certifications: string[] | null
          created_at: string
          experience_years: number | null
          gym_id: string
          hourly_rate: number | null
          id: string
          name: string
          specializations: string[] | null
        }
        Insert: {
          available_hours?: Json | null
          bio?: string | null
          certifications?: string[] | null
          created_at?: string
          experience_years?: number | null
          gym_id: string
          hourly_rate?: number | null
          id?: string
          name: string
          specializations?: string[] | null
        }
        Update: {
          available_hours?: Json | null
          bio?: string | null
          certifications?: string[] | null
          created_at?: string
          experience_years?: number | null
          gym_id?: string
          hourly_rate?: number | null
          id?: string
          name?: string
          specializations?: string[] | null
        }
        Relationships: [
          {
            foreignKeyName: "personal_trainers_gym_id_fkey"
            columns: ["gym_id"]
            isOneToOne: false
            referencedRelation: "gyms"
            referencedColumns: ["id"]
          },
        ]
      }
      products: {
        Row: {
          brand: string | null
          category: string
          created_at: string
          description: string | null
          id: string
          image_url: string | null
          in_stock: boolean | null
          name: string
          price: number
        }
        Insert: {
          brand?: string | null
          category: string
          created_at?: string
          description?: string | null
          id?: string
          image_url?: string | null
          in_stock?: boolean | null
          name: string
          price: number
        }
        Update: {
          brand?: string | null
          category?: string
          created_at?: string
          description?: string | null
          id?: string
          image_url?: string | null
          in_stock?: boolean | null
          name?: string
          price?: number
        }
        Relationships: []
      }
      profiles: {
        Row: {
          address: string | null
          city: string | null
          created_at: string
          email: string
          full_name: string | null
          id: string
          phone: string | null
          postal_code: string | null
          state: string | null
          updated_at: string
          user_role: Database["public"]["Enums"]["user_role"]
        }
        Insert: {
          address?: string | null
          city?: string | null
          created_at?: string
          email: string
          full_name?: string | null
          id: string
          phone?: string | null
          postal_code?: string | null
          state?: string | null
          updated_at?: string
          user_role?: Database["public"]["Enums"]["user_role"]
        }
        Update: {
          address?: string | null
          city?: string | null
          created_at?: string
          email?: string
          full_name?: string | null
          id?: string
          phone?: string | null
          postal_code?: string | null
          state?: string | null
          updated_at?: string
          user_role?: Database["public"]["Enums"]["user_role"]
        }
        Relationships: []
      }
      subscription_plans: {
        Row: {
          created_at: string
          description: string | null
          duration_months: number
          features: string[] | null
          gym_id: string
          id: string
          name: string
          price: number
          trainer_sessions_included: number | null
        }
        Insert: {
          created_at?: string
          description?: string | null
          duration_months: number
          features?: string[] | null
          gym_id: string
          id?: string
          name: string
          price: number
          trainer_sessions_included?: number | null
        }
        Update: {
          created_at?: string
          description?: string | null
          duration_months?: number
          features?: string[] | null
          gym_id?: string
          id?: string
          name?: string
          price?: number
          trainer_sessions_included?: number | null
        }
        Relationships: [
          {
            foreignKeyName: "subscription_plans_gym_id_fkey"
            columns: ["gym_id"]
            isOneToOne: false
            referencedRelation: "gyms"
            referencedColumns: ["id"]
          },
        ]
      }
      user_nutrition_log: {
        Row: {
          created_at: string
          food_id: string
          id: string
          log_date: string
          meal_type: string
          quantity_grams: number
          user_id: string
        }
        Insert: {
          created_at?: string
          food_id: string
          id?: string
          log_date?: string
          meal_type: string
          quantity_grams: number
          user_id: string
        }
        Update: {
          created_at?: string
          food_id?: string
          id?: string
          log_date?: string
          meal_type?: string
          quantity_grams?: number
          user_id?: string
        }
        Relationships: [
          {
            foreignKeyName: "user_nutrition_log_food_id_fkey"
            columns: ["food_id"]
            isOneToOne: false
            referencedRelation: "nutrition"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "user_nutrition_log_user_id_fkey"
            columns: ["user_id"]
            isOneToOne: false
            referencedRelation: "gym_user_profiles"
            referencedColumns: ["id"]
          },
        ]
      }
      user_workouts: {
        Row: {
          created_at: string
          duration_minutes: number | null
          exercise_id: string
          id: string
          notes: string | null
          reps: number | null
          sets: number | null
          user_id: string
          weight: number | null
          workout_date: string
        }
        Insert: {
          created_at?: string
          duration_minutes?: number | null
          exercise_id: string
          id?: string
          notes?: string | null
          reps?: number | null
          sets?: number | null
          user_id: string
          weight?: number | null
          workout_date?: string
        }
        Update: {
          created_at?: string
          duration_minutes?: number | null
          exercise_id?: string
          id?: string
          notes?: string | null
          reps?: number | null
          sets?: number | null
          user_id?: string
          weight?: number | null
          workout_date?: string
        }
        Relationships: [
          {
            foreignKeyName: "user_workouts_exercise_id_fkey"
            columns: ["exercise_id"]
            isOneToOne: false
            referencedRelation: "exercises"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "user_workouts_user_id_fkey"
            columns: ["user_id"]
            isOneToOne: false
            referencedRelation: "gym_user_profiles"
            referencedColumns: ["id"]
          },
        ]
      }
    }
    Views: {
      [_ in never]: never
    }
    Functions: {
      [_ in never]: never
    }
    Enums: {
      fitness_goal:
        | "gain_muscle"
        | "lose_weight"
        | "calisthenics"
        | "bulking"
        | "basic_fitness"
        | "bodybuilding"
        | "heavy_lifting"
      subscription_status: "active" | "inactive" | "cancelled" | "expired"
      training_type:
        | "strength"
        | "cardio"
        | "yoga"
        | "pilates"
        | "crossfit"
        | "martial_arts"
        | "swimming"
        | "cycling"
      user_role: "gym_admin" | "gym_user"
    }
    CompositeTypes: {
      [_ in never]: never
    }
  }
}

type DefaultSchema = Database[Extract<keyof Database, "public">]

export type Tables<
  DefaultSchemaTableNameOrOptions extends
    | keyof (DefaultSchema["Tables"] & DefaultSchema["Views"])
    | { schema: keyof Database },
  TableName extends DefaultSchemaTableNameOrOptions extends {
    schema: keyof Database
  }
    ? keyof (Database[DefaultSchemaTableNameOrOptions["schema"]]["Tables"] &
        Database[DefaultSchemaTableNameOrOptions["schema"]]["Views"])
    : never = never,
> = DefaultSchemaTableNameOrOptions extends { schema: keyof Database }
  ? (Database[DefaultSchemaTableNameOrOptions["schema"]]["Tables"] &
      Database[DefaultSchemaTableNameOrOptions["schema"]]["Views"])[TableName] extends {
      Row: infer R
    }
    ? R
    : never
  : DefaultSchemaTableNameOrOptions extends keyof (DefaultSchema["Tables"] &
        DefaultSchema["Views"])
    ? (DefaultSchema["Tables"] &
        DefaultSchema["Views"])[DefaultSchemaTableNameOrOptions] extends {
        Row: infer R
      }
      ? R
      : never
    : never

export type TablesInsert<
  DefaultSchemaTableNameOrOptions extends
    | keyof DefaultSchema["Tables"]
    | { schema: keyof Database },
  TableName extends DefaultSchemaTableNameOrOptions extends {
    schema: keyof Database
  }
    ? keyof Database[DefaultSchemaTableNameOrOptions["schema"]]["Tables"]
    : never = never,
> = DefaultSchemaTableNameOrOptions extends { schema: keyof Database }
  ? Database[DefaultSchemaTableNameOrOptions["schema"]]["Tables"][TableName] extends {
      Insert: infer I
    }
    ? I
    : never
  : DefaultSchemaTableNameOrOptions extends keyof DefaultSchema["Tables"]
    ? DefaultSchema["Tables"][DefaultSchemaTableNameOrOptions] extends {
        Insert: infer I
      }
      ? I
      : never
    : never

export type TablesUpdate<
  DefaultSchemaTableNameOrOptions extends
    | keyof DefaultSchema["Tables"]
    | { schema: keyof Database },
  TableName extends DefaultSchemaTableNameOrOptions extends {
    schema: keyof Database
  }
    ? keyof Database[DefaultSchemaTableNameOrOptions["schema"]]["Tables"]
    : never = never,
> = DefaultSchemaTableNameOrOptions extends { schema: keyof Database }
  ? Database[DefaultSchemaTableNameOrOptions["schema"]]["Tables"][TableName] extends {
      Update: infer U
    }
    ? U
    : never
  : DefaultSchemaTableNameOrOptions extends keyof DefaultSchema["Tables"]
    ? DefaultSchema["Tables"][DefaultSchemaTableNameOrOptions] extends {
        Update: infer U
      }
      ? U
      : never
    : never

export type Enums<
  DefaultSchemaEnumNameOrOptions extends
    | keyof DefaultSchema["Enums"]
    | { schema: keyof Database },
  EnumName extends DefaultSchemaEnumNameOrOptions extends {
    schema: keyof Database
  }
    ? keyof Database[DefaultSchemaEnumNameOrOptions["schema"]]["Enums"]
    : never = never,
> = DefaultSchemaEnumNameOrOptions extends { schema: keyof Database }
  ? Database[DefaultSchemaEnumNameOrOptions["schema"]]["Enums"][EnumName]
  : DefaultSchemaEnumNameOrOptions extends keyof DefaultSchema["Enums"]
    ? DefaultSchema["Enums"][DefaultSchemaEnumNameOrOptions]
    : never

export type CompositeTypes<
  PublicCompositeTypeNameOrOptions extends
    | keyof DefaultSchema["CompositeTypes"]
    | { schema: keyof Database },
  CompositeTypeName extends PublicCompositeTypeNameOrOptions extends {
    schema: keyof Database
  }
    ? keyof Database[PublicCompositeTypeNameOrOptions["schema"]]["CompositeTypes"]
    : never = never,
> = PublicCompositeTypeNameOrOptions extends { schema: keyof Database }
  ? Database[PublicCompositeTypeNameOrOptions["schema"]]["CompositeTypes"][CompositeTypeName]
  : PublicCompositeTypeNameOrOptions extends keyof DefaultSchema["CompositeTypes"]
    ? DefaultSchema["CompositeTypes"][PublicCompositeTypeNameOrOptions]
    : never

export const Constants = {
  public: {
    Enums: {
      fitness_goal: [
        "gain_muscle",
        "lose_weight",
        "calisthenics",
        "bulking",
        "basic_fitness",
        "bodybuilding",
        "heavy_lifting",
      ],
      subscription_status: ["active", "inactive", "cancelled", "expired"],
      training_type: [
        "strength",
        "cardio",
        "yoga",
        "pilates",
        "crossfit",
        "martial_arts",
        "swimming",
        "cycling",
      ],
      user_role: ["gym_admin", "gym_user"],
    },
  },
} as const
