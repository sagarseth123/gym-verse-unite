#!/bin/bash

# Script to set up and run the Node.js fitness planner server
set -e

# Step 1: Install dependencies
if ! npm list express >/dev/null 2>&1; then
  echo "Installing express..."
  npm install express
fi
if ! npm list node-fetch >/dev/null 2>&1; then
  echo "Installing node-fetch..."
  npm install node-fetch
fi

# Step 2: Check for Gemini API key
if [ -z "$GEMINI_API_KEY" ]; then
  echo "GEMINI_API_KEY is not set."
  echo "Please export your Gemini API key in your terminal before running this script:"
  echo "  export GEMINI_API_KEY=your_real_gemini_api_key"
  exit 1
else
  echo "Using GEMINI_API_KEY from environment."
fi

# Step 3: Ensure public/images/exercise directory exists
mkdir -p public/images/exercise

# Step 4: Start the server
echo "Starting Node.js fitness planner server..."
echo "(You can stop the server with Ctrl+C)"
node server.cjs 