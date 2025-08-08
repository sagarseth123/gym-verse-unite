// serve_edge_function.js - A simple server to test the Edge Function without Supabase CLI
import { serve } from 'https://deno.land/std@0.168.0/http/server.ts';
import { corsHeaders, handleCors, addCorsHeaders } from './supabase/functions/_shared/cors.ts';
import { config } from './supabase/functions/ai-chat-coach/config.ts';

console.log("🚀 Starting standalone Edge Function server on http://localhost:8000");
console.log("📝 API Key status:", config.geminiApiKey ? "Present" : "Missing");
console.log("🔄 CORS headers configured for:", corsHeaders["Access-Control-Allow-Origin"]);

serve(async (req) => {
  console.log(`${req.method} ${new URL(req.url).pathname}`);
  
  // Handle CORS preflight requests
  const corsResponse = handleCors(req);
  if (corsResponse) {
    console.log("✅ Handled OPTIONS request");
    return corsResponse;
  }
  
  try {
    if (req.method !== 'POST') {
      return addCorsHeaders(
        new Response(JSON.stringify({ error: 'Method not allowed' }), { 
          status: 405, 
          headers: { 'Content-Type': 'application/json' } 
        })
      );
    }
    
    const { prompt } = await req.json();
    console.log("📨 Received prompt:", prompt);
    
    if (!prompt) {
      return addCorsHeaders(
        new Response(JSON.stringify({ error: 'No prompt provided' }), { 
          status: 400, 
          headers: { 'Content-Type': 'application/json' } 
        })
      );
    }
    
    // Use a mock response for testing to avoid timeouts
    let answer = 'This is a test response from the AI Chat Coach. CORS is now working correctly!';
    console.log("🤖 Sending mock response");
    
    // Return the response with CORS headers
    return addCorsHeaders(
      new Response(
        JSON.stringify({ answer }), 
        { headers: { 'Content-Type': 'application/json' } }
      )
    );
  } catch (err) {
    console.error('❌ Error in ai-chat-coach:', err);
    return addCorsHeaders(
      new Response(
        JSON.stringify({ error: err.message || 'Unknown error' }), 
        { status: 500, headers: { 'Content-Type': 'application/json' } }
      )
    );
  }
}, { port: 8000 });
