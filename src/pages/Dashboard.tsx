
import { useState, useEffect } from 'react';
import { useAuth } from '@/hooks/useAuth';
import { useProfileStatus } from '@/hooks/useProfileStatus';
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from '@/components/ui/card';
import { Button } from '@/components/ui/button';
import { Link } from 'react-router-dom';
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
  Brain
} from 'lucide-react';

export default function Dashboard() {
  const { profile } = useAuth();
  const { isProfileComplete, loading } = useProfileStatus();
  const [showProfileAlert, setShowProfileAlert] = useState(false);
  const [showOnboarding, setShowOnboarding] = useState(false);
  const [showAIPlanner, setShowAIPlanner] = useState(false);

  console.log('Dashboard - profile:', profile?.user_role, 'isProfileComplete:', isProfileComplete, 'loading:', loading);

  useEffect(() => {
    if (!loading && !isProfileComplete && profile?.user_role === 'gym_user') {
      // Check if user has dismissed the alert before
      const dismissed = localStorage.getItem('profileAlertDismissed');
      const skipped = localStorage.getItem('onboardingSkipped');
      if (!dismissed && !skipped) {
        setShowProfileAlert(true);
      }
    }
  }, [loading, isProfileComplete, profile?.user_role]);

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
        <Card>
          <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
            <CardTitle className="text-sm font-medium">Today's Workout</CardTitle>
            <Dumbbell className="h-4 w-4 text-muted-foreground" />
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold">Push Day</div>
            <p className="text-xs text-muted-foreground">
              Chest, Shoulders, Triceps
            </p>
          </CardContent>
        </Card>

        <Card>
          <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
            <CardTitle className="text-sm font-medium">Weekly Progress</CardTitle>
            <TrendingUp className="h-4 w-4 text-muted-foreground" />
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold">4/5</div>
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
    </div>
  );
}
