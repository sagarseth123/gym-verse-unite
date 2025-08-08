import "https://deno.land/x/xhr@0.1.0/mod.ts";
import { serve } from "https://deno.land/std@0.168.0/http/server.ts";
import { createClient } from 'https://esm.sh/@supabase/supabase-js@2.7.1';
import { config } from './config.ts';
import { corsHeaders, handleCors } from '../_shared/cors.ts';

// Utility to generate exercise image URL using a mapping approach
async function getExerciseImageUrl(name: string, description: string = '') {
  try {
    // Sanitize exercise name for URL
    const sanitizedName = name.toLowerCase()
      .replace(/[^a-z0-9]/g, '_')
      .replace(/_+/g, '_')
      .replace(/^_|_$/g, '');
    
    // Common exercise name mappings for better matching
    const exerciseMappings: { [key: string]: string } = {
      // Push-ups variations
      'push_ups': 'push_ups',
      'pushup': 'push_ups',
      'pushups': 'push_ups',
      // Pull-ups variations
      'pull_ups': 'pull_ups',
      'pullup': 'pull_ups',
      'pullups': 'pull_ups',
      // Squats variations
      'squats': 'squats',
      'squat': 'squats',
      'jump_squats': 'jump_squats',
      'jump_squat': 'jump_squats',
      'bodyweight_squats': 'squats',
      'bodyweight_squat': 'squats',
      'sumo_squat': 'sumo_deadlift',
      'barbel_squat': 'back_squats',
      'barbell_squat': 'back_squats',
      'front_squat': 'front_squats',
      // Bench press variations
      'bench_press': 'bench_press',
      'bench_presses': 'bench_press',
      'barbell_bench_press': 'bench_press',
      'chest_press': 'bench_press',
      'chest_press_incline': 'incline_bench_press',
      'chest_press_decline': 'decline_bench_press',
      'pec_fly': 'chest_fly',
      // Deadlift variations
      'deadlift': 'deadlift',
      'deadlifts': 'deadlift',
      'barbell_deadlift': 'deadlift',
      // Plank variations
      'plank': 'plank',
      'side_plank': 'side_plank',
      // Crunches variations
      'crunches': 'crunches',
      'crunch': 'crunches',
      // Leg raise
      'leg_raise': 'leg_raises',
      'leg_raises': 'leg_raises',
      // Shoulder press
      'shoulder_press': 'shoulder_press',
      'shoulder_presses': 'shoulder_press',
      // Lateral raise
      'lateral_raise': 'lateral_raise',
      // Tricep pushdown
      'tricep_pushdown': 'tricep_pushdown',
      // Overhead extension
      'overhead_extension': 'overhead_extension',
      // Lat pull down
      'lat_pull_down': 'lat_pulldowns',
      'lat_close_grip': 'lat_pulldowns',
      'lat_machine': 'lat_pulldowns',
      // Mid rowing
      'mid_rowing': 'rows',
      // Hyperextension
      'hyperextension': 'superman',
      // Biceps curl
      'biceps_curl': 'dumbbell_curls',
      'biceps_curl_barbel': 'dumbbell_curls',
      'biceps_machine': 'dumbbell_curls',
      // Hammer curl
      'hammer_curl': 'dumbbell_curls',
      // Barbell sides
      'barbell_sides': 'barbell_sides',
      // Dumbel sides
      'dumbel_sides': 'dumbel_sides',
      // Leg press
      'leg_press': 'leg_press',
      // Leg extension
      'leg_extension': 'leg_extension',
      // Leg curl
      'leg_curl': 'leg_curl',
      // Calves seated
      'calves_seated': 'calf_raises',
      // Calves standing
      'calves_standing': 'calf_raises',
      // Elliptical
      'eliptical': 'elliptical',
      // Cycling
      'cycling': 'cycling',
      // Front raise
      'front_raise': 'front_raise',
      // Rear delt
      'rear_delt': 'rear_delt',
      // Single head extension
      'single_head_extension': 'overhead_extension',
      // Triceps machine
      'triceps_machine': 'tricep_pushdown',
      // Chest fly
      'chest_fly': 'chest_fly',
    };
    
    // Try to find a matching exercise name
    const matchedName = exerciseMappings[sanitizedName] || sanitizedName;
    const imageUrl = `/images/exercise/${matchedName}.png`;
    
    // Check if the image exists by trying to validate it
    const imageExists = await validateImageUrl(imageUrl);
    if (imageExists) {
      return imageUrl;
    } else {
      // If the specific image doesn't exist, return default
      console.warn(`Image not found for exercise: ${name}, using default image`);
      return '/images/default.png';
    }
  } catch (err) {
    console.warn(`Failed to get image URL for ${name}:`, err);
    return '/images/default.png';
  }
}

// Function to validate image URL (basic check)
async function validateImageUrl(url: string): Promise<boolean> {
  try {
    // For serverless functions, we can't easily validate relative URLs
    // Instead, we'll use a simple approach based on available images
    const availableImages = [
      'push_ups', 'pull_ups', 'squats', 'bench_press', 'deadlift', 'plank',
      'burpees', 'lunges', 'mountain_climbers', 'jumping_jacks', 'sit_ups',
      'crunches', 'dumbbell_curls', 'shoulder_press', 'rows', 'lat_pulldowns', 'leg_press',
      'cycling', 'elliptical', 'leg_raises', 'superman', 'calf_raises', 'incline_bench_press',
      'decline_bench_press', 'back_squats', 'front_squats', 'sumo_deadlift', 'side_plank',
      // Add new images as you generate them:
      'lateral_raise', 'tricep_pushdown', 'overhead_extension', 'barbell_sides', 'dumbel_sides',
      'leg_extension', 'leg_curl', 'front_raise', 'rear_delt', 'chest_fly'
    ];
    // Extract the image name from the URL
    const imageName = url.replace('/images/exercise/', '').replace('.png', '');
    return availableImages.includes(imageName);
  } catch (error) {
    console.warn(`Failed to validate image URL: ${url}`, error);
    return false;
  }
}

serve(async (req) => {
  let allowedNames: string[] = [];
  
  // Handle CORS preflight requests
  const corsResponse = handleCors(req);
  if (corsResponse) {
    return new Response(null, { status: 204, headers: corsHeaders });
  }

  try {
    const { type, userProfile, exercise, category, allowedExercises, preferences } = await req.json();
    
    const geminiApiKey = config.geminiApiKey;
    if (!geminiApiKey) {
      throw new Error('GEMINI_API_KEY not configured');
    }

    let prompt = '';
    
    if (type === 'exercise_guidance') {
      // Create a more specific and detailed prompt for each exercise
      const exerciseName = exercise.name || 'Unknown Exercise';
      const category = exercise.category || 'General';
      const muscleGroups = exercise.muscle_groups?.join(', ') || 'Multiple muscle groups';
      const difficulty = exercise.difficulty_level || 'Intermediate';
      const equipment = exercise.equipment_needed?.join(', ') || 'Bodyweight';
      const existingInstructions = exercise.existing_instructions || 'None provided';
      
      prompt = `
You are a certified personal trainer and fitness expert. Generate comprehensive, SPECIFIC guidance for the exercise: "${exerciseName}".

EXERCISE DETAILS:
- Name: ${exerciseName}
- Category: ${category}
- Primary Muscles: ${muscleGroups}
- Difficulty Level: ${difficulty}
- Equipment Needed: ${equipment}
- Current Instructions: ${existingInstructions}

CRITICAL REQUIREMENTS:
1. Make ALL guidance SPECIFIC to "${exerciseName}" - do NOT provide generic advice
2. Reference the specific muscles (${muscleGroups}) in benefits and instructions
3. Consider the difficulty level (${difficulty}) when providing progressions
4. Account for equipment (${equipment}) in modifications
5. Output must be valid JSON with NO comments, NO trailing commas

Generate a JSON object with this exact structure:

{
  "instructions": [
    "Step 1: [Specific step for ${exerciseName}]",
    "Step 2: [Next specific step for ${exerciseName}]",
    "Step 3: [Continue with 5-8 detailed steps specific to ${exerciseName}]"
  ],
  "benefits": [
    "[Specific benefit for ${muscleGroups} development]",
    "[Functional benefit of ${exerciseName}]",
    "[Performance benefit of ${exerciseName}]",
    "[Health benefit specific to ${exerciseName}]"
  ],
  "commonMistakes": [
    "[Most common form error specific to ${exerciseName}]",
    "[Safety mistake unique to ${exerciseName}]",
    "[Efficiency mistake for ${exerciseName}]"
  ],
  "progressions": [
    "[Beginner variation of ${exerciseName}]",
    "[Intermediate advancement for ${exerciseName}]",
    "[Advanced version of ${exerciseName}]"
  ],
  "modifications": [
    "[Modification for ${exerciseName} with limited equipment]",
    "[Easier variation of ${exerciseName}]",
    "[Alternative for ${exerciseName} with injuries]"
  ],
  "safetyTips": [
    "[Critical safety point for ${exerciseName}]",
    "[Warm-up specific to ${exerciseName}]",
    "[When to stop ${exerciseName}]"
  ]
}

IMPORTANT: Every piece of guidance must be SPECIFIC to "${exerciseName}" and the ${muscleGroups} muscles. Do NOT provide generic fitness advice.
      `;
    } else {
      const goals = userProfile?.fitness_goals?.join(', ') || category || 'general fitness';
      const level = userProfile?.fitness_level || 'beginner';
      const height = userProfile?.height || 'not specified';
      const weight = userProfile?.weight || 'not specified';
      
      // Build preferences text
      let preferencesText = '';
      if (preferences) {
        preferencesText = `
User Preferences:
- Workout Days: ${preferences.workoutDays} days per week
- Preferred Workout Days: ${preferences.preferredDays.join(', ')}
- Rest Days: ${preferences.restDays.join(', ')}
- Workout Duration: ${preferences.workoutDuration} minutes
- Available Equipment: ${preferences.equipmentAvailable.join(', ')}
- Workout Time: ${preferences.workoutTime}
- Workout Type Focus: ${preferences.workoutType}
- Experience Level: ${preferences.experienceLevel}
- Intensity Level: ${preferences.intensity}
${preferences.injuries.length > 0 ? `- Injury Considerations: ${preferences.injuries.join(', ')}` : ''}
${preferences.specificGoals.length > 0 ? `- Specific Goals: ${preferences.specificGoals.join(', ')}` : ''}

IMPORTANT: Only schedule workouts on the preferred days (${preferences.preferredDays.join(', ')}). 
Mark the rest days (${preferences.restDays.join(', ')}) as rest days with no exercises.
Keep each workout session within ${preferences.workoutDuration} minutes.
Only use exercises that can be done with the available equipment: ${preferences.equipmentAvailable.join(', ')}.
Adjust intensity to ${preferences.intensity} level - use appropriate weights, reps, and rest periods.
${preferences.injuries.length > 0 ? `AVOID exercises that could aggravate: ${preferences.injuries.join(', ')}. Provide alternative exercises where needed.` : ''}
${preferences.specificGoals.length > 0 ? `Focus on exercises that support these specific goals: ${preferences.specificGoals.join(', ')}.` : ''}
`;
      }
      
      let allowedExercisesText = '';
      if (allowedExercises && Array.isArray(allowedExercises) && allowedExercises.length > 0) {
        allowedNames = allowedExercises.map((e: any) => e.name);
        allowedExercisesText = `\n\nYou MUST use ONLY the following exercises. Do not invent or use any other exercises.\nHere is the list (with metadata):\n${JSON.stringify(allowedExercises, null, 2)}\n`;
      }
      
      prompt = `
Create a personalized weekly fitness plan for:
- Goals: ${goals}
- Fitness Level: ${level}  
- Height: ${height}
- Weight: ${weight}
- Focus Group/Category: ${category || goals}
${preferencesText}
${allowedExercisesText}

IMPORTANT: Output must be valid JSON. All values must be strings, numbers, or arrays. No unquoted words, no comments, no trailing commas. If a value is a phrase (like AMRAP), put it in double quotes.

Please provide a structured 7-day plan with:
1. Daily workout focus (e.g., "Upper Body Strength", "Cardio", "Rest")
2. 3-5 specific exercises per workout day (choose only from the allowed list)
3. Sets, reps, and duration recommendations
4. Rest day activities
5. Weekly progression tips

Format as a JSON object with this structure:
{
  "plan": {
    "monday": {"focus": "...", "exercises": [...]},
    "tuesday": {"focus": "...", "exercises": [...]},
    // ... continue for all days
  },
  "tips": ["tip1", "tip2", ...]
}
      `;
    }

    // Gemini API call with retry logic
    async function fetchWithRetry(url: string, options: RequestInit, retries = 3, delay = 1000): Promise<Response> {
      let lastResponse: Response | undefined = undefined;
      for (let attempt = 0; attempt < retries; attempt++) {
        const response = await fetch(url, options);
        lastResponse = response;
        if (response.ok) return response;
        if (response.status === 503 && attempt < retries - 1) {
          // Wait before retrying
          await new Promise(res => setTimeout(res, delay));
          continue;
        }
        break;
      }
      if (!lastResponse) throw new Error('No response received from Gemini API');
      return lastResponse;
    }

    const geminiUrl = `https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash:generateContent?key=${geminiApiKey}`;
    const fetchOptions: RequestInit = {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify({
        contents: [{
          parts: [{
            text: prompt
          }]
        }],
        generationConfig: {
          temperature: 0.9,
          topK: 40,
          topP: 0.95,
          maxOutputTokens: 2048,
        }
      })
    };

    const response = await fetchWithRetry(geminiUrl, fetchOptions, 3, 1500);

    if (!response.ok) {
      const errorData = await response.text();
      console.error('Gemini API error:', errorData);
      throw new Error(`Gemini API error: ${response.status}`);
    }

    let data;
    try {
      data = await response.json();
    } catch (jsonErr) {
      const text = await response.text();
      console.error('Failed to parse Gemini API response as JSON:', text);
      throw new Error('Gemini API returned invalid JSON');
    }
    
    if (!data.candidates?.[0]?.content?.parts?.[0]?.text) {
      throw new Error('Invalid response from Gemini API');
    }

    const generatedText = data.candidates[0].content.parts[0].text;

    // Try to extract and parse JSON, even if it's in a code block
    function parseGeminiPlan(raw: string) {
      let rawStr = raw.trim();
      if (rawStr.startsWith('```json')) rawStr = rawStr.slice(7);
      if (rawStr.startsWith('```')) rawStr = rawStr.slice(3);
      if (rawStr.endsWith('```')) rawStr = rawStr.slice(0, -3);
      try {
        return JSON.parse(rawStr);
      } catch (e) {
        return null;
      }
    }

    let parsedResponse: any = null;
    try {
      // Try to extract JSON object from anywhere in the string
      const jsonMatch = generatedText.match(/\{[\s\S]*\}/);
      if (jsonMatch) {
        parsedResponse = parseGeminiPlan(jsonMatch[0]);
      }
    } catch (e) {
      parsedResponse = null;
    }

    if (type === 'exercise_guidance') {
      if (parsedResponse) {
        return new Response(JSON.stringify({ 
          guidance: parsedResponse,
          success: true 
        }), {
          headers: { ...corsHeaders, 'Content-Type': 'application/json' },
        });
      } else {
        return new Response(JSON.stringify({
          error: 'Failed to parse exercise guidance',
          success: false
        }), {
          status: 500,
          headers: { ...corsHeaders, 'Content-Type': 'application/json' },
        });
      }
    } else if (parsedResponse && parsedResponse.plan) {
      // After parsing the plan, filter out any exercises not in the allowed list as a safety net
      if (parsedResponse && parsedResponse.plan && Array.isArray(allowedNames) && allowedNames.length > 0) {
        for (const day of Object.keys(parsedResponse.plan)) {
          if (Array.isArray(parsedResponse.plan[day]?.exercises)) {
            parsedResponse.plan[day].exercises = parsedResponse.plan[day].exercises.filter(
              (ex: any) => allowedNames.includes(ex.name)
            );
          }
        }
      }
      
      // For each exercise, get the image URL
      async function addImagesToPlan(plan: any) {
        for (const day of Object.keys(plan)) {
          if (Array.isArray(plan[day]?.exercises)) {
            for (const ex of plan[day].exercises) {
              ex.imageUrl = await getExerciseImageUrl(ex.name, ex.description || '');
            }
          }
        }
        return plan;
      }

      parsedResponse.plan = await addImagesToPlan(parsedResponse.plan);
      
      // Normalized response
      let normalized = {
        exercisePlan: parsedResponse.plan,
        tips: parsedResponse.tips || [],
      };
      return new Response(JSON.stringify({
        data: normalized,
        success: true
      }), {
        headers: { ...corsHeaders, 'Content-Type': 'application/json' },
      });
    } else {
      // Fallback: return error and raw text
      return new Response(JSON.stringify({
        error: 'Failed to parse AI plan output as JSON',
        raw: generatedText,
        success: false
      }), {
        headers: { ...corsHeaders, 'Content-Type': 'application/json' },
      });
    }

  } catch (error) {
    console.error('Error in generate-fitness-plan function:', error);
    let message = 'Unknown error';
    if (typeof error === 'object' && error !== null && 'message' in error && typeof (error as any).message === 'string') {
      message = (error as any).message;
    } else if (typeof error === 'string') {
      message = error;
    }
    return new Response(JSON.stringify({ 
      error: message,
      success: false 
    }), {
      status: 500,
      headers: { ...corsHeaders, 'Content-Type': 'application/json' },
    });
  }
});
