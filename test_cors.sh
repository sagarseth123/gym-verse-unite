#!/bin/bash

echo "Testing OPTIONS request (CORS preflight)"
curl -X OPTIONS -i http://127.0.0.1:54321/functions/v1/ai-chat-coach \
  -H "Origin: http://localhost:8080" \
  -H "Access-Control-Request-Method: POST" \
  -H "Access-Control-Request-Headers: Content-Type,Authorization"

echo -e "\n\nTesting POST request"
curl -X POST -i http://127.0.0.1:54321/functions/v1/ai-chat-coach \
  -H "Content-Type: application/json" \
  -H "Origin: http://localhost:8080" \
  -H "Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZS1kZW1vIiwicm9sZSI6ImFub24iLCJleHAiOjE5ODM4MTI5OTZ9.CRXP1A7WOeoJeXxjNni43kdQwgnWNReilDMblYTn_I0" \
  -d '{"prompt":"Give me a quick workout tip"}'
