
export interface Exercise {
  id: string;
  name: string;
  category: string;
  muscle_groups: string[];
  equipment_needed: string[];
  instructions?: string;
  difficulty_level?: string;
}

export interface FitnessGoalCategory {
  id: string;
  name: string;
  description: string;
  icon: string;
  color: string;
  goals: string[];
  targetMuscles: string[];
  equipment?: string[];
}

export interface ExerciseGuidance {
  instructions: string[];
  benefits: string[];
  commonMistakes: string[];
  progressions: string[];
  modifications: string[];
  safetyTips: string[];
}

export interface EnhancedExercise extends Exercise {
  goalCategories: string[];
  difficulty: 'beginner' | 'intermediate' | 'advanced';
  primaryMuscles: string[];
  secondaryMuscles: string[];
  aiGuidance?: ExerciseGuidance;
}

export const FITNESS_GOAL_CATEGORIES: FitnessGoalCategory[] = [
  {
    id: 'strength-building',
    name: 'Strength Training & Muscle Building',
    description: 'Build muscle mass, increase strength, and develop powerful physique',
    icon: '💪',
    color: 'bg-red-500',
    goals: ['gain_muscle', 'bodybuilding', 'heavy_lifting'],
    targetMuscles: ['chest', 'back', 'shoulders', 'arms', 'legs'],
    equipment: ['barbells', 'dumbbells', 'machines']
  },
  {
    id: 'weight-loss',
    name: 'Weight Loss & Fat Burning',
    description: 'Burn calories, lose fat, and improve cardiovascular health',
    icon: '🔥',
    color: 'bg-orange-500',
    goals: ['lose_weight'],
    targetMuscles: ['full_body', 'core'],
    equipment: ['cardio_machines', 'bodyweight']
  },
  {
    id: 'calisthenics',
    name: 'Calisthenics & Bodyweight',
    description: 'Master bodyweight movements and functional strength',
    icon: '🤸',
    color: 'bg-blue-500',
    goals: ['calisthenics', 'basic_fitness'],
    targetMuscles: ['core', 'upper_body', 'full_body'],
    equipment: ['bodyweight', 'pull_up_bar']
  },
  {
    id: 'bulking',
    name: 'Bulking & Mass Gain',
    description: 'Maximize muscle growth and overall body mass',
    icon: '🥩',
    color: 'bg-green-500',
    goals: ['bulking'],
    targetMuscles: ['chest', 'back', 'legs', 'shoulders'],
    equipment: ['barbells', 'dumbbells', 'plates']
  },
  {
    id: 'functional',
    name: 'Functional Fitness',
    description: 'Improve real-world movement patterns and athletic performance',
    icon: '⚡',
    color: 'bg-purple-500',
    goals: ['crossfit', 'martial_arts'],
    targetMuscles: ['full_body', 'core', 'stabilizers'],
    equipment: ['kettlebells', 'resistance_bands', 'medicine_balls']
  },
  {
    id: 'flexibility',
    name: 'Flexibility & Recovery',
    description: 'Enhance mobility, reduce tension, and promote recovery',
    icon: '🧘',
    color: 'bg-indigo-500',
    goals: ['yoga', 'pilates'],
    targetMuscles: ['full_body', 'core', 'flexibility'],
    equipment: ['yoga_mat', 'blocks', 'straps']
  }
];
