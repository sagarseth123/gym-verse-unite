
import { useState } from 'react';
import { Dialog, DialogContent, DialogHeader, DialogTitle } from '@/components/ui/dialog';
import { Badge } from '@/components/ui/badge';
import { Button } from '@/components/ui/button';
import { Tabs, TabsContent, TabsList, TabsTrigger } from '@/components/ui/tabs';
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from '@/components/ui/card';
import { Textarea } from '@/components/ui/textarea';
import { AIGeneratedExercise } from '@/services/aiExerciseService';
import { useExerciseHistory } from '@/hooks/useExerciseHistory';
import { useExercisePreferences } from '@/hooks/useExercisePreferences';
import { 
  Target, 
  Zap, 
  AlertTriangle, 
  TrendingUp, 
  RefreshCw, 
  Heart,
  Clock,
  Star,
  CheckCircle,
  MessageSquare
} from 'lucide-react';
import { useToast } from '@/hooks/use-toast';

interface AIExerciseDetailModalProps {
  exercise: AIGeneratedExercise | null;
  isOpen: boolean;
  onClose: () => void;
}

export function AIExerciseDetailModal({ exercise, isOpen, onClose }: AIExerciseDetailModalProps) {
  const [notes, setNotes] = useState('');
  const [isPerformed, setIsPerformed] = useState(false);
  const { addToHistory } = useExerciseHistory();
  const { preferences, addFavoriteExercise, removeFavoriteExercise } = useExercisePreferences();
  const { toast } = useToast();

  if (!exercise) return null;

  const isFavorite = preferences?.favorite_exercises?.includes(exercise.name) || false;

  const handleMarkPerformed = () => {
    addToHistory({
      exercise_id: exercise.id,
      exercise_name: exercise.name,
      goal_category: exercise.category,
      performed: true,
      notes: notes.trim() || undefined
    });
    setIsPerformed(true);
    setNotes('');
    toast({
      title: "Excellent work!",
      description: `${exercise.name} completed and saved to your history`,
    });
  };

  const handleToggleFavorite = () => {
    if (isFavorite) {
      removeFavoriteExercise(exercise.name);
    } else {
      addFavoriteExercise(exercise.name);
    }
  };

  return (
    <Dialog open={isOpen} onOpenChange={onClose}>
      <DialogContent className="max-w-4xl max-h-[90vh] overflow-y-auto">
        <DialogHeader>
          <DialogTitle className="flex items-center justify-between text-xl">
            <div className="flex items-center gap-3">
              <Target className="h-6 w-6 text-blue-600" />
              {exercise.name}
              <Badge className={`ml-2 ${
                exercise.difficulty === 'beginner' ? 'bg-green-100 text-green-800' :
                exercise.difficulty === 'intermediate' ? 'bg-yellow-100 text-yellow-800' :
                'bg-red-100 text-red-800'
              }`}>
                {exercise.difficulty}
              </Badge>
            </div>
            <Button
              variant="ghost"
              size="sm"
              onClick={handleToggleFavorite}
            >
              <Star className={`h-5 w-5 ${isFavorite ? 'fill-yellow-400 text-yellow-400' : 'text-gray-400'}`} />
            </Button>
          </DialogTitle>
        </DialogHeader>

        <div className="mt-4">
          {/* Exercise Overview */}
          <div className="grid grid-cols-1 md:grid-cols-4 gap-4 mb-6">
            <Card>
              <CardHeader className="pb-2">
                <CardTitle className="text-sm flex items-center gap-2">
                  <Target className="h-4 w-4" />
                  Target Muscles
                </CardTitle>
              </CardHeader>
              <CardContent>
                <div className="flex flex-wrap gap-1">
                  {exercise.muscle_groups.map((muscle, index) => (
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
                  {exercise.equipment_needed.map((equipment, index) => (
                    <Badge key={index} variant="secondary" className="text-xs">
                      {equipment}
                    </Badge>
                  ))}
                </div>
              </CardContent>
            </Card>

            <Card>
              <CardHeader className="pb-2">
                <CardTitle className="text-sm flex items-center gap-2">
                  <Clock className="h-4 w-4" />
                  Sets & Reps
                </CardTitle>
              </CardHeader>
              <CardContent>
                <p className="text-sm">{exercise.sets_reps_guidance}</p>
              </CardContent>
            </Card>

            <Card>
              <CardHeader className="pb-2">
                <CardTitle className="text-sm flex items-center gap-2">
                  <RefreshCw className="h-4 w-4" />
                  Rest Period
                </CardTitle>
              </CardHeader>
              <CardContent>
                <p className="text-sm">{exercise.rest_periods}</p>
              </CardContent>
            </Card>
          </div>

          {/* AI-Powered Guidance Tabs */}
          <Tabs defaultValue="instructions" className="w-full">
            <TabsList className="grid w-full grid-cols-6">
              <TabsTrigger value="instructions">Instructions</TabsTrigger>
              <TabsTrigger value="benefits">Benefits</TabsTrigger>
              <TabsTrigger value="mistakes">Mistakes</TabsTrigger>
              <TabsTrigger value="progressions">Progress</TabsTrigger>
              <TabsTrigger value="modifications">Modify</TabsTrigger>
              <TabsTrigger value="safety">Safety</TabsTrigger>
            </TabsList>

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
                  <div className="prose prose-sm max-w-none">
                    <p className="whitespace-pre-line">{exercise.instructions}</p>
                  </div>
                  {exercise.tips && (
                    <div className="mt-4 p-3 bg-blue-50 rounded-lg">
                      <h4 className="font-medium text-blue-900 mb-2">Pro Tips</h4>
                      <p className="text-blue-800 text-sm">{exercise.tips}</p>
                    </div>
                  )}
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
                    {exercise.benefits.map((benefit, index) => (
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
                    {exercise.common_mistakes.map((mistake, index) => (
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
                    {exercise.progressions.map((progression, index) => (
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
                    {exercise.modifications.map((modification, index) => (
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
                    {exercise.safety_tips.map((tip, index) => (
                      <li key={index} className="flex gap-3">
                        <AlertTriangle className="h-4 w-4 text-orange-500 mt-0.5 flex-shrink-0" />
                        <span className="text-sm">{tip}</span>
                      </li>
                    ))}
                  </ul>
                </CardContent>
              </Card>
            </TabsContent>
          </Tabs>

          {/* Action Section */}
          <div className="mt-6 p-4 bg-gray-50 rounded-lg">
            <h3 className="font-medium mb-3 flex items-center gap-2">
              <MessageSquare className="h-4 w-4" />
              Complete this exercise
            </h3>
            <div className="space-y-3">
              <Textarea
                placeholder="Add notes about your performance, weight used, or any observations..."
                value={notes}
                onChange={(e) => setNotes(e.target.value)}
                rows={3}
              />
              <Button 
                onClick={handleMarkPerformed}
                disabled={isPerformed}
                className={`w-full ${isPerformed ? 'bg-green-600' : ''}`}
              >
                <CheckCircle className="h-4 w-4 mr-2" />
                {isPerformed ? 'Exercise Completed!' : 'Mark as Completed'}
              </Button>
            </div>
          </div>
        </div>
      </DialogContent>
    </Dialog>
  );
}
