export const config = {
  geminiApiKey: Deno.env.get("GEMINI_API_KEY") || "AIzaSyBs8DnaQb6WzzRC0zF3y_U71WkwJkBlC8g",
  supabaseUrl: Deno.env.get("SUPABASE_URL"),
  supabaseServiceKey: Deno.env.get("SUPABASE_SERVICE_KEY")
}; 