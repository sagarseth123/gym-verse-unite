
import { useState, useEffect } from 'react';
import { Dialog, DialogContent, DialogHeader, DialogTitle } from '@/components/ui/dialog';
import { Badge } from '@/components/ui/badge';
import { Button } from '@/components/ui/button';
import { Tabs, TabsContent, TabsList, TabsTrigger } from '@/components/ui/tabs';
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from '@/components/ui/card';
import { EnhancedExercise, ExerciseGuidance } from '@/types/fitness';
import { supabase } from '@/integrations/supabase/client';
import { Loader2, Target, Zap, AlertTriangle, TrendingUp, RefreshCw, Heart } from 'lucide-react';
import { useToast } from '@/hooks/use-toast';

interface ExerciseDetailModalProps {
  exercise: EnhancedExercise;
  isOpen: boolean;
  onClose: () => void;
}

export function ExerciseDetailModal({ exercise, isOpen, onClose }: ExerciseDetailModalProps) {
  const [aiGuidance, setAiGuidance] = useState<ExerciseGuidance | null>(null);
  const [loading, setLoading] = useState(false);
  const { toast } = useToast();

  const fetchAIGuidance = async () => {
    if (aiGuidance || loading) return;
    
    setLoading(true);
    try {
      const { data, error } = await supabase.functions.invoke('generate-fitness-plan', {
        body: {
          type: 'exercise_guidance',
          exercise: {
            name: exercise.name,
            category: exercise.category,
            muscle_groups: exercise.muscle_groups,
            difficulty_level: exercise.difficulty,
            equipment_needed: exercise.equipment_needed,
            existing_instructions: exercise.instructions
          }
        }
      });

      if (error) throw error;

      if (data?.guidance) {
        setAiGuidance(data.guidance);
      }
    } catch (error: any) {
      console.error('Error fetching AI guidance:', error);
      toast({
        title: "Error",
        description: "Failed to load AI guidance. Using basic information.",
        variant: "destructive",
      });
      // Fallback to basic guidance
      setAiGuidance({
        instructions: exercise.instructions ? [exercise.instructions] : ['Perform this exercise with proper form'],
        benefits: [`Targets ${exercise.muscle_groups?.join(', ') || 'multiple muscle groups'}`],
        commonMistakes: ['Ensure proper form throughout the movement'],
        progressions: ['Start with lighter weight and gradually increase'],
        modifications: ['Adjust weight or reps based on your fitness level'],
        safetyTips: ['Warm up before performing this exercise']
      });
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    if (isOpen) {
      fetchAIGuidance();
    }
  }, [isOpen]);

  const handleRefreshGuidance = () => {
    setAiGuidance(null);
    fetchAIGuidance();
  };

  return (
    <Dialog open={isOpen} onOpenChange={onClose}>
      <DialogContent className="max-w-4xl max-h-[90vh] overflow-y-auto">
        <DialogHeader>
          <DialogTitle className="flex items-center gap-3 text-xl">
            <Target className="h-6 w-6 text-blue-600" />
            {exercise.name}
            <Badge className={`ml-2 ${
              exercise.difficulty === 'beginner' ? 'bg-green-100 text-green-800' :
              exercise.difficulty === 'intermediate' ? 'bg-yellow-100 text-yellow-800' :
              'bg-red-100 text-red-800'
            }`}>
              {exercise.difficulty}
            </Badge>
          </DialogTitle>
        </DialogHeader>

        <div className="mt-4">
          {/* Exercise Overview */}
          <div className="grid grid-cols-1 md:grid-cols-3 gap-4 mb-6">
            <Card>
              <CardHeader className="pb-2">
                <CardTitle className="text-sm flex items-center gap-2">
                  <Target className="h-4 w-4" />
                  Primary Muscles
                </CardTitle>
              </CardHeader>
              <CardContent>
                <div className="flex flex-wrap gap-1">
                  {(exercise.primaryMuscles || exercise.muscle_groups || []).map((muscle, index) => (
                    <Badge key={index} variant="outline" className="text-xs">
                      {muscle}
                    </Badge>
                  ))}
                </div>
              </CardContent>
            </Card>

            <Card>
              <CardHeader className="pb-2">
                <CardTitle className="text-sm flex items-center gap-2">
                  <Zap className="h-4 w-4" />
                  Equipment
                </CardTitle>
              </CardHeader>
              <CardContent>
                <div className="flex flex-wrap gap-1">
                  {(exercise.equipment_needed || ['Bodyweight']).map((equipment, index) => (
                    <Badge key={index} variant="secondary" className="text-xs">
                      {equipment}
                    </Badge>
                  ))}
                </div>
              </CardContent>
            </Card>

            <Card>
              <CardHeader className="pb-2">
                <CardTitle className="text-sm">Category</CardTitle>
              </CardHeader>
              <CardContent>
                <Badge variant="outline">{exercise.category}</Badge>
              </CardContent>
            </Card>
          </div>

          {/* AI-Powered Guidance Tabs */}
          <Tabs defaultValue="instructions" className="w-full">
            <div className="flex items-center justify-between mb-4">
              <TabsList className="grid w-full grid-cols-6 lg:w-auto">
                <TabsTrigger value="instructions">Instructions</TabsTrigger>
                <TabsTrigger value="benefits">Benefits</TabsTrigger>
                <TabsTrigger value="mistakes">Common Mistakes</TabsTrigger>
                <TabsTrigger value="progressions">Progressions</TabsTrigger>
                <TabsTrigger value="modifications">Modifications</TabsTrigger>
                <TabsTrigger value="safety">Safety</TabsTrigger>
              </TabsList>
              
              <Button
                variant="outline"
                size="sm"
                onClick={handleRefreshGuidance}
                disabled={loading}
                className="flex items-center gap-2"
              >
                <RefreshCw className={`h-4 w-4 ${loading ? 'animate-spin' : ''}`} />
                Refresh AI Guidance
              </Button>
            </div>

            {loading ? (
              <div className="flex items-center justify-center py-8">
                <Loader2 className="h-6 w-6 animate-spin mr-2" />
                <span>Getting AI-powered guidance...</span>
              </div>
            ) : (
              <>
                <TabsContent value="instructions">
                  <Card>
                    <CardHeader>
                      <CardTitle className="flex items-center gap-2">
                        <Target className="h-5 w-5 text-blue-600" />
                        Step-by-Step Instructions
                      </CardTitle>
                      <CardDescription>
                        AI-generated detailed instructions for proper exercise execution
                      </CardDescription>
                    </CardHeader>
                    <CardContent>
                      <ol className="space-y-2">
                        {(aiGuidance?.instructions || [exercise.instructions || 'No instructions available']).map((instruction, index) => (
                          <li key={index} className="flex gap-3">
                            <span className="flex-shrink-0 w-6 h-6 bg-blue-100 text-blue-800 rounded-full flex items-center justify-center text-sm font-medium">
                              {index + 1}
                            </span>
                            <span className="text-sm">{instruction}</span>
                          </li>
                        ))}
                      </ol>
                    </CardContent>
                  </Card>
                </TabsContent>

                <TabsContent value="benefits">
                  <Card>
                    <CardHeader>
                      <CardTitle className="flex items-center gap-2">
                        <Heart className="h-5 w-5 text-red-600" />
                        Exercise Benefits
                      </CardTitle>
                      <CardDescription>
                        How this exercise contributes to your fitness goals
                      </CardDescription>
                    </CardHeader>
                    <CardContent>
                      <ul className="space-y-2">
                        {(aiGuidance?.benefits || [`Targets ${exercise.muscle_groups?.join(', ') || 'multiple muscle groups'}`]).map((benefit, index) => (
                          <li key={index} className="flex gap-3">
                            <Heart className="h-4 w-4 text-red-500 mt-0.5 flex-shrink-0" />
                            <span className="text-sm">{benefit}</span>
                          </li>
                        ))}
                      </ul>
                    </CardContent>
                  </Card>
                </TabsContent>

                <TabsContent value="mistakes">
                  <Card>
                    <CardHeader>
                      <CardTitle className="flex items-center gap-2">
                        <AlertTriangle className="h-5 w-5 text-yellow-600" />
                        Common Mistakes to Avoid
                      </CardTitle>
                      <CardDescription>
                        AI-identified common errors and how to prevent them
                      </CardDescription>
                    </CardHeader>
                    <CardContent>
                      <ul className="space-y-2">
                        {(aiGuidance?.commonMistakes || ['Ensure proper form throughout the movement']).map((mistake, index) => (
                          <li key={index} className="flex gap-3">
                            <AlertTriangle className="h-4 w-4 text-yellow-500 mt-0.5 flex-shrink-0" />
                            <span className="text-sm">{mistake}</span>
                          </li>
                        ))}
                      </ul>
                    </CardContent>
                  </Card>
                </TabsContent>

                <TabsContent value="progressions">
                  <Card>
                    <CardHeader>
                      <CardTitle className="flex items-center gap-2">
                        <TrendingUp className="h-5 w-5 text-green-600" />
                        Exercise Progressions
                      </CardTitle>
                      <CardDescription>
                        How to advance and challenge yourself with this exercise
                      </CardDescription>
                    </CardHeader>
                    <CardContent>
                      <ul className="space-y-2">
                        {(aiGuidance?.progressions || ['Start with lighter weight and gradually increase']).map((progression, index) => (
                          <li key={index} className="flex gap-3">
                            <TrendingUp className="h-4 w-4 text-green-500 mt-0.5 flex-shrink-0" />
                            <span className="text-sm">{progression}</span>
                          </li>
                        ))}
                      </ul>
                    </CardContent>
                  </Card>
                </TabsContent>

                <TabsContent value="modifications">
                  <Card>
                    <CardHeader>
                      <CardTitle className="flex items-center gap-2">
                        <RefreshCw className="h-5 w-5 text-purple-600" />
                        Exercise Modifications
                      </CardTitle>
                      <CardDescription>
                        Adaptations for different fitness levels and limitations
                      </CardDescription>
                    </CardHeader>
                    <CardContent>
                      <ul className="space-y-2">
                        {(aiGuidance?.modifications || ['Adjust weight or reps based on your fitness level']).map((modification, index) => (
                          <li key={index} className="flex gap-3">
                            <RefreshCw className="h-4 w-4 text-purple-500 mt-0.5 flex-shrink-0" />
                            <span className="text-sm">{modification}</span>
                          </li>
                        ))}
                      </ul>
                    </CardContent>
                  </Card>
                </TabsContent>

                <TabsContent value="safety">
                  <Card>
                    <CardHeader>
                      <CardTitle className="flex items-center gap-2">
                        <AlertTriangle className="h-5 w-5 text-orange-600" />
                        Safety Tips
                      </CardTitle>
                      <CardDescription>
                        Important safety considerations for injury prevention
                      </CardDescription>
                    </CardHeader>
                    <CardContent>
                      <ul className="space-y-2">
                        {(aiGuidance?.safetyTips || ['Warm up before performing this exercise']).map((tip, index) => (
                          <li key={index} className="flex gap-3">
                            <AlertTriangle className="h-4 w-4 text-orange-500 mt-0.5 flex-shrink-0" />
                            <span className="text-sm">{tip}</span>
                          </li>
                        ))}
                      </ul>
                    </CardContent>
                  </Card>
                </TabsContent>
              </>
            )}
          </Tabs>
        </div>
      </DialogContent>
    </Dialog>
  );
}
