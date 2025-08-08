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
  CheckCircle,
  Image as ImageIcon,
  Loader2
} from 'lucide-react';
import { useToast } from '@/hooks/use-toast';

interface AIExerciseCardProps {
  exercise: AIGeneratedExercise & { imageUrl?: string };
  onViewDetails: (exercise: AIGeneratedExercise) => void;
  compact?: boolean;
}

export function AIExerciseCard({ exercise, onViewDetails, compact = false }: AIExerciseCardProps) {
  const [isPerformed, setIsPerformed] = useState(false);
  const [imageError, setImageError] = useState(false);
  const [imageLoading, setImageLoading] = useState(false);
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

  const getImageUrl = () => {
    // First, try to use the exercise's imageUrl if it exists
    if (exercise.imageUrl) {
      console.log(`🖼️ AIExerciseCard - Exercise: "${exercise.name}" | Using provided Image URL: ${exercise.imageUrl}`);
      return exercise.imageUrl;
    }
    
    // Remove batch information from exercise name for image matching
    const cleanName = exercise.name.replace(/\s*\(Batch\s*\d+\)/gi, '');
    
    // Create a comprehensive mapping for common exercises
    const exerciseImageMap: { [key: string]: string } = {
      // Cable exercises
      'cable flyes': 'cable_chest_flyes.png',
      'cable triceps pushdowns': 'tricep_pushdown.png',
      'cable tricep pushdowns': 'tricep_pushdown.png',
      'cable chest flyes': 'cable_chest_flyes.png',
      
      // Barbell exercises
      'barbell bicep curls': 'biceps_curl_barbel.png',
      'barbell bent-over row': 'bent_over_rows_barbell.png',
      'barbell overhead press': 'barbell_overhead_press.png',
      'barbell rows': 'bent_over_rows_barbell.png',
      'barbell deadlift': 'deadlift.png',
      'barbell romanian deadlift': 'barbell_romanian_deadlift_rdl.png',
      
      // Dumbbell exercises
      'dumbbell overhead press': 'shoulder_press.png',
      'dumbbell bicep curls': 'biceps_curl.png',
      'dumbbell rows': 'bent_over_rows_barbell.png',
      
      // Bodyweight exercises
      'pull-ups': 'pull_ups.png',
      'pull ups': 'pull_ups.png',
      'dips': 'dips.png',
      'dips (weighted)': 'weighted_dips.png',
      'weighted dips': 'weighted_dips.png',
      'push-ups': 'push_ups.png',
      'push ups': 'push_ups.png',
      
      // Kettlebell exercises
      'kettlebell goblet squat': 'kettlebell_goblet_squat.png',
      'kettlebell swing': 'kettlebell_swing.png',
      
      // Other exercises
      'romanian deadlift': 'barbell_romanian_deadlift_rdl.png',
      'bodyweight romanian deadlift': 'bodyweight_romanian_deadlift.png',
      'medicine ball russian twist': 'medicine_ball_russian_twist.png',
      'resistance band lateral walks': 'resistance_band_lateral_walks.png',
      
      // Stretching exercises
      'child\'s pose': 'child_s_pose.png',
      'cat-cow pose': 'cat_cow_pose.png',
      'downward-facing dog': 'downward_facing_dog.png',
      'pigeon pose': 'pigeon_pose.png',
      'standing quadriceps stretch': 'standing_quadriceps_stretch.png'
    };
    
    // Try to find a match in our mapping
    const normalizedName = cleanName.toLowerCase().trim();
    const mappedImage = exerciseImageMap[normalizedName];
    
    if (mappedImage) {
      const imageUrl = `/images/exercise/${mappedImage}`;
      console.log(`🖼️ AIExerciseCard - Exercise: "${exercise.name}" | Mapped to: ${imageUrl}`);
      return imageUrl;
    }
    
    // Fallback: try to create a filename from the clean name
    const fallbackUrl = `/images/exercise/${cleanName.toLowerCase().replace(/[^a-z0-9]/g, '_')}.png`;
    console.log(`🖼️ AIExerciseCard - Exercise: "${exercise.name}" | Fallback URL: ${fallbackUrl}`);
    return fallbackUrl;
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

  const handleImageError = async (e: React.SyntheticEvent<HTMLImageElement, Event>) => {
    console.log(`🚀 Starting image generation for: "${exercise.name}"`);
    setImageLoading(true);
    try {
      const apiUrl = `http://localhost:4000/api/exercise-image?name=${encodeURIComponent(exercise.name)}`;
      console.log(`🌐 Calling API: ${apiUrl}`);
      
      const res = await fetch(apiUrl);
      console.log(`📡 Response status: ${res.status} ${res.statusText}`);
      
      if (!res.ok) {
        const errorText = await res.text();
        console.error(`❌ API Error (${res.status}):`, errorText);
        throw new Error(`API Error: ${res.status} ${res.statusText}`);
      }
      
      const data = await res.json();
      console.log(`📡 Image generation response for "${exercise.name}":`, data);
      
      if (data.imageUrl) {
        if (e.currentTarget) e.currentTarget.src = data.imageUrl;
        setImageError(false);
        console.log(`✅ Image generated successfully for "${exercise.name}" at: ${data.imageUrl}`);
      } else {
        setImageError(true);
        console.error(`❌ Failed to generate image for "${exercise.name}": No imageUrl in response`);
      }
    } catch (error) {
    setImageError(true);
      console.error(`❌ Image generation error for "${exercise.name}":`, error);
    } finally {
      setTimeout(() => setImageLoading(false), 1000);
    }
  };
  const handleImageLoad = () => {
    console.log(`✅ Image loaded successfully for: "${exercise.name}"`);
    setImageLoading(false);
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
    <Card className="cursor-pointer hover:shadow-lg transition-all duration-300 h-full overflow-hidden">
      {/* Exercise Image */}
      <div className="relative h-48 w-full flex items-center justify-center bg-white border">
        {imageLoading && (
          <div className="absolute inset-0 flex items-center justify-center bg-white/70 z-10">
            <Loader2 className="animate-spin h-8 w-8 text-blue-500" />
          </div>
        )}
        {!imageError && (
          <img
            src={getImageUrl()}
            alt={`${exercise.name} exercise demonstration`}
            className="max-h-full max-w-full object-contain transition-transform duration-300 hover:scale-105"
            onError={handleImageError}
            onLoad={handleImageLoad}
            loading="lazy"
            style={imageLoading ? { opacity: 0.3 } : {}}
          />
      )}
        {imageError && !imageLoading && (
          <div className="text-center w-full">
            <ImageIcon className="h-12 w-12 text-gray-400 mx-auto mb-2" />
            <p className="text-sm text-gray-500">Exercise Image</p>
          </div>
        )}
          <div className="absolute top-2 right-2">
            <Button
              variant="ghost"
              size="sm"
              onClick={handleToggleFavorite}
              className="h-8 w-8 p-0 bg-white/80 hover:bg-white/90"
            >
              <Star className={`h-4 w-4 ${isFavorite ? 'fill-yellow-400 text-yellow-400' : 'text-gray-600'}`} />
            </Button>
          </div>
        </div>

      <CardHeader className="pb-3">
        <div className="flex items-start justify-between">
          <div className="flex-1">
            <CardTitle className="text-lg flex items-center gap-2">
              <Dumbbell className="h-5 w-5 text-blue-600" />
              {exercise.name}
            </CardTitle>
            <div className="flex items-center gap-2 mt-1">
              <Badge variant="secondary">{exercise.category}</Badge>
              <Badge className={getDifficultyColor(exercise.difficulty)}>
                {exercise.difficulty}
              </Badge>
            </div>
          </div>
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
            variant={isPerformed ? "default" : "outline"}
            size="sm"
            onClick={handleMarkPerformed}
            disabled={isPerformed}
          >
            {isPerformed ? (
              <>
                <CheckCircle className="h-4 w-4 mr-1" />
                Done
              </>
            ) : (
              <>
                <CheckCircle className="h-4 w-4 mr-1" />
                Mark Done
              </>
            )}
          </Button>
        </div>
      </CardContent>
    </Card>
  );
}
