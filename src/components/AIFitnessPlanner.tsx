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
      exercises: Array<{
        name: string;
        sets: number;
        reps: string;
        rest: string;
      }>;
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
  const navigate = useNavigate();

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
                  <div className="space-y-2">
                    {dayPlan.exercises.map((exercise, index) => (
                      <div key={index} className="bg-gray-50 p-3 rounded text-sm">
                        <div className="font-medium">{exercise.name}</div>
                        <div className="text-gray-600">
                          {exercise.sets} sets × {exercise.reps} | Rest: {exercise.rest}
                        </div>
                      </div>
                    ))}
                  </div>
                )}
              </div>
            );
          })}
        </CardContent>
      </Card>
    );
  };

  return (
    <div className="space-y-6">
      <Card>
        <CardHeader>
          <div className="flex items-center justify-between">
            <div className="flex items-center space-x-2">
              <Brain className="h-6 w-6 text-purple-600" />
              <div>
                <CardTitle>AI Fitness Planner</CardTitle>
                <CardDescription>
                  Generate a personalized diet and exercise plan based on your profile
                </CardDescription>
              </div>
            </div>
            <div className="flex space-x-2">
              {error && (
                <Button onClick={generatePlan} disabled={isLoading} variant="outline">
                  <RefreshCw className="h-4 w-4 mr-2" />
                  Retry
                </Button>
              )}
              <Button onClick={() => setShowPreferences(!showPreferences)} variant="outline">
                <Settings className="h-4 w-4 mr-2" />
                Preferences
              </Button>
              <Button onClick={generatePlan} disabled={isLoading}>
                {isLoading ? (
                  <>
                    <Loader2 className="h-4 w-4 mr-2 animate-spin" />
                    Generating...
                  </>
                ) : (
                  <>
                    <Target className="h-4 w-4 mr-2" />
                    Generate Plan
                  </>
                )}
              </Button>
            </div>
          </div>
        </CardHeader>
        <CardContent>
          {!profile || !gymProfile ? (
            <Alert>
              <AlertCircle className="h-4 w-4" />
              <AlertDescription>
                Please complete your profile information to generate a personalized fitness plan.
              </AlertDescription>
            </Alert>
          ) : (
            <div className="grid grid-cols-2 md:grid-cols-4 gap-4 text-sm">
              <div>
                <p className="text-gray-600">Weight</p>
                <p className="font-medium">{gymProfile.weight || 'Not set'} kg</p>
              </div>
              <div>
                <p className="text-gray-600">Height</p>
                <p className="font-medium">{gymProfile.height || 'Not set'} cm</p>
              </div>
              <div>
                <p className="text-gray-600">Fitness Level</p>
                <p className="font-medium capitalize">{gymProfile.fitness_level || 'Not set'}</p>
              </div>
              <div>
                <p className="text-gray-600">Goals</p>
                <p className="font-medium">{gymProfile.fitness_goals?.length || 0} set</p>
              </div>
            </div>
          )}
        </CardContent>
      </Card>

      {/* Preferences Form */}
      {showPreferences && (
        <Card>
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
      )}

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
