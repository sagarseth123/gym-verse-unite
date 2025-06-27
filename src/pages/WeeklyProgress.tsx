import { useEffect, useState, useCallback } from 'react';
import { supabase } from '@/integrations/supabase/client';
import { useAuth } from '@/hooks/useAuth';
import { Card, CardHeader, CardTitle, CardContent, CardDescription } from '@/components/ui/card';
import { Progress } from '@/components/ui/progress';
import { Badge } from '@/components/ui/badge';
import { Button } from '@/components/ui/button';
import { Loader2, TrendingUp, Dumbbell, Brain, Target, Calendar, CheckCircle } from 'lucide-react';
import { startOfWeek, addDays, format, isToday } from 'date-fns';
import { Dialog, DialogContent, DialogHeader, DialogTitle } from '@/components/ui/dialog';
import { PieChart, Pie, Cell, Tooltip, ResponsiveContainer } from 'recharts';
import { LineChart, Line, XAxis, YAxis, CartesianGrid, Legend } from 'recharts';
import { FITNESS_GOAL_CATEGORIES, Exercise } from '@/types/fitness';
import { ExerciseDetailModal } from '@/components/fitness/ExerciseDetailModal';
import { toast } from '@/components/ui/use-toast';
import { Textarea } from '@/components/ui/textarea';
import { Input } from '@/components/ui/input';

// Utility to get correct Supabase Edge Function URL
function getSupabaseFunctionUrl(functionName: string) {
  const isLocal = window.location.hostname === 'localhost' || window.location.hostname === '127.0.0.1';
  const baseUrl = isLocal
    ? 'http://127.0.0.1:54321/functions/v1'
    : 'https://<your-project-ref>.functions.supabase.co'; // TODO: Replace <your-project-ref> with your actual project ref
  return `${baseUrl}/${functionName}`;
}

export default function WeeklyProgress() {
    const { user } = useAuth();
    const [weeklyPlan, setWeeklyPlan] = useState<any>(null);
    const [trackLoading, setTrackLoading] = useState(true);
    const [trackError, setTrackError] = useState<string | null>(null);
    const [weeklyWorkouts, setWeeklyWorkouts] = useState<any[]>([]);
    const [completedCount, setCompletedCount] = useState(0);
    const [plannedCount, setPlannedCount] = useState(0);
    const [aiFeedback, setAIFeedback] = useState<string>('');
    const [aiLoading, setAILoading] = useState(false);
    const [hypertrophyAnalytics, setHypertrophyAnalytics] = useState<any>(null);
    const [hypertrophyLoading, setHypertrophyLoading] = useState(false);
    const [hypertrophyError, setHypertrophyError] = useState<string | null>(null);
    const [nutritionFeedback, setNutritionFeedback] = useState<any>(null);
    const [nutritionLoading, setNutritionLoading] = useState(false);
    const [nutritionError, setNutritionError] = useState<string | null>(null);
    const [chatOpen, setChatOpen] = useState(false);
    const [chatInput, setChatInput] = useState('');
    const [chatHistory, setChatHistory] = useState<{ role: 'user' | 'ai', message: string }[]>([]);
    const [chatLoading, setChatLoading] = useState(false);
    const [bodyMeasurements, setBodyMeasurements] = useState<any[]>([]);
    const [bodyWeight, setBodyWeight] = useState('');
    const [bodyFat, setBodyFat] = useState('');
    const [bodyLoading, setBodyLoading] = useState(false);
    const [wearablesLog, setWearablesLog] = useState<any[]>([]);
    const [steps, setSteps] = useState('');
    const [sleep, setSleep] = useState('');
    const [heartRate, setHeartRate] = useState('');
    const [wearablesLoading, setWearablesLoading] = useState(false);
    const [nutritionEntries, setNutritionEntries] = useState<any[]>([]);
    const [foodName, setFoodName] = useState('');
    const [quantity, setQuantity] = useState('');
    const [mealType, setMealType] = useState('');
    const [nutritionLoading2, setNutritionLoading2] = useState(false);
    const [nutritionFoods, setNutritionFoods] = useState<any[]>([]);
    const [goals, setGoals] = useState<any>({});
    const [goalInputs, setGoalInputs] = useState({ workouts: '', weight: '', streak: '' });
    const [goalsLoading, setGoalsLoading] = useState(false);
    const [motivationMsg, setMotivationMsg] = useState('');
    const [selectedDay, setSelectedDay] = useState<number>(new Date().getDay() === 0 ? 6 : new Date().getDay() - 1); // 0=Monday
    const [selectedExercise, setSelectedExercise] = useState<any>(null);
    const [exerciseModalOpen, setExerciseModalOpen] = useState(false);
    const [workoutTracking, setWorkoutTracking] = useState<{ [key: string]: { sets: { reps: string; weight: string; duration: string }[], notes: string, calories: number } }>({});
    const [showWorkoutForm, setShowWorkoutForm] = useState<{ [key: string]: boolean }>({});
    const [dailyStats, setDailyStats] = useState<{ [key: string]: any }>({});
    const [measurements, setMeasurements] = useState<{ [key: string]: number }>({});
    const [showMeasurementForm, setShowMeasurementForm] = useState(false);
    const [gymProfile, setGymProfile] = useState<any>(null);

    const fetchBodyMeasurements = useCallback(async () => {
        if (!user) return;
        try {
            const { data, error } = await supabase
                .from('user_body_measurements')
                .select('*')
                .eq('user_id', user.id)
                .order('date', { ascending: false })
                .limit(1);

            if (error) throw error;
            if (data && data.length > 0) {
                setGymProfile(data[0]);
            }
        } catch (error) {
            console.error('Error fetching body measurements:', error);
        }
    }, [user]);

    const fetchPlanAndWorkouts = useCallback(async () => {
        if (!user) {
            setTrackError('User not authenticated. Please log in again.');
            console.error('User is undefined in fetchPlanAndWorkouts');
            return;
        }
        setTrackLoading(true);
        setTrackError(null);
        try {
            const weekStartDate = startOfWeek(new Date(), { weekStartsOn: 1 });
            const weekStart = format(weekStartDate, 'yyyy-MM-dd');
            console.log('Fetching plan for user:', user.id, 'weekStart:', weekStart);
            const { data: planRows, error: planError } = await supabase
                .from('user_weekly_plans')
                .select('*')
                .eq('user_id', user.id)
                .eq('week_start', weekStart);
            console.log('Raw planRows:', planRows, 'planError:', planError);
            if (planError && planError.code !== 'PGRST116') {
                console.error('Supabase planError:', planError);
                throw planError;
            }
            if (Array.isArray(planRows) && planRows.length > 1) {
                console.warn('Multiple user_weekly_plans rows found for user and week:', planRows);
            }
            setWeeklyPlan(planRows && planRows[0]?.plan_data ? planRows[0].plan_data : null);
            const weekDates = Array.from({ length: 7 }, (_, i) => format(addDays(weekStartDate, i), 'yyyy-MM-dd'));
            const { data: workouts, error: workoutsError } = await supabase
                .from('user_workouts')
                .select('*')
                .eq('user_id', user.id)
                .in('workout_date', weekDates);
            if (workoutsError) {
                console.error('Supabase workoutsError:', workoutsError);
                throw workoutsError;
            }
            setWeeklyWorkouts(workouts || []);
            const completedDays = new Set((workouts || []).map(w => w.workout_date));
            setCompletedCount(completedDays.size);
            if (planRows && planRows[0]?.plan_data?.exercisePlan) {
                const planned = Object.values(planRows[0].plan_data.exercisePlan).filter((d: any) => d.exercises && d.exercises.length > 0).length;
                setPlannedCount(planned);
            }
        } catch (err: any) {
            setTrackError(err.message || 'Failed to load data');
            console.error('fetchPlanAndWorkouts error:', err);
        } finally {
            setTrackLoading(false);
        }
    }, [user]);

    const getAIFeedback = useCallback(async () => {
        if (!user || completedCount === 0) return;
        setAILoading(true);
        try {
            const summary = {
                completedWorkouts: completedCount,
                plannedWorkouts: plannedCount,
                workouts: weeklyWorkouts.map(w => ({ exercise: w.exercise_id, date: w.workout_date, completed: w.completed })),
                goal: weeklyPlan?.goal,
            };
            const prompt = `Give me a concise weekly fitness feedback summary for this user data: ${JSON.stringify(summary)}. Keep it under 100 words.`;
            const { data, error } = await supabase.functions.invoke('ai-chat-coach', { body: { prompt } });
            if (error) throw error;
            setAIFeedback(data?.answer || 'No feedback available.');
        } catch (err) {
            console.error('AI Feedback error:', err);
            setAIFeedback('AI feedback is currently unavailable.');
        } finally {
            setAILoading(false);
        }
    }, [user, completedCount, plannedCount, weeklyWorkouts, weeklyPlan]);

    useEffect(() => {
        console.log('Calling fetchPlanAndWorkouts, user:', user);
        fetchBodyMeasurements();
        fetchPlanAndWorkouts();
    }, [fetchBodyMeasurements, fetchPlanAndWorkouts]);

    useEffect(() => {
        if (completedCount > 0) {
            getAIFeedback();
        }
    }, [completedCount, getAIFeedback]);

    const handleSetInputChange = (exerciseId: string, setIndex: number, field: string, value: string) => {
        setWorkoutTracking(prev => {
            const newSets = [...(prev[exerciseId]?.sets || [])];
            newSets[setIndex] = { ...newSets[setIndex], [field]: value };
            return { ...prev, [exerciseId]: { ...(prev[exerciseId] || { notes: '', calories: 0 }), sets: newSets } };
        });
    };

    const addSet = (exerciseId: string) => {
        setWorkoutTracking(prev => ({ ...prev, [exerciseId]: { ...(prev[exerciseId] || { notes: '', calories: 0 }), sets: [...(prev[exerciseId]?.sets || []), { reps: '', weight: '', duration: '' }] } }));
    };

    const removeSet = (exerciseId: string, setIndex: number) => {
        setWorkoutTracking(prev => ({ ...prev, [exerciseId]: { ...prev[exerciseId], sets: prev[exerciseId].sets.filter((_, i) => i !== setIndex) } }));
    };

    const handleNoteChange = (exerciseId: string, value: string) => {
        setWorkoutTracking(prev => ({ ...prev, [exerciseId]: { ...(prev[exerciseId] || { sets: [], calories: 0 }), notes: value } }));
    };

    const calculateCaloriesBurned = useCallback((sets: { reps: number; weight: number; duration: number }[]) => {
        const userWeight = gymProfile?.weight || 70;
        let totalWorkDone = 0;
        let totalDuration = 0;
        sets.forEach(set => {
            totalWorkDone += (set.reps || 0) * (set.weight || 0);
            totalDuration += (set.duration || 0);
        });
        const estimatedDuration = totalDuration > 0 ? totalDuration : sets.length * 2;
        const metValue = totalWorkDone > 0 ? 5.5 : 3.5;
        const timeBasedCalories = (metValue * userWeight * estimatedDuration) / 60;
        const workBasedCalories = totalWorkDone / 9;
        const bmrContribution = estimatedDuration * 1.2;
        return Math.round(Math.max(timeBasedCalories + workBasedCalories + bmrContribution, 1));
    }, [gymProfile]);

    const handleSaveExercise = (exerciseId: string) => {
        const sets = workoutTracking[exerciseId]?.sets || [];
        const calories = calculateCaloriesBurned(sets.map(s => ({ reps: Number(s.reps) || 0, weight: Number(s.weight) || 0, duration: Number(s.duration) || 0 })));
        setWorkoutTracking(prev => ({ ...prev, [exerciseId]: { ...prev[exerciseId], calories } }));
        setShowWorkoutForm(prev => ({ ...prev, [exerciseId]: false }));
    };

    const saveWorkoutData = async (date: string, exercises: any[]) => {
        if (!user) return;
        try {
            const workoutData = exercises
                .filter(ex => (workoutTracking[ex.id || ex.name]?.sets || []).length > 0)
                .map(ex => {
                    const tracking = workoutTracking[ex.id || ex.name];
                    const sets = tracking.sets || [];
                    const totalReps = sets.reduce((sum, set) => sum + (Number(set.reps) || 0), 0);
                    const totalWeight = sets.reduce((sum, set) => sum + ((Number(set.reps) || 0) * (Number(set.weight) || 0)), 0);
                    const avgWeight = totalReps > 0 ? totalWeight / totalReps : 0;
                    const totalDuration = sets.reduce((sum, set) => sum + (Number(set.duration) || 0), 0);
                    return { user_id: user.id, exercise_id: ex.id || ex.name, workout_date: date, sets: sets.length, reps: totalReps, weight: avgWeight, duration: totalDuration, calories_burned: tracking.calories || 0, notes: tracking.notes || '', completed: true };
                });

            if (workoutData.length === 0) {
                toast({ title: "No data to save", description: "Track at least one set for an exercise." });
                return;
            }

            const { error } = await supabase.from('user_workouts').upsert(workoutData, { onConflict: 'user_id,exercise_id,workout_date' });
            if (error) throw error;

            toast({ title: 'Workout Saved!', description: `Workout for ${date} has been saved successfully.` });
            fetchPlanAndWorkouts();
        } catch (err: any) {
            toast({ title: 'Error', description: err.message || 'Failed to save workout data', variant: 'destructive' });
        }
    };

    const getExerciseDetails = (ex: any): Exercise => ({
        id: ex.id || ex.name,
        name: ex.name,
        muscle_groups: ex.muscle_groups || [],
        equipment: ex.equipment,
        difficulty: ex.difficulty,
        instructions: ex.instructions || [],
        video_url: ex.video_url,
        image_url: ex.image_url,
    });
    
    const weekStartDate = startOfWeek(new Date(), { weekStartsOn: 1 });
    const days = Array.from({ length: 7 }, (_, i) => ({
        name: format(addDays(weekStartDate, i), 'EEE'),
        date: format(addDays(weekStartDate, i), 'yyyy-MM-dd'),
        dayName: format(addDays(weekStartDate, i), 'eeee')
    }));

    return (
        <div className="max-w-5xl mx-auto py-8 px-4">
            <h1 className="text-3xl font-bold mb-6 flex items-center gap-3"><TrendingUp className="h-8 w-8 text-green-600" /> Weekly Progress & AI Coach</h1>
            <div className="grid grid-cols-1 md:grid-cols-2 gap-6 mb-8">
                <Card>
                    <CardHeader><CardTitle>Progress Overview</CardTitle><CardDescription>Track your weekly completion</CardDescription></CardHeader>
                    <CardContent>
                        <div className="flex items-center gap-4 mb-4">
                            <Progress value={plannedCount > 0 ? (completedCount / plannedCount) * 100 : 0} className="w-2/3" />
                            <span className="text-lg font-bold">{completedCount}/{plannedCount}</span>
                        </div>
                        <div className="text-sm text-gray-600">Workouts completed this week</div>
                    </CardContent>
                </Card>
                <Card>
                    <CardHeader><CardTitle>AI Insights & Suggestions</CardTitle><CardDescription>Personalized feedback powered by Gemini AI</CardDescription></CardHeader>
                    <CardContent>
                        {aiLoading ? <div className="flex items-center gap-2"><Loader2 className="animate-spin" /> Loading AI feedback...</div> : <div className="text-blue-900 text-base whitespace-pre-line">{aiFeedback || "Complete a workout to get feedback."}</div>}
                    </CardContent>
                </Card>
            </div>

            <Card className="mb-8">
                <CardHeader><CardTitle>Workout Timeline</CardTitle></CardHeader>
                <CardContent>
                    <div className="flex justify-center mb-6">
                        <div className="flex space-x-1 bg-gray-200 p-1 rounded-full">
                            {days.map((day, index) => (
                                <button key={index} onClick={() => setSelectedDay(index)} className={`px-4 py-2 text-sm font-medium rounded-full transition-colors ${selectedDay === index ? 'bg-white text-gray-900 shadow' : 'text-gray-600 hover:bg-gray-300'}`}>
                                    {day.name}
                                </button>
                            ))}
                        </div>
                    </div>

                    {trackLoading ? <div className="flex justify-center items-center h-40"><Loader2 className="animate-spin h-8 w-8 text-gray-500" /></div>
                    : trackError ? <div className="text-red-600 text-center">{trackError}</div>
                    : !weeklyPlan?.exercisePlan ? (
                        <div className="text-center text-gray-500 py-8">
                            <p>No workout plan found for this week.</p>
                            <Button onClick={() => window.location.href='/dashboard?ai=1'} className="mt-4">Generate a New Plan</Button>
                        </div>
                    ) : (
                        <div>
                            {(() => {
                                const dayInfo = days[selectedDay];
                                const dayPlan = weeklyPlan.exercisePlan[dayInfo.dayName.toLowerCase()] || {};
                                return (
                                    <div>
                                        <h3 className="text-lg font-semibold mb-2 flex items-center gap-2">
                                            {dayInfo.dayName}'s Workout
                                            {isToday(new Date(dayInfo.date.replace(/-/g, '/'))) && <Badge variant="secondary">Today</Badge>}
                                        </h3>
                                        {dayPlan.restday ? <div className="text-center py-6 bg-gray-50 rounded-lg"><p className="font-semibold text-green-700">Rest Day</p><p className="text-sm text-gray-600">Time to recover!</p></div>
                                        : (dayPlan.exercises || []).length > 0 ? (
                                            <div className="space-y-4">
                                                {dayPlan.exercises.map((ex: any, index: number) => {
                                                    const exerciseId = ex.id || ex.name;
                                                    const details = getExerciseDetails(ex);
                                                    const trackingInfo = workoutTracking[exerciseId];
                                                    return (
                                                        <div key={index} className="p-4 border rounded-lg bg-white shadow-sm">
                                                            <div className="grid grid-cols-[1fr_auto] gap-4 items-start">
                                                                <div>
                                                                    <p className="font-semibold">{details.name}</p>
                                                                    <div className="flex items-center gap-2 text-xs text-gray-500 mt-1">
                                                                        <Dumbbell className="h-3 w-3" /><span>{details.equipment}</span><span className="text-gray-300">|</span><Target className="h-3 w-3" /><span>{details.muscle_groups?.join(', ')}</span>
                                                                    </div>
                                                                    {showWorkoutForm[exerciseId] ? (
                                                                        <div className="mt-4 p-4 bg-gray-100 rounded-lg">
                                                                            <h4 className="font-semibold mb-3">Log Workout</h4>
                                                                            <div className="space-y-3 mb-3">
                                                                                {(trackingInfo?.sets || []).map((set, setIndex) => (
                                                                                    <div key={setIndex} className="flex items-center gap-2 p-2 bg-gray-200 rounded">
                                                                                        <span className="font-medium text-sm">Set {setIndex + 1}</span>
                                                                                        <Input type="number" placeholder="Reps" className="w-20" value={set.reps} onChange={e => handleSetInputChange(exerciseId, setIndex, 'reps', e.target.value)} />
                                                                                        <Input type="number" placeholder="Weight (kg)" className="w-24" value={set.weight} onChange={e => handleSetInputChange(exerciseId, setIndex, 'weight', e.target.value)} />
                                                                                        <Input type="number" placeholder="Time (min)" className="w-24" value={set.duration} onChange={e => handleSetInputChange(exerciseId, setIndex, 'duration', e.target.value)} />
                                                                                        <Button size="sm" variant="ghost" onClick={() => removeSet(exerciseId, setIndex)}>✕</Button>
                                                                                    </div>
                                                                                ))}
                                                                            </div>
                                                                            <Button size="sm" variant="outline" onClick={() => addSet(exerciseId)} className="mb-3">Add Set</Button>
                                                                            <Textarea placeholder="Notes..." value={trackingInfo?.notes || ''} onChange={e => handleNoteChange(exerciseId, e.target.value)} className="mb-3" />
                                                                            <div className="flex justify-end gap-2">
                                                                                <Button size="sm" variant="ghost" onClick={() => setShowWorkoutForm(prev => ({ ...prev, [exerciseId]: false }))}>Cancel</Button>
                                                                                <Button size="sm" onClick={() => handleSaveExercise(exerciseId)}>Save Exercise</Button>
                                                                            </div>
                                                                        </div>
                                                                    ) : (trackingInfo?.sets || []).length > 0 && (
                                                                        <div className="mt-3 p-3 bg-green-50 rounded-lg border border-green-200">
                                                                            <div className="flex items-center gap-2 mb-2"><CheckCircle className="h-4 w-4 text-green-600" /><span className="font-medium text-green-800">Completed</span></div>
                                                                            <div className="grid grid-cols-2 md:grid-cols-4 gap-2 text-sm">
                                                                                <div><strong>Sets:</strong> {trackingInfo.sets.length}</div>
                                                                                <div><strong>Total Reps:</strong> {trackingInfo.sets.reduce((acc, s) => acc + Number(s.reps), 0)}</div>
                                                                                <div><strong>Avg Weight:</strong> {(trackingInfo.sets.reduce((acc, s) => acc + Number(s.weight), 0) / (trackingInfo.sets.length || 1)).toFixed(1)}kg</div>
                                                                                <div><strong>Calories:</strong> {trackingInfo.calories || 0}</div>
                                                                            </div>
                                                                            {trackingInfo.notes && <div className="mt-2 text-sm text-gray-600"><strong>Notes:</strong> {trackingInfo.notes}</div>}
                                                                        </div>
                                                                    )}
                                                                </div>
                                                                <div className="flex flex-col gap-2">
                                                                    <Button size="sm" variant="outline" onClick={() => { setSelectedExercise(details); setExerciseModalOpen(true); }}>Details</Button>
                                                                    <Button size="sm" onClick={() => {setShowWorkoutForm(prev => ({ ...prev, [exerciseId]: true })); if (!workoutTracking[exerciseId]) addSet(exerciseId);}}>
                                                                        { (trackingInfo?.sets || []).length > 0 ? 'Edit' : 'Track Workout' }
                                                                    </Button>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    );
                                                })}
                                                <div className="mt-6 p-4 bg-gray-50 rounded-lg border">
                                                    <div className="flex items-center justify-between">
                                                        <div><h5 className="font-medium">Daily Summary</h5><p className="text-sm text-gray-600">Completed: {dayPlan.exercises.filter((ex: any) => (workoutTracking[ex.id || ex.name]?.sets || []).length > 0).length}/{dayPlan.exercises.length}</p></div>
                                                        <Button onClick={() => saveWorkoutData(dayInfo.date, dayPlan.exercises)} disabled={(dayPlan.exercises.filter((ex: any) => (workoutTracking[ex.id || ex.name]?.sets || []).length > 0).length) === 0}>Save All</Button>
                                                    </div>
                                                </div>
                                            </div>
                                        ) : <div className="text-gray-500 mb-2">No exercises planned.</div>}
                                    </div>
                                )
                            })()}
                        </div>
                    )}
                </CardContent>
            </Card>
            {selectedExercise && <ExerciseDetailModal exercise={selectedExercise} isOpen={exerciseModalOpen} onClose={() => setExerciseModalOpen(false)} />}
        </div>
    );
} 