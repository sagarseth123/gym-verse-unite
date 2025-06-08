import { useState, useEffect } from 'react';
import { useAuth } from '@/hooks/useAuth';
import { supabase } from '@/integrations/supabase/client';
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from '@/components/ui/card';
import { Button } from '@/components/ui/button';
import { Input } from '@/components/ui/input';
import { Label } from '@/components/ui/label';
import { Textarea } from '@/components/ui/textarea';
import { Checkbox } from '@/components/ui/checkbox';
import { RadioGroup, RadioGroupItem } from '@/components/ui/radio-group';
import { Badge } from '@/components/ui/badge';
import { Separator } from '@/components/ui/separator';
import { Alert, AlertDescription } from '@/components/ui/alert';
import { toast } from '@/hooks/use-toast';
import { 
  Edit2, 
  Save, 
  X, 
  User, 
  Activity, 
  Target, 
  MapPin, 
  AlertCircle,
  CheckCircle
} from 'lucide-react';
import { Profile as ProfileType, GymUserProfile, FitnessGoal, TrainingType } from '@/types/database';

export default function Profile() {
  const { user, profile, loading: authLoading, refreshProfile } = useAuth();
  const [gymProfile, setGymProfile] = useState<GymUserProfile | null>(null);
  const [editingSection, setEditingSection] = useState<string | null>(null);
  const [isLoading, setIsLoading] = useState(false);
  const [pageLoading, setPageLoading] = useState(true);
  
  const [personalData, setPersonalData] = useState({
    full_name: '',
    phone: '',
    address: '',
    city: '',
    state: '',
    postal_code: ''
  });

  const [fitnessData, setFitnessData] = useState({
    weight: '',
    height: '',
    fitness_level: '',
    medical_conditions: [] as string[]
  });

  const [goalsData, setGoalsData] = useState({
    fitness_goals: [] as FitnessGoal[],
    preferred_training_types: [] as TrainingType[]
  });

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

  // Check profile completion status
  const getProfileCompletionStatus = () => {
    if (!profile) return { isComplete: false, missingFields: [] };
    
    const missingFields = [];
    
    // Basic info
    if (!profile.full_name) missingFields.push('Full Name');
    if (!profile.phone) missingFields.push('Phone Number');
    if (!profile.address) missingFields.push('Address');
    
    // For gym users, check fitness info
    if (profile.user_role === 'gym_user') {
      if (!gymProfile?.weight) missingFields.push('Weight');
      if (!gymProfile?.height) missingFields.push('Height');
      if (!gymProfile?.fitness_level) missingFields.push('Fitness Level');
      if (!gymProfile?.fitness_goals?.length) missingFields.push('Fitness Goals');
    }
    
    return {
      isComplete: missingFields.length === 0,
      missingFields,
      completionPercentage: Math.round(((10 - missingFields.length) / 10) * 100)
    };
  };

  useEffect(() => {
    if (profile) {
      console.log('Setting personal data from profile:', profile);
      setPersonalData({
        full_name: profile.full_name || '',
        phone: profile.phone || '',
        address: profile.address || '',
        city: profile.city || '',
        state: profile.state || '',
        postal_code: profile.postal_code || ''
      });
    }
  }, [profile]);

  useEffect(() => {
    const fetchGymProfile = async () => {
      if (!user || authLoading) return;

      console.log('Fetching gym profile for user:', user.id);
      setPageLoading(true);

      try {
        const { data, error } = await supabase
          .from('gym_user_profiles')
          .select('*')
          .eq('id', user.id)
          .maybeSingle();

        if (error && error.code !== 'PGRST116') {
          console.error('Error fetching gym profile:', error);
        } else if (data) {
          console.log('Gym profile fetched:', data);
          setGymProfile(data);
          setFitnessData({
            weight: data.weight?.toString() || '',
            height: data.height?.toString() || '',
            fitness_level: data.fitness_level || '',
            medical_conditions: data.medical_conditions || []
          });
          setGoalsData({
            fitness_goals: data.fitness_goals || [],
            preferred_training_types: data.preferred_training_types || []
          });
        }
      } catch (error) {
        console.error('Error in fetchGymProfile:', error);
      } finally {
        setPageLoading(false);
      }
    };

    fetchGymProfile();
  }, [user, authLoading]);

  const calculateBMI = (weight: number, height: number): number => {
    const heightInMeters = height / 100;
    return weight / (heightInMeters * heightInMeters);
  };

  const getBMICategory = (bmi: number): string => {
    if (bmi < 18.5) return 'Underweight';
    if (bmi < 25) return 'Normal weight';
    if (bmi < 30) return 'Overweight';
    return 'Obese';
  };

  const handleSavePersonal = async () => {
    if (!user) return;

    setIsLoading(true);
    try {
      const { error } = await supabase
        .from('profiles')
        .update(personalData)
        .eq('id', user.id);

      if (error) throw error;

      await refreshProfile();
      
      toast({
        title: "Personal information updated!",
        description: "Your personal details have been saved.",
      });
      setEditingSection(null);
    } catch (error) {
      console.error('Error updating personal info:', error);
      toast({
        title: "Error",
        description: "Failed to update personal information.",
        variant: "destructive"
      });
    } finally {
      setIsLoading(false);
    }
  };

  const handleSaveFitness = async () => {
    if (!user) return;

    setIsLoading(true);
    try {
      const weight = parseFloat(fitnessData.weight);
      const height = parseFloat(fitnessData.height);
      const bmi = weight && height ? calculateBMI(weight, height) : null;

      const { error } = await supabase
        .from('gym_user_profiles')
        .update({
          weight: weight || null,
          height: height || null,
          bmi: bmi,
          fitness_level: fitnessData.fitness_level || null,
          medical_conditions: fitnessData.medical_conditions.length > 0 ? fitnessData.medical_conditions : null,
        })
        .eq('id', user.id);

      if (error) throw error;

      toast({
        title: "Fitness information updated!",
        description: "Your fitness details have been saved.",
      });
      setEditingSection(null);
      
      // Refresh gym profile
      const { data } = await supabase
        .from('gym_user_profiles')
        .select('*')
        .eq('id', user.id)
        .single();
      if (data) setGymProfile(data);
    } catch (error) {
      console.error('Error updating fitness info:', error);
      toast({
        title: "Error",
        description: "Failed to update fitness information.",
        variant: "destructive"
      });
    } finally {
      setIsLoading(false);
    }
  };

  const handleSaveGoals = async () => {
    if (!user) return;

    setIsLoading(true);
    try {
      const { error } = await supabase
        .from('gym_user_profiles')
        .update({
          fitness_goals: goalsData.fitness_goals.length > 0 ? goalsData.fitness_goals : null,
          preferred_training_types: goalsData.preferred_training_types.length > 0 ? goalsData.preferred_training_types : null,
        })
        .eq('id', user.id);

      if (error) throw error;

      toast({
        title: "Goals updated!",
        description: "Your fitness goals and preferences have been saved.",
      });
      setEditingSection(null);
      
      // Refresh gym profile
      const { data } = await supabase
        .from('gym_user_profiles')
        .select('*')
        .eq('id', user.id)
        .single();
      if (data) setGymProfile(data);
    } catch (error) {
      console.error('Error updating goals:', error);
      toast({
        title: "Error",
        description: "Failed to update goals.",
        variant: "destructive"
      });
    } finally {
      setIsLoading(false);
    }
  };

  const handleGoalToggle = (goal: FitnessGoal) => {
    setGoalsData(prev => ({
      ...prev,
      fitness_goals: prev.fitness_goals.includes(goal)
        ? prev.fitness_goals.filter(g => g !== goal)
        : [...prev.fitness_goals, goal]
    }));
  };

  const handleTrainingTypeToggle = (type: TrainingType) => {
    setGoalsData(prev => ({
      ...prev,
      preferred_training_types: prev.preferred_training_types.includes(type)
        ? prev.preferred_training_types.filter(t => t !== type)
        : [...prev.preferred_training_types, type]
    }));
  };

  if (authLoading || pageLoading) {
    return (
      <div className="container mx-auto px-4 py-8">
        <div className="text-center">
          <div className="animate-spin rounded-full h-8 w-8 border-b-2 border-blue-600 mx-auto"></div>
          <p className="mt-2 text-gray-600">Loading profile...</p>
        </div>
      </div>
    );
  }

  if (!profile) {
    return (
      <div className="container mx-auto px-4 py-8">
        <div className="text-center">
          <p className="text-gray-600">Profile not found. Please try refreshing the page.</p>
        </div>
      </div>
    );
  }

  const completionStatus = getProfileCompletionStatus();

  return (
    <div className="container mx-auto px-4 py-8 max-w-4xl">
      <div className="mb-8">
        <h1 className="text-3xl font-bold text-gray-900">My Profile</h1>
        <p className="text-gray-600 mt-2">Manage your personal information and fitness preferences</p>
      </div>

      {/* Profile Completion Status */}
      {profile.user_role === 'gym_user' && (
        <div className="mb-6">
          {!completionStatus.isComplete ? (
            <Alert className="border-orange-200 bg-orange-50">
              <AlertCircle className="h-4 w-4 text-orange-600" />
              <AlertDescription className="text-orange-800">
                <div className="flex justify-between items-center">
                  <div>
                    <span className="font-medium">Profile {completionStatus.completionPercentage}% Complete</span>
                    <p className="text-sm mt-1">
                      Missing: {completionStatus.missingFields.join(', ')}
                    </p>
                  </div>
                  <div className="text-right">
                    <div className="text-2xl font-bold">{completionStatus.completionPercentage}%</div>
                  </div>
                </div>
              </AlertDescription>
            </Alert>
          ) : (
            <Alert className="border-green-200 bg-green-50">
              <CheckCircle className="h-4 w-4 text-green-600" />
              <AlertDescription className="text-green-800">
                <span className="font-medium">Profile Complete!</span> You're all set to get personalized recommendations.
              </AlertDescription>
            </Alert>
          )}
        </div>
      )}

      <div className="space-y-6">
        {/* Personal Information */}
        <Card>
          <CardHeader>
            <div className="flex items-center justify-between">
              <div className="flex items-center space-x-2">
                <User className="h-5 w-5 text-blue-600" />
                <CardTitle>Personal Information</CardTitle>
              </div>
              {editingSection !== 'personal' && (
                <Button
                  variant="outline"
                  size="sm"
                  onClick={() => setEditingSection('personal')}
                >
                  <Edit2 className="h-4 w-4 mr-2" />
                  Edit
                </Button>
              )}
            </div>
          </CardHeader>
          <CardContent>
            {editingSection === 'personal' ? (
              <div className="space-y-4">
                <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                  <div>
                    <Label htmlFor="full_name">Full Name</Label>
                    <Input
                      id="full_name"
                      value={personalData.full_name}
                      onChange={(e) => setPersonalData(prev => ({ ...prev, full_name: e.target.value }))}
                    />
                  </div>
                  <div>
                    <Label htmlFor="phone">Phone Number</Label>
                    <Input
                      id="phone"
                      value={personalData.phone}
                      onChange={(e) => setPersonalData(prev => ({ ...prev, phone: e.target.value }))}
                    />
                  </div>
                  <div className="md:col-span-2">
                    <Label htmlFor="address">Address</Label>
                    <Input
                      id="address"
                      value={personalData.address}
                      onChange={(e) => setPersonalData(prev => ({ ...prev, address: e.target.value }))}
                    />
                  </div>
                  <div>
                    <Label htmlFor="city">City</Label>
                    <Input
                      id="city"
                      value={personalData.city}
                      onChange={(e) => setPersonalData(prev => ({ ...prev, city: e.target.value }))}
                    />
                  </div>
                  <div>
                    <Label htmlFor="state">State</Label>
                    <Input
                      id="state"
                      value={personalData.state}
                      onChange={(e) => setPersonalData(prev => ({ ...prev, state: e.target.value }))}
                    />
                  </div>
                  <div>
                    <Label htmlFor="postal_code">Postal Code</Label>
                    <Input
                      id="postal_code"
                      value={personalData.postal_code}
                      onChange={(e) => setPersonalData(prev => ({ ...prev, postal_code: e.target.value }))}
                    />
                  </div>
                </div>
                <div className="flex space-x-2">
                  <Button onClick={handleSavePersonal} disabled={isLoading}>
                    <Save className="h-4 w-4 mr-2" />
                    Save
                  </Button>
                  <Button variant="outline" onClick={() => setEditingSection(null)}>
                    <X className="h-4 w-4 mr-2" />
                    Cancel
                  </Button>
                </div>
              </div>
            ) : (
              <div className="space-y-3">
                <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                  <div>
                    <p className="text-sm text-gray-600">Full Name</p>
                    <p className="font-medium">{profile.full_name || 'Not provided'}</p>
                  </div>
                  <div>
                    <p className="text-sm text-gray-600">Email</p>
                    <p className="font-medium">{profile.email}</p>
                  </div>
                  <div>
                    <p className="text-sm text-gray-600">Phone</p>
                    <p className="font-medium">{profile.phone || 'Not provided'}</p>
                  </div>
                  <div>
                    <p className="text-sm text-gray-600">Role</p>
                    <Badge variant="secondary">{profile.user_role.replace('_', ' ').toUpperCase()}</Badge>
                  </div>
                </div>
                {(profile.address || profile.city || profile.state) && (
                  <>
                    <Separator />
                    <div className="flex items-center space-x-2">
                      <MapPin className="h-4 w-4 text-gray-500" />
                      <p className="font-medium">Address</p>
                    </div>
                    <p className="text-gray-700">
                      {[profile.address, profile.city, profile.state, profile.postal_code]
                        .filter(Boolean)
                        .join(', ') || 'Not provided'}
                    </p>
                  </>
                )}
              </div>
            )}
          </CardContent>
        </Card>

        {/* Only show fitness sections for gym users */}
        {profile.user_role === 'gym_user' && (
          <>
            {/* Fitness Information */}
            <Card>
              <CardHeader>
                <div className="flex items-center justify-between">
                  <div className="flex items-center space-x-2">
                    <Activity className="h-5 w-5 text-green-600" />
                    <CardTitle>Fitness Information</CardTitle>
                  </div>
                  {editingSection !== 'fitness' && (
                    <Button
                      variant="outline"
                      size="sm"
                      onClick={() => setEditingSection('fitness')}
                    >
                      <Edit2 className="h-4 w-4 mr-2" />
                      Edit
                    </Button>
                  )}
                </div>
              </CardHeader>
              <CardContent>
                {editingSection === 'fitness' ? (
                  <div className="space-y-4">
                    <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                      <div>
                        <Label htmlFor="weight">Weight (kg)</Label>
                        <Input
                          id="weight"
                          type="number"
                          value={fitnessData.weight}
                          onChange={(e) => setFitnessData(prev => ({ ...prev, weight: e.target.value }))}
                        />
                      </div>
                      <div>
                        <Label htmlFor="height">Height (cm)</Label>
                        <Input
                          id="height"
                          type="number"
                          value={fitnessData.height}
                          onChange={(e) => setFitnessData(prev => ({ ...prev, height: e.target.value }))}
                        />
                      </div>
                    </div>
                    
                    <div>
                      <Label>Fitness Level</Label>
                      <RadioGroup
                        value={fitnessData.fitness_level}
                        onValueChange={(value) => setFitnessData(prev => ({ ...prev, fitness_level: value }))}
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
                      <Label>Medical Conditions</Label>
                      <Textarea
                        value={fitnessData.medical_conditions.join(', ')}
                        onChange={(e) => setFitnessData(prev => ({ 
                          ...prev, 
                          medical_conditions: e.target.value.split(',').map(s => s.trim()).filter(s => s) 
                        }))}
                        placeholder="List any medical conditions (comma separated)"
                        className="mt-2"
                      />
                    </div>

                    <div className="flex space-x-2">
                      <Button onClick={handleSaveFitness} disabled={isLoading}>
                        <Save className="h-4 w-4 mr-2" />
                        Save
                      </Button>
                      <Button variant="outline" onClick={() => setEditingSection(null)}>
                        <X className="h-4 w-4 mr-2" />
                        Cancel
                      </Button>
                    </div>
                  </div>
                ) : (
                  <div className="space-y-3">
                    <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
                      <div>
                        <p className="text-sm text-gray-600">Weight</p>
                        <p className="font-medium">{gymProfile?.weight ? `${gymProfile.weight} kg` : 'Not provided'}</p>
                      </div>
                      <div>
                        <p className="text-sm text-gray-600">Height</p>
                        <p className="font-medium">{gymProfile?.height ? `${gymProfile.height} cm` : 'Not provided'}</p>
                      </div>
                      <div>
                        <p className="text-sm text-gray-600">BMI</p>
                        {gymProfile?.bmi ? (
                          <div>
                            <p className="font-medium">{gymProfile.bmi.toFixed(1)}</p>
                            <Badge variant="outline" className="text-xs">
                              {getBMICategory(gymProfile.bmi)}
                            </Badge>
                          </div>
                        ) : (
                          <p className="font-medium">Not calculated</p>
                        )}
                      </div>
                    </div>
                    
                    <div>
                      <p className="text-sm text-gray-600">Fitness Level</p>
                      <p className="font-medium capitalize">{gymProfile?.fitness_level || 'Not provided'}</p>
                    </div>

                    {gymProfile?.medical_conditions && gymProfile.medical_conditions.length > 0 && (
                      <div>
                        <p className="text-sm text-gray-600">Medical Conditions</p>
                        <div className="flex flex-wrap gap-2 mt-1">
                          {gymProfile.medical_conditions.map((condition, index) => (
                            <Badge key={index} variant="outline">{condition}</Badge>
                          ))}
                        </div>
                      </div>
                    )}
                  </div>
                )}
              </CardContent>
            </Card>

            {/* Goals & Preferences */}
            <Card>
              <CardHeader>
                <div className="flex items-center justify-between">
                  <div className="flex items-center space-x-2">
                    <Target className="h-5 w-5 text-purple-600" />
                    <CardTitle>Goals & Preferences</CardTitle>
                  </div>
                  {editingSection !== 'goals' && (
                    <Button
                      variant="outline"
                      size="sm"
                      onClick={() => setEditingSection('goals')}
                    >
                      <Edit2 className="h-4 w-4 mr-2" />
                      Edit
                    </Button>
                  )}
                </div>
              </CardHeader>
              <CardContent>
                {editingSection === 'goals' ? (
                  <div className="space-y-4">
                    <div>
                      <Label className="text-base font-medium">Fitness Goals</Label>
                      <div className="grid grid-cols-2 md:grid-cols-3 gap-3 mt-3">
                        {fitnessGoalOptions.map((goal) => (
                          <div key={goal.value} className="flex items-center space-x-2">
                            <Checkbox
                              id={goal.value}
                              checked={goalsData.fitness_goals.includes(goal.value)}
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
                              checked={goalsData.preferred_training_types.includes(type.value)}
                              onCheckedChange={() => handleTrainingTypeToggle(type.value)}
                            />
                            <Label htmlFor={type.value} className="text-sm">{type.label}</Label>
                          </div>
                        ))}
                      </div>
                    </div>

                    <div className="flex space-x-2">
                      <Button onClick={handleSaveGoals} disabled={isLoading}>
                        <Save className="h-4 w-4 mr-2" />
                        Save
                      </Button>
                      <Button variant="outline" onClick={() => setEditingSection(null)}>
                        <X className="h-4 w-4 mr-2" />
                        Cancel
                      </Button>
                    </div>
                  </div>
                ) : (
                  <div className="space-y-4">
                    <div>
                      <p className="text-sm text-gray-600 mb-2">Fitness Goals</p>
                      {gymProfile?.fitness_goals && gymProfile.fitness_goals.length > 0 ? (
                        <div className="flex flex-wrap gap-2">
                          {gymProfile.fitness_goals.map((goal) => (
                            <Badge key={goal} variant="default">
                              {fitnessGoalOptions.find(g => g.value === goal)?.label || goal}
                            </Badge>
                          ))}
                        </div>
                      ) : (
                        <p className="text-gray-500">No goals set</p>
                      )}
                    </div>

                    <div>
                      <p className="text-sm text-gray-600 mb-2">Preferred Training Types</p>
                      {gymProfile?.preferred_training_types && gymProfile.preferred_training_types.length > 0 ? (
                        <div className="flex flex-wrap gap-2">
                          {gymProfile.preferred_training_types.map((type) => (
                            <Badge key={type} variant="secondary">
                              {trainingTypeOptions.find(t => t.value === type)?.label || type}
                            </Badge>
                          ))}
                        </div>
                      ) : (
                        <p className="text-gray-500">No preferences set</p>
                      )}
                    </div>
                  </div>
                )}
              </CardContent>
            </Card>
          </>
        )}
      </div>
    </div>
  );
}
