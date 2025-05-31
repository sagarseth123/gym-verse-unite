
export type UserRole = 'gym_admin' | 'gym_user';
export type FitnessGoal = 'gain_muscle' | 'lose_weight' | 'calisthenics' | 'bulking' | 'basic_fitness' | 'bodybuilding' | 'heavy_lifting';
export type TrainingType = 'strength' | 'cardio' | 'yoga' | 'pilates' | 'crossfit' | 'martial_arts' | 'swimming' | 'cycling';
export type SubscriptionStatus = 'active' | 'inactive' | 'cancelled' | 'expired';

export interface Profile {
  id: string;
  email: string;
  full_name?: string;
  user_role: UserRole;
  phone?: string;
  address?: string;
  city?: string;
  state?: string;
  postal_code?: string;
  created_at: string;
  updated_at: string;
}

export interface Gym {
  id: string;
  admin_id: string;
  name: string;
  description?: string;
  area_sqft?: number;
  address: string;
  city: string;
  state: string;
  postal_code?: string;
  phone?: string;
  email?: string;
  website?: string;
  operating_hours?: any;
  created_at: string;
  updated_at: string;
}

export interface Exercise {
  id: string;
  name: string;
  category: string;
  muscle_groups?: string[];
  equipment_needed?: string[];
  difficulty_level?: string;
  instructions?: string;
  tips?: string;
  image_url?: string;
  video_url?: string;
  created_at: string;
}

export interface Product {
  id: string;
  name: string;
  description?: string;
  price: number;
  category: string;
  brand?: string;
  image_url?: string;
  in_stock?: boolean;
  created_at: string;
}
