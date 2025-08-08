// Simple mock server to simulate Supabase Edge Functions
import http from 'http';

// CORS middleware similar to what's in your Edge Function
const corsHeaders = {
  'Access-Control-Allow-Origin': 'http://localhost:8080',
  'Access-Control-Allow-Headers': 'authorization, x-client-info, apikey, content-type',
  'Access-Control-Allow-Methods': 'GET, POST, PUT, DELETE, OPTIONS',
  'Access-Control-Allow-Credentials': 'true',
};

// Create the server
const server = http.createServer((req, res) => {
  // Log all requests
  console.log(`${req.method} ${req.url}`);

  // Set CORS headers for all responses
  Object.entries(corsHeaders).forEach(([key, value]) => {
    res.setHeader(key, value);
  });

  // Handle OPTIONS requests (CORS preflight)
  if (req.method === 'OPTIONS') {
    res.statusCode = 200;
    res.end('OK');
    return;
  }

  // Only accept POST requests to /functions/v1/ai-chat-coach
  if (req.method === 'POST' && req.url === '/functions/v1/ai-chat-coach') {
    let body = '';
    
    req.on('data', (chunk) => {
      body += chunk.toString();
    });
    
    req.on('end', () => {
      try {
        const data = JSON.parse(body);
        if (!data.prompt) {
          res.statusCode = 400;
          res.setHeader('Content-Type', 'application/json');
          res.end(JSON.stringify({ error: 'No prompt provided' }));
          return;
        }
        
        console.log('Received prompt:', data.prompt);
        
        // Mock response
        res.statusCode = 200;
        res.setHeader('Content-Type', 'application/json');
        res.end(JSON.stringify({ 
          answer: `This is a mock response from the AI Chat Coach for: "${data.prompt}". CORS is now working correctly!` 
        }));
      } catch (err) {
        console.error('Error:', err);
        res.statusCode = 500;
        res.setHeader('Content-Type', 'application/json');
        res.end(JSON.stringify({ error: err.message || 'Unknown error' }));
      }
    });
  } else {
    res.statusCode = 404;
    res.setHeader('Content-Type', 'application/json');
    res.end(JSON.stringify({ error: 'Not found' }));
  }
});

// Start the server on the same port as Supabase's localhost
const PORT = 54321;
server.listen(PORT, () => {
  console.log(`Mock server running at http://127.0.0.1:${PORT}`);
  console.log(`CORS configured for: ${corsHeaders['Access-Control-Allow-Origin']}`);
  console.log('Available endpoints:');
  console.log('  POST /functions/v1/ai-chat-coach');
});
