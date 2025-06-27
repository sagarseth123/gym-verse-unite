import { useState } from 'react';
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from '@/components/ui/card';
import { Badge } from '@/components/ui/badge';
import { Button } from '@/components/ui/button';
import { AIGeneratedExercise } from '@/services/aiExerciseService';
import { useExerciseHistory } from '@/hooks/useExerciseHistory';
import { useExercisePreferences } from '@/hooks/useExercisePreferences';
import { 
  Dumbbell, 
  Target, 
  Zap, 
  Heart, 
  Clock,
  Star,
  PlayCircle,
  CheckCircle
} from 'lucide-react';
import { useToast } from '@/hooks/use-toast';

interface AIExerciseCardProps {
  exercise: AIGeneratedExercise;
  onViewDetails: (exercise: AIGeneratedExercise) => void;
  compact?: boolean;
}

export function AIExerciseCard({ exercise, onViewDetails, compact = false }: AIExerciseCardProps) {
  const [isPerformed, setIsPerformed] = useState(false);
  const { addToHistory } = useExerciseHistory();
  const { preferences, addFavoriteExercise, removeFavoriteExercise } = useExercisePreferences();
  const { toast } = useToast();

  const isFavorite = preferences?.favorite_exercises?.includes(exercise.name) || false;

  const getDifficultyColor = (difficulty: string) => {
    switch (difficulty) {
      case 'beginner': return 'bg-green-100 text-green-800';
      case 'intermediate': return 'bg-yellow-100 text-yellow-800';
      case 'advanced': return 'bg-red-100 text-red-800';
      default: return 'bg-gray-100 text-gray-800';
    }
  };

  const handleViewDetails = () => {
    // Add to history when viewed
    addToHistory({
      exercise_id: exercise.id,
      exercise_name: exercise.name,
      goal_category: exercise.category
    });
    onViewDetails(exercise);
  };

  const handleMarkPerformed = () => {
    addToHistory({
      exercise_id: exercise.id,
      exercise_name: exercise.name,
      goal_category: exercise.category,
      performed: true
    });
    setIsPerformed(true);
    toast({
      title: "Great job!",
      description: `${exercise.name} marked as completed`,
    });
  };

  const handleToggleFavorite = () => {
    if (isFavorite) {
      removeFavoriteExercise(exercise.name);
    } else {
      addFavoriteExercise(exercise.name);
    }
  };

  if (compact) {
    return (
      <Card className="hover:shadow-md transition-shadow">
        <CardContent className="p-4">
          <div className="flex items-center justify-between mb-2">
            <h4 className="font-medium text-sm">{exercise.name}</h4>
            <Button
              variant="ghost"
              size="sm"
              onClick={handleToggleFavorite}
              className="h-6 w-6 p-0"
            >
              <Star className={`h-3 w-3 ${isFavorite ? 'fill-yellow-400 text-yellow-400' : 'text-gray-400'}`} />
            </Button>
          </div>
          <div className="flex items-center gap-2 mb-2">
            <Badge className={getDifficultyColor(exercise.difficulty)} variant="secondary">
              {exercise.difficulty}
            </Badge>
            <span className="text-xs text-gray-500">{exercise.muscle_groups.join(', ')}</span>
          </div>
          <Button onClick={handleViewDetails} size="sm" className="w-full">
            View Details
          </Button>
        </CardContent>
      </Card>
    );
  }

  return (
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
          <Button
            variant="ghost"
            size="sm"
            onClick={handleToggleFavorite}
            className="h-8 w-8 p-0"
          >
            <Star className={`h-4 w-4 ${isFavorite ? 'fill-yellow-400 text-yellow-400' : 'text-gray-400'}`} />
          </Button>
        </div>
      </CardHeader>
      
      <CardContent className="space-y-4">
        {/* Primary Muscles */}
        <div>
          <div className="flex items-center gap-2 mb-2">
            <Target className="h-4 w-4 text-red-500" />
            <span className="text-sm font-medium">Target Muscles</span>
          </div>
          <div className="flex flex-wrap gap-1">
            {exercise.muscle_groups.map((muscle, index) => (
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
              {exercise.equipment_needed.slice(0, 3).map((equipment, index) => (
                <Badge key={index} variant="secondary" className="text-xs">
                  {equipment}
                </Badge>
              ))}
              {exercise.equipment_needed.length > 3 && (
                <Badge variant="outline" className="text-xs">
                  +{exercise.equipment_needed.length - 3}
                </Badge>
              )}
            </div>
          </div>
        )}

        {/* Sets/Reps Guidance */}
        {exercise.sets_reps_guidance && (
          <div>
            <div className="flex items-center gap-2 mb-1">
              <Clock className="h-4 w-4 text-green-500" />
              <span className="text-sm font-medium">Recommended</span>
            </div>
            <p className="text-xs text-gray-600">{exercise.sets_reps_guidance}</p>
          </div>
        )}

        {/* Quick Benefits */}
        {exercise.benefits && exercise.benefits.length > 0 && (
          <div>
            <div className="flex items-center gap-2 mb-1">
              <Heart className="h-4 w-4 text-red-500" />
              <span className="text-sm font-medium">Key Benefits</span>
            </div>
            <p className="text-xs text-gray-600 line-clamp-2">
              {exercise.benefits.slice(0, 2).join(', ')}
            </p>
          </div>
        )}

        <div className="flex gap-2 pt-2">
          <Button 
            onClick={handleViewDetails}
            className="flex-1"
            size="sm"
          >
            <PlayCircle className="h-4 w-4 mr-1" />
            View Details
          </Button>
          <Button 
            onClick={handleMarkPerformed}
            variant="outline"
            size="sm"
            disabled={isPerformed}
            className={isPerformed ? 'bg-green-50 border-green-200' : ''}
          >
            <CheckCircle className={`h-4 w-4 ${isPerformed ? 'text-green-600' : ''}`} />
          </Button>
        </div>
      </CardContent>
    </Card>
  );
}
