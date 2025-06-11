
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
    const { type, userProfile, exercise } = await req.json();
    
    const geminiApiKey = Deno.env.get('GEMINI_API_KEY');
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
      const goals = userProfile?.fitness_goals?.join(', ') || 'general fitness';
      const level = userProfile?.fitness_level || 'beginner';
      const height = userProfile?.height || 'not specified';
      const weight = userProfile?.weight || 'not specified';
      
      prompt = `
Create a personalized weekly fitness plan for:
- Goals: ${goals}
- Fitness Level: ${level}  
- Height: ${height}
- Weight: ${weight}

Please provide a structured 7-day plan with:
1. Daily workout focus (e.g., "Upper Body Strength", "Cardio", "Rest")
2. 3-5 specific exercises per workout day
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

    const data = await response.json();
    
    if (!data.candidates?.[0]?.content?.parts?.[0]?.text) {
      throw new Error('Invalid response from Gemini API');
    }

    const generatedText = data.candidates[0].content.parts[0].text;
    
    try {
      // Try to parse as JSON
      const jsonMatch = generatedText.match(/\{[\s\S]*\}/);
      if (jsonMatch) {
        const parsedResponse = JSON.parse(jsonMatch[0]);
        
        if (type === 'exercise_guidance') {
          return new Response(JSON.stringify({ 
            guidance: parsedResponse,
            success: true 
          }), {
            headers: { ...corsHeaders, 'Content-Type': 'application/json' },
          });
        } else {
          return new Response(JSON.stringify({ 
            plan: parsedResponse,
            success: true 
          }), {
            headers: { ...corsHeaders, 'Content-Type': 'application/json' },
          });
        }
      }
    } catch (parseError) {
      console.log('JSON parsing failed, returning raw text');
    }
    
    // Fallback: return raw text
    return new Response(JSON.stringify({ 
      plan: { raw: generatedText },
      success: true 
    }), {
      headers: { ...corsHeaders, 'Content-Type': 'application/json' },
    });

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
