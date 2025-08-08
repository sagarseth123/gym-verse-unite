import "https://deno.land/x/xhr@0.1.0/mod.ts";
import { serve } from "https://deno.land/std@0.168.0/http/server.ts";
import { createClient } from 'https://esm.sh/@supabase/supabase-js@2.7.1';
import { config } from './config.ts';
import { corsHeaders, handleCors } from '../_shared/cors.ts';

serve(async (req) => {
  // Handle CORS preflight requests
  const corsResponse = handleCors(req);
  if (corsResponse) {
    return corsResponse;
  }

  try {
    const { goalCategory, forceRefresh = false, exerciseCount = 25 } = await req.json();
    
    const { supabaseUrl, supabaseServiceKey, geminiApiKey } = config;
    if (!supabaseUrl || !supabaseServiceKey) {
      throw new Error('Supabase configuration missing in config.ts');
    }
    const supabase = createClient(supabaseUrl, supabaseServiceKey);

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

    const prompt = `Generate a comprehensive list of ${exerciseCount} exercises specifically designed for ${categoryInfo.name}.

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

Generate ${exerciseCount} high-quality exercises that would form a comprehensive training system for someone focused on ${categoryInfo.name}.`;

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
          maxOutputTokens: 8192,
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
    console.log('Raw Gemini response:', generatedText.substring(0, 500) + '...');
    
    // Try multiple parsing strategies
    let parsedResponse = null;
    
    // Strategy 1: Try to find JSON object in the response
    try {
      const jsonMatch = generatedText.match(/\{[\s\S]*\}/);
      if (jsonMatch) {
        parsedResponse = JSON.parse(jsonMatch[0]);
        console.log('Strategy 1 succeeded - found JSON object');
      }
    } catch (e: any) {
      console.log('Strategy 1 failed:', e?.message || 'Unknown error');
    }
    
    // Strategy 2: Try to extract JSON from code blocks
    if (!parsedResponse) {
      try {
        const codeBlockMatch = generatedText.match(/```(?:json)?\s*(\{[\s\S]*?\})\s*```/);
        if (codeBlockMatch) {
          parsedResponse = JSON.parse(codeBlockMatch[1]);
          console.log('Strategy 2 succeeded - found JSON in code block');
        }
      } catch (e: any) {
        console.log('Strategy 2 failed:', e?.message || 'Unknown error');
      }
    }
    
    // Strategy 3: Try to clean up the response and parse
    if (!parsedResponse) {
      try {
        let cleanedText = generatedText
          .replace(/^[^{]*/, '') // Remove everything before first {
          .replace(/[^}]*$/, '') // Remove everything after last }
          .trim();
        
        if (cleanedText.startsWith('{') && cleanedText.endsWith('}')) {
          parsedResponse = JSON.parse(cleanedText);
          console.log('Strategy 3 succeeded - cleaned text parsing');
        }
      } catch (e: any) {
        console.log('Strategy 3 failed:', e?.message || 'Unknown error');
      }
    }
    
    // Strategy 4: Try to find the largest JSON object in the response
    if (!parsedResponse) {
      try {
        const jsonMatches = generatedText.match(/\{[^{}]*(?:\{[^{}]*\}[^{}]*)*\}/g);
        if (jsonMatches && jsonMatches.length > 0) {
          // Find the largest JSON object
          const largestMatch = jsonMatches.reduce((largest: string, current: string) => 
            current.length > largest.length ? current : largest
          );
          parsedResponse = JSON.parse(largestMatch);
          console.log('Strategy 4 succeeded - found largest JSON object');
        }
      } catch (e: any) {
        console.log('Strategy 4 failed:', e?.message || 'Unknown error');
      }
    }
    
    // Strategy 5: Try to extract everything between the first { and last } (for large responses)
    if (!parsedResponse) {
      try {
        const firstBrace = generatedText.indexOf('{');
        const lastBrace = generatedText.lastIndexOf('}');
        
        if (firstBrace !== -1 && lastBrace !== -1 && lastBrace > firstBrace) {
          const jsonText = generatedText.substring(firstBrace, lastBrace + 1);
          parsedResponse = JSON.parse(jsonText);
          console.log('Strategy 5 succeeded - extracted from first to last brace');
        }
      } catch (e: any) {
        console.log('Strategy 5 failed:', e?.message || 'Unknown error');
      }
    }
    
    if (parsedResponse && parsedResponse.exercises && Array.isArray(parsedResponse.exercises)) {
      console.log(`Successfully parsed ${parsedResponse.exercises.length} exercises`);
      
          // Cache the generated exercises
      const cachePromises = parsedResponse.exercises.map((exercise: any) => 
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
    
    // If all strategies failed, return error with raw text for debugging
    console.error('All parsing strategies failed. Raw response:', generatedText);
    throw new Error(`Failed to parse AI response. Raw text: ${generatedText.substring(0, 200)}...`);

  } catch (error: any) {
    console.error('Error in generate-ai-exercises function:', error);
    return new Response(JSON.stringify({ 
      error: error?.message || 'Unknown error',
      success: false 
    }), {
      status: 500,
      headers: { ...corsHeaders, 'Content-Type': 'application/json' },
    });
  }
});
