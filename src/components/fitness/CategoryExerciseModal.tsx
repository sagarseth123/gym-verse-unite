import { useState } from 'react';
import { supabase } from '@/integrations/supabase/client';
import { useToast } from '@/hooks/use-toast';
import { Dialog, DialogContent, DialogHeader, DialogTitle } from '@/components/ui/dialog';
import { Button } from '@/components/ui/button';
import { Badge } from '@/components/ui/badge';
import { Tabs, TabsContent, TabsList, TabsTrigger } from '@/components/ui/tabs';
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from '@/components/ui/card';
import { EnhancedExercise } from '@/types/fitness';
import { AIGeneratedExercise } from '@/services/aiExerciseService';
import { CategoryExercise } from '@/services/exerciseCategoryService';
import { EnhancedExerciseCard } from '@/components/fitness/EnhancedExerciseCard';
import { AIExerciseCard } from '@/components/fitness/AIExerciseCard';
import { AIExerciseDetailModal } from '@/components/fitness/AIExerciseDetailModal';
import { 
  Sparkles, 
  User, 
  CheckSquare, 
  Calendar,
  Target,
  Loader2,
  Database
} from 'lucide-react';
import { startOfWeek, format } from 'date-fns';

interface CategoryExerciseModalProps {
  isOpen: boolean;
  onClose: () => void;
  categoryName: string;
  categoryDescription: string;
  dbExercises: EnhancedExercise[];
  aiExercises: AIGeneratedExercise[];
  categoryExercises: CategoryExercise[];
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
  categoryExercises,
  aiLoading,
  onRefreshAI
}: CategoryExerciseModalProps) {
  const [selectedAIExercise, setSelectedAIExercise] = useState<AIGeneratedExercise | null>(null);
  const [selectedExercises, setSelectedExercises] = useState<string[]>([]);
  const [planModalOpen, setPlanModalOpen] = useState(false);
  const [planLoading, setPlanLoading] = useState(false);
  const [planData, setPlanData] = useState<any>(null);
  const { toast } = useToast();

  const handleExerciseSelect = (exerciseId: string) => {
    setSelectedExercises(prev => 
      prev.includes(exerciseId) 
        ? prev.filter(id => id !== exerciseId)
        : [...prev, exerciseId]
    );
  };

  const handleCreateAIPlan = async () => {
    setPlanLoading(true);
    setPlanData(null);
    setPlanModalOpen(true);
    try {
      // Prepare allowed exercises from dbExercises (with metadata)
      const allowedExercises = dbExercises.map(ex => ({
        name: ex.name,
        difficulty: ex.difficulty,
        muscle_groups: ex.muscle_groups,
        equipment_needed: ex.equipment_needed,
      }));
      const { data, error } = await supabase.functions.invoke('generate-fitness-plan', {
        body: {
          type: 'weekly_plan',
          category: categoryName,
          allowedExercises,
        },
      });
      if (error) throw error;
      setPlanData(data?.data || data);
      // Parse and normalize plan structure for dashboard compatibility
      const days = ['monday','tuesday','wednesday','thursday','friday','saturday','sunday'];
      let normalizedPlan = { ...(data?.data || data) };
      function parseRawPlan(raw) {
        let rawStr = raw.trim();
        if (rawStr.startsWith('```json')) rawStr = rawStr.slice(7);
        if (rawStr.startsWith('```')) rawStr = rawStr.slice(3);
        if (rawStr.endsWith('```')) rawStr = rawStr.slice(0, -3);
        try {
          return JSON.parse(rawStr);
        } catch (e) {
          return null;
        }
      }
      // If plan.plan.raw exists, always parse and use it
      if (normalizedPlan.plan && typeof normalizedPlan.plan.raw === 'string') {
        const parsed = parseRawPlan(normalizedPlan.plan.raw);
        if (parsed && parsed.plan) {
          normalizedPlan.exercisePlan = parsed.plan;
          if (parsed.tips) normalizedPlan.tips = parsed.tips;
        }
      }
      // If exercisePlan.raw exists, parse it (fallback)
      if (normalizedPlan.exercisePlan && typeof normalizedPlan.exercisePlan.raw === 'string') {
        const parsed = parseRawPlan(normalizedPlan.exercisePlan.raw);
        if (parsed && parsed.plan) {
          normalizedPlan.exercisePlan = parsed.plan;
          if (parsed.tips) normalizedPlan.tips = parsed.tips;
        }
      }
      // Ensure all days are present, but do NOT overwrite real exercises
      if (!normalizedPlan.exercisePlan) {
        normalizedPlan.exercisePlan = {};
      }
      days.forEach(day => {
        if (!normalizedPlan.exercisePlan[day]) {
          normalizedPlan.exercisePlan[day] = { type: '', duration: '', exercises: [] };
        } else if (!Array.isArray(normalizedPlan.exercisePlan[day].exercises)) {
          normalizedPlan.exercisePlan[day].exercises = [];
        }
      });
      // Save plan to user_weekly_plans
      const session = await supabase.auth.getSession();
      const user = session.data.session?.user;
      if (user) {
        const weekStart = format(startOfWeek(new Date(), { weekStartsOn: 1 }), 'yyyy-MM-dd');
        console.log('Normalized plan to save:', normalizedPlan);
        await supabase.from('user_weekly_plans').upsert({
          user_id: user.id,
          week_start: weekStart,
          plan_data: normalizedPlan
        }, { onConflict: 'user_id,week_start' });
      }
      toast({
        title: 'AI Plan Generated!',
        description: 'Your personalized AI plan has been generated and saved.',
      });
    } catch (err: any) {
      setPlanData({ error: err.message || 'Failed to generate plan.' });
      toast({
        title: 'Error',
        description: err.message || 'Failed to generate plan.',
        variant: 'destructive',
      });
    } finally {
      setPlanLoading(false);
    }
  };

  const handleCreateManualPlan = async () => {
    // Save selected exercises as a manual plan
    const days = ['monday','tuesday','wednesday','thursday','friday','saturday','sunday'];
    let normalizedPlan: any = { type: 'manual', exercisePlan: {} };
    const perDay = Math.ceil(selectedExercises.length / 7);
    days.forEach((day, idx) => {
      normalizedPlan.exercisePlan[day] = {
        type: '',
        duration: '',
        exercises: selectedExercises.slice(idx * perDay, (idx + 1) * perDay)
      };
    });
    const session = await supabase.auth.getSession();
    const user = session.data.session?.user;
    if (user) {
      const weekStart = format(startOfWeek(new Date(), { weekStartsOn: 1 }), 'yyyy-MM-dd');
      await supabase.from('user_weekly_plans').upsert({
        user_id: user.id,
        week_start: weekStart,
        plan_data: normalizedPlan
      }, { onConflict: 'user_id,week_start' });
      toast({
        title: 'Plan Created!',
        description: `Created and saved a plan with ${selectedExercises.length} exercises.`,
      });
      setSelectedExercises([]);
    } else {
      toast({
        title: 'Error',
        description: 'User not authenticated.',
        variant: 'destructive',
      });
    }
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
            <Tabs defaultValue="category-exercises" className="w-full">
              <TabsList className="grid w-full grid-cols-3">
                <TabsTrigger value="category-exercises" className="flex items-center gap-2">
                  <Target className="h-4 w-4" />
                  Category Exercises
                  {categoryExercises.length > 0 && (
                    <Badge variant="secondary">{categoryExercises.length}</Badge>
                  )}
                </TabsTrigger>
                <TabsTrigger value="ai-exercises" className="flex items-center gap-2">
                  <Sparkles className="h-4 w-4" />
                  AI-Generated Exercises
                  {aiExercises.length > 0 && (
                    <Badge variant="secondary">{aiExercises.length}</Badge>
                  )}
                </TabsTrigger>
                <TabsTrigger value="db-exercises" className="flex items-center gap-2">
                  <Database className="h-4 w-4" />
                  Database Exercises
                  {dbExercises.length > 0 && (
                    <Badge variant="secondary">{dbExercises.length}</Badge>
                  )}
                </TabsTrigger>
              </TabsList>

              <TabsContent value="category-exercises" className="mt-6">
                {aiLoading ? (
                  <div className="text-center py-12">
                    <Loader2 className="h-8 w-8 animate-spin text-blue-600 mx-auto mb-4" />
                    <p className="text-gray-600">Loading category exercises...</p>
                  </div>
                ) : categoryExercises.length > 0 ? (
                  <>
                    <div className="flex justify-between items-center mb-4">
                      <h3 className="text-lg font-semibold">Category Exercises</h3>
                      <Badge variant="outline" className="text-sm">
                        {categoryExercises.length} exercises
                      </Badge>
                    </div>
                    <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
                      {categoryExercises.map((exercise) => (
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
                    <Target className="h-12 w-12 text-gray-400 mx-auto mb-4" />
                    <h3 className="text-lg font-medium text-gray-900 mb-2">No Category Exercises</h3>
                    <p className="text-gray-600 mb-4">
                      No stored exercises found for this category. Check the AI-Generated tab for dynamic exercises.
                    </p>
                  </div>
                )}
              </TabsContent>

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
                      {aiExercises.map((exercise) => {
                        console.log(`🎯 Rendering AI Exercise: "${exercise.name}" (ID: ${exercise.id})`);
                        return (
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
                        );
                      })}
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

      <Dialog open={planModalOpen} onOpenChange={setPlanModalOpen}>
        <DialogContent className="max-w-2xl">
          <DialogHeader>
            <DialogTitle>AI Generated Plan</DialogTitle>
          </DialogHeader>
          {planLoading ? (
            <div className="flex flex-col items-center py-8">
              <Loader2 className="h-8 w-8 animate-spin text-purple-600 mb-4" />
              <p>Generating your plan...</p>
            </div>
          ) : planData && !planData.error ? (
            <pre className="whitespace-pre-wrap text-sm max-h-96 overflow-y-auto">{JSON.stringify(planData, null, 2)}</pre>
          ) : (
            <div className="text-red-600">{planData?.error || 'Failed to generate plan.'}</div>
          )}
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
