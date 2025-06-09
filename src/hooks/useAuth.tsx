
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

  const loadUserProfile = async (userId: string, userEmail?: string) => {
    console.log('Loading profile for user:', userId);
    try {
      // Load basic profile
      const { data: profileData, error: profileError } = await supabase
        .from('profiles')
        .select('*')
        .eq('id', userId)
        .maybeSingle();

      if (profileError && profileError.code !== 'PGRST116') {
        console.error('Error loading profile:', profileError);
        setLoading(false);
        return;
      }

      if (!profileData) {
        console.log('Profile not found, creating new profile');
        const email = userEmail || user?.email || '';
        
        const { data: newProfile, error: createError } = await supabase
          .from('profiles')
          .insert({
            id: userId,
            email: email,
            user_role: 'gym_user'
          })
          .select()
          .maybeSingle();

        if (createError) {
          console.error('Error creating profile:', createError);
          // Don't block the app if profile creation fails
          setProfile(null);
          setLoading(false);
          return;
        }
        
        if (newProfile) {
          console.log('Profile created:', newProfile);
          setProfile(newProfile);
        }
      } else {
        console.log('Profile loaded:', profileData);
        setProfile(profileData);
      }

      // Load gym user profile if user is a gym_user
      const currentProfile = profileData;
      if (currentProfile?.user_role === 'gym_user') {
        const { data: gymData, error: gymError } = await supabase
          .from('gym_user_profiles')
          .select('*')
          .eq('id', userId)
          .maybeSingle();

        if (gymError && gymError.code !== 'PGRST116') {
          console.error('Error loading gym profile:', gymError);
          setGymProfile(null);
        } else if (!gymData) {
          console.log('Gym profile not found, creating new gym profile');
          const { data: newGymProfile, error: createGymError } = await supabase
            .from('gym_user_profiles')
            .insert({ id: userId })
            .select()
            .maybeSingle();

          if (createGymError) {
            console.error('Error creating gym profile:', createGymError);
            setGymProfile(null);
          } else if (newGymProfile) {
            console.log('Gym profile created:', newGymProfile);
            setGymProfile(newGymProfile);
          }
        } else {
          console.log('Gym profile loaded:', gymData);
          setGymProfile(gymData);
        }
      }
    } catch (error) {
      console.error('Error in loadUserProfile:', error);
    } finally {
      console.log('Setting loading to false');
      setLoading(false);
    }
  };

  const refreshProfile = async () => {
    if (user) {
      setLoading(true);
      await loadUserProfile(user.id, user.email);
    }
  };

  useEffect(() => {
    console.log('AuthProvider useEffect - initializing');
    
    // Set up auth state listener FIRST to avoid missing events
    const {
      data: { subscription },
    } = supabase.auth.onAuthStateChange((event, session) => {
      console.log('Auth state changed:', event, session?.user?.id);
      setSession(session);
      setUser(session?.user ?? null);
      
      // Use setTimeout to defer profile loading and prevent deadlocks
      if (session?.user) {
        setTimeout(() => {
          loadUserProfile(session.user.id, session.user.email);
        }, 0);
      } else {
        setProfile(null);
        setGymProfile(null);
        console.log('No user, setting loading to false');
        setLoading(false);
      }
    });

    // Get initial session AFTER setting up the listener
    supabase.auth.getSession().then(({ data: { session } }) => {
      console.log('Initial session:', session?.user?.id);
      setSession(session);
      setUser(session?.user ?? null);
      
      if (session?.user) {
        loadUserProfile(session.user.id, session.user.email);
      } else {
        console.log('No session, setting loading to false');
        setLoading(false);
      }
    }).catch((error) => {
      console.error('Error getting initial session:', error);
      setLoading(false);
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
