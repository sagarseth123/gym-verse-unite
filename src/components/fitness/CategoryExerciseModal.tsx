
import { useState } from 'react';
import { Dialog, DialogContent, DialogHeader, DialogTitle } from '@/components/ui/dialog';
import { Button } from '@/components/ui/button';
import { Badge } from '@/components/ui/badge';
import { Tabs, TabsContent, TabsList, TabsTrigger } from '@/components/ui/tabs';
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from '@/components/ui/card';
import { EnhancedExercise } from '@/types/fitness';
import { AIGeneratedExercise } from '@/services/aiExerciseService';
import { EnhancedExerciseCard } from '@/components/fitness/EnhancedExerciseCard';
import { AIExerciseCard } from '@/components/fitness/AIExerciseCard';
import { AIExerciseDetailModal } from '@/components/fitness/AIExerciseDetailModal';
import { 
  Sparkles, 
  User, 
  CheckSquare, 
  Calendar,
  Target,
  Loader2
} from 'lucide-react';

interface CategoryExerciseModalProps {
  isOpen: boolean;
  onClose: () => void;
  categoryName: string;
  categoryDescription: string;
  dbExercises: EnhancedExercise[];
  aiExercises: AIGeneratedExercise[];
  aiLoading: boolean;
  onRefreshAI: () => void;
}

export function CategoryExerciseModal({
  isOpen,
  onClose,
  categoryName,
  categoryDescription,
  dbExercises,
  aiExercises,
  aiLoading,
  onRefreshAI
}: CategoryExerciseModalProps) {
  const [selectedAIExercise, setSelectedAIExercise] = useState<AIGeneratedExercise | null>(null);
  const [selectedExercises, setSelectedExercises] = useState<string[]>([]);

  const handleExerciseSelect = (exerciseId: string) => {
    setSelectedExercises(prev => 
      prev.includes(exerciseId) 
        ? prev.filter(id => id !== exerciseId)
        : [...prev, exerciseId]
    );
  };

  const handleCreateAIPlan = () => {
    // TODO: Implement AI plan creation
    console.log('Creating AI-powered weekly plan for', categoryName);
  };

  const handleCreateManualPlan = () => {
    // TODO: Implement manual plan creation with selected exercises
    console.log('Creating manual plan with exercises:', selectedExercises);
  };

  return (
    <>
      <Dialog open={isOpen} onOpenChange={onClose}>
        <DialogContent className="max-w-6xl max-h-[90vh] overflow-y-auto">
          <DialogHeader>
            <DialogTitle className="flex items-center gap-3 text-xl">
              <Target className="h-6 w-6 text-blue-600" />
              {categoryName} Exercises
            </DialogTitle>
            <p className="text-gray-600">{categoryDescription}</p>
          </DialogHeader>

          <div className="mt-6">
            {/* Action Buttons */}
            <div className="grid grid-cols-1 md:grid-cols-2 gap-4 mb-6">
              <Card className="cursor-pointer hover:shadow-lg transition-shadow" onClick={handleCreateAIPlan}>
                <CardHeader className="pb-3">
                  <CardTitle className="flex items-center gap-2 text-lg">
                    <Sparkles className="h-5 w-5 text-purple-600" />
                    AI-Powered Weekly Plan
                  </CardTitle>
                  <CardDescription>
                    Let AI create a personalized weekly workout plan for {categoryName.toLowerCase()}
                  </CardDescription>
                </CardHeader>
                <CardContent>
                  <Button className="w-full">
                    <Calendar className="h-4 w-4 mr-2" />
                    Generate AI Plan
                  </Button>
                </CardContent>
              </Card>

              <Card className="cursor-pointer hover:shadow-lg transition-shadow">
                <CardHeader className="pb-3">
                  <CardTitle className="flex items-center gap-2 text-lg">
                    <User className="h-5 w-5 text-green-600" />
                    Manual Plan Selection
                  </CardTitle>
                  <CardDescription>
                    Choose specific exercises to create your custom workout plan
                  </CardDescription>
                </CardHeader>
                <CardContent>
                  <Button 
                    variant="outline" 
                    className="w-full"
                    onClick={handleCreateManualPlan}
                    disabled={selectedExercises.length === 0}
                  >
                    <CheckSquare className="h-4 w-4 mr-2" />
                    Create Plan ({selectedExercises.length} selected)
                  </Button>
                </CardContent>
              </Card>
            </div>

            {/* Exercise Tabs */}
            <Tabs defaultValue="ai-exercises" className="w-full">
              <TabsList className="grid w-full grid-cols-2">
                <TabsTrigger value="ai-exercises" className="flex items-center gap-2">
                  <Sparkles className="h-4 w-4" />
                  AI-Generated Exercises
                  {aiExercises.length > 0 && (
                    <Badge variant="secondary">{aiExercises.length}</Badge>
                  )}
                </TabsTrigger>
                <TabsTrigger value="db-exercises" className="flex items-center gap-2">
                  <Target className="h-4 w-4" />
                  Database Exercises
                  {dbExercises.length > 0 && (
                    <Badge variant="secondary">{dbExercises.length}</Badge>
                  )}
                </TabsTrigger>
              </TabsList>

              <TabsContent value="ai-exercises" className="mt-6">
                {aiLoading ? (
                  <div className="text-center py-12">
                    <Loader2 className="h-8 w-8 animate-spin text-purple-600 mx-auto mb-4" />
                    <p className="text-gray-600">AI is generating personalized exercises...</p>
                  </div>
                ) : aiExercises.length > 0 ? (
                  <>
                    <div className="flex justify-between items-center mb-4">
                      <h3 className="text-lg font-semibold">AI-Generated Exercises</h3>
                      <Button variant="outline" size="sm" onClick={onRefreshAI}>
                        <Sparkles className="h-4 w-4 mr-2" />
                        Generate New
                      </Button>
                    </div>
                    <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
                      {aiExercises.map((exercise) => (
                        <div key={exercise.id} className="relative">
                          <AIExerciseCard
                            exercise={exercise}
                            onViewDetails={setSelectedAIExercise}
                          />
                          <div className="absolute top-2 right-2">
                            <input
                              type="checkbox"
                              checked={selectedExercises.includes(exercise.id)}
                              onChange={() => handleExerciseSelect(exercise.id)}
                              className="w-4 h-4 text-blue-600 bg-gray-100 border-gray-300 rounded focus:ring-blue-500"
                            />
                          </div>
                        </div>
                      ))}
                    </div>
                  </>
                ) : (
                  <div className="text-center py-12">
                    <Sparkles className="h-12 w-12 text-gray-400 mx-auto mb-4" />
                    <h3 className="text-lg font-medium text-gray-900 mb-2">No AI exercises generated yet</h3>
                    <p className="text-gray-500 mb-4">Click the button below to generate personalized exercises</p>
                    <Button onClick={onRefreshAI}>
                      <Sparkles className="h-4 w-4 mr-2" />
                      Generate AI Exercises
                    </Button>
                  </div>
                )}
              </TabsContent>

              <TabsContent value="db-exercises" className="mt-6">
                {dbExercises.length > 0 ? (
                  <>
                    <h3 className="text-lg font-semibold mb-4">Database Exercises</h3>
                    <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
                      {dbExercises.map((exercise) => (
                        <div key={exercise.id} className="relative">
                          <EnhancedExerciseCard
                            exercise={exercise}
                            showGoalContext={false}
                          />
                          <div className="absolute top-2 right-2">
                            <input
                              type="checkbox"
                              checked={selectedExercises.includes(exercise.id)}
                              onChange={() => handleExerciseSelect(exercise.id)}
                              className="w-4 h-4 text-blue-600 bg-gray-100 border-gray-300 rounded focus:ring-blue-500"
                            />
                          </div>
                        </div>
                      ))}
                    </div>
                  </>
                ) : (
                  <div className="text-center py-12">
                    <Target className="h-12 w-12 text-gray-400 mx-auto mb-4" />
                    <h3 className="text-lg font-medium text-gray-900 mb-2">No database exercises found</h3>
                    <p className="text-gray-500">No exercises found in the database for this category</p>
                  </div>
                )}
              </TabsContent>
            </Tabs>
          </div>
        </DialogContent>
      </Dialog>

      <AIExerciseDetailModal
        exercise={selectedAIExercise}
        isOpen={!!selectedAIExercise}
        onClose={() => setSelectedAIExercise(null)}
      />
    </>
  );
}
