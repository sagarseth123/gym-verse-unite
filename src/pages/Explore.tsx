
import { useState, useEffect } from 'react';
import { supabase } from '@/integrations/supabase/client';
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from '@/components/ui/card';
import { Tabs, TabsContent, TabsList, TabsTrigger } from '@/components/ui/tabs';
import { Input } from '@/components/ui/input';
import { Badge } from '@/components/ui/badge';
import { Exercise, Product } from '@/types/database';
import { Search, Dumbbell, Apple, Store } from 'lucide-react';
import { useToast } from '@/hooks/use-toast';

export default function Explore() {
  const [exercises, setExercises] = useState<Exercise[]>([]);
  const [nutrition, setNutrition] = useState<any[]>([]);
  const [gyms, setGyms] = useState<any[]>([]);
  const [searchTerm, setSearchTerm] = useState('');
  const [loading, setLoading] = useState(true);
  const { toast } = useToast();

  useEffect(() => {
    loadData();
  }, []);

  const loadData = async () => {
    try {
      const [exercisesResult, nutritionResult, gymsResult] = await Promise.all([
        supabase.from('exercises').select('*').limit(20),
        supabase.from('nutrition').select('*').limit(20),
        supabase.from('gyms').select('*').limit(20)
      ]);

      if (exercisesResult.error) throw exercisesResult.error;
      if (nutritionResult.error) throw nutritionResult.error;
      if (gymsResult.error) throw gymsResult.error;

      setExercises(exercisesResult.data || []);
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

  const filteredExercises = exercises.filter(exercise =>
    exercise.name.toLowerCase().includes(searchTerm.toLowerCase()) ||
    exercise.category.toLowerCase().includes(searchTerm.toLowerCase())
  );

  const filteredNutrition = nutrition.filter(food =>
    food.name.toLowerCase().includes(searchTerm.toLowerCase()) ||
    food.category.toLowerCase().includes(searchTerm.toLowerCase())
  );

  const filteredGyms = gyms.filter(gym =>
    gym.name.toLowerCase().includes(searchTerm.toLowerCase()) ||
    gym.city.toLowerCase().includes(searchTerm.toLowerCase())
  );

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
        <h1 className="text-3xl font-bold text-gray-900 mb-4">Explore Fitness</h1>
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
            Exercises
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
          <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
            {filteredExercises.map((exercise) => (
              <Card key={exercise.id} className="cursor-pointer hover:shadow-lg transition-shadow">
                <CardHeader>
                  <CardTitle className="text-lg">{exercise.name}</CardTitle>
                  <CardDescription className="flex items-center gap-2">
                    <Badge variant="secondary">{exercise.category}</Badge>
                    {exercise.difficulty_level && (
                      <Badge variant="outline">{exercise.difficulty_level}</Badge>
                    )}
                  </CardDescription>
                </CardHeader>
                <CardContent>
                  {exercise.muscle_groups && (
                    <div className="mb-3">
                      <p className="text-sm font-medium mb-2">Target Muscles:</p>
                      <div className="flex flex-wrap gap-1">
                        {exercise.muscle_groups.map((muscle, index) => (
                          <Badge key={index} variant="outline" className="text-xs">
                            {muscle}
                          </Badge>
                        ))}
                      </div>
                    </div>
                  )}
                  {exercise.instructions && (
                    <p className="text-sm text-gray-600 line-clamp-3">
                      {exercise.instructions}
                    </p>
                  )}
                </CardContent>
              </Card>
            ))}
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
    </div>
  );
}
