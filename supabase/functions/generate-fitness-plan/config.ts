export const config = {
  geminiApiKey: Deno.env.get("GEMINI_API_KEY"),
  supabaseUrl: Deno.env.get("SUPABASE_URL"),
  supabaseServiceKey: Deno.env.get("SUPABASE_SERVICE_KEY")
}; 