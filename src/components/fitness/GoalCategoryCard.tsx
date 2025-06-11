
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from '@/components/ui/card';
import { Badge } from '@/components/ui/badge';
import { Button } from '@/components/ui/button';
import { FitnessGoalCategory } from '@/types/fitness';
import { Dumbbell, Eye } from 'lucide-react';

interface GoalCategoryCardProps {
  category: FitnessGoalCategory;
  exerciseCount: number;
  onClick: () => void;
  isSelected?: boolean;
}

export function GoalCategoryCard({ category, exerciseCount, onClick, isSelected }: GoalCategoryCardProps) {
  return (
    <Card 
      className={`transition-all duration-300 hover:shadow-lg ${
        isSelected ? 'ring-2 ring-blue-500 shadow-lg' : ''
      }`}
    >
      <CardHeader className="pb-3">
        <div className="flex items-center justify-between">
          <div className="flex items-center gap-3">
            <div className={`w-12 h-12 rounded-full ${category.color} flex items-center justify-center text-white text-xl font-bold`}>
              {category.icon}
            </div>
            <div>
              <CardTitle className="text-lg">{category.name}</CardTitle>
              <CardDescription className="text-sm">
                {exerciseCount} exercises available
              </CardDescription>
            </div>
          </div>
        </div>
      </CardHeader>
      <CardContent className="pt-0">
        <p className="text-sm text-gray-600 mb-4">{category.description}</p>
        <div className="flex flex-wrap gap-1 mb-4">
          {category.targetMuscles.slice(0, 3).map((muscle) => (
            <Badge key={muscle} variant="secondary" className="text-xs">
              {muscle.replace('_', ' ')}
            </Badge>
          ))}
          {category.targetMuscles.length > 3 && (
            <Badge variant="outline" className="text-xs">
              +{category.targetMuscles.length - 3} more
            </Badge>
          )}
        </div>
        <Button onClick={onClick} className="w-full">
          <Eye className="h-4 w-4 mr-2" />
          View Exercises & Create Plans
        </Button>
      </CardContent>
    </Card>
  );
}
