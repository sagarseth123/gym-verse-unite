
import "https://deno.land/x/xhr@0.1.0/mod.ts";
import { serve } from "https://deno.land/std@0.168.0/http/server.ts";
import { createClient } from 'https://esm.sh/@supabase/supabase-js@2.39.3';

const corsHeaders = {
  'Access-Control-Allow-Origin': '*',
  'Access-Control-Allow-Headers': 'authorization, x-client-info, apikey, content-type',
};

const supabaseUrl = Deno.env.get('SUPABASE_URL')!;
const supabaseServiceKey = Deno.env.get('SUPABASE_SERVICE_ROLE_KEY')!;
const geminiApiKey = Deno.env.get('GEMINI_API_KEY');

serve(async (req) => {
  if (req.method === 'OPTIONS') {
    return new Response(null, { headers: corsHeaders });
  }

  try {
    console.log('Function started');

    if (!geminiApiKey) {
      throw new Error('GEMINI_API_KEY not configured');
    }

    const supabase = createClient(supabaseUrl, supabaseServiceKey);
    
    // Get the user from the Authorization header
    const authHeader = req.headers.get('Authorization');
    if (!authHeader) {
      throw new Error('No authorization header');
    }

    console.log('Getting user from auth header');
    const { data: { user }, error: authError } = await supabase.auth.getUser(
      authHeader.replace('Bearer ', '')
    );

    if (authError || !user) {
      console.error('Auth error:', authError);
      throw new Error('Unauthorized');
    }

    console.log('User authenticated:', user.id);

    // Get user profile data
    const { data: profile, error: profileError } = await supabase
      .from('profiles')
      .select('*')
      .eq('id', user.id)
      .maybeSingle();

    if (profileError) {
      console.error('Profile error:', profileError);
      throw new Error('Failed to fetch profile');
    }

    const { data: gymProfile, error: gymProfileError } = await supabase
      .from('gym_user_profiles')
      .select('*')
      .eq('id', user.id)
      .maybeSingle();

    if (gymProfileError) {
      console.error('Gym profile error:', gymProfileError);
      throw new Error('Failed to fetch gym profile');
    }

    if (!profile || !gymProfile) {
      throw new Error('Profile data not found. Please complete your profile first.');
    }

    console.log('Profile data retrieved successfully');

    // Calculate age (using a default for now since we don't have birth_date)
    const estimatedAge = 25;

    // Calculate BMI if not already calculated
    const bmi = gymProfile.bmi || (gymProfile.weight && gymProfile.height ? 
      gymProfile.weight / Math.pow(gymProfile.height / 100, 2) : null);

    // Prepare the prompt for Gemini
    const prompt = `
You are a certified fitness and nutrition expert. Generate a comprehensive, personalized weekly fitness plan for this user:

**User Profile:**
- Age: ${estimatedAge} years old
- Weight: ${gymProfile.weight || 'Not provided'} kg
- Height: ${gymProfile.height || 'Not provided'} cm
- BMI: ${bmi ? bmi.toFixed(1) : 'Not calculated'}
- Fitness Level: ${gymProfile.fitness_level || 'Not specified'}
- Primary Goals: ${gymProfile.fitness_goals?.join(', ') || 'General fitness'}
- Preferred Training Types: ${gymProfile.preferred_training_types?.join(', ') || 'Not specified'}
- Medical Conditions: ${gymProfile.medical_conditions?.join(', ') || 'None reported'}

**Please provide a detailed response in JSON format with the following structure:**

{
  "weeklyPlan": {
    "overview": "Brief overview of the plan",
    "dailyCalorieTarget": number,
    "macronutrients": {
      "protein": "grams and percentage",
      "carbohydrates": "grams and percentage", 
      "fats": "grams and percentage"
    }
  },
  "dietPlan": {
    "monday": {
      "breakfast": "meal description with calories",
      "lunch": "meal description with calories",
      "dinner": "meal description with calories",
      "snacks": ["snack 1", "snack 2"]
    },
    "tuesday": { /* same structure */ },
    "wednesday": { /* same structure */ },
    "thursday": { /* same structure */ },
    "friday": { /* same structure */ },
    "saturday": { /* same structure */ },
    "sunday": { /* same structure */ }
  },
  "exercisePlan": {
    "monday": {
      "type": "workout type",
      "duration": "minutes",
      "exercises": [
        {
          "name": "exercise name",
          "sets": number,
          "reps": "reps or duration",
          "rest": "rest time"
        }
      ]
    },
    "tuesday": { /* same structure */ },
    "wednesday": { /* same structure */ },
    "thursday": { /* same structure */ },
    "friday": { /* same structure */ },
    "saturday": { /* same structure */ },
    "sunday": { /* same structure */ }
  },
  "progressTracking": {
    "weeklyMeasurements": ["measurement 1", "measurement 2"],
    "adjustmentTriggers": ["trigger 1", "trigger 2"],
    "expectedResults": "what to expect in 4-6 weeks"
  },
  "tips": [
    "tip 1",
    "tip 2", 
    "tip 3"
  ]
}

Make sure the plan is realistic, safe, and tailored to the user's specific goals and fitness level. Focus on sustainable habits and gradual progression.
`;

    console.log('Calling Gemini API with model: gemini-1.5-flash');
    
    // Call Gemini API with the correct model name
    const geminiResponse = await fetch(`https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash:generateContent?key=${geminiApiKey}`, {
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

    if (!geminiResponse.ok) {
      const errorText = await geminiResponse.text();
      console.error('Gemini API error:', geminiResponse.status, errorText);
      throw new Error(`Gemini API error: ${geminiResponse.status} - ${errorText}`);
    }

    const geminiData = await geminiResponse.json();
    console.log('Gemini response received');

    if (!geminiData.candidates || !geminiData.candidates[0]) {
      console.error('No candidates in Gemini response:', geminiData);
      throw new Error('No response from Gemini API');
    }

    const responseText = geminiData.candidates[0].content.parts[0].text;
    console.log('Response text length:', responseText.length);
    
    // Try to extract JSON from the response
    let fitnessPlans;
    try {
      // Find JSON in the response (it might be wrapped in markdown code blocks)
      const jsonMatch = responseText.match(/```json\n([\s\S]*?)\n```/) || responseText.match(/\{[\s\S]*\}/);
      if (jsonMatch) {
        const jsonString = jsonMatch[1] || jsonMatch[0];
        fitnessPlans = JSON.parse(jsonString);
        console.log('Successfully parsed JSON response');
      } else {
        console.log('No JSON found in response, returning raw text');
        fitnessPlans = { rawResponse: responseText };
      }
    } catch (parseError) {
      console.error('JSON parse error:', parseError);
      fitnessPlans = { rawResponse: responseText };
    }

    return new Response(
      JSON.stringify({ 
        success: true, 
        data: fitnessPlans,
        userProfile: {
          age: estimatedAge,
          weight: gymProfile.weight,
          height: gymProfile.height,
          bmi: bmi,
          goals: gymProfile.fitness_goals,
          fitnessLevel: gymProfile.fitness_level
        }
      }),
      {
        headers: { ...corsHeaders, 'Content-Type': 'application/json' },
      }
    );

  } catch (error) {
    console.error('Error in generate-fitness-plan function:', error);
    return new Response(
      JSON.stringify({ 
        success: false, 
        error: error.message 
      }),
      {
        status: 500,
        headers: { ...corsHeaders, 'Content-Type': 'application/json' },
      }
    );
  }
});
