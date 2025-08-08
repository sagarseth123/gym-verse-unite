import { useState } from 'react';
import { useAuth } from '@/hooks/useAuth';
import { supabase } from '@/integrations/supabase/client';
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from '@/components/ui/card';
import { Button } from '@/components/ui/button';
import { Badge } from '@/components/ui/badge';
import { Separator } from '@/components/ui/separator';
import { Alert, AlertDescription } from '@/components/ui/alert';
import { toast } from '@/hooks/use-toast';
import { useNavigate } from 'react-router-dom';
import { 
  Brain, 
  Calendar, 
  Apple, 
  Dumbbell, 
  Target, 
  TrendingUp,
  AlertCircle,
  Loader2,
  RefreshCw,
  CheckCircle,
  Clock,
  Settings
} from 'lucide-react';
import { startOfWeek, format } from 'date-fns';
import { defaultWeeklyPlan } from '@/content_generation/defaultWeeklyPlan';
import { useEffect } from 'react';

interface Exercise {
  name: string;
  sets: number;
  reps: string;
  rest: string;
  imageUrl?: string;
  muscle_groups?: string[];
}

interface FitnessPlan {
  weeklyPlan?: {
    overview: string;
    dailyCalorieTarget: number;
    macronutrients: {
      protein: string;
      carbohydrates: string;
      fats: string;
    };
  };
  dietPlan?: {
    [key: string]: {
      breakfast: string;
      lunch: string;
      dinner: string;
      snacks: string[];
    };
  };
  exercisePlan?: {
    [key: string]: {
      type: string;
      duration: string;
      exercises: Exercise[];
    };
  };
  progressTracking?: {
    weeklyMeasurements: string[];
    adjustmentTriggers: string[];
    expectedResults: string;
  };
  tips?: string[];
  rawResponse?: string;
}

interface UserPreferences {
  workoutDays: number;
  preferredDays: string[];
  restDays: string[];
  workoutDuration: number; // in minutes
  equipmentAvailable: string[];
  workoutTime: 'morning' | 'afternoon' | 'evening' | 'flexible';
  workoutType: 'strength' | 'cardio' | 'mixed' | 'flexibility';
  experienceLevel: 'beginner' | 'intermediate' | 'advanced';
  intensity: 'low' | 'moderate' | 'high';
  injuries: string[];
  specificGoals: string[];
}

// --- Backend exerciseMappings for image URL logic ---
const exerciseMappings: { [key: string]: string } = {
  // Push-ups variations
  'push_ups': 'push_ups',
  'pushup': 'push_ups',
  'pushups': 'push_ups',
  // Pull-ups variations
  'pull_ups': 'pull_ups',
  'pullup': 'pull_ups',
  'pullups': 'pull_ups',
  // Squats variations
  'squats': 'squats',
  'squat': 'squats',
  'jump_squats': 'jump_squats',
  'jump_squat': 'jump_squats',
  'bodyweight_squats': 'squats',
  'bodyweight_squat': 'squats',
  'sumo_squat': 'sumo_deadlift',
  'barbel_squat': 'back_squats',
  'barbell_squat': 'back_squats',
  'front_squat': 'front_squats',
  // Bench press variations
  'bench_press': 'bench_press',
  'bench_presses': 'bench_press',
  'barbell_bench_press': 'bench_press',
  'chest_press': 'bench_press',
  'chest_press_incline': 'incline_bench_press',
  'chest_press_decline': 'decline_bench_press',
  'pec_fly': 'chest_fly',
  // Deadlift variations
  'deadlift': 'deadlift',
  'deadlifts': 'deadlift',
  'barbell_deadlift': 'deadlift',
  // Plank variations
  'plank': 'plank',
  'side_plank': 'side_plank',
  // Crunches variations
  'crunches': 'crunches',
  'crunch': 'crunches',
  // Leg raise
  'leg_raise': 'leg_raises',
  'leg_raises': 'leg_raises',
  // Shoulder press
  'shoulder_press': 'shoulder_press',
  'shoulder_presses': 'shoulder_press',
  // Lateral raise
  'lateral_raise': 'lateral_raise',
  // Tricep pushdown
  'tricep_pushdown': 'tricep_pushdown',
  // Overhead extension
  'overhead_extension': 'overhead_extension',
  // Lat pull down
  'lat_pull_down': 'lat_pulldowns',
  'lat_close_grip': 'lat_pulldowns',
  'lat_machine': 'lat_pulldowns',
  // Mid rowing
  'mid_rowing': 'rows',
  // Hyperextension
  'hyperextension': 'superman',
  // Biceps curl
  'biceps_curl': 'dumbbell_curls',
  'biceps_curl_barbel': 'dumbbell_curls',
  'biceps_machine': 'dumbbell_curls',
  // Hammer curl
  'hammer_curl': 'dumbbell_curls',
  // Barbell sides
  'barbell_sides': 'barbell_sides',
  // Dumbel sides
  'dumbel_sides': 'dumbel_sides',
  // Leg press
  'leg_press': 'leg_press',
  // Leg extension
  'leg_extension': 'leg_extension',
  // Leg curl
  'leg_curl': 'leg_curl',
  // Calves seated
  'calves_seated': 'calf_raises',
  // Calves standing
  'calves_standing': 'calf_raises',
  // Elliptical
  'eliptical': 'elliptical',
  // Cycling
  'cycling': 'cycling',
  // Front raise
  'front_raise': 'front_raise',
  // Rear delt
  'rear_delt': 'rear_delt',
  // Single head extension
  'single_head_extension': 'overhead_extension',
  // Triceps machine
  'triceps_machine': 'tricep_pushdown',
  // Chest fly
  'chest_fly': 'chest_fly',
};

// Updated getExerciseImageUrl to use backend mapping
const getExerciseImageUrl = (name: string) => {
  const sanitized = name.toLowerCase().replace(/[^a-z0-9]/g, '_').replace(/_+/g, '_').replace(/^_|_$/g, '');
  const mapped = exerciseMappings[sanitized] || sanitized;
  return `/images/exercise/${mapped}.png`;
};

export function AIFitnessPlanner() {
  const { user, profile, gymProfile } = useAuth();
  const [isLoading, setIsLoading] = useState(false);
  const [fitnessPlans, setFitnessPlans] = useState<FitnessPlan | null>(null);
  const [error, setError] = useState<string | null>(null);
  const [showPreferences, setShowPreferences] = useState(false);
  const [preferences, setPreferences] = useState<UserPreferences>({
    workoutDays: 4,
    preferredDays: ['monday', 'wednesday', 'friday', 'saturday'],
    restDays: ['sunday', 'tuesday', 'thursday'],
    workoutDuration: 45,
    equipmentAvailable: ['bodyweight', 'dumbbells'],
    workoutTime: 'evening',
    workoutType: 'mixed',
    experienceLevel: 'intermediate',
    intensity: 'moderate',
    injuries: [],
    specificGoals: []
  });
  const [useDefaultPlan, setUseDefaultPlan] = useState(false);
  // Set up default assignments with 'None' as the default value
  const [defaultPlanAssignments, setDefaultPlanAssignments] = useState([
    'None', 'None', 'None', 'None', 'None', 'None'
  ]);
  const [defaultRestDay, setDefaultRestDay] = useState('sunday');
  const navigate = useNavigate();
  const [planType, setPlanType] = useState<'default' | 'ai'>('default');
  const [imageLoading, setImageLoading] = useState<{ [key: string]: boolean }>({});

  const handleViewInWeeklyProgress = () => {
    // Small delay to ensure plan is saved
    setTimeout(() => {
      navigate('/WeeklyProgress');
    }, 500);
  };

  const handlePreferenceChange = (field: keyof UserPreferences, value: any) => {
    setPreferences(prev => ({
      ...prev,
      [field]: value
    }));
  };

  const handleDayToggle = (day: string, type: 'preferred' | 'rest') => {
    if (type === 'preferred') {
      setPreferences(prev => ({
        ...prev,
        preferredDays: prev.preferredDays.includes(day) 
          ? prev.preferredDays.filter(d => d !== day)
          : [...prev.preferredDays, day],
        restDays: prev.restDays.filter(d => d !== day)
      }));
    } else {
      setPreferences(prev => ({
        ...prev,
        restDays: prev.restDays.includes(day) 
          ? prev.restDays.filter(d => d !== day)
          : [...prev.restDays, day],
        preferredDays: prev.preferredDays.filter(d => d !== day)
      }));
    }
  };

  const generatePlan = async () => {
    if (!user) {
      toast({
        title: "Authentication Required",
        description: "Please log in to generate a fitness plan.",
        variant: "destructive"
      });
      return;
    }

    if (!profile || !gymProfile) {
      toast({
        title: "Profile Incomplete",
        description: "Please complete your profile first to generate a personalized plan.",
        variant: "destructive"
      });
      return;
    }

    setIsLoading(true);
    setError(null);
    setFitnessPlans(null);

    try {
      console.log('Calling generate-fitness-plan function...');
      
      const session = await supabase.auth.getSession();
      if (!session.data.session?.access_token) {
        throw new Error('No valid session found');
      }

      const { data, error } = await supabase.functions.invoke('generate-fitness-plan', {
        body: {
          type: 'weekly_plan',
          userProfile: {
            fitness_level: gymProfile.fitness_level,
            fitness_goals: gymProfile.fitness_goals,
            height: gymProfile.height,
            weight: gymProfile.weight
          },
          preferences: {
            workoutDays: preferences.workoutDays,
            preferredDays: preferences.preferredDays,
            restDays: preferences.restDays,
            workoutDuration: preferences.workoutDuration,
            equipmentAvailable: preferences.equipmentAvailable,
            workoutTime: preferences.workoutTime,
            workoutType: preferences.workoutType,
            experienceLevel: preferences.experienceLevel,
            intensity: preferences.intensity,
            injuries: preferences.injuries,
            specificGoals: preferences.specificGoals
          }
        },
        headers: {
          Authorization: `Bearer ${session.data.session.access_token}`,
        },
      });

      console.log('Function response:', { data, error });

      if (error) {
        console.error('Function error:', error);
        throw new Error(error.message || 'Failed to generate fitness plan');
      }

      if (data?.success) {
        setFitnessPlans(data.data);
        // Parse and normalize plan structure for dashboard compatibility
        const normalizedPlan = normalizePlan(data.data);
        // Save plan to user_weekly_plans
        const weekStart = format(startOfWeek(new Date(), { weekStartsOn: 1 }), 'yyyy-MM-dd');
        console.log('Normalized plan to save:', normalizedPlan);
        await supabase.from('user_weekly_plans').upsert({
          user_id: user.id,
          week_start: weekStart,
          plan_data: normalizedPlan
        }, { onConflict: 'user_id,week_start' });
        toast({
          title: "Success!",
          description: "Your personalized fitness plan has been generated and saved. It's now available in Weekly Progress.",
        });
      } else {
        throw new Error(data?.error || 'No data received from AI service');
      }
    } catch (err: any) {
      console.error('Error generating fitness plan:', err);
      const errorMessage = err.message || 'Failed to generate fitness plan. Please try again.';
      setError(errorMessage);
      toast({
        title: "Error",
        description: errorMessage,
        variant: "destructive"
      });
    } finally {
      setIsLoading(false);
    }
  };

  // --- Robust normalization for AI plan responses ---
  function normalizePlan(data: any) {
    const days = ['monday','tuesday','wednesday','thursday','friday','saturday','sunday'];
    let normalizedPlan = { ...(data?.data || data) };
    function parseRawPlan(raw: string) {
      let rawStr = raw.trim();
      if (rawStr.startsWith('```json')) rawStr = rawStr.slice(7);
      if (rawStr.startsWith('```')) rawStr = rawStr.slice(3);
      if (rawStr.endsWith('```')) rawStr = rawStr.slice(0, -3);
      try {
        return JSON.parse(rawStr);
      } catch (e) {
        return null;
      }
    }
    // If plan.plan.raw exists, always parse and use it
    if (normalizedPlan.plan && typeof normalizedPlan.plan.raw === 'string') {
      const parsed = parseRawPlan(normalizedPlan.plan.raw);
      if (parsed && parsed.plan) {
        normalizedPlan.exercisePlan = parsed.plan;
        if (parsed.tips) normalizedPlan.tips = parsed.tips;
      }
    }
    // If exercisePlan.raw exists, parse it (fallback)
    if (normalizedPlan.exercisePlan && typeof normalizedPlan.exercisePlan.raw === 'string') {
      const parsed = parseRawPlan(normalizedPlan.exercisePlan.raw);
      if (parsed && parsed.plan) {
        normalizedPlan.exercisePlan = parsed.plan;
        if (parsed.tips) normalizedPlan.tips = parsed.tips;
      }
    }
    // Ensure all days are present, but do NOT overwrite real exercises
    if (!normalizedPlan.exercisePlan) {
      normalizedPlan.exercisePlan = {};
    }
    days.forEach(day => {
      if (!normalizedPlan.exercisePlan[day]) {
        normalizedPlan.exercisePlan[day] = { type: '', duration: '', exercises: [] };
      } else if (!Array.isArray(normalizedPlan.exercisePlan[day].exercises)) {
        normalizedPlan.exercisePlan[day].exercises = [];
      }
      // Update imageUrl for each exercise
      normalizedPlan.exercisePlan[day].exercises = normalizedPlan.exercisePlan[day].exercises.map((ex: any) => ({
        ...ex,
        imageUrl: getExerciseImageUrl(ex.name)
      }));
    });
    return normalizedPlan;
  }

  const renderDietPlan = () => {
    if (!fitnessPlans?.dietPlan) return null;

    const days = ['monday', 'tuesday', 'wednesday', 'thursday', 'friday', 'saturday', 'sunday'];
    
    return (
      <Card>
        <CardHeader>
          <div className="flex items-center space-x-2">
            <Apple className="h-5 w-5 text-green-600" />
            <CardTitle>Weekly Diet Plan</CardTitle>
          </div>
        </CardHeader>
        <CardContent className="space-y-4">
          {days.map((day) => {
            const dayPlan = fitnessPlans.dietPlan?.[day];
            if (!dayPlan) return null;
            
            return (
              <div key={day} className="p-4 border rounded-lg">
                <h4 className="font-semibold capitalize mb-3">{day}</h4>
                <div className="space-y-2 text-sm">
                  <div><strong>Breakfast:</strong> {dayPlan.breakfast}</div>
                  <div><strong>Lunch:</strong> {dayPlan.lunch}</div>
                  <div><strong>Dinner:</strong> {dayPlan.dinner}</div>
                  {dayPlan.snacks && (
                    <div><strong>Snacks:</strong> {dayPlan.snacks.join(', ')}</div>
                  )}
                </div>
              </div>
            );
          })}
        </CardContent>
      </Card>
    );
  };

  const renderExercisePlan = () => {
    if (!fitnessPlans?.exercisePlan) return null;

    const days = ['monday', 'tuesday', 'wednesday', 'thursday', 'friday', 'saturday', 'sunday'];
    
    return (
      <Card>
        <CardHeader>
          <div className="flex items-center space-x-2">
            <Dumbbell className="h-5 w-5 text-blue-600" />
            <CardTitle>Weekly Exercise Plan</CardTitle>
          </div>
        </CardHeader>
        <CardContent className="space-y-4">
          {days.map((day) => {
            const dayPlan = fitnessPlans.exercisePlan?.[day];
            if (!dayPlan) return null;
            
            return (
              <div key={day} className="p-4 border rounded-lg">
                <div className="flex justify-between items-center mb-3">
                  <h4 className="font-semibold capitalize">{day}</h4>
                  <Badge variant="outline">{dayPlan.type}</Badge>
                </div>
                <p className="text-sm text-gray-600 mb-3">Duration: {dayPlan.duration}</p>
                {dayPlan.exercises && (
                  <div className="space-y-3">
                    {dayPlan.exercises.map((exercise, index) => {
                      const exerciseName = typeof exercise === 'string' ? exercise : exercise.name;
                      const imageUrl = typeof exercise === 'object' && exercise.imageUrl ? exercise.imageUrl : getExerciseImageUrl(exerciseName);
                      const imageKey = `${day}-${exerciseName}`;
                      // Handler to generate image if not present
                      const handleImageError = async (e: React.SyntheticEvent<HTMLImageElement, Event>) => {
                        setImageLoading(prev => ({ ...prev, [imageKey]: true }));
                        try {
                          const res = await fetch(`/api/exercise-image?name=${encodeURIComponent(exerciseName)}`);
                          const data = await res.json();
                          if (data.imageUrl) {
                            if (e.currentTarget) e.currentTarget.src = data.imageUrl;
                          } else {
                            // If still not found, keep spinner for a moment then hide
                            setTimeout(() => setImageLoading(prev => ({ ...prev, [imageKey]: false })), 1200);
                          }
                        } catch {
                          setTimeout(() => setImageLoading(prev => ({ ...prev, [imageKey]: false })), 1200);
                        }
                      };
                      const handleImageLoad = () => {
                        setImageLoading(prev => ({ ...prev, [imageKey]: false }));
                      };
                      return (
                        <div key={index} className="bg-white border rounded-lg overflow-hidden shadow-sm">
                          <div className="flex">
                            {/* Exercise Image */}
                            <div className="w-24 h-24 flex items-center justify-center relative bg-white border">
                              {imageLoading[imageKey] && (
                                <div className="absolute inset-0 flex items-center justify-center bg-white/70 z-10">
                                  <Loader2 className="animate-spin h-8 w-8 text-blue-500" />
                                </div>
                              )}
                              <img
                                src={imageUrl}
                                alt={exerciseName + ' exercise demonstration'}
                                className="w-full h-full object-contain bg-white border"
                                loading="lazy"
                                onError={handleImageError}
                                onLoad={handleImageLoad}
                                style={imageLoading[imageKey] ? { opacity: 0.3 } : {}}
                              />
                            </div>
                            {/* Exercise Details */}
                            <div className="flex-1 p-3">
                              <div className="font-medium text-sm">{exerciseName}</div>
                              <div className="text-gray-600 text-xs mt-1">
                                {typeof exercise !== 'string' ? `${exercise.sets} sets × ${exercise.reps} | Rest: ${exercise.rest}` : ''}
                              </div>
                              {typeof exercise !== 'string' && exercise.muscle_groups?.length > 0 && (
                                <div className="flex flex-wrap gap-1 mt-2">
                                  {exercise.muscle_groups?.slice(0, 3).map((muscle, idx) => (
                                    <Badge key={idx} variant="outline" className="text-xs">
                                      {muscle}
                                    </Badge>
                                  ))}
                                  {exercise.muscle_groups?.length > 3 && (
                                    <Badge variant="outline" className="text-xs">
                                      +{exercise.muscle_groups.length - 3}
                                    </Badge>
                                  )}
                                </div>
                              )}
                            </div>
                          </div>
                        </div>
                      );
                    })}
                  </div>
                )}
              </div>
            );
          })}
        </CardContent>
      </Card>
    );
  };

  // Show default plan if no plan exists or user selects it
  useEffect(() => {
    if (!fitnessPlans && !isLoading) {
      setUseDefaultPlan(true);
    }
  }, [fitnessPlans, isLoading]);

  // Helper to get image URL for an exercise name
  const getExerciseImageUrl = (name: string) => {
    // Use the same logic as your backend mapping, or import if available
    const sanitized = name.toLowerCase().replace(/[^a-z0-9]/g, '_').replace(/_+/g, '_').replace(/^_|_$/g, '');
    return `/images/exercise/${sanitized}.png`;
  };

  // UI for assigning days and rest day for default plan
  const renderDefaultPlanAssignment = () => {
    const days = ['monday','tuesday','wednesday','thursday','friday','saturday','sunday'];
    return (
      <div className="mb-4">
        <div className="mb-2 font-semibold">Assign each workout to a day:</div>
        {defaultWeeklyPlan.map((plan, idx) => (
          <div key={plan.name + idx} className="flex items-center mb-2">
            <span className="w-40">{plan.name}</span>
            <select
              className="border rounded px-2 py-1 ml-2"
              value={defaultPlanAssignments[idx]}
              onChange={e => {
                const newAssignments = [...defaultPlanAssignments];
                newAssignments[idx] = e.target.value;
                setDefaultPlanAssignments(newAssignments);
              }}
            >
              <option value="None">None</option>
              {days.filter(d => d !== defaultRestDay && !defaultPlanAssignments.includes(d) || defaultPlanAssignments[idx] === d).map(day => (
                <option key={day} value={day}>{day.charAt(0).toUpperCase() + day.slice(1)}</option>
              ))}
            </select>
          </div>
        ))}
        <div className="mt-4">
          <span className="font-semibold">Select your rest day: </span>
          <select
            className="border rounded px-2 py-1 ml-2"
            value={defaultRestDay}
            onChange={e => setDefaultRestDay(e.target.value)}
          >
            {days.map(day => (
              <option key={day} value={day}>{day.charAt(0).toUpperCase() + day.slice(1)}</option>
            ))}
          </select>
        </div>
      </div>
    );
  };

  const saveDefaultPlanToWeeklyProgress = async () => {
    if (!user) {
      toast({
        title: "Authentication Required",
        description: "Please log in to save your plan.",
        variant: "destructive"
      });
      return;
    }
    // Prevent saving if any workout is not assigned
    if (defaultPlanAssignments.includes('None')) {
      toast({
        title: "Assign All Workouts",
        description: "Please assign each workout to a day before saving.",
        variant: "destructive"
      });
      return;
    }
    // Build the plan object in the same format as AI plan
    const days = ['monday','tuesday','wednesday','thursday','friday','saturday','sunday'];
    const plan: any = {};
    defaultPlanAssignments.forEach((day, idx) => {
      plan[day] = {
        type: defaultWeeklyPlan[idx].name,
        duration: '45-60 min',
        exercises: defaultWeeklyPlan[idx].exercises.map(ex => ({
          ...ex,
          sets: 3,
          reps: '10-15',
          rest: '60s',
        }))
      };
    });
    // Fill in rest day
    plan[defaultRestDay] = {
      type: 'Rest',
      duration: '',
      exercises: []
    };
    // Fill in any missing days (shouldn't happen)
    days.forEach(day => {
      if (!plan[day]) plan[day] = { type: '', duration: '', exercises: [] };
    });
    // Save to Supabase
    setIsLoading(true);
    try {
      const weekStart = format(startOfWeek(new Date(), { weekStartsOn: 1 }), 'yyyy-MM-dd');
      const { error } = await supabase.from('user_weekly_plans').upsert({
        user_id: user.id,
        week_start: weekStart,
        plan_data: { exercisePlan: plan }
      }, { onConflict: 'user_id,week_start' });
      if (error) throw error;
      toast({
        title: "Plan Saved!",
        description: "Your most effective plan is now available in Weekly Progress and AI Coach.",
      });
    } catch (err: any) {
      toast({
        title: "Error Saving Plan",
        description: err.message || 'Failed to save plan.',
        variant: "destructive"
      });
    } finally {
      setIsLoading(false);
    }
  };

  // Render the default plan as a weekly plan
  const renderDefaultWeeklyPlan = () => {
    const days = ['monday','tuesday','wednesday','thursday','friday','saturday','sunday'];
    // Map assignments to days
    const planByDay: { [key: string]: typeof defaultWeeklyPlan[0] | null } = {};
    days.forEach(day => {
      const idx = defaultPlanAssignments.indexOf(day);
      planByDay[day] = idx !== -1 ? defaultWeeklyPlan[idx] : null;
    });
    return (
      <Card className="mb-6">
        <CardHeader>
          <div className="flex items-center space-x-2">
            <Dumbbell className="h-5 w-5 text-blue-600" />
            <CardTitle>Most Effective Weekly Plan</CardTitle>
          </div>
        </CardHeader>
        <CardContent className="space-y-4">
          <Button onClick={saveDefaultPlanToWeeklyProgress} disabled={isLoading} className="mb-4">
            {isLoading ? 'Saving...' : 'Save This Plan'}
          </Button>
          {days.map(day => (
            <div key={day} className="p-4 border rounded-lg bg-gray-50">
              <div className="flex justify-between items-center mb-3">
                <h4 className="font-semibold capitalize">{day}</h4>
                {day === defaultRestDay ? (
                  <Badge variant="destructive">Rest Day</Badge>
                ) : (
                  <Badge variant="outline">{planByDay[day]?.name || ''}</Badge>
                )}
              </div>
              {day !== defaultRestDay && planByDay[day] && (
                <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                  {(planByDay[day]?.exercises as { name: string; imageUrl: string }[]).map((exercise, idx) => {
                    const exerciseName = exercise.name;
                    const imageUrl = exercise.imageUrl || getExerciseImageUrl(exerciseName);
                    return (
                      <div key={exerciseName + idx} className="flex items-center space-x-4 p-2 bg-white border rounded shadow-sm">
                        <div className="w-16 h-16 flex items-center justify-center bg-white border rounded">
                          <img
                            src={imageUrl}
                            alt={exerciseName + ' exercise demonstration'}
                            className="max-h-full max-w-full object-contain"
                        onError={e => (e.currentTarget.style.display = 'none')}
                      />
                    </div>
                        <span className="font-medium text-sm">{exerciseName}</span>
                      </div>
                    );
                  })}
                </div>
              )}
            </div>
          ))}
        </CardContent>
      </Card>
    );
  };

  return (
    <div className="space-y-6">
      <Card>
        <CardHeader>
          <div className="flex items-center justify-between">
            <div className="flex flex-col space-y-1">
            <div className="flex items-center space-x-2">
              <Brain className="h-5 w-5 text-purple-600" />
              <CardTitle>AI Fitness Planner</CardTitle>
            </div>
              <CardDescription>Get personalized diet and exercise recommendations powered by AI</CardDescription>
            </div>
          </div>
        </CardHeader>
        <CardContent>
          {/* Plan Type Selection */}
          <div className="flex flex-col md:flex-row gap-4 mb-6">
            <Button
              variant={planType === 'default' ? 'default' : 'outline'}
              onClick={() => { setPlanType('default'); setUseDefaultPlan(true); setShowPreferences(false); }}
            >
              Use Most Effective Plan
            </Button>
            <Button
              variant={planType === 'ai' ? 'default' : 'outline'}
              onClick={() => { setPlanType('ai'); setUseDefaultPlan(false); setShowPreferences(true); }}
            >
              Generate a Custom Plan Using AI
            </Button>
          </div>
          {/* Show default plan assignment if default selected */}
          {planType === 'default' && useDefaultPlan && renderDefaultPlanAssignment()}
          {/* Show preferences form if AI selected */}
          {planType === 'ai' && showPreferences && (
            <>
      {/* Preferences Form */}
              <Card className="mb-6">
          <CardHeader>
            <div className="flex items-center space-x-2">
              <Settings className="h-5 w-5 text-blue-600" />
              <CardTitle>Workout Preferences</CardTitle>
            </div>
            <CardDescription>
              Customize your workout schedule and preferences for a more personalized plan
            </CardDescription>
          </CardHeader>
          <CardContent className="space-y-6">
            {/* Workout Frequency */}
            <div>
              <label className="text-sm font-medium mb-2 block">Workout Days per Week</label>
              <div className="flex items-center space-x-4">
                <input
                  type="range"
                  min="3"
                  max="7"
                  value={preferences.workoutDays}
                  onChange={(e) => handlePreferenceChange('workoutDays', parseInt(e.target.value))}
                  className="flex-1"
                />
                <span className="text-sm font-medium w-8">{preferences.workoutDays} days</span>
              </div>
            </div>

            {/* Day Selection */}
            <div>
              <label className="text-sm font-medium mb-3 block">Select Your Workout Days</label>
              <div className="grid grid-cols-7 gap-2">
                {['monday', 'tuesday', 'wednesday', 'thursday', 'friday', 'saturday', 'sunday'].map((day) => (
                  <div key={day} className="text-center">
                    <button
                      type="button"
                      onClick={() => handleDayToggle(day, preferences.preferredDays.includes(day) ? 'rest' : 'preferred')}
                      className={`w-full p-2 rounded-lg text-xs font-medium transition-colors ${
                        preferences.preferredDays.includes(day)
                          ? 'bg-blue-600 text-white'
                          : preferences.restDays.includes(day)
                          ? 'bg-gray-200 text-gray-600'
                          : 'bg-gray-100 text-gray-500 hover:bg-gray-200'
                      }`}
                    >
                      {day.charAt(0).toUpperCase() + day.slice(1, 3)}
                    </button>
                    <div className="text-xs mt-1">
                      {preferences.preferredDays.includes(day) ? 'Workout' : 'Rest'}
                    </div>
                  </div>
                ))}
              </div>
            </div>

            {/* Workout Duration */}
            <div>
              <label className="text-sm font-medium mb-2 block">Workout Duration</label>
              <div className="flex items-center space-x-4">
                <input
                  type="range"
                  min="30"
                  max="120"
                  step="15"
                  value={preferences.workoutDuration}
                  onChange={(e) => handlePreferenceChange('workoutDuration', parseInt(e.target.value))}
                  className="flex-1"
                />
                <span className="text-sm font-medium w-16">{preferences.workoutDuration} min</span>
              </div>
            </div>

            {/* Workout Type */}
            <div>
              <label className="text-sm font-medium mb-2 block">Workout Type Focus</label>
              <div className="grid grid-cols-2 md:grid-cols-4 gap-2">
                {[
                  { value: 'strength', label: 'Strength', icon: '💪' },
                  { value: 'cardio', label: 'Cardio', icon: '❤️' },
                  { value: 'mixed', label: 'Mixed', icon: '⚡' },
                  { value: 'flexibility', label: 'Flexibility', icon: '🧘' }
                ].map((type) => (
                  <button
                    key={type.value}
                    type="button"
                    onClick={() => handlePreferenceChange('workoutType', type.value)}
                    className={`p-3 rounded-lg border text-sm font-medium transition-colors ${
                      preferences.workoutType === type.value
                        ? 'border-blue-600 bg-blue-50 text-blue-700'
                        : 'border-gray-200 hover:border-gray-300'
                    }`}
                  >
                    <div className="text-lg mb-1">{type.icon}</div>
                    {type.label}
                  </button>
                ))}
              </div>
            </div>

            {/* Equipment Available */}
            <div>
              <label className="text-sm font-medium mb-2 block">Available Equipment</label>
              <div className="grid grid-cols-2 md:grid-cols-4 gap-2">
                {[
                  'bodyweight', 'dumbbells', 'barbells', 'machines', 
                  'cables', 'kettlebells', 'resistance_bands', 'cardio_machines'
                ].map((equipment) => (
                  <button
                    key={equipment}
                    type="button"
                    onClick={() => {
                      const current = preferences.equipmentAvailable;
                      const updated = current.includes(equipment)
                        ? current.filter(e => e !== equipment)
                        : [...current, equipment];
                      handlePreferenceChange('equipmentAvailable', updated);
                    }}
                    className={`p-2 rounded-lg border text-xs font-medium transition-colors ${
                      preferences.equipmentAvailable.includes(equipment)
                        ? 'border-green-600 bg-green-50 text-green-700'
                        : 'border-gray-200 hover:border-gray-300'
                    }`}
                  >
                    {equipment.replace('_', ' ').replace(/\b\w/g, l => l.toUpperCase())}
                  </button>
                ))}
              </div>
            </div>

            {/* Workout Time */}
            <div>
              <label className="text-sm font-medium mb-2 block">Preferred Workout Time</label>
              <div className="grid grid-cols-2 md:grid-cols-4 gap-2">
                {[
                  { value: 'morning', label: 'Morning', icon: '🌅' },
                  { value: 'afternoon', label: 'Afternoon', icon: '☀️' },
                  { value: 'evening', label: 'Evening', icon: '🌆' },
                  { value: 'flexible', label: 'Flexible', icon: '🕐' }
                ].map((time) => (
                  <button
                    key={time.value}
                    type="button"
                    onClick={() => handlePreferenceChange('workoutTime', time.value)}
                    className={`p-3 rounded-lg border text-sm font-medium transition-colors ${
                      preferences.workoutTime === time.value
                        ? 'border-blue-600 bg-blue-50 text-blue-700'
                        : 'border-gray-200 hover:border-gray-300'
                    }`}
                  >
                    <div className="text-lg mb-1">{time.icon}</div>
                    {time.label}
                  </button>
                ))}
              </div>
            </div>

            {/* Workout Intensity */}
            <div>
              <label className="text-sm font-medium mb-2 block">Workout Intensity</label>
              <div className="grid grid-cols-3 gap-2">
                {[
                  { value: 'low', label: 'Low', icon: '🐌', desc: 'Light & Easy' },
                  { value: 'moderate', label: 'Moderate', icon: '⚡', desc: 'Balanced' },
                  { value: 'high', label: 'High', icon: '🔥', desc: 'Challenging' }
                ].map((intensity) => (
                  <button
                    key={intensity.value}
                    type="button"
                    onClick={() => handlePreferenceChange('intensity', intensity.value)}
                    className={`p-3 rounded-lg border text-sm font-medium transition-colors ${
                      preferences.intensity === intensity.value
                        ? 'border-blue-600 bg-blue-50 text-blue-700'
                        : 'border-gray-200 hover:border-gray-300'
                    }`}
                  >
                    <div className="text-lg mb-1">{intensity.icon}</div>
                    <div>{intensity.label}</div>
                    <div className="text-xs text-gray-500">{intensity.desc}</div>
                  </button>
                ))}
              </div>
            </div>

            {/* Injury Considerations */}
            <div>
              <label className="text-sm font-medium mb-2 block">Injury Considerations (Optional)</label>
              <div className="grid grid-cols-2 md:grid-cols-4 gap-2">
                {[
                  'knee', 'back', 'shoulder', 'wrist', 'ankle', 'hip', 'neck', 'none'
                ].map((injury) => (
                  <button
                    key={injury}
                    type="button"
                    onClick={() => {
                      const current = preferences.injuries;
                      const updated = current.includes(injury)
                        ? current.filter(i => i !== injury)
                        : injury === 'none' 
                          ? []
                          : [...current.filter(i => i !== 'none'), injury];
                      handlePreferenceChange('injuries', updated);
                    }}
                    className={`p-2 rounded-lg border text-xs font-medium transition-colors ${
                      preferences.injuries.includes(injury)
                        ? 'border-red-600 bg-red-50 text-red-700'
                        : 'border-gray-200 hover:border-gray-300'
                    }`}
                  >
                    {injury === 'none' ? 'No Injuries' : injury.charAt(0).toUpperCase() + injury.slice(1)}
                  </button>
                ))}
              </div>
            </div>

            {/* Specific Goals */}
            <div>
              <label className="text-sm font-medium mb-2 block">Specific Goals (Optional)</label>
              <div className="grid grid-cols-2 md:grid-cols-3 gap-2">
                {[
                  'lose_weight', 'build_muscle', 'improve_strength', 'increase_endurance', 
                  'better_flexibility', 'reduce_stress', 'improve_posture', 'sports_performance'
                ].map((goal) => (
                  <button
                    key={goal}
                    type="button"
                    onClick={() => {
                      const current = preferences.specificGoals;
                      const updated = current.includes(goal)
                        ? current.filter(g => g !== goal)
                        : [...current, goal];
                      handlePreferenceChange('specificGoals', updated);
                    }}
                    className={`p-2 rounded-lg border text-xs font-medium transition-colors ${
                      preferences.specificGoals.includes(goal)
                        ? 'border-green-600 bg-green-50 text-green-700'
                        : 'border-gray-200 hover:border-gray-300'
                    }`}
                  >
                    {goal.replace('_', ' ').replace(/\b\w/g, l => l.toUpperCase())}
                  </button>
                ))}
              </div>
            </div>

            {/* Preferences Summary */}
            <div className="bg-gray-50 p-4 rounded-lg">
              <h4 className="font-medium mb-3 text-sm">Your Plan Summary</h4>
              <div className="grid grid-cols-1 md:grid-cols-2 gap-4 text-sm">
                <div>
                  <p><strong>Workout Schedule:</strong> {preferences.workoutDays} days per week</p>
                  <p><strong>Workout Days:</strong> {preferences.preferredDays.map(d => d.charAt(0).toUpperCase() + d.slice(1)).join(', ')}</p>
                  <p><strong>Rest Days:</strong> {preferences.restDays.map(d => d.charAt(0).toUpperCase() + d.slice(1)).join(', ')}</p>
                  <p><strong>Duration:</strong> {preferences.workoutDuration} minutes per session</p>
                  <p><strong>Intensity:</strong> {preferences.intensity.charAt(0).toUpperCase() + preferences.intensity.slice(1)}</p>
                </div>
                <div>
                  <p><strong>Focus:</strong> {preferences.workoutType.charAt(0).toUpperCase() + preferences.workoutType.slice(1)}</p>
                  <p><strong>Time:</strong> {preferences.workoutTime.charAt(0).toUpperCase() + preferences.workoutTime.slice(1)}</p>
                  <p><strong>Equipment:</strong> {preferences.equipmentAvailable.length} types available</p>
                  <p><strong>Level:</strong> {preferences.experienceLevel.charAt(0).toUpperCase() + preferences.experienceLevel.slice(1)}</p>
                  {preferences.injuries.length > 0 && (
                    <p><strong>Injuries:</strong> {preferences.injuries.map(i => i.charAt(0).toUpperCase() + i.slice(1)).join(', ')}</p>
                  )}
                  {preferences.specificGoals.length > 0 && (
                    <p><strong>Goals:</strong> {preferences.specificGoals.map(g => g.replace('_', ' ').replace(/\b\w/g, l => l.toUpperCase())).join(', ')}</p>
                  )}
                </div>
              </div>
            </div>
          </CardContent>
        </Card>
              <Button onClick={generatePlan} disabled={isLoading} className="mt-4">
                {isLoading ? 'Generating...' : 'Generate AI Plan'}
              </Button>
            </>
      )}
        </CardContent>
      </Card>
      {/* Show the selected plan */}
      {planType === 'default' && useDefaultPlan ? renderDefaultWeeklyPlan() : null}
      {planType === 'ai' && fitnessPlans ? renderExercisePlan() : null}

      {error && (
        <Alert variant="destructive">
          <AlertCircle className="h-4 w-4" />
          <AlertDescription>
            {error}
          </AlertDescription>
        </Alert>
      )}

      {fitnessPlans && (
        <Alert className="border-green-200 bg-green-50">
          <CheckCircle className="h-4 w-4 text-green-600" />
          <AlertDescription className="text-green-800">
            <div className="flex items-center justify-between">
              <span>Your fitness plan has been generated and saved successfully!</span>
              <Button 
                size="sm" 
                onClick={handleViewInWeeklyProgress}
                className="ml-4 bg-green-600 hover:bg-green-700"
              >
                <TrendingUp className="h-4 w-4 mr-2" />
                View in Weekly Progress
              </Button>
            </div>
          </AlertDescription>
        </Alert>
      )}

      {fitnessPlans && (
        <div className="space-y-6">
          {/* Weekly Overview */}
          {fitnessPlans.weeklyPlan && (
            <Card>
              <CardHeader>
                <div className="flex items-center space-x-2">
                  <Calendar className="h-5 w-5 text-orange-600" />
                  <CardTitle>Weekly Overview</CardTitle>
                </div>
              </CardHeader>
              <CardContent>
                <p className="mb-4">{fitnessPlans.weeklyPlan.overview}</p>
                <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                  <div>
                    <h4 className="font-semibold mb-2">Daily Calorie Target</h4>
                    <p className="text-2xl font-bold text-blue-600">
                      {fitnessPlans.weeklyPlan.dailyCalorieTarget} calories
                    </p>
                  </div>
                  <div>
                    <h4 className="font-semibold mb-2">Macronutrients</h4>
                    <div className="space-y-1 text-sm">
                      <div>Protein: {fitnessPlans.weeklyPlan.macronutrients.protein}</div>
                      <div>Carbs: {fitnessPlans.weeklyPlan.macronutrients.carbohydrates}</div>
                      <div>Fats: {fitnessPlans.weeklyPlan.macronutrients.fats}</div>
                    </div>
                  </div>
                </div>
              </CardContent>
            </Card>
          )}

          {/* Diet Plan */}
          {renderDietPlan()}

          {/* Exercise Plan */}
          {renderExercisePlan()}

          {/* Progress Tracking */}
          {fitnessPlans.progressTracking && (
            <Card>
              <CardHeader>
                <div className="flex items-center space-x-2">
                  <TrendingUp className="h-5 w-5 text-green-600" />
                  <CardTitle>Progress Tracking</CardTitle>
                </div>
              </CardHeader>
              <CardContent className="space-y-4">
                <div>
                  <h4 className="font-semibold mb-2">Weekly Measurements</h4>
                  <ul className="list-disc list-inside space-y-1 text-sm">
                    {fitnessPlans.progressTracking.weeklyMeasurements.map((measurement, index) => (
                      <li key={index}>{measurement}</li>
                    ))}
                  </ul>
                </div>
                <Separator />
                <div>
                  <h4 className="font-semibold mb-2">Adjustment Triggers</h4>
                  <ul className="list-disc list-inside space-y-1 text-sm">
                    {fitnessPlans.progressTracking.adjustmentTriggers.map((trigger, index) => (
                      <li key={index}>{trigger}</li>
                    ))}
                  </ul>
                </div>
                <Separator />
                <div>
                  <h4 className="font-semibold mb-2">Expected Results</h4>
                  <p className="text-sm">{fitnessPlans.progressTracking.expectedResults}</p>
                </div>
              </CardContent>
            </Card>
          )}

          {/* Tips */}
          {fitnessPlans.tips && (
            <Card>
              <CardHeader>
                <CardTitle>Tips & Recommendations</CardTitle>
              </CardHeader>
              <CardContent>
                <ul className="list-disc list-inside space-y-2 text-sm">
                  {fitnessPlans.tips.map((tip, index) => (
                    <li key={index}>{tip}</li>
                  ))}
                </ul>
              </CardContent>
            </Card>
          )}

          {/* Raw Response (fallback) */}
          {fitnessPlans.rawResponse && !fitnessPlans.weeklyPlan && (
            <Card>
              <CardHeader>
                <CardTitle>AI Generated Plan</CardTitle>
              </CardHeader>
              <CardContent>
                <pre className="whitespace-pre-wrap text-sm">{fitnessPlans.rawResponse}</pre>
              </CardContent>
            </Card>
          )}
        </div>
      )}
    </div>
  );
}
