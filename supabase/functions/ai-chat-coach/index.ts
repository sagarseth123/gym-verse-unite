import { serve } from 'https://deno.land/std@0.168.0/http/server.ts';
import { config } from './config.ts';
import { corsHeaders, handleCors, addCorsHeaders } from '../_shared/cors.ts';

serve(async (req) => {
  // Handle CORS preflight requests
  const corsResponse = handleCors(req);
  if (corsResponse) {
    return corsResponse;
  }
  try {
    const { prompt } = await req.json();
    if (!prompt) {
      return addCorsHeaders(
        new Response(JSON.stringify({ error: 'No prompt provided' }), { 
          status: 400, 
          headers: { 'Content-Type': 'application/json' } 
        })
      );
    }
    
    if (!config.geminiApiKey) {
      return addCorsHeaders(
        new Response(JSON.stringify({ error: 'GEMINI_API_KEY not configured' }), { 
          status: 500, 
          headers: { 'Content-Type': 'application/json' } 
        })
      );
    }

    // Use a mock response for testing to avoid timeouts
    // We can replace this with the actual API call once CORS is working
    let answer = 'This is a test response from the AI Chat Coach. CORS is now working correctly!';
    
    /* Temporarily comment out the actual API call to avoid timeouts
    try {
      const controller = new AbortController();
      const timeoutId = setTimeout(() => controller.abort(), 10000); // 10 second timeout
      
      const geminiRes = await fetch(`https://generativelanguage.googleapis.com/v1beta/models/gemini-pro:generateContent?key=${config.geminiApiKey}`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ contents: [{ parts: [{ text: prompt }] }] }),
        signal: controller.signal
      });
      
      clearTimeout(timeoutId);
      const geminiData = await geminiRes.json();
      answer = geminiData.candidates?.[0]?.content?.parts?.[0]?.text || geminiData.candidates?.[0]?.content?.text || 'No answer received.';
    } catch (e) {
      if (e.name === 'AbortError') {
        answer = 'Request timed out. Please try again.';
      } else {
        answer = 'Failed to get response from Gemini API.';
        console.error(e);
      }
    }
    */
    
    // Return the response with CORS headers
    return addCorsHeaders(
      new Response(
        JSON.stringify({ answer }), 
        { headers: { 'Content-Type': 'application/json' } }
      )
    );
  } catch (err: any) {
    console.error('Error in ai-chat-coach:', err);
    return addCorsHeaders(
      new Response(
        JSON.stringify({ error: err.message || 'Unknown error' }), 
        { status: 500, headers: { 'Content-Type': 'application/json' } }
      )
    );
  }
});