
import { useState } from 'react';
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from '@/components/ui/card';
import { Badge } from '@/components/ui/badge';
import { Button } from '@/components/ui/button';
import { EnhancedExercise } from '@/types/fitness';
import { ExerciseDetailModal } from './ExerciseDetailModal';
import { Dumbbell, Clock, Target, Zap } from 'lucide-react';

interface EnhancedExerciseCardProps {
  exercise: EnhancedExercise;
  showGoalContext?: boolean;
}

export function EnhancedExerciseCard({ exercise, showGoalContext = false }: EnhancedExerciseCardProps) {
  const [isDetailOpen, setIsDetailOpen] = useState(false);

  const getDifficultyColor = (difficulty: string) => {
    switch (difficulty) {
      case 'beginner': return 'bg-green-100 text-green-800';
      case 'intermediate': return 'bg-yellow-100 text-yellow-800';
      case 'advanced': return 'bg-red-100 text-red-800';
      default: return 'bg-gray-100 text-gray-800';
    }
  };

  return (
    <>
      <Card className="cursor-pointer hover:shadow-lg transition-all duration-300 h-full">
        <CardHeader className="pb-3">
          <div className="flex items-start justify-between">
            <div className="flex-1">
              <CardTitle className="text-lg flex items-center gap-2">
                <Dumbbell className="h-5 w-5 text-blue-600" />
                {exercise.name}
              </CardTitle>
              <CardDescription className="flex items-center gap-2 mt-1">
                <Badge variant="secondary">{exercise.category}</Badge>
                <Badge className={getDifficultyColor(exercise.difficulty)}>
                  {exercise.difficulty}
                </Badge>
              </CardDescription>
            </div>
          </div>
        </CardHeader>
        
        <CardContent className="space-y-4">
          {/* Primary Muscles */}
          <div>
            <div className="flex items-center gap-2 mb-2">
              <Target className="h-4 w-4 text-red-500" />
              <span className="text-sm font-medium">Primary Muscles</span>
            </div>
            <div className="flex flex-wrap gap-1">
              {exercise.primaryMuscles?.map((muscle, index) => (
                <Badge key={index} variant="outline" className="text-xs">
                  {muscle}
                </Badge>
              )) || exercise.muscle_groups?.slice(0, 3).map((muscle, index) => (
                <Badge key={index} variant="outline" className="text-xs">
                  {muscle}
                </Badge>
              ))}
            </div>
          </div>

          {/* Equipment */}
          {exercise.equipment_needed && exercise.equipment_needed.length > 0 && (
            <div>
              <div className="flex items-center gap-2 mb-2">
                <Zap className="h-4 w-4 text-purple-500" />
                <span className="text-sm font-medium">Equipment</span>
              </div>
              <div className="flex flex-wrap gap-1">
                {exercise.equipment_needed.slice(0, 2).map((equipment, index) => (
                  <Badge key={index} variant="secondary" className="text-xs">
                    {equipment}
                  </Badge>
                ))}
                {exercise.equipment_needed.length > 2 && (
                  <Badge variant="outline" className="text-xs">
                    +{exercise.equipment_needed.length - 2}
                  </Badge>
                )}
              </div>
            </div>
          )}

          {/* Description Preview */}
          {exercise.instructions && (
            <p className="text-sm text-gray-600 line-clamp-2">
              {exercise.instructions}
            </p>
          )}

          <div className="flex gap-2 pt-2">
            <Button 
              onClick={() => setIsDetailOpen(true)}
              className="flex-1"
              size="sm"
            >
              View Details & AI Guidance
            </Button>
          </div>
        </CardContent>
      </Card>

      <ExerciseDetailModal
        exercise={exercise}
        isOpen={isDetailOpen}
        onClose={() => setIsDetailOpen(false)}
      />
    </>
  );
}
