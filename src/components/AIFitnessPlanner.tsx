
import { useState } from 'react';
import { useAuth } from '@/hooks/useAuth';
import { supabase } from '@/integrations/supabase/client';
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from '@/components/ui/card';
import { Button } from '@/components/ui/button';
import { Badge } from '@/components/ui/badge';
import { Tabs, TabsContent, TabsList, TabsTrigger } from '@/components/ui/tabs';
import { Alert, AlertDescription } from '@/components/ui/alert';
import { Separator } from '@/components/ui/separator';
import { toast } from '@/hooks/use-toast';
import { 
  Brain, 
  Loader2, 
  Target, 
  Utensils, 
  Dumbbell, 
  TrendingUp,
  Calendar,
  Clock,
  AlertCircle,
  CheckCircle
} from 'lucide-react';

interface FitnessPlans {
  weeklyPlan?: {
    overview: string;
    dailyCalorieTarget: number;
    macronutrients: {
      protein: string;
      carbohydrates: string;
      fats: string;
    };
  };
  dietPlan?: Record<string, {
    breakfast: string;
    lunch: string;
    dinner: string;
    snacks: string[];
  }>;
  exercisePlan?: Record<string, {
    type: string;
    duration: string;
    exercises: Array<{
      name: string;
      sets: number;
      reps: string;
      rest: string;
    }>;
  }>;
  progressTracking?: {
    weeklyMeasurements: string[];
    adjustmentTriggers: string[];
    expectedResults: string;
  };
  tips?: string[];
  rawResponse?: string;
}

export function AIFitnessPlanner() {
  const { user, profile } = useAuth();
  const [isGenerating, setIsGenerating] = useState(false);
  const [fitnessPlans, setFitnessPlans] = useState<FitnessPlans | null>(null);
  const [userProfile, setUserProfile] = useState<any>(null);

  const generateFitnessPlan = async () => {
    if (!user || !profile) {
      toast({
        title: "Profile Required",
        description: "Please complete your profile first to generate a personalized plan.",
        variant: "destructive"
      });
      return;
    }

    setIsGenerating(true);
    try {
      const { data, error } = await supabase.functions.invoke('generate-fitness-plan', {
        headers: {
          Authorization: `Bearer ${(await supabase.auth.getSession()).data.session?.access_token}`,
        },
      });

      if (error) throw error;

      if (data.success) {
        setFitnessPlans(data.data);
        setUserProfile(data.userProfile);
        toast({
          title: "Plan Generated!",
          description: "Your personalized fitness plan has been created.",
        });
      } else {
        throw new Error(data.error || 'Failed to generate plan');
      }
    } catch (error) {
      console.error('Error generating fitness plan:', error);
      toast({
        title: "Error",
        description: "Failed to generate fitness plan. Please try again.",
        variant: "destructive"
      });
    } finally {
      setIsGenerating(false);
    }
  };

  const daysOfWeek = ['monday', 'tuesday', 'wednesday', 'thursday', 'friday', 'saturday', 'sunday'];

  if (!user || !profile) {
    return (
      <Alert>
        <AlertCircle className="h-4 w-4" />
        <AlertDescription>
          Please complete your profile to access AI-powered fitness planning.
        </AlertDescription>
      </Alert>
    );
  }

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
                  Get a personalized diet and exercise plan powered by AI
                </CardDescription>
              </div>
            </div>
            <Button 
              onClick={generateFitnessPlan} 
              disabled={isGenerating}
              className="bg-purple-600 hover:bg-purple-700"
            >
              {isGenerating ? (
                <>
                  <Loader2 className="h-4 w-4 mr-2 animate-spin" />
                  Generating...
                </>
              ) : (
                <>
                  <Brain className="h-4 w-4 mr-2" />
                  Generate Plan
                </>
              )}
            </Button>
          </div>
        </CardHeader>
        
        {userProfile && (
          <CardContent>
            <div className="grid grid-cols-2 md:grid-cols-4 gap-4 mb-4">
              <div className="text-center">
                <p className="text-sm text-gray-600">Weight</p>
                <p className="font-semibold">{userProfile.weight || 'N/A'} kg</p>
              </div>
              <div className="text-center">
                <p className="text-sm text-gray-600">Height</p>
                <p className="font-semibold">{userProfile.height || 'N/A'} cm</p>
              </div>
              <div className="text-center">
                <p className="text-sm text-gray-600">BMI</p>
                <p className="font-semibold">{userProfile.bmi ? userProfile.bmi.toFixed(1) : 'N/A'}</p>
              </div>
              <div className="text-center">
                <p className="text-sm text-gray-600">Level</p>
                <p className="font-semibold capitalize">{userProfile.fitnessLevel || 'N/A'}</p>
              </div>
            </div>
            {userProfile.goals && (
              <div className="flex flex-wrap gap-2">
                {userProfile.goals.map((goal: string) => (
                  <Badge key={goal} variant="outline">{goal.replace('_', ' ')}</Badge>
                ))}
              </div>
            )}
          </CardContent>
        )}
      </Card>

      {fitnessPlans && (
        <Tabs defaultValue="overview" className="space-y-4">
          <TabsList className="grid w-full grid-cols-4">
            <TabsTrigger value="overview">
              <Target className="h-4 w-4 mr-2" />
              Overview
            </TabsTrigger>
            <TabsTrigger value="diet">
              <Utensils className="h-4 w-4 mr-2" />
              Diet Plan
            </TabsTrigger>
            <TabsTrigger value="exercise">
              <Dumbbell className="h-4 w-4 mr-2" />
              Exercise Plan
            </TabsTrigger>
            <TabsTrigger value="tracking">
              <TrendingUp className="h-4 w-4 mr-2" />
              Progress
            </TabsTrigger>
          </TabsList>

          <TabsContent value="overview" className="space-y-4">
            {fitnessPlans.weeklyPlan ? (
              <Card>
                <CardHeader>
                  <CardTitle>Weekly Plan Overview</CardTitle>
                </CardHeader>
                <CardContent>
                  <p className="mb-4">{fitnessPlans.weeklyPlan.overview}</p>
                  
                  <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                    <div>
                      <h4 className="font-semibold mb-2">Daily Calorie Target</h4>
                      <p className="text-2xl font-bold text-green-600">
                        {fitnessPlans.weeklyPlan.dailyCalorieTarget} calories
                      </p>
                    </div>
                    
                    <div>
                      <h4 className="font-semibold mb-2">Macronutrient Breakdown</h4>
                      <div className="space-y-1">
                        <div className="flex justify-between">
                          <span>Protein:</span>
                          <span className="font-medium">{fitnessPlans.weeklyPlan.macronutrients.protein}</span>
                        </div>
                        <div className="flex justify-between">
                          <span>Carbs:</span>
                          <span className="font-medium">{fitnessPlans.weeklyPlan.macronutrients.carbohydrates}</span>
                        </div>
                        <div className="flex justify-between">
                          <span>Fats:</span>
                          <span className="font-medium">{fitnessPlans.weeklyPlan.macronutrients.fats}</span>
                        </div>
                      </div>
                    </div>
                  </div>

                  {fitnessPlans.tips && (
                    <div className="mt-6">
                      <h4 className="font-semibold mb-3">Key Tips</h4>
                      <div className="grid gap-2">
                        {fitnessPlans.tips.map((tip, index) => (
                          <div key={index} className="flex items-start space-x-2">
                            <CheckCircle className="h-4 w-4 text-green-500 mt-0.5 flex-shrink-0" />
                            <p className="text-sm">{tip}</p>
                          </div>
                        ))}
                      </div>
                    </div>
                  )}
                </CardContent>
              </Card>
            ) : (
              <Alert>
                <AlertCircle className="h-4 w-4" />
                <AlertDescription>
                  Plan overview not available. The AI response may need to be processed differently.
                </AlertDescription>
              </Alert>
            )}
          </TabsContent>

          <TabsContent value="diet" className="space-y-4">
            {fitnessPlans.dietPlan ? (
              daysOfWeek.map((day) => (
                <Card key={day}>
                  <CardHeader>
                    <CardTitle className="capitalize flex items-center">
                      <Calendar className="h-4 w-4 mr-2" />
                      {day}
                    </CardTitle>
                  </CardHeader>
                  <CardContent>
                    {fitnessPlans.dietPlan![day] ? (
                      <div className="grid gap-4">
                        <div>
                          <h4 className="font-semibold text-orange-600 mb-1">Breakfast</h4>
                          <p className="text-sm">{fitnessPlans.dietPlan![day].breakfast}</p>
                        </div>
                        <Separator />
                        <div>
                          <h4 className="font-semibold text-blue-600 mb-1">Lunch</h4>
                          <p className="text-sm">{fitnessPlans.dietPlan![day].lunch}</p>
                        </div>
                        <Separator />
                        <div>
                          <h4 className="font-semibold text-purple-600 mb-1">Dinner</h4>
                          <p className="text-sm">{fitnessPlans.dietPlan![day].dinner}</p>
                        </div>
                        {fitnessPlans.dietPlan![day].snacks && fitnessPlans.dietPlan![day].snacks.length > 0 && (
                          <>
                            <Separator />
                            <div>
                              <h4 className="font-semibold text-green-600 mb-2">Snacks</h4>
                              <div className="space-y-1">
                                {fitnessPlans.dietPlan![day].snacks.map((snack, index) => (
                                  <p key={index} className="text-sm">• {snack}</p>
                                ))}
                              </div>
                            </div>
                          </>
                        )}
                      </div>
                    ) : (
                      <p className="text-gray-500">No diet plan available for this day.</p>
                    )}
                  </CardContent>
                </Card>
              ))
            ) : (
              <Alert>
                <AlertCircle className="h-4 w-4" />
                <AlertDescription>
                  Diet plan not available. Please try regenerating the plan.
                </AlertDescription>
              </Alert>
            )}
          </TabsContent>

          <TabsContent value="exercise" className="space-y-4">
            {fitnessPlans.exercisePlan ? (
              daysOfWeek.map((day) => (
                <Card key={day}>
                  <CardHeader>
                    <CardTitle className="capitalize flex items-center">
                      <Dumbbell className="h-4 w-4 mr-2" />
                      {day}
                    </CardTitle>
                    {fitnessPlans.exercisePlan![day] && (
                      <CardDescription className="flex items-center space-x-4">
                        <span className="flex items-center">
                          <Badge variant="outline">{fitnessPlans.exercisePlan![day].type}</Badge>
                        </span>
                        <span className="flex items-center">
                          <Clock className="h-3 w-3 mr-1" />
                          {fitnessPlans.exercisePlan![day].duration}
                        </span>
                      </CardDescription>
                    )}
                  </CardHeader>
                  <CardContent>
                    {fitnessPlans.exercisePlan![day] && fitnessPlans.exercisePlan![day].exercises ? (
                      <div className="space-y-3">
                        {fitnessPlans.exercisePlan![day].exercises.map((exercise, index) => (
                          <div key={index} className="border rounded-lg p-3">
                            <div className="flex justify-between items-start mb-2">
                              <h4 className="font-semibold">{exercise.name}</h4>
                            </div>
                            <div className="grid grid-cols-3 gap-2 text-sm text-gray-600">
                              <span>Sets: {exercise.sets}</span>
                              <span>Reps: {exercise.reps}</span>
                              <span>Rest: {exercise.rest}</span>
                            </div>
                          </div>
                        ))}
                      </div>
                    ) : (
                      <p className="text-gray-500">Rest day or no exercise plan available for this day.</p>
                    )}
                  </CardContent>
                </Card>
              ))
            ) : (
              <Alert>
                <AlertCircle className="h-4 w-4" />
                <AlertDescription>
                  Exercise plan not available. Please try regenerating the plan.
                </AlertDescription>
              </Alert>
            )}
          </TabsContent>

          <TabsContent value="tracking" className="space-y-4">
            {fitnessPlans.progressTracking ? (
              <div className="space-y-4">
                <Card>
                  <CardHeader>
                    <CardTitle>Progress Tracking</CardTitle>
                  </CardHeader>
                  <CardContent className="space-y-4">
                    <div>
                      <h4 className="font-semibold mb-2">Weekly Measurements</h4>
                      <div className="space-y-1">
                        {fitnessPlans.progressTracking.weeklyMeasurements.map((measurement, index) => (
                          <p key={index} className="text-sm flex items-center">
                            <CheckCircle className="h-3 w-3 mr-2 text-green-500" />
                            {measurement}
                          </p>
                        ))}
                      </div>
                    </div>

                    <Separator />

                    <div>
                      <h4 className="font-semibold mb-2">When to Adjust Your Plan</h4>
                      <div className="space-y-1">
                        {fitnessPlans.progressTracking.adjustmentTriggers.map((trigger, index) => (
                          <p key={index} className="text-sm flex items-center">
                            <AlertCircle className="h-3 w-3 mr-2 text-orange-500" />
                            {trigger}
                          </p>
                        ))}
                      </div>
                    </div>

                    <Separator />

                    <div>
                      <h4 className="font-semibold mb-2">Expected Results (4-6 weeks)</h4>
                      <p className="text-sm">{fitnessPlans.progressTracking.expectedResults}</p>
                    </div>
                  </CardContent>
                </Card>
              </div>
            ) : (
              <Alert>
                <AlertCircle className="h-4 w-4" />
                <AlertDescription>
                  Progress tracking information not available. Please try regenerating the plan.
                </AlertDescription>
              </Alert>
            )}
          </TabsContent>
        </Tabs>
      )}

      {fitnessPlans?.rawResponse && !fitnessPlans.weeklyPlan && (
        <Card>
          <CardHeader>
            <CardTitle>AI Response</CardTitle>
            <CardDescription>Raw response from the AI (formatting may need adjustment)</CardDescription>
          </CardHeader>
          <CardContent>
            <div className="whitespace-pre-wrap text-sm">{fitnessPlans.rawResponse}</div>
          </CardContent>
        </Card>
      )}
    </div>
  );
}
