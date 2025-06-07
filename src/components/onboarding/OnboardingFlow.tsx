
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
import { ArrowLeft, ArrowRight, Target, User, Activity } from 'lucide-react';

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
  const { user } = useAuth();
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

  const totalSteps = 3;
  const progress = (currentStep / totalSteps) * 100;

  const fitnessGoalOptions: { value: FitnessGoal; label: string }[] = [
    { value: 'gain_muscle', label: 'Gain Muscle' },
    { value: 'lose_weight', label: 'Lose Weight' },
    { value: 'calisthenics', label: 'Calisthenics Body' },
    { value: 'bulking', label: 'Bulking' },
    { value: 'basic_fitness', label: 'Basic Fitness' },
    { value: 'bodybuilding', label: 'Bodybuilding' },
    { value: 'heavy_lifting', label: 'Heavy Lifting' }
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
    // height should be in meters, weight in kg
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

      toast({
        title: "Profile Updated!",
        description: "Your information has been saved successfully.",
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
    <div className="space-y-4">
      <div className="flex items-center space-x-2 mb-4">
        <User className="h-5 w-5 text-blue-600" />
        <h3 className="text-lg font-semibold">Personal Information</h3>
      </div>
      
      <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
        <div>
          <Label htmlFor="full_name">Full Name</Label>
          <Input
            id="full_name"
            value={data.full_name}
            onChange={(e) => setData(prev => ({ ...prev, full_name: e.target.value }))}
            placeholder="Enter your full name"
          />
        </div>
        <div>
          <Label htmlFor="phone">Phone Number</Label>
          <Input
            id="phone"
            value={data.phone}
            onChange={(e) => setData(prev => ({ ...prev, phone: e.target.value }))}
            placeholder="Enter your phone number"
          />
        </div>
        <div className="md:col-span-2">
          <Label htmlFor="address">Address</Label>
          <Input
            id="address"
            value={data.address}
            onChange={(e) => setData(prev => ({ ...prev, address: e.target.value }))}
            placeholder="Enter your address"
          />
        </div>
        <div>
          <Label htmlFor="city">City</Label>
          <Input
            id="city"
            value={data.city}
            onChange={(e) => setData(prev => ({ ...prev, city: e.target.value }))}
            placeholder="Enter your city"
          />
        </div>
        <div>
          <Label htmlFor="state">State</Label>
          <Input
            id="state"
            value={data.state}
            onChange={(e) => setData(prev => ({ ...prev, state: e.target.value }))}
            placeholder="Enter your state"
          />
        </div>
        <div>
          <Label htmlFor="postal_code">Postal Code</Label>
          <Input
            id="postal_code"
            value={data.postal_code}
            onChange={(e) => setData(prev => ({ ...prev, postal_code: e.target.value }))}
            placeholder="Enter your postal code"
          />
        </div>
      </div>
    </div>
  );

  const renderStep2 = () => (
    <div className="space-y-4">
      <div className="flex items-center space-x-2 mb-4">
        <Activity className="h-5 w-5 text-blue-600" />
        <h3 className="text-lg font-semibold">Physical Information</h3>
      </div>
      
      <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
        <div>
          <Label htmlFor="weight">Weight (kg)</Label>
          <Input
            id="weight"
            type="number"
            value={data.weight}
            onChange={(e) => setData(prev => ({ ...prev, weight: e.target.value }))}
            placeholder="Enter your weight"
          />
        </div>
        <div>
          <Label htmlFor="height">Height (cm)</Label>
          <Input
            id="height"
            type="number"
            value={data.height}
            onChange={(e) => setData(prev => ({ ...prev, height: e.target.value }))}
            placeholder="Enter your height"
          />
        </div>
      </div>

      <div>
        <Label>Fitness Level</Label>
        <RadioGroup
          value={data.fitness_level}
          onValueChange={(value) => setData(prev => ({ ...prev, fitness_level: value }))}
          className="mt-2"
        >
          <div className="flex items-center space-x-2">
            <RadioGroupItem value="beginner" id="beginner" />
            <Label htmlFor="beginner">Beginner</Label>
          </div>
          <div className="flex items-center space-x-2">
            <RadioGroupItem value="intermediate" id="intermediate" />
            <Label htmlFor="intermediate">Intermediate</Label>
          </div>
          <div className="flex items-center space-x-2">
            <RadioGroupItem value="advanced" id="advanced" />
            <Label htmlFor="advanced">Advanced</Label>
          </div>
        </RadioGroup>
      </div>

      <div>
        <Label>Medical Conditions (if any)</Label>
        <Textarea
          value={data.medical_conditions.join(', ')}
          onChange={(e) => setData(prev => ({ 
            ...prev, 
            medical_conditions: e.target.value.split(',').map(s => s.trim()).filter(s => s) 
          }))}
          placeholder="List any medical conditions or injuries (comma separated)"
          className="mt-2"
        />
      </div>
    </div>
  );

  const renderStep3 = () => (
    <div className="space-y-4">
      <div className="flex items-center space-x-2 mb-4">
        <Target className="h-5 w-5 text-blue-600" />
        <h3 className="text-lg font-semibold">Fitness Goals & Preferences</h3>
      </div>
      
      <div>
        <Label className="text-base font-medium">What are your fitness goals?</Label>
        <div className="grid grid-cols-2 md:grid-cols-3 gap-3 mt-3">
          {fitnessGoalOptions.map((goal) => (
            <div key={goal.value} className="flex items-center space-x-2">
              <Checkbox
                id={goal.value}
                checked={data.fitness_goals.includes(goal.value)}
                onCheckedChange={() => handleGoalToggle(goal.value)}
              />
              <Label htmlFor={goal.value} className="text-sm">{goal.label}</Label>
            </div>
          ))}
        </div>
      </div>

      <div>
        <Label className="text-base font-medium">Preferred Training Types</Label>
        <div className="grid grid-cols-2 md:grid-cols-3 gap-3 mt-3">
          {trainingTypeOptions.map((type) => (
            <div key={type.value} className="flex items-center space-x-2">
              <Checkbox
                id={type.value}
                checked={data.preferred_training_types.includes(type.value)}
                onCheckedChange={() => handleTrainingTypeToggle(type.value)}
              />
              <Label htmlFor={type.value} className="text-sm">{type.label}</Label>
            </div>
          ))}
        </div>
      </div>
    </div>
  );

  return (
    <div className="max-w-2xl mx-auto p-6">
      <Card>
        <CardHeader>
          <div className="flex items-center justify-between">
            <div>
              <CardTitle>Complete Your Profile</CardTitle>
              <CardDescription>
                Help us personalize your fitness journey
              </CardDescription>
            </div>
            <Button variant="outline" onClick={onSkip}>
              Skip for now
            </Button>
          </div>
          <Progress value={progress} className="w-full mt-4" />
          <p className="text-sm text-gray-600 mt-2">
            Step {currentStep} of {totalSteps}
          </p>
        </CardHeader>
        
        <CardContent>
          {currentStep === 1 && renderStep1()}
          {currentStep === 2 && renderStep2()}
          {currentStep === 3 && renderStep3()}
          
          <div className="flex justify-between mt-8">
            <Button
              variant="outline"
              onClick={() => setCurrentStep(prev => Math.max(1, prev - 1))}
              disabled={currentStep === 1}
            >
              <ArrowLeft className="h-4 w-4 mr-2" />
              Previous
            </Button>
            
            {currentStep < totalSteps ? (
              <Button onClick={() => setCurrentStep(prev => prev + 1)}>
                Next
                <ArrowRight className="h-4 w-4 ml-2" />
              </Button>
            ) : (
              <Button onClick={handleSubmit} disabled={isLoading}>
                {isLoading ? 'Saving...' : 'Complete Profile'}
              </Button>
            )}
          </div>
        </CardContent>
      </Card>
    </div>
  );
}
