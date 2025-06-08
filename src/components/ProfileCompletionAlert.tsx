
import { Alert, AlertDescription } from '@/components/ui/alert';
import { Button } from '@/components/ui/button';
import { X, AlertCircle, Target, Activity } from 'lucide-react';

interface ProfileCompletionAlertProps {
  onDismiss: () => void;
  onStartOnboarding: () => void;
}

export function ProfileCompletionAlert({ onDismiss, onStartOnboarding }: ProfileCompletionAlertProps) {
  return (
    <Alert className="mb-6 border-orange-200 bg-gradient-to-r from-orange-50 to-yellow-50">
      <AlertCircle className="h-5 w-5 text-orange-600" />
      <div className="flex justify-between items-start w-full">
        <div className="flex-1">
          <AlertDescription className="text-orange-800">
            <div className="mb-3">
              <span className="font-bold text-lg">Complete Your Fitness Profile</span>
              <p className="text-sm mt-1">
                Get personalized workout recommendations, track your progress, and unlock all features by completing your profile.
              </p>
            </div>
            
            <div className="grid grid-cols-1 md:grid-cols-2 gap-3 mb-4 text-sm">
              <div className="flex items-center space-x-2">
                <Activity className="h-4 w-4 text-orange-600" />
                <span>Physical stats (height, weight, BMI)</span>
              </div>
              <div className="flex items-center space-x-2">
                <Target className="h-4 w-4 text-orange-600" />
                <span>Fitness goals & preferences</span>
              </div>
            </div>
            
            <div className="flex space-x-3">
              <Button 
                onClick={onStartOnboarding}
                className="bg-orange-600 hover:bg-orange-700 text-white"
              >
                Complete Profile (2 min)
              </Button>
              <Button variant="outline" size="sm" onClick={onDismiss}>
                Maybe Later
              </Button>
            </div>
          </AlertDescription>
        </div>
        <Button
          variant="ghost"
          size="sm"
          onClick={onDismiss}
          className="text-orange-600 hover:text-orange-800 p-1 ml-4"
        >
          <X className="h-4 w-4" />
        </Button>
      </div>
    </Alert>
  );
}
