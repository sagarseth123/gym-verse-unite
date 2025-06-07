
import { useState, useEffect } from 'react';
import { useAuth } from '@/hooks/useAuth';
import { supabase } from '@/integrations/supabase/client';
import { GymUserProfile } from '@/types/database';

export function useProfileStatus() {
  const { user, profile } = useAuth();
  const [gymProfile, setGymProfile] = useState<GymUserProfile | null>(null);
  const [isProfileComplete, setIsProfileComplete] = useState(false);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    const checkProfileStatus = async () => {
      if (!user || !profile) {
        setLoading(false);
        return;
      }

      // Check if user has skipped onboarding
      const hasSkipped = localStorage.getItem('onboardingSkipped') === 'true';
      if (hasSkipped) {
        setIsProfileComplete(true);
        setLoading(false);
        return;
      }

      // Check if basic profile info is complete
      const hasBasicInfo = !!(
        profile.full_name &&
        profile.phone &&
        profile.address
      );

      // Fetch gym profile
      const { data: gymData, error } = await supabase
        .from('gym_user_profiles')
        .select('*')
        .eq('id', user.id)
        .maybeSingle();

      if (error && error.code !== 'PGRST116') {
        console.error('Error fetching gym profile:', error);
      }

      setGymProfile(gymData);

      // Check if fitness info is complete
      const hasFitnessInfo = !!(
        gymData?.weight &&
        gymData?.height &&
        gymData?.fitness_level &&
        gymData?.fitness_goals &&
        gymData.fitness_goals.length > 0
      );

      setIsProfileComplete(hasBasicInfo && hasFitnessInfo);
      setLoading(false);
    };

    checkProfileStatus();
  }, [user, profile]);

  return {
    isProfileComplete,
    gymProfile,
    loading
  };
}
