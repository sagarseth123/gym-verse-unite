
import { Alert, AlertDescription } from '@/components/ui/alert';
import { Button } from '@/components/ui/button';
import { X, AlertCircle } from 'lucide-react';
import { Link } from 'react-router-dom';

interface ProfileCompletionAlertProps {
  onDismiss: () => void;
}

export function ProfileCompletionAlert({ onDismiss }: ProfileCompletionAlertProps) {
  return (
    <Alert className="mb-6 border-orange-200 bg-orange-50">
      <AlertCircle className="h-4 w-4 text-orange-600" />
      <div className="flex justify-between items-start w-full">
        <div className="flex-1">
          <AlertDescription className="text-orange-800">
            <span className="font-semibold">Complete your profile</span> to get personalized fitness recommendations and unlock all features.
          </AlertDescription>
          <div className="mt-3 flex space-x-2">
            <Button asChild size="sm" className="bg-orange-600 hover:bg-orange-700">
              <Link to="/profile">Complete Profile</Link>
            </Button>
            <Button variant="outline" size="sm" onClick={onDismiss}>
              Skip for now
            </Button>
          </div>
        </div>
        <Button
          variant="ghost"
          size="sm"
          onClick={onDismiss}
          className="text-orange-600 hover:text-orange-800 p-1"
        >
          <X className="h-4 w-4" />
        </Button>
      </div>
    </Alert>
  );
}
