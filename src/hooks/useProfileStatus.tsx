
import { useState, useEffect } from 'react';
import { useAuth } from '@/hooks/useAuth';
import { supabase } from '@/integrations/supabase/client';
import { GymUserProfile } from '@/types/database';

export function useProfileStatus() {
  const { user, profile, loading: authLoading } = useAuth();
  const [gymProfile, setGymProfile] = useState<GymUserProfile | null>(null);
  const [isProfileComplete, setIsProfileComplete] = useState(false);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    const checkProfileStatus = async () => {
      console.log('Checking profile status - user:', user?.id, 'profile:', profile?.id, 'authLoading:', authLoading);
      
      // Wait for auth to finish loading
      if (authLoading) {
        console.log('Auth still loading, waiting...');
        return;
      }

      if (!user || !profile) {
        console.log('No user or profile, setting complete to false');
        setIsProfileComplete(false);
        setLoading(false);
        return;
      }

      try {
        // Check if user has skipped onboarding
        const hasSkipped = localStorage.getItem('onboardingSkipped') === 'true';
        if (hasSkipped) {
          console.log('User has skipped onboarding');
          setIsProfileComplete(true);
          setLoading(false);
          return;
        }

        // Check if user is gym admin (gym admins don't need to complete profiles)
        if (profile.user_role === 'gym_admin') {
          console.log('User is gym_admin, skipping profile completion check');
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

        // Fetch gym profile for gym users
        if (profile.user_role === 'gym_user') {
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
        } else {
          // For non-gym users, just check basic info
          setIsProfileComplete(hasBasicInfo);
        }
      } catch (error) {
        console.error('Error in checkProfileStatus:', error);
        setIsProfileComplete(false);
      } finally {
        setLoading(false);
      }
    };

    checkProfileStatus();
  }, [user, profile, authLoading]);

  return {
    isProfileComplete,
    gymProfile,
    loading
  };
}
