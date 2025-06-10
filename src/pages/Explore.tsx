import { useState, useEffect } from 'react';
import { supabase } from '@/integrations/supabase/client';
import { Tabs, TabsContent, TabsList, TabsTrigger } from '@/components/ui/tabs';
import { Input } from '@/components/ui/input';
import { Badge } from '@/components/ui/badge';
import { Button } from '@/components/ui/button';
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from '@/components/ui/card';
import { EnhancedExercise } from '@/types/fitness';
import { Search, Dumbbell, Apple, Store, Filter, Sparkles, Zap, History, Heart } from 'lucide-react';
import { useToast } from '@/hooks/use-toast';
import { FITNESS_GOAL_CATEGORIES, FitnessGoalCategory } from '@/types/fitness';
import { GoalCategoryCard } from '@/components/fitness/GoalCategoryCard';
import { EnhancedExerciseCard } from '@/components/fitness/EnhancedExerciseCard';
import { AIExerciseCard } from '@/components/fitness/AIExerciseCard';
import { AIExerciseDetailModal } from '@/components/fitness/AIExerciseDetailModal';
import { AIExerciseService, AIGeneratedExercise } from '@/services/aiExerciseService';
import { useExerciseHistory } from '@/hooks/useExerciseHistory';
import { useExercisePreferences } from '@/hooks/useExercisePreferences';

export default function Explore() {
  const [exercises, setExercises] = useState<EnhancedExercise[]>([]);
  const [aiExercises, setAiExercises] = useState<AIGeneratedExercise[]>([]);
  const [nutrition, setNutrition] = useState<any[]>([]);
  const [gyms, setGyms] = useState<any[]>([]);
  const [searchTerm, setSearchTerm] = useState('');
  const [selectedGoalCategory, setSelectedGoalCategory] = useState<string | null>(null);
  const [selectedDifficulty, setSelectedDifficulty] = useState<string | null>(null);
  const [loading, setLoading] = useState(true);
  const [aiLoading, setAiLoading] = useState(false);
  const [selectedAIExercise, setSelectedAIExercise] = useState<AIGeneratedExercise | null>(null);
  const [showPersonalized, setShowPersonalized] = useState(false);
  const [personalizedExercises, setPersonalizedExercises] = useState<AIGeneratedExercise[]>([]);
  const { toast } = useToast();
  const { history } = useExerciseHistory();
  const { preferences } = useExercisePreferences();

  useEffect(() => {
    loadData();
    loadPersonalizedRecommendations();
  }, []);

  useEffect(() => {
    if (selectedGoalCategory) {
      loadAIExercisesForCategory(selectedGoalCategory);
    }
  }, [selectedGoalCategory]);

  const loadData = async () => {
    try {
      const [exercisesResult, nutritionResult, gymsResult] = await Promise.all([
        supabase.from('exercises').select('*').limit(50),
        supabase.from('nutrition').select('*').limit(20),
        supabase.from('gyms').select('*').limit(20)
      ]);

      if (exercisesResult.error) throw exercisesResult.error;
      if (nutritionResult.error) throw nutritionResult.error;
      if (gymsResult.error) throw gymsResult.error;

      // Enhance exercises with goal categories and difficulty
      const enhancedExercises = (exercisesResult.data || []).map(exercise => ({
        ...exercise,
        goalCategories: mapExerciseToGoals(exercise),
        difficulty: determineDifficulty(exercise),
        primaryMuscles: exercise.muscle_groups?.slice(0, 2) || [],
        secondaryMuscles: exercise.muscle_groups?.slice(2) || []
      }));

      setExercises(enhancedExercises);
      setNutrition(nutritionResult.data || []);
      setGyms(gymsResult.data || []);
    } catch (error: any) {
      toast({
        title: "Error",
        description: "Failed to load data",
        variant: "destructive",
      });
    } finally {
      setLoading(false);
    }
  };

  const loadAIExercisesForCategory = async (categoryId: string) => {
    setAiLoading(true);
    try {
      // First try to get cached exercises
      const cachedExercises = await AIExerciseService.getCachedExercises(categoryId);
      
      if (cachedExercises.length > 0) {
        setAiExercises(cachedExercises);
      } else {
        // Generate new exercises if none cached
        const generatedExercises = await AIExerciseService.generateExercisesForGoalCategory(categoryId);
        setAiExercises(generatedExercises);
        toast({
          title: "AI Exercises Generated!",
          description: `Generated ${generatedExercises.length} personalized exercises for ${categoryId}`,
        });
      }
    } catch (error: any) {
      console.error('Error loading AI exercises:', error);
      toast({
        title: "Error",
        description: "Failed to load AI exercises. Please try again.",
        variant: "destructive",
      });
      setAiExercises([]);
    } finally {
      setAiLoading(false);
    }
  };

  const loadPersonalizedRecommendations = async () => {
    try {
      const recommendations = await AIExerciseService.getPersonalizedRecommendations(
        preferences,
        history
      );
      setPersonalizedExercises(recommendations.suggestedExercises);
    } catch (error) {
      console.error('Error loading personalized recommendations:', error);
    }
  };

  const handleRefreshAIExercises = async () => {
    if (selectedGoalCategory) {
      setAiLoading(true);
      try {
        const generatedExercises = await AIExerciseService.generateExercisesForGoalCategory(
          selectedGoalCategory, 
          true // Force refresh
        );
        setAiExercises(generatedExercises);
        toast({
          title: "Fresh AI Exercises!",
          description: `Generated ${generatedExercises.length} new exercises`,
        });
      } catch (error: any) {
        toast({
          title: "Error",
          description: "Failed to generate new exercises",
          variant: "destructive",
        });
      } finally {
        setAiLoading(false);
      }
    }
  };

  const mapExerciseToGoals = (exercise: any): string[] => {
    const categories = [];
    
    // Map based on category and muscle groups
    if (exercise.category?.toLowerCase().includes('strength') || 
        exercise.muscle_groups?.some((m: string) => ['chest', 'back', 'shoulders', 'arms', 'biceps', 'triceps'].includes(m.toLowerCase()))) {
      categories.push('strength-building');
    }
    
    if (exercise.category?.toLowerCase().includes('cardio') || 
        exercise.name?.toLowerCase().includes('cardio') ||
        exercise.name?.toLowerCase().includes('running')) {
      categories.push('weight-loss');
    }
    
    if (exercise.equipment_needed?.includes('bodyweight') || 
        exercise.equipment_needed?.length === 0 ||
        exercise.name?.toLowerCase().includes('push') ||
        exercise.name?.toLowerCase().includes('pull')) {
      categories.push('calisthenics');
    }
    
    if (exercise.difficulty_level === 'advanced' || 
        exercise.muscle_groups?.includes('legs') ||
        exercise.name?.toLowerCase().includes('squat') ||
        exercise.name?.toLowerCase().includes('deadlift')) {
      categories.push('bulking');
    }
    
    if (exercise.category?.toLowerCase().includes('functional') ||
        exercise.name?.toLowerCase().includes('kettle') ||
        exercise.name?.toLowerCase().includes('burpee')) {
      categories.push('functional');
    }
    
    if (exercise.category?.toLowerCase().includes('yoga') ||
        exercise.category?.toLowerCase().includes('stretch') ||
        exercise.name?.toLowerCase().includes('stretch')) {
      categories.push('flexibility');
    }
    
    return categories.length > 0 ? categories : ['strength-building']; // Default fallback
  };

  const determineDifficulty = (exercise: any): 'beginner' | 'intermediate' | 'advanced' => {
    if (exercise.difficulty_level) {
      return exercise.difficulty_level as 'beginner' | 'intermediate' | 'advanced';
    }
    
    // Determine based on exercise characteristics
    if (exercise.equipment_needed?.includes('bodyweight') || exercise.equipment_needed?.length === 0) {
      return 'beginner';
    }
    if (exercise.equipment_needed?.includes('barbell') || exercise.name?.toLowerCase().includes('deadlift')) {
      return 'advanced';
    }
    return 'intermediate';
  };

  const getExercisesByGoalCategory = (categoryId: string) => {
    return exercises.filter(exercise => 
      exercise.goalCategories.includes(categoryId)
    );
  };

  const getFilteredExercises = () => {
    let filtered = exercises;
    
    if (selectedGoalCategory) {
      filtered = getExercisesByGoalCategory(selectedGoalCategory);
    }
    
    if (selectedDifficulty) {
      filtered = filtered.filter(exercise => exercise.difficulty === selectedDifficulty);
    }
    
    if (searchTerm) {
      filtered = filtered.filter(exercise =>
        exercise.name.toLowerCase().includes(searchTerm.toLowerCase()) ||
        exercise.category.toLowerCase().includes(searchTerm.toLowerCase()) ||
        exercise.muscle_groups?.some(mg => mg.toLowerCase().includes(searchTerm.toLowerCase()))
      );
    }
    
    return filtered;
  };

  const filteredNutrition = nutrition.filter(food =>
    food.name.toLowerCase().includes(searchTerm.toLowerCase()) ||
    food.category.toLowerCase().includes(searchTerm.toLowerCase())
  );

  const filteredGyms = gyms.filter(gym =>
    gym.name.toLowerCase().includes(searchTerm.toLowerCase()) ||
    gym.city.toLowerCase().includes(searchTerm.toLowerCase())
  );

  const getFilteredAIExercises = () => {
    let filtered = aiExercises;
    
    if (selectedDifficulty) {
      filtered = filtered.filter(exercise => exercise.difficulty === selectedDifficulty);
    }
    
    if (searchTerm) {
      filtered = filtered.filter(exercise =>
        exercise.name.toLowerCase().includes(searchTerm.toLowerCase()) ||
        exercise.muscle_groups?.some(mg => mg.toLowerCase().includes(searchTerm.toLowerCase()))
      );
    }
    
    return filtered;
  };

  if (loading) {
    return (
      <div className="container mx-auto px-4 py-8">
        <div className="text-center">Loading...</div>
      </div>
    );
  }

  return (
    <div className="container mx-auto px-4 py-8">
      <div className="mb-8">
        <h1 className="text-3xl font-bold text-gray-900 mb-2">AI-Powered Fitness Explorer</h1>
        <p className="text-gray-600 mb-4">Discover personalized exercises, nutrition, and gyms with AI guidance</p>
        <div className="relative">
          <Search className="absolute left-3 top-3 h-4 w-4 text-gray-400" />
          <Input
            placeholder="Search exercises, nutrition, or gyms..."
            value={searchTerm}
            onChange={(e) => setSearchTerm(e.target.value)}
            className="pl-10"
          />
        </div>
      </div>

      <Tabs defaultValue="exercises" className="w-full">
        <TabsList className="grid w-full grid-cols-3">
          <TabsTrigger value="exercises" className="flex items-center gap-2">
            <Dumbbell className="h-4 w-4" />
            AI-Powered Exercises
          </TabsTrigger>
          <TabsTrigger value="nutrition" className="flex items-center gap-2">
            <Apple className="h-4 w-4" />
            Nutrition
          </TabsTrigger>
          <TabsTrigger value="gyms" className="flex items-center gap-2">
            <Store className="h-4 w-4" />
            Gyms
          </TabsTrigger>
        </TabsList>
        
        <TabsContent value="exercises" className="mt-6">
          {/* Personalized Recommendations */}
          {personalizedExercises.length > 0 && (
            <div className="mb-8">
              <div className="flex items-center justify-between mb-4">
                <h2 className="text-xl font-semibold flex items-center gap-2">
                  <Heart className="h-5 w-5 text-red-600" />
                  Personalized for You
                </h2>
                <Button
                  variant="outline"
                  onClick={() => setShowPersonalized(!showPersonalized)}
                  size="sm"
                >
                  {showPersonalized ? 'Hide' : 'Show'} Recommendations
                </Button>
              </div>
              
              {showPersonalized && (
                <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-4 mb-6">
                  {personalizedExercises.slice(0, 8).map((exercise) => (
                    <AIExerciseCard
                      key={exercise.id}
                      exercise={exercise}
                      onViewDetails={setSelectedAIExercise}
                      compact={true}
                    />
                  ))}
                </div>
              )}
            </div>
          )}

          {/* Goal Categories */}
          <div className="mb-8">
            <div className="flex items-center justify-between mb-4">
              <h2 className="text-xl font-semibold flex items-center gap-2">
                <Sparkles className="h-5 w-5 text-blue-600" />
                AI Exercise Categories
              </h2>
              {selectedGoalCategory && (
                <div className="flex gap-2">
                  <Button
                    variant="outline"
                    onClick={handleRefreshAIExercises}
                    size="sm"
                    disabled={aiLoading}
                  >
                    <Zap className="h-4 w-4 mr-1" />
                    Generate New
                  </Button>
                  <Button
                    variant="outline"
                    onClick={() => {
                      setSelectedGoalCategory(null);
                      setAiExercises([]);
                    }}
                    size="sm"
                  >
                    Clear Filter
                  </Button>
                </div>
              )}
            </div>
            
            <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4 mb-6">
              {FITNESS_GOAL_CATEGORIES.map((category) => (
                <GoalCategoryCard
                  key={category.id}
                  category={category}
                  exerciseCount={getExercisesByGoalCategory(category.id).length}
                  onClick={() => setSelectedGoalCategory(category.id)}
                  isSelected={selectedGoalCategory === category.id}
                />
              ))}
            </div>
          </div>

          {/* Filters */}
          <div className="flex flex-wrap gap-2 mb-6">
            <Filter className="h-4 w-4 text-gray-500 mt-2" />
            <span className="text-sm text-gray-500 mt-1 mr-2">Difficulty:</span>
            {['beginner', 'intermediate', 'advanced'].map((difficulty) => (
              <Button
                key={difficulty}
                variant={selectedDifficulty === difficulty ? 'default' : 'outline'}
                size="sm"
                onClick={() => setSelectedDifficulty(selectedDifficulty === difficulty ? null : difficulty)}
              >
                {difficulty.charAt(0).toUpperCase() + difficulty.slice(1)}
              </Button>
            ))}
          </div>

          {/* AI Generated Exercises for Selected Category */}
          {selectedGoalCategory && (
            <div className="mb-8">
              <h3 className="text-lg font-semibold mb-4 flex items-center gap-2">
                <Zap className="h-5 w-5 text-purple-600" />
                AI-Generated Exercises
                {aiLoading && <span className="text-sm text-gray-500">(Generating...)</span>}
              </h3>
              
              {aiLoading ? (
                <div className="text-center py-8">
                  <Zap className="h-8 w-8 animate-pulse text-purple-600 mx-auto mb-2" />
                  <p>AI is generating personalized exercises...</p>
                </div>
              ) : (
                <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
                  {getFilteredAIExercises().map((exercise) => (
                    <AIExerciseCard
                      key={exercise.id}
                      exercise={exercise}
                      onViewDetails={setSelectedAIExercise}
                    />
                  ))}
                </div>
              )}
            </div>
          )}

          {/* Database Exercises */}
          <div className="mb-8">
            <h3 className="text-lg font-semibold mb-4 flex items-center gap-2">
              <History className="h-5 w-5 text-gray-600" />
              Exercise Database
            </h3>
            <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
              {getFilteredExercises().map((exercise) => (
                <EnhancedExerciseCard
                  key={exercise.id}
                  exercise={exercise}
                  showGoalContext={!selectedGoalCategory}
                />
              ))}
            </div>

            {getFilteredExercises().length === 0 && (
              <div className="text-center py-12">
                <Dumbbell className="h-12 w-12 text-gray-400 mx-auto mb-4" />
                <h3 className="text-lg font-medium text-gray-900 mb-2">No exercises found</h3>
                <p className="text-gray-500">Try adjusting your search or filter criteria</p>
              </div>
            )}
          </div>
        </TabsContent>
        
        <TabsContent value="nutrition" className="mt-6">
          <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
            {filteredNutrition.map((food) => (
              <Card key={food.id} className="cursor-pointer hover:shadow-lg transition-shadow">
                <CardHeader>
                  <CardTitle className="text-lg">{food.name}</CardTitle>
                  <CardDescription>
                    <Badge variant="secondary">{food.category}</Badge>
                  </CardDescription>
                </CardHeader>
                <CardContent>
                  <div className="space-y-2">
                    <div className="flex justify-between">
                      <span className="text-sm">Calories (per 100g):</span>
                      <span className="font-medium">{food.calories_per_100g || 'N/A'}</span>
                    </div>
                    <div className="flex justify-between">
                      <span className="text-sm">Protein:</span>
                      <span className="font-medium">{food.protein_per_100g || 'N/A'}g</span>
                    </div>
                    <div className="flex justify-between">
                      <span className="text-sm">Carbs:</span>
                      <span className="font-medium">{food.carbs_per_100g || 'N/A'}g</span>
                    </div>
                    <div className="flex justify-between">
                      <span className="text-sm">Fat:</span>
                      <span className="font-medium">{food.fat_per_100g || 'N/A'}g</span>
                    </div>
                  </div>
                </CardContent>
              </Card>
            ))}
          </div>
        </TabsContent>
        
        <TabsContent value="gyms" className="mt-6">
          <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
            {filteredGyms.map((gym) => (
              <Card key={gym.id} className="cursor-pointer hover:shadow-lg transition-shadow">
                <CardHeader>
                  <CardTitle className="text-lg">{gym.name}</CardTitle>
                  <CardDescription>{gym.city}, {gym.state}</CardDescription>
                </CardHeader>
                <CardContent>
                  <div className="space-y-2">
                    <p className="text-sm"><strong>Address:</strong> {gym.address}</p>
                    {gym.phone && (
                      <p className="text-sm"><strong>Phone:</strong> {gym.phone}</p>
                    )}
                    {gym.area_sqft && (
                      <p className="text-sm"><strong>Area:</strong> {gym.area_sqft} sq ft</p>
                    )}
                    {gym.description && (
                      <p className="text-sm text-gray-600 line-clamp-2">
                        {gym.description}
                      </p>
                    )}
                  </div>
                </CardContent>
              </Card>
            ))}
          </div>
        </TabsContent>
      </Tabs>

      <AIExerciseDetailModal
        exercise={selectedAIExercise}
        isOpen={!!selectedAIExercise}
        onClose={() => setSelectedAIExercise(null)}
      />
    </div>
  );
}
