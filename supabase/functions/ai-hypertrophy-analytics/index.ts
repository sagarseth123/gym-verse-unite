// Follow this setup guide to integrate the Deno language server with your editor:
// https://deno.land/manual/getting_started/setup_your_environment
// This enables autocomplete, go to definition, etc.

// Setup type definitions for built-in Supabase Runtime APIs
import "jsr:@supabase/functions-js/edge-runtime.d.ts"

import "https://deno.land/x/xhr@0.1.0/mod.ts";
import { serve } from "https://deno.land/std@0.168.0/http/server.ts";
import { config } from '../generate-fitness-plan/config.ts';

const corsHeaders = {
  'Access-Control-Allow-Origin': '*',
  'Access-Control-Allow-Headers': 'authorization, x-client-info, apikey, content-type',
};

console.log("Hello from Functions!")

serve(async (req) => {
  if (req.method === 'OPTIONS') {
    return new Response(null, { headers: corsHeaders });
  }

  try {
    const { workoutHistory, weeklyPlan } = await req.json();
    const geminiApiKey = config.geminiApiKey;
    if (!geminiApiKey) {
      throw new Error('GEMINI_API_KEY not configured');
    }

    // Compose prompt for hypertrophy analytics
    const prompt = `
You are an advanced bodybuilding and hypertrophy coach. Analyze the following user's workout history and weekly plan for muscle growth optimization:

WORKOUT HISTORY (JSON):
${JSON.stringify(workoutHistory, null, 2)}

WEEKLY PLAN (JSON):
${JSON.stringify(weeklyPlan, null, 2)}

IMPORTANT: Output must be valid JSON. All values must be strings, numbers, or arrays. No unquoted words, no comments, no trailing commas.

Please provide:
1. Muscle group balance analysis (which muscles are over/undertrained)
2. Hypertrophy growth potential (is the user progressing? any plateaus?)
3. Personalized advice for next week (volume, frequency, exercise selection)
4. Warnings about injury risk or imbalances
5. Motivation and encouragement

Format as a JSON object:
{
  "muscleBalance": "...",
  "growthPotential": "...",
  "advice": "...",
  "warnings": "...",
  "motivation": "..."
}
`;

    const response = await fetch(`https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash:generateContent?key=${geminiApiKey}`, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify({
        contents: [{
          parts: [{ text: prompt }]
        }],
        generationConfig: {
          temperature: 0.7,
          topK: 40,
          topP: 0.95,
          maxOutputTokens: 1024,
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
    function parseGeminiJson(raw) {
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

    let parsedResponse = null;
    try {
      const jsonMatch = generatedText.match(/\{[\s\S]*\}/);
      if (jsonMatch) {
        parsedResponse = parseGeminiJson(jsonMatch[0]);
      }
    } catch (e) {
      parsedResponse = null;
    }

    if (parsedResponse) {
      return new Response(JSON.stringify({
        analytics: parsedResponse,
        success: true
      }), {
        headers: { ...corsHeaders, 'Content-Type': 'application/json' },
      });
    } else {
      return new Response(JSON.stringify({
        error: 'Failed to parse AI analytics output as JSON',
        raw: generatedText,
        success: false
      }), {
        headers: { ...corsHeaders, 'Content-Type': 'application/json' },
      });
    }
  } catch (error) {
    console.error('Error in ai-hypertrophy-analytics function:', error);
    return new Response(JSON.stringify({
      error: error.message,
      success: false
    }), {
      status: 500,
      headers: { ...corsHeaders, 'Content-Type': 'application/json' },
    });
  }
});

/* To invoke locally:

  1. Run `supabase start` (see: https://supabase.com/docs/reference/cli/supabase-start)
  2. Make an HTTP request:

  curl -i --location --request POST 'http://127.0.0.1:54321/functions/v1/ai-hypertrophy-analytics' \
    --header 'Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZS1kZW1vIiwicm9sZSI6ImFub24iLCJleHAiOjE5ODM4MTI5OTZ9.CRXP1A7WOeoJeXxjNni43kdQwgnWNReilDMblYTn_I0' \
    --header 'Content-Type: application/json' \
    --data '{"name":"Functions"}'

*/
