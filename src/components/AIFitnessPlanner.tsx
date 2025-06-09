
import { useState } from 'react';
import { useAuth } from '@/hooks/useAuth';
import { supabase } from '@/integrations/supabase/client';
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from '@/components/ui/card';
import { Button } from '@/components/ui/button';
import { Badge } from '@/components/ui/badge';
import { Separator } from '@/components/ui/separator';
import { Alert, AlertDescription } from '@/components/ui/alert';
import { toast } from '@/hooks/use-toast';
import { 
  Brain, 
  Calendar, 
  Apple, 
  Dumbbell, 
  Target, 
  TrendingUp,
  AlertCircle,
  Loader2,
  RefreshCw
} from 'lucide-react';

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

export function AIFitnessPlanner() {
  const { user, profile, gymProfile } = useAuth();
  const [isLoading, setIsLoading] = useState(false);
  const [fitnessPlans, setFitnessPlans] = useState<FitnessPlan | null>(null);
  const [error, setError] = useState<string | null>(null);

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
        toast({
          title: "Success!",
          description: "Your personalized fitness plan has been generated.",
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

      {error && (
        <Alert variant="destructive">
          <AlertCircle className="h-4 w-4" />
          <AlertDescription>
            {error}
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
