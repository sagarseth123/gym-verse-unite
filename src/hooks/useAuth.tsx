
import { createContext, useContext, useEffect, useState, ReactNode } from 'react';
import { User, Session } from '@supabase/supabase-js';
import { supabase } from '@/integrations/supabase/client';
import { Profile, GymUserProfile } from '@/types/database';

interface AuthContextType {
  user: User | null;
  profile: Profile | null;
  gymProfile: GymUserProfile | null;
  session: Session | null;
  loading: boolean;
  signOut: () => Promise<void>;
  refreshProfile: () => Promise<void>;
}

const AuthContext = createContext<AuthContextType | undefined>(undefined);

export function AuthProvider({ children }: { children: ReactNode }) {
  const [user, setUser] = useState<User | null>(null);
  const [profile, setProfile] = useState<Profile | null>(null);
  const [gymProfile, setGymProfile] = useState<GymUserProfile | null>(null);
  const [session, setSession] = useState<Session | null>(null);
  const [loading, setLoading] = useState(true);

  const loadUserProfile = async (userId: string) => {
    console.log('Loading profile for user:', userId);
    try {
      // Load basic profile
      const { data: profileData, error: profileError } = await supabase
        .from('profiles')
        .select('*')
        .eq('id', userId)
        .single();

      if (profileError) {
        console.error('Error loading profile:', profileError);
        // If profile doesn't exist, create one
        if (profileError.code === 'PGRST116') {
          console.log('Profile not found, creating new profile');
          const { data: newProfile, error: createError } = await supabase
            .from('profiles')
            .insert({
              id: userId,
              email: session?.user?.email || '',
              user_role: 'gym_user'
            })
            .select()
            .single();

          if (createError) {
            console.error('Error creating profile:', createError);
          } else {
            console.log('Profile created:', newProfile);
            setProfile(newProfile);
          }
        }
      } else if (profileData) {
        console.log('Profile loaded:', profileData);
        setProfile(profileData);

        // Load gym user profile if user is a gym_user
        if (profileData.user_role === 'gym_user') {
          const { data: gymData, error: gymError } = await supabase
            .from('gym_user_profiles')
            .select('*')
            .eq('id', userId)
            .single();

          if (gymError) {
            if (gymError.code === 'PGRST116') {
              console.log('Gym profile not found, creating new gym profile');
              const { data: newGymProfile, error: createGymError } = await supabase
                .from('gym_user_profiles')
                .insert({ id: userId })
                .select()
                .single();

              if (createGymError) {
                console.error('Error creating gym profile:', createGymError);
              } else {
                console.log('Gym profile created:', newGymProfile);
                setGymProfile(newGymProfile);
              }
            } else {
              console.error('Error loading gym profile:', gymError);
            }
          } else if (gymData) {
            console.log('Gym profile loaded:', gymData);
            setGymProfile(gymData);
          }
        }
      }
    } catch (error) {
      console.error('Error in loadUserProfile:', error);
    } finally {
      setLoading(false);
    }
  };

  const refreshProfile = async () => {
    if (user) {
      setLoading(true);
      await loadUserProfile(user.id);
    }
  };

  useEffect(() => {
    console.log('AuthProvider useEffect - initializing');
    
    // Get initial session
    supabase.auth.getSession().then(({ data: { session } }) => {
      console.log('Initial session:', session?.user?.id);
      setSession(session);
      setUser(session?.user ?? null);
      if (session?.user) {
        loadUserProfile(session.user.id);
      } else {
        setLoading(false);
      }
    });

    // Listen for auth changes
    const {
      data: { subscription },
    } = supabase.auth.onAuthStateChange(async (event, session) => {
      console.log('Auth state changed:', event, session?.user?.id);
      setSession(session);
      setUser(session?.user ?? null);
      
      if (session?.user) {
        await loadUserProfile(session.user.id);
      } else {
        setProfile(null);
        setGymProfile(null);
        setLoading(false);
      }
    });

    return () => subscription.unsubscribe();
  }, []);

  const signOut = async () => {
    await supabase.auth.signOut();
  };

  const value = {
    user,
    profile,
    gymProfile,
    session,
    loading,
    signOut,
    refreshProfile,
  };

  return <AuthContext.Provider value={value}>{children}</AuthContext.Provider>;
}

export function useAuth() {
  const context = useContext(AuthContext);
  if (context === undefined) {
    throw new Error('useAuth must be used within an AuthProvider');
  }
  return context;
}
