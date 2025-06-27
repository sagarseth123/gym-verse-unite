import { useState, useEffect } from 'react';
import { useAuth } from '@/hooks/useAuth';
import { useProfileStatus } from '@/hooks/useProfileStatus';
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from '@/components/ui/card';
import { Button } from '@/components/ui/button';
import { Link, useNavigate, useLocation } from 'react-router-dom';
import { ProfileCompletionAlert } from '@/components/ProfileCompletionAlert';
import { OnboardingFlow } from '@/components/onboarding/OnboardingFlow';
import { AIFitnessPlanner } from '@/components/AIFitnessPlanner';
import { 
  Dumbbell, 
  Target, 
  TrendingUp, 
  Calendar,
  MapPin,
  ShoppingCart,
  Brain,
  Loader2,
  MessageCircle
} from 'lucide-react';
import { supabase } from '@/integrations/supabase/client';
import { startOfWeek, format, addDays, isToday } from 'date-fns';
import { useToast } from '@/hooks/use-toast';
import { Badge } from '@/components/ui/badge';
import { Dialog, DialogContent, DialogHeader, DialogTitle } from '@/components/ui/dialog';

export default function Dashboard() {
  const { profile } = useAuth();
  const { isProfileComplete, loading } = useProfileStatus();
  const [showProfileAlert, setShowProfileAlert] = useState(false);
  const [showOnboarding, setShowOnboarding] = useState(false);
  const [showAIPlanner, setShowAIPlanner] = useState(false);

  // Workout Track state
  const [weeklyPlan, setWeeklyPlan] = useState<any>(null);
  const [trackLoading, setTrackLoading] = useState(true);
  const [trackError, setTrackError] = useState<string | null>(null);
  const [workoutInputs, setWorkoutInputs] = useState<{ [date: string]: { calories: string; notes: string; completed: boolean; aiFeedback?: string; aiLoading?: boolean } }>({});
  const { toast } = useToast();

  // Add state for weekly progress
  const [completedCount, setCompletedCount] = useState(0);
  const [plannedCount, setPlannedCount] = useState(0);
  const [showProgressModal, setShowProgressModal] = useState(false);
  const [weeklyWorkouts, setWeeklyWorkouts] = useState<any[]>([]);

  const navigate = useNavigate();
  const location = useLocation();

  console.log('Dashboard - profile:', profile?.user_role, 'isProfileComplete:', isProfileComplete, 'loading:', loading);

  useEffect(() => {
    const dismissed = localStorage.getItem('profileAlertDismissed');
    const skipped = localStorage.getItem('onboardingSkipped');
    if (!dismissed && !skipped) {
      setShowProfileAlert(true);
    }
  }, [loading, isProfileComplete, profile?.user_role]);

  useEffect(() => {
    const params = new URLSearchParams(location.search);
    if (params.get('ai') === '1') {
      setShowAIPlanner(true);
    }
  }, [location.search]);

  // Fetch weekly plan and workouts on mount
  useEffect(() => {
    const fetchPlanAndWorkouts = async () => {
      setTrackLoading(true);
      setTrackError(null);
      try {
        const session = await supabase.auth.getSession();
        const user = session.data.session?.user;
        if (!user) throw new Error('Not authenticated');
        const weekStartDate = startOfWeek(new Date(), { weekStartsOn: 1 });
        const weekStart = format(weekStartDate, 'yyyy-MM-dd');
        // Fetch plan
        const { data: planRows, error: planError } = await supabase
          .from('user_weekly_plans')
          .select('*')
          .eq('user_id', user.id)
          .eq('week_start', weekStart);
        console.log('Raw planRows (dashboard):', planRows, 'planError:', planError);
        if (planError) throw planError;
        let planObj: any = null;
        if (Array.isArray(planRows) && planRows.length > 0) {
          const plan = planRows[0]?.plan_data || null;
          if (plan && typeof plan === 'object' && !Array.isArray(plan)) {
            planObj = plan;
          }
        }
        setWeeklyPlan(planObj);
        // Calculate planned workout days
        let planned = 0;
        if (planObj && planObj.exercisePlan) {
          planned = Object.values(planObj.exercisePlan).filter((d: any) => d.exercises && d.exercises.length > 0).length;
        }
        setPlannedCount(planned);
        // Fetch completed workouts for the week
        const weekDates = Array.from({length: 7}, (_, i) => format(addDays(weekStartDate, i), 'yyyy-MM-dd'));
        const { data: workouts, error: workoutsError } = await supabase
          .from('user_workouts')
          .select('*')
          .eq('user_id', user.id)
          .in('workout_date', weekDates);
        if (workoutsError) throw workoutsError;
        setWeeklyWorkouts(workouts);
        // Count unique days with at least one workout
        const completedDays = new Set(workouts.map(w => w.workout_date));
        setCompletedCount(completedDays.size);
        // Debug output
        console.log('Loaded plan:', planObj);
        console.log('Loaded workouts:', workouts);
      } catch (err: any) {
        setTrackError(err.message || 'Failed to load plan');
      } finally {
        setTrackLoading(false);
      }
    };
    fetchPlanAndWorkouts();
  }, []);

  // Handle workout tracking input changes
  const handleInputChange = (date: string, field: 'calories' | 'notes', value: string) => {
    setWorkoutInputs((prev) => ({
      ...prev,
      [date]: {
        ...prev[date],
        [field]: value,
      },
    }));
  };

  // Mark workout as complete and save to user_workouts
  const handleCompleteWorkout = async (date: string, exercises: any[]) => {
    setWorkoutInputs((prev) => ({
      ...prev,
      [date]: {
        ...prev[date],
        completed: true,
      },
    }));
    try {
      const session = await supabase.auth.getSession();
      const user = session.data.session?.user;
      if (!user) throw new Error('Not authenticated');
      const calories = parseInt(workoutInputs[date]?.calories || '0', 10);
      const notes = workoutInputs[date]?.notes || '';
      // Save each exercise as a workout
      for (const ex of exercises) {
        await supabase.from('user_workouts').insert({
          user_id: user.id,
          exercise_id: ex.id || ex.name,
          workout_date: date,
          notes,
          // Optionally add sets, reps, etc.
        });
      }
      toast({ title: 'Workout Tracked!', description: `Workout for ${date} marked as complete.` });
    } catch (err: any) {
      toast({ title: 'Error', description: err.message || 'Failed to track workout', variant: 'destructive' });
    }
  };

  // Get AI feedback for a day's workout
  const handleGetAIFeedback = async (date: string, exercises: any[], calories: string, notes: string) => {
    setWorkoutInputs((prev) => ({
      ...prev,
      [date]: {
        ...prev[date],
        aiLoading: true,
      },
    }));
    try {
      const { data, error } = await supabase.functions.invoke('generate-fitness-plan', {
        body: {
          type: 'workout_feedback',
          exercises,
          calories,
          notes,
          date,
        },
      });
      setWorkoutInputs((prev) => ({
        ...prev,
        [date]: {
          ...prev[date],
          aiFeedback: data?.feedback || 'No feedback received.',
          aiLoading: false,
        },
      }));
    } catch (err: any) {
      setWorkoutInputs((prev) => ({
        ...prev,
        [date]: {
          ...prev[date],
          aiFeedback: err.message || 'Failed to get feedback.',
          aiLoading: false,
        },
      }));
    }
  };

  const handleDismissAlert = () => {
    setShowProfileAlert(false);
    localStorage.setItem('profileAlertDismissed', 'true');
  };

  const handleStartOnboarding = () => {
    setShowOnboarding(true);
    setShowProfileAlert(false);
  };

  const handleCompleteOnboarding = () => {
    setShowOnboarding(false);
    window.location.reload();
  };

  const handleSkipOnboarding = () => {
    localStorage.setItem('onboardingSkipped', 'true');
    setShowOnboarding(false);
    setShowProfileAlert(false);
  };

  if (loading) {
    return (
      <div className="container mx-auto px-4 py-8">
        <div className="text-center">
          <div className="animate-spin rounded-full h-8 w-8 border-b-2 border-blue-600 mx-auto"></div>
          <p className="mt-2 text-gray-600">Loading dashboard...</p>
        </div>
      </div>
    );
  }

  // Show onboarding flow if requested
  if (showOnboarding) {
    return (
      <OnboardingFlow 
        onComplete={handleCompleteOnboarding}
        onSkip={handleSkipOnboarding}
      />
    );
  }

  // Show AI Planner if requested
  if (showAIPlanner) {
    return (
      <div className="container mx-auto px-4 py-8">
        <div className="mb-6">
          <Button 
            variant="outline" 
            onClick={() => setShowAIPlanner(false)}
            className="mb-4"
          >
            ← Back to Dashboard
          </Button>
          <h1 className="text-3xl font-bold text-gray-900">AI Fitness Planner</h1>
          <p className="text-gray-600 mt-2">
            Get personalized diet and exercise recommendations powered by AI
          </p>
        </div>
        <AIFitnessPlanner />
      </div>
    );
  }

  return (
    <div className="container mx-auto px-4 py-8">
      <div className="mb-8">
        <h1 className="text-3xl font-bold text-gray-900">
          Welcome back, {profile?.full_name || 'there'}!
        </h1>
        <p className="text-gray-600 mt-2">
          Ready to crush your fitness goals today?
        </p>
      </div>

      {showProfileAlert && (
        <ProfileCompletionAlert 
          onDismiss={handleDismissAlert}
          onStartOnboarding={handleStartOnboarding}
        />
      )}

      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6 mb-8">
        <Card className="cursor-pointer hover:shadow-lg transition-shadow" onClick={() => navigate('/WeeklyProgress')}>
          <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
            <CardTitle className="text-sm font-medium">Today's Workout</CardTitle>
            <Dumbbell className="h-4 w-4 text-muted-foreground" />
          </CardHeader>
          <CardContent>
            {weeklyPlan ? (() => {
              const today = new Date().toLocaleDateString('en-US', { weekday: 'long' }).toLowerCase();
              const todayPlan = weeklyPlan.exercisePlan?.[today];
              const exercises = todayPlan?.exercises || [];
              
              if (exercises.length > 0) {
                // Determine workout type and muscles from exercises
                const workoutType = todayPlan?.workoutType || 'Strength Training';
                const muscles = todayPlan?.targetMuscles || 'Full Body';
                const exerciseCount = exercises.length;
                
                return (
                  <>
                    <div className="text-2xl font-bold text-blue-600">{workoutType}</div>
                    <p className="text-xs text-muted-foreground mb-2">
                      {muscles}
                    </p>
                    <div className="flex items-center justify-between">
                      <span className="text-sm font-medium">{exerciseCount} exercises</span>
                      <Badge variant="secondary" className="text-xs">
                        {isToday(new Date()) ? 'Today' : 'Scheduled'}
                      </Badge>
                    </div>
                    <div className="mt-2 text-xs text-gray-500">
                      Click to view details
                    </div>
                  </>
                );
              } else {
                return (
                  <>
                    <div className="text-2xl font-bold text-gray-400">Rest Day</div>
                    <p className="text-xs text-muted-foreground mb-2">
                      No workout scheduled
                    </p>
                    <div className="text-xs text-gray-500">
                      Perfect time for recovery
                    </div>
                  </>
                );
              }
            })() : (
              <>
                <div className="text-2xl font-bold text-gray-400">No Plan</div>
                <p className="text-xs text-muted-foreground mb-2">
                  Generate a workout plan
                </p>
                <div className="text-xs text-gray-500">
                  Click to create your plan
                </div>
              </>
            )}
          </CardContent>
        </Card>

        <Card className="cursor-pointer hover:shadow-lg transition-shadow" onClick={() => navigate('/WeeklyProgress')}>
          <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
            <CardTitle className="text-sm font-medium">Weekly Progress</CardTitle>
            <TrendingUp className="h-4 w-4 text-muted-foreground" />
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold">{completedCount}/{plannedCount}</div>
            <p className="text-xs text-muted-foreground">
              Workouts completed this week
            </p>
          </CardContent>
        </Card>

        <Card>
          <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
            <CardTitle className="text-sm font-medium">Current Goal</CardTitle>
            <Target className="h-4 w-4 text-muted-foreground" />
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold">Muscle Gain</div>
            <p className="text-xs text-muted-foreground">
              75% progress to target
            </p>
          </CardContent>
        </Card>
      </div>

      <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
        <Card>
          <CardHeader>
            <CardTitle>Quick Actions</CardTitle>
            <CardDescription>
              Get started with your fitness journey
            </CardDescription>
          </CardHeader>
          <CardContent className="grid grid-cols-2 gap-4">
            <Button 
              onClick={() => setShowAIPlanner(true)}
              className="h-20 flex-col bg-purple-600 hover:bg-purple-700"
            >
              <Brain className="h-6 w-6 mb-2" />
              AI Fitness Plan
            </Button>
            <Button asChild className="h-20 flex-col">
              <Link to="/explore">
                <Dumbbell className="h-6 w-6 mb-2" />
                Browse Exercises
              </Link>
            </Button>
            <Button asChild variant="outline" className="h-20 flex-col">
              <Link to="/explore">
                <Calendar className="h-6 w-6 mb-2" />
                Plan Workout
              </Link>
            </Button>
            <Button asChild variant="outline" className="h-20 flex-col">
              <Link to="/explore">
                <MapPin className="h-6 w-6 mb-2" />
                Find Gyms
              </Link>
            </Button>
            <Button asChild variant="outline" className="h-20 flex-col">
              <Link to="/shop">
                <ShoppingCart className="h-6 w-6 mb-2" />
                Shop Products
              </Link>
            </Button>
          </CardContent>
        </Card>

        <Card>
          <CardHeader>
            <CardTitle>Fitness Recommendations</CardTitle>
            <CardDescription>
              Based on your goals and progress
            </CardDescription>
          </CardHeader>
          <CardContent className="space-y-4">
            <div className="p-4 border rounded-lg">
              <h4 className="font-medium">Try AI Fitness Planning</h4>
              <p className="text-sm text-gray-600">
                Get personalized diet and exercise plans powered by AI
              </p>
              <Button 
                size="sm" 
                className="mt-2 bg-purple-600 hover:bg-purple-700"
                onClick={() => setShowAIPlanner(true)}
              >
                <Brain className="h-4 w-4 mr-2" />
                Generate Plan
              </Button>
            </div>
            <div className="p-4 border rounded-lg">
              <h4 className="font-medium">Progressive Overload</h4>
              <p className="text-sm text-gray-600">
                Time to increase weights for better strength gains
              </p>
            </div>
            <div className="p-4 border rounded-lg">
              <h4 className="font-medium">Rest Day Reminder</h4>
              <p className="text-sm text-gray-600">
                Don't forget to schedule rest days for recovery
              </p>
            </div>
          </CardContent>
        </Card>
      </div>

      {/* Workout Track Section */}
      <div className="mb-8">
        <Card>
          <CardHeader>
            <CardTitle>Workout Track</CardTitle>
            <CardDescription>Track your weekly plan and daily progress</CardDescription>
          </CardHeader>
          <CardContent>
            {trackLoading ? (
              <div className="flex items-center gap-2"><Loader2 className="animate-spin" /> Loading plan...</div>
            ) : trackError ? (
              <div className="text-red-600">{trackError}</div>
            ) : !weeklyPlan ? (
              <div>No plan found for this week. Generate a plan to get started!</div>
            ) : (
              <div className="space-y-6">
                {['monday','tuesday','wednesday','thursday','friday','saturday','sunday'].map((day, idx) => {
                  const date = format(addDays(startOfWeek(new Date(), { weekStartsOn: 1 }), idx), 'yyyy-MM-dd');
                  const dayPlan = weeklyPlan.exercisePlan?.[day] || (weeklyPlan.exercises ? { exercises: weeklyPlan.exercises } : null);
                  return (
                    <div key={day} className="p-4 border rounded-lg bg-gray-50">
                      <div className="flex justify-between items-center mb-2">
                        <h4 className="font-semibold capitalize">{day}</h4>
                        {isToday(addDays(startOfWeek(new Date(), { weekStartsOn: 1 }), idx)) && <Badge variant="secondary">Today</Badge>}
                      </div>
                      {dayPlan && dayPlan.exercises && dayPlan.exercises.length > 0 ? (
                        <div className="space-y-2 mb-2">
                          {dayPlan.exercises.map((ex: any, i: number) => (
                            <div key={i} className="flex items-center gap-2">
                              <Dumbbell className="h-4 w-4 text-blue-600" />
                              <span className="font-medium">{ex.name || ex}</span>
                            </div>
                          ))}
                        </div>
                      ) : (
                        <div className="text-gray-500 mb-2">No exercises planned.</div>
                      )}
                      <div className="flex flex-col md:flex-row gap-2 items-center">
                        <input
                          type="number"
                          placeholder="Calories burned"
                          className="border rounded px-2 py-1 text-sm"
                          value={workoutInputs[date]?.calories || ''}
                          onChange={e => handleInputChange(date, 'calories', e.target.value)}
                        />
                        <input
                          type="text"
                          placeholder="Notes"
                          className="border rounded px-2 py-1 text-sm"
                          value={workoutInputs[date]?.notes || ''}
                          onChange={e => handleInputChange(date, 'notes', e.target.value)}
                        />
                        <Button
                          size="sm"
                          onClick={() => handleCompleteWorkout(date, dayPlan?.exercises || [])}
                          disabled={workoutInputs[date]?.completed}
                        >
                          {workoutInputs[date]?.completed ? 'Completed' : 'Mark Complete'}
                        </Button>
                        <Button
                          size="sm"
                          variant="outline"
                          onClick={() => handleGetAIFeedback(date, dayPlan?.exercises || [], workoutInputs[date]?.calories || '', workoutInputs[date]?.notes || '')}
                          disabled={workoutInputs[date]?.aiLoading}
                        >
                          {workoutInputs[date]?.aiLoading ? <Loader2 className="h-4 w-4 animate-spin" /> : <MessageCircle className="h-4 w-4" />}
                          Get AI Feedback
                        </Button>
                      </div>
                      {workoutInputs[date]?.aiFeedback && (
                        <div className="mt-2 p-2 bg-blue-50 rounded text-blue-900 text-sm">
                          <strong>AI Feedback:</strong> {workoutInputs[date].aiFeedback}
                        </div>
                      )}
                    </div>
                  );
                })}
              </div>
            )}
          </CardContent>
        </Card>
      </div>

      {/* Progress Modal */}
      <Dialog open={showProgressModal} onOpenChange={setShowProgressModal}>
        <DialogContent>
          <DialogHeader>
            <DialogTitle>Weekly Workout Details</DialogTitle>
          </DialogHeader>
          <div className="space-y-2">
            {plannedCount === 0 ? (
              <div>No planned workouts for this week.</div>
            ) : (
              <>
                <div><strong>Planned Days:</strong> {plannedCount}</div>
                <div><strong>Completed Days:</strong> {completedCount}</div>
                <div className="mt-2">
                  <strong>Completed Workouts:</strong>
                  <ul className="list-disc ml-6">
                    {Array.from(new Set(weeklyWorkouts.map(w => w.workout_date))).map(date => (
                      <li key={date}>{date}</li>
                    ))}
                  </ul>
                </div>
              </>
            )}
          </div>
        </DialogContent>
      </Dialog>
    </div>
  );
}
