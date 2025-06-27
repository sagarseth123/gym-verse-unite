import "https://deno.land/x/xhr@0.1.0/mod.ts";
import { serve } from "https://deno.land/std@0.168.0/http/server.ts";
import { createClient } from 'https://esm.sh/@supabase/supabase-js@2.7.1';
import { config } from './config.ts';

const corsHeaders = {
  'Access-Control-Allow-Origin': '*',
  'Access-Control-Allow-Headers': 'authorization, x-client-info, apikey, content-type',
};

serve(async (req) => {
  let allowedNames: string[] = [];
  if (req.method === 'OPTIONS') {
    return new Response(null, { headers: corsHeaders });
  }

  try {
    const { type, userProfile, exercise, category, allowedExercises, preferences } = await req.json();
    
    const geminiApiKey = config.geminiApiKey;
    if (!geminiApiKey) {
      throw new Error('GEMINI_API_KEY not configured');
    }

    let prompt = '';
    
    if (type === 'exercise_guidance') {
      prompt = `
Generate comprehensive exercise guidance for the following exercise:

Exercise Name: ${exercise.name}
Category: ${exercise.category}
Target Muscles: ${exercise.muscle_groups?.join(', ') || 'Not specified'}
Difficulty: ${exercise.difficulty_level || 'Not specified'}
Equipment: ${exercise.equipment_needed?.join(', ') || 'Not specified'}
Existing Instructions: ${exercise.existing_instructions || 'None provided'}

IMPORTANT: Output must be valid JSON. All values must be strings, numbers, or arrays. No unquoted words, no comments, no trailing commas. If a value is a phrase (like AMRAP), put it in double quotes.

Please provide detailed guidance in the following format (respond with a JSON object):

{
  "instructions": [
    "Step 1: Detailed instruction...",
    "Step 2: Next step...",
    // Continue with 5-8 detailed steps
  ],
  "benefits": [
    "Primary benefit related to muscle building/strength...",
    "Secondary benefit for functional movement...",
    "Benefit for specific fitness goals...",
    // 4-6 key benefits
  ],
  "commonMistakes": [
    "Most common form error to avoid...",
    "Safety mistake that could lead to injury...",
    "Efficiency mistake that reduces effectiveness...",
    // 3-5 common mistakes
  ],
  "progressions": [
    "Beginner progression or regression...",
    "Intermediate advancement...",
    "Advanced variation...",
    // 3-4 progression options
  ],
  "modifications": [
    "Modification for limited mobility...",
    "Equipment-free alternative...",
    "Easier variation for beginners...",
    // 3-4 modifications
  ],
  "safetyTips": [
    "Critical safety point...",
    "Warm-up recommendation...",
    "When to stop or rest...",
    // 3-4 safety tips
  ]
}

Focus on:
- Clear, actionable instructions
- Specific benefits for muscle development and fitness goals
- Practical safety advice
- Evidence-based progressions
- Accessible modifications

Make sure the guidance is professional, accurate, and suitable for fitness enthusiasts of all levels.
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

    const response = await fetch(`https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash:generateContent?key=${geminiApiKey}`, {
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
          temperature: 0.7,
          topK: 40,
          topP: 0.95,
          maxOutputTokens: 2048,
        }
      })
    });

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
    function parseGeminiPlan(raw) {
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
    return new Response(JSON.stringify({ 
      error: error.message,
      success: false 
    }), {
      status: 500,
      headers: { ...corsHeaders, 'Content-Type': 'application/json' },
    });
  }
});
