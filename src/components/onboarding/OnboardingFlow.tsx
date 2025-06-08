
import { useState } from 'react';
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from '@/components/ui/card';
import { Button } from '@/components/ui/button';
import { Input } from '@/components/ui/input';
import { Label } from '@/components/ui/label';
import { Textarea } from '@/components/ui/textarea';
import { Checkbox } from '@/components/ui/checkbox';
import { RadioGroup, RadioGroupItem } from '@/components/ui/radio-group';
import { Progress } from '@/components/ui/progress';
import { useAuth } from '@/hooks/useAuth';
import { supabase } from '@/integrations/supabase/client';
import { FitnessGoal, TrainingType } from '@/types/database';
import { toast } from '@/hooks/use-toast';
import { ArrowLeft, ArrowRight, Target, User, Activity, MapPin } from 'lucide-react';

interface OnboardingData {
  // Personal Info
  full_name: string;
  phone: string;
  address: string;
  city: string;
  state: string;
  postal_code: string;
  
  // Fitness Info
  weight: string;
  height: string;
  fitness_level: string;
  fitness_goals: FitnessGoal[];
  preferred_training_types: TrainingType[];
  medical_conditions: string[];
}

interface OnboardingFlowProps {
  onComplete: () => void;
  onSkip: () => void;
}

export function OnboardingFlow({ onComplete, onSkip }: OnboardingFlowProps) {
  const { user, refreshProfile } = useAuth();
  const [currentStep, setCurrentStep] = useState(1);
  const [isLoading, setIsLoading] = useState(false);
  const [data, setData] = useState<OnboardingData>({
    full_name: '',
    phone: '',
    address: '',
    city: '',
    state: '',
    postal_code: '',
    weight: '',
    height: '',
    fitness_level: '',
    fitness_goals: [],
    preferred_training_types: [],
    medical_conditions: []
  });

  const totalSteps = 4;
  const progress = (currentStep / totalSteps) * 100;

  const fitnessGoalOptions: { value: FitnessGoal; label: string; description: string }[] = [
    { value: 'gain_muscle', label: 'Gain Muscle', description: 'Build lean muscle mass and strength' },
    { value: 'lose_weight', label: 'Lose Weight', description: 'Reduce body fat and achieve a lean physique' },
    { value: 'calisthenics', label: 'Calisthenics Body', description: 'Master bodyweight movements and functional strength' },
    { value: 'bulking', label: 'Bulking', description: 'Gain mass and size through structured eating and training' },
    { value: 'basic_fitness', label: 'Basic Fitness', description: 'Improve overall health and daily activity levels' },
    { value: 'bodybuilding', label: 'Bodybuilding', description: 'Sculpt physique for competition or aesthetic goals' },
    { value: 'heavy_lifting', label: 'Heavy Lifting', description: 'Focus on powerlifting and maximum strength gains' }
  ];

  const trainingTypeOptions: { value: TrainingType; label: string }[] = [
    { value: 'strength', label: 'Strength Training' },
    { value: 'cardio', label: 'Cardio' },
    { value: 'yoga', label: 'Yoga' },
    { value: 'pilates', label: 'Pilates' },
    { value: 'crossfit', label: 'CrossFit' },
    { value: 'martial_arts', label: 'Martial Arts' },
    { value: 'swimming', label: 'Swimming' },
    { value: 'cycling', label: 'Cycling' }
  ];

  const handleGoalToggle = (goal: FitnessGoal) => {
    setData(prev => ({
      ...prev,
      fitness_goals: prev.fitness_goals.includes(goal)
        ? prev.fitness_goals.filter(g => g !== goal)
        : [...prev.fitness_goals, goal]
    }));
  };

  const handleTrainingTypeToggle = (type: TrainingType) => {
    setData(prev => ({
      ...prev,
      preferred_training_types: prev.preferred_training_types.includes(type)
        ? prev.preferred_training_types.filter(t => t !== type)
        : [...prev.preferred_training_types, type]
    }));
  };

  const calculateBMI = (weight: number, height: number): number => {
    const heightInMeters = height / 100;
    return weight / (heightInMeters * heightInMeters);
  };

  const handleSubmit = async () => {
    if (!user) return;

    setIsLoading(true);
    try {
      // Update profile table
      const { error: profileError } = await supabase
        .from('profiles')
        .update({
          full_name: data.full_name || null,
          phone: data.phone || null,
          address: data.address || null,
          city: data.city || null,
          state: data.state || null,
          postal_code: data.postal_code || null,
        })
        .eq('id', user.id);

      if (profileError) throw profileError;

      // Update gym user profile
      const weight = parseFloat(data.weight);
      const height = parseFloat(data.height);
      const bmi = weight && height ? calculateBMI(weight, height) : null;

      const { error: gymProfileError } = await supabase
        .from('gym_user_profiles')
        .update({
          weight: weight || null,
          height: height || null,
          bmi: bmi,
          fitness_level: data.fitness_level || null,
          fitness_goals: data.fitness_goals.length > 0 ? data.fitness_goals : null,
          preferred_training_types: data.preferred_training_types.length > 0 ? data.preferred_training_types : null,
          medical_conditions: data.medical_conditions.length > 0 ? data.medical_conditions : null,
        })
        .eq('id', user.id);

      if (gymProfileError) throw gymProfileError;

      // Clear the onboarding skipped flag
      localStorage.removeItem('onboardingSkipped');
      localStorage.removeItem('profileAlertDismissed');

      // Refresh profile data
      await refreshProfile();

      toast({
        title: "Profile Completed!",
        description: "Welcome! Your fitness journey starts now.",
      });

      onComplete();
    } catch (error) {
      console.error('Error updating profile:', error);
      toast({
        title: "Error",
        description: "Failed to save your information. Please try again.",
        variant: "destructive"
      });
    } finally {
      setIsLoading(false);
    }
  };

  const renderStep1 = () => (
    <div className="space-y-6">
      <div className="flex items-center space-x-3 mb-6">
        <User className="h-6 w-6 text-blue-600" />
        <div>
          <h3 className="text-xl font-bold">Personal Information</h3>
          <p className="text-gray-600">Let's start with your basic details</p>
        </div>
      </div>
      
      <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
        <div>
          <Label htmlFor="full_name">Full Name *</Label>
          <Input
            id="full_name"
            value={data.full_name}
            onChange={(e) => setData(prev => ({ ...prev, full_name: e.target.value }))}
            placeholder="Enter your full name"
            className="mt-1"
          />
        </div>
        <div>
          <Label htmlFor="phone">Phone Number</Label>
          <Input
            id="phone"
            value={data.phone}
            onChange={(e) => setData(prev => ({ ...prev, phone: e.target.value }))}
            placeholder="Enter your phone number"
            className="mt-1"
          />
        </div>
        <div className="md:col-span-2">
          <Label htmlFor="address">Street Address</Label>
          <Input
            id="address"
            value={data.address}
            onChange={(e) => setData(prev => ({ ...prev, address: e.target.value }))}
            placeholder="Enter your street address"
            className="mt-1"
          />
        </div>
        <div>
          <Label htmlFor="city">City</Label>
          <Input
            id="city"
            value={data.city}
            onChange={(e) => setData(prev => ({ ...prev, city: e.target.value }))}
            placeholder="Enter your city"
            className="mt-1"
          />
        </div>
        <div>
          <Label htmlFor="state">State/Province</Label>
          <Input
            id="state"
            value={data.state}
            onChange={(e) => setData(prev => ({ ...prev, state: e.target.value }))}
            placeholder="Enter your state"
            className="mt-1"
          />
        </div>
        <div>
          <Label htmlFor="postal_code">Postal Code</Label>
          <Input
            id="postal_code"
            value={data.postal_code}
            onChange={(e) => setData(prev => ({ ...prev, postal_code: e.target.value }))}
            placeholder="Enter your postal code"
            className="mt-1"
          />
        </div>
      </div>
    </div>
  );

  const renderStep2 = () => (
    <div className="space-y-6">
      <div className="flex items-center space-x-3 mb-6">
        <Activity className="h-6 w-6 text-green-600" />
        <div>
          <h3 className="text-xl font-bold">Physical Information</h3>
          <p className="text-gray-600">Help us understand your current fitness level</p>
        </div>
      </div>
      
      <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
        <div>
          <Label htmlFor="weight">Weight (kg) *</Label>
          <Input
            id="weight"
            type="number"
            value={data.weight}
            onChange={(e) => setData(prev => ({ ...prev, weight: e.target.value }))}
            placeholder="e.g., 70"
            className="mt-1"
          />
        </div>
        <div>
          <Label htmlFor="height">Height (cm) *</Label>
          <Input
            id="height"
            type="number"
            value={data.height}
            onChange={(e) => setData(prev => ({ ...prev, height: e.target.value }))}
            placeholder="e.g., 175"
            className="mt-1"
          />
        </div>
      </div>

      {data.weight && data.height && (
        <div className="p-4 bg-blue-50 rounded-lg">
          <p className="text-sm font-medium text-blue-900">
            Your BMI: {calculateBMI(parseFloat(data.weight), parseFloat(data.height)).toFixed(1)}
          </p>
        </div>
      )}

      <div>
        <Label className="text-base font-medium">Current Fitness Level *</Label>
        <RadioGroup
          value={data.fitness_level}
          onValueChange={(value) => setData(prev => ({ ...prev, fitness_level: value }))}
          className="mt-3"
        >
          <div className="flex items-center space-x-3 p-3 border rounded-lg">
            <RadioGroupItem value="beginner" id="beginner" />
            <div>
              <Label htmlFor="beginner" className="font-medium">Beginner</Label>
              <p className="text-sm text-gray-600">New to exercise or returning after a long break</p>
            </div>
          </div>
          <div className="flex items-center space-x-3 p-3 border rounded-lg">
            <RadioGroupItem value="intermediate" id="intermediate" />
            <div>
              <Label htmlFor="intermediate" className="font-medium">Intermediate</Label>
              <p className="text-sm text-gray-600">Regular exercise routine for 6+ months</p>
            </div>
          </div>
          <div className="flex items-center space-x-3 p-3 border rounded-lg">
            <RadioGroupItem value="advanced" id="advanced" />
            <div>
              <Label htmlFor="advanced" className="font-medium">Advanced</Label>
              <p className="text-sm text-gray-600">Consistent training for 2+ years</p>
            </div>
          </div>
        </RadioGroup>
      </div>
    </div>
  );

  const renderStep3 = () => (
    <div className="space-y-6">
      <div className="flex items-center space-x-3 mb-6">
        <Target className="h-6 w-6 text-purple-600" />
        <div>
          <h3 className="text-xl font-bold">Fitness Goals</h3>
          <p className="text-gray-600">What do you want to achieve? (Select multiple if needed)</p>
        </div>
      </div>
      
      <div className="grid grid-cols-1 gap-4">
        {fitnessGoalOptions.map((goal) => (
          <div 
            key={goal.value} 
            className={`p-4 border rounded-lg cursor-pointer transition-all ${
              data.fitness_goals.includes(goal.value) 
                ? 'border-blue-500 bg-blue-50' 
                : 'border-gray-200 hover:border-gray-300'
            }`}
            onClick={() => handleGoalToggle(goal.value)}
          >
            <div className="flex items-start space-x-3">
              <Checkbox
                id={goal.value}
                checked={data.fitness_goals.includes(goal.value)}
                onChange={() => handleGoalToggle(goal.value)}
              />
              <div className="flex-1">
                <Label htmlFor={goal.value} className="font-medium text-base cursor-pointer">
                  {goal.label}
                </Label>
                <p className="text-sm text-gray-600 mt-1">{goal.description}</p>
              </div>
            </div>
          </div>
        ))}
      </div>
    </div>
  );

  const renderStep4 = () => (
    <div className="space-y-6">
      <div className="flex items-center space-x-3 mb-6">
        <Activity className="h-6 w-6 text-orange-600" />
        <div>
          <h3 className="text-xl font-bold">Training Preferences</h3>
          <p className="text-gray-600">What types of training do you enjoy?</p>
        </div>
      </div>
      
      <div>
        <Label className="text-base font-medium mb-4 block">Preferred Training Types</Label>
        <div className="grid grid-cols-2 md:grid-cols-3 gap-3">
          {trainingTypeOptions.map((type) => (
            <div 
              key={type.value} 
              className={`p-3 border rounded-lg cursor-pointer transition-all ${
                data.preferred_training_types.includes(type.value) 
                  ? 'border-orange-500 bg-orange-50' 
                  : 'border-gray-200 hover:border-gray-300'
              }`}
              onClick={() => handleTrainingTypeToggle(type.value)}
            >
              <div className="flex items-center space-x-2">
                <Checkbox
                  id={type.value}
                  checked={data.preferred_training_types.includes(type.value)}
                  onChange={() => handleTrainingTypeToggle(type.value)}
                />
                <Label htmlFor={type.value} className="text-sm cursor-pointer">
                  {type.label}
                </Label>
              </div>
            </div>
          ))}
        </div>
      </div>

      <div>
        <Label htmlFor="medical_conditions" className="text-base font-medium">
          Medical Conditions or Injuries
        </Label>
        <Textarea
          id="medical_conditions"
          value={data.medical_conditions.join(', ')}
          onChange={(e) => setData(prev => ({ 
            ...prev, 
            medical_conditions: e.target.value.split(',').map(s => s.trim()).filter(s => s) 
          }))}
          placeholder="List any medical conditions, injuries, or limitations (comma separated)"
          className="mt-2"
          rows={3}
        />
        <p className="text-xs text-gray-500 mt-1">
          This helps us provide safer workout recommendations
        </p>
      </div>
    </div>
  );

  const canProceed = () => {
    switch (currentStep) {
      case 1:
        return data.full_name.trim() !== '';
      case 2:
        return data.weight && data.height && data.fitness_level;
      case 3:
        return data.fitness_goals.length > 0;
      case 4:
        return true; // Optional step
      default:
        return false;
    }
  };

  return (
    <div className="min-h-screen bg-gray-50 py-8">
      <div className="max-w-3xl mx-auto px-4">
        <Card className="shadow-lg">
          <CardHeader>
            <div className="flex items-center justify-between">
              <div>
                <CardTitle className="text-2xl">Complete Your Fitness Profile</CardTitle>
                <CardDescription className="text-base">
                  Help us personalize your fitness journey and provide better recommendations
                </CardDescription>
              </div>
              <Button variant="outline" onClick={onSkip} className="shrink-0">
                Skip for now
              </Button>
            </div>
            <div className="mt-6">
              <Progress value={progress} className="w-full h-2" />
              <div className="flex justify-between text-sm text-gray-600 mt-2">
                <span>Step {currentStep} of {totalSteps}</span>
                <span>{Math.round(progress)}% complete</span>
              </div>
            </div>
          </CardHeader>
          
          <CardContent className="pt-6">
            {currentStep === 1 && renderStep1()}
            {currentStep === 2 && renderStep2()}
            {currentStep === 3 && renderStep3()}
            {currentStep === 4 && renderStep4()}
            
            <div className="flex justify-between mt-10">
              <Button
                variant="outline"
                onClick={() => setCurrentStep(prev => Math.max(1, prev - 1))}
                disabled={currentStep === 1}
                className="flex items-center"
              >
                <ArrowLeft className="h-4 w-4 mr-2" />
                Previous
              </Button>
              
              {currentStep < totalSteps ? (
                <Button 
                  onClick={() => setCurrentStep(prev => prev + 1)}
                  disabled={!canProceed()}
                  className="flex items-center"
                >
                  Next
                  <ArrowRight className="h-4 w-4 ml-2" />
                </Button>
              ) : (
                <Button onClick={handleSubmit} disabled={isLoading} className="min-w-[120px]">
                  {isLoading ? 'Saving...' : 'Complete Profile'}
                </Button>
              )}
            </div>
          </CardContent>
        </Card>
      </div>
    </div>
  );
}
