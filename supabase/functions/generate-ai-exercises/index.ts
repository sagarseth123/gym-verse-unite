
import "https://deno.land/x/xhr@0.1.0/mod.ts";
import { serve } from "https://deno.land/std@0.168.0/http/server.ts";
import { createClient } from 'https://esm.sh/@supabase/supabase-js@2.7.1';

const corsHeaders = {
  'Access-Control-Allow-Origin': '*',
  'Access-Control-Allow-Headers': 'authorization, x-client-info, apikey, content-type',
};

serve(async (req) => {
  if (req.method === 'OPTIONS') {
    return new Response(null, { headers: corsHeaders });
  }

  try {
    const { goalCategory, forceRefresh = false } = await req.json();
    
    const supabaseUrl = Deno.env.get('SUPABASE_URL')!;
    const supabaseServiceKey = Deno.env.get('SUPABASE_SERVICE_ROLE_KEY')!;
    const supabase = createClient(supabaseUrl, supabaseServiceKey);
    
    const geminiApiKey = Deno.env.get('GEMINI_API_KEY');
    if (!geminiApiKey) {
      throw new Error('GEMINI_API_KEY not configured');
    }

    // Check if we have cached exercises for this goal category (unless force refresh)
    if (!forceRefresh) {
      const { data: cachedExercises } = await supabase
        .from('ai_exercises_cache')
        .select('*')
        .eq('goal_category', goalCategory)
        .gte('generated_at', new Date(Date.now() - 24 * 60 * 60 * 1000).toISOString()); // Cache for 24 hours

      if (cachedExercises && cachedExercises.length > 0) {
        console.log('Returning cached exercises for:', goalCategory);
        return new Response(JSON.stringify({ 
          exercises: cachedExercises.map(cache => cache.exercise_data),
          source: 'cache',
          success: true 
        }), {
          headers: { ...corsHeaders, 'Content-Type': 'application/json' },
        });
      }
    }

    const goalCategoryMap = {
      'strength-building': {
        name: 'Strength Training & Muscle Building',
        focus: 'compound movements, progressive overload, muscle hypertrophy',
        equipment: 'barbells, dumbbells, machines, cables'
      },
      'weight-loss': {
        name: 'Weight Loss & Fat Burning',
        focus: 'high-intensity cardio, metabolic training, calorie burning',
        equipment: 'bodyweight, cardio machines, light weights'
      },
      'calisthenics': {
        name: 'Calisthenics & Bodyweight',
        focus: 'bodyweight movements, functional strength, mobility',
        equipment: 'bodyweight, pull-up bars, parallel bars'
      },
      'bulking': {
        name: 'Bulking & Mass Gain',
        focus: 'heavy compound lifts, mass building, strength gains',
        equipment: 'barbells, plates, power racks'
      },
      'functional': {
        name: 'Functional Fitness',
        focus: 'real-world movements, athletic performance, coordination',
        equipment: 'kettlebells, medicine balls, resistance bands'
      },
      'flexibility': {
        name: 'Flexibility & Recovery',
        focus: 'stretching, mobility, relaxation, injury prevention',
        equipment: 'yoga mats, blocks, straps'
      }
    };

    const categoryInfo = goalCategoryMap[goalCategory as keyof typeof goalCategoryMap] || goalCategoryMap['strength-building'];

    const prompt = `Generate a comprehensive list of 25 exercises specifically designed for ${categoryInfo.name}.

Focus on: ${categoryInfo.focus}
Primary equipment: ${categoryInfo.equipment}

For each exercise, provide detailed information in the following JSON format:

{
  "exercises": [
    {
      "id": "unique-exercise-id",
      "name": "Exercise Name",
      "category": "${goalCategory}",
      "muscle_groups": ["primary_muscle", "secondary_muscle"],
      "equipment_needed": ["equipment1", "equipment2"],
      "difficulty": "beginner|intermediate|advanced",
      "instructions": "Step-by-step execution instructions",
      "benefits": ["benefit1", "benefit2", "benefit3"],
      "common_mistakes": ["mistake1", "mistake2"],
      "progressions": ["easier_variation", "harder_variation"],
      "modifications": ["modification1", "modification2"],
      "safety_tips": ["safety_tip1", "safety_tip2"],
      "sets_reps_guidance": "Recommended sets and reps",
      "rest_periods": "Recommended rest between sets",
      "tips": "Additional performance tips"
    }
  ]
}

Requirements:
1. Include exercises for all difficulty levels (beginner, intermediate, advanced)
2. Vary equipment requirements (some bodyweight, some with equipment)
3. Target different muscle groups within the category
4. Provide practical, actionable instructions
5. Include safety considerations
6. Make exercises progressive and complementary
7. Ensure all exercise names are unique and specific

Generate 25 high-quality exercises that would form a comprehensive training system for someone focused on ${categoryInfo.name}.`;

    const response = await fetch(`https://generativelanguage.googleapis.com/v1beta/models/gemini-pro:generateContent?key=${geminiApiKey}`, {
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
          maxOutputTokens: 8192,
        }
      })
    });

    if (!response.ok) {
      const errorData = await response.text();
      console.error('Gemini API error:', errorData);
      throw new Error(`Gemini API error: ${response.status}`);
    }

    const data = await response.json();
    
    if (!data.candidates?.[0]?.content?.parts?.[0]?.text) {
      throw new Error('Invalid response from Gemini API');
    }

    const generatedText = data.candidates[0].content.parts[0].text;
    
    try {
      const jsonMatch = generatedText.match(/\{[\s\S]*\}/);
      if (jsonMatch) {
        const parsedResponse = JSON.parse(jsonMatch[0]);
        
        if (parsedResponse.exercises && Array.isArray(parsedResponse.exercises)) {
          // Cache the generated exercises
          const cachePromises = parsedResponse.exercises.map(exercise => 
            supabase.from('ai_exercises_cache').insert({
              goal_category: goalCategory,
              exercise_name: exercise.name,
              exercise_data: exercise
            })
          );
          
          await Promise.all(cachePromises);
          
          console.log(`Cached ${parsedResponse.exercises.length} exercises for ${goalCategory}`);
          
          return new Response(JSON.stringify({ 
            exercises: parsedResponse.exercises,
            source: 'ai-generated',
            success: true 
          }), {
            headers: { ...corsHeaders, 'Content-Type': 'application/json' },
          });
        }
      }
    } catch (parseError) {
      console.error('JSON parsing failed:', parseError);
      throw new Error('Failed to parse AI response');
    }
    
    throw new Error('No valid exercises generated');

  } catch (error) {
    console.error('Error in generate-ai-exercises function:', error);
    return new Response(JSON.stringify({ 
      error: error.message,
      success: false 
    }), {
      status: 500,
      headers: { ...corsHeaders, 'Content-Type': 'application/json' },
    });
  }
});
