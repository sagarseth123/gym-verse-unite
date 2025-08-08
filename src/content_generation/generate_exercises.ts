// Script to generate exercises using Gemini, upload images to Google Drive, and insert into Supabase
// Run with: bun run src/content_generation/generate_exercises.ts

import { createClient } from '@supabase/supabase-js';
import fs from 'fs/promises';
import path from 'path';

// --- CONFIGURATION ---
const GEMINI_API_KEY = process.env.GEMINI_API_KEY || '<YOUR_GEMINI_API_KEY>';
const SUPABASE_URL = process.env.SUPABASE_URL || '<YOUR_SUPABASE_URL>';
const SUPABASE_SERVICE_ROLE_KEY = process.env.SUPABASE_SERVICE_ROLE_KEY || '<YOUR_SUPABASE_SERVICE_ROLE_KEY>';
const GOOGLE_DRIVE_FOLDER_ID = process.env.GOOGLE_DRIVE_FOLDER_ID || '<YOUR_GOOGLE_DRIVE_FOLDER_ID>';
const GOOGLE_DRIVE_ACCESS_TOKEN = process.env.GOOGLE_DRIVE_ACCESS_TOKEN || '<YOUR_GOOGLE_DRIVE_ACCESS_TOKEN>';

// --- SUPABASE CLIENT ---
const supabase = createClient(SUPABASE_URL, SUPABASE_SERVICE_ROLE_KEY);

// --- EXERCISE FIELDS ---
type Exercise = {
  name: string;
  description: string;
  category: string;
  muscle_groups: string[];
  difficulty_level: string;
  equipment_needed: string[];
  image_url: string;
};

// --- GEMINI EXERCISE GENERATION ---
async function generateExercise(prompt: string): Promise<Exercise | null> {
  const geminiUrl = `https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash:generateContent?key=${GEMINI_API_KEY}`;
  const body = {
    contents: [{ parts: [{ text: prompt }] }],
    generationConfig: {
      temperature: 0.7,
      topK: 40,
      topP: 0.95,
      maxOutputTokens: 512,
    },
  };
  const response = await fetch(geminiUrl, {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify(body),
  });
  if (!response.ok) {
    console.error('Gemini API error:', await response.text());
    return null;
  }
  const data = await response.json();
  const text = data.candidates?.[0]?.content?.parts?.[0]?.text || '';
  // Try to extract JSON from the response
  const match = text.match(/\{[\s\S]*\}/);
  if (!match) return null;
  try {
    return JSON.parse(match[0]);
  } catch {
    return null;
  }
}

// --- IMAGE GENERATION USING GEMINI ---
async function generateExerciseImage(exerciseName: string, description: string): Promise<Buffer | null> {
  // Compose a prompt for a consistent, professional exercise image
  const prompt = `Create a high-quality, professional, app-ready image of a person performing the exercise: ${exerciseName}. The background should be a solid, neutral color (e.g., white or light gray), with no distractions or clutter. The style, lighting, and surroundings should be consistent and clean across all images. The person should be clearly demonstrating the correct form for: ${exerciseName}. Description: ${description}`;

  const geminiUrl = 'https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash-preview-image-generation:generateContent?key=' + GEMINI_API_KEY;
  const body = {
    contents: [{ parts: [{ text: prompt }] }],
    generationConfig: {
      responseModalities: ["TEXT", "IMAGE"],
    },
  };
  const response = await fetch(geminiUrl, {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify(body),
  });
  if (!response.ok) {
    console.error('Gemini image API error:', await response.text());
    return null;
  }
  const data = await response.json();
  // Find the image part
  const parts = data.candidates?.[0]?.content?.parts || [];
  for (const part of parts) {
    if (part.inlineData && part.inlineData.data) {
      // The image is base64 encoded
      return Buffer.from(part.inlineData.data, 'base64');
    }
  }
  return null;
}

// --- GOOGLE DRIVE UPLOAD ---
async function uploadToGoogleDrive(fileName: string, fileBuffer: Buffer): Promise<string | null> {
  const metadata = {
    name: fileName,
    parents: [GOOGLE_DRIVE_FOLDER_ID],
  };
  const boundary = 'foo_bar_baz';
  const delimiter = `\r\n--${boundary}\r\n`;
  const closeDelimiter = `\r\n--${boundary}--`;
  const multipartRequestBody =
    delimiter +
    'Content-Type: application/json; charset=UTF-8\r\n\r\n' +
    JSON.stringify(metadata) +
    delimiter +
    'Content-Type: image/png\r\n\r\n' +
    fileBuffer.toString('binary') +
    closeDelimiter;
  const res = await fetch('https://www.googleapis.com/upload/drive/v3/files?uploadType=multipart', {
    method: 'POST',
    headers: {
      'Authorization': `Bearer ${GOOGLE_DRIVE_ACCESS_TOKEN}`,
      'Content-Type': `multipart/related; boundary=${boundary}`,
    },
    body: multipartRequestBody,
  });
  if (!res.ok) {
    console.error('Google Drive upload error:', await res.text());
    return null;
  }
  const data = await res.json();
  // Make the file public
  await fetch(`https://www.googleapis.com/drive/v3/files/${data.id}/permissions`, {
    method: 'POST',
    headers: {
      'Authorization': `Bearer ${GOOGLE_DRIVE_ACCESS_TOKEN}`,
      'Content-Type': 'application/json',
    },
    body: JSON.stringify({ role: 'reader', type: 'anyone' }),
  });
  return `https://drive.google.com/uc?id=${data.id}`;
}

// --- SUPABASE INSERT ---
async function insertExercise(exercise: Exercise) {
  const { error } = await supabase.from('exercise').insert([exercise]);
  if (error) {
    console.error('Supabase insert error:', error);
  } else {
    console.log('Inserted exercise:', exercise.name);
  }
}

// --- MAIN SCRIPT ---
async function main() {
  // Example: Generate 100 unique exercise prompts
  const baseExercises = [
    'Push-Up', 'Squat', 'Lunge', 'Plank', 'Burpee', 'Mountain Climber', 'Deadlift', 'Bench Press', 'Pull-Up', 'Bicep Curl',
    'Tricep Dip', 'Shoulder Press', 'Lat Pulldown', 'Leg Press', 'Calf Raise', 'Russian Twist', 'Bicycle Crunch', 'Superman', 'Glute Bridge', 'Hip Thrust',
    // ... add more base names or use Gemini to generate a list of 100 unique exercises
  ];
  // If less than 100, repeat or expand
  while (baseExercises.length < 100) baseExercises.push(`Exercise ${baseExercises.length + 1}`);

  for (const exerciseName of baseExercises.slice(0, 100)) {
    // Generate exercise details
    const prompt = `Generate a JSON object for the exercise '${exerciseName}' with fields: name, description, category, muscle_groups, difficulty_level, equipment_needed.`;
    const exercise = await generateExercise(prompt);
    if (!exercise) {
      console.error('Failed to generate exercise for:', exerciseName);
      continue;
    }
    // Generate image using Gemini
    const imageBuffer = await generateExerciseImage(exercise.name, exercise.description);
    if (!imageBuffer) {
      console.error('Failed to generate image for:', exercise.name);
      continue;
    }
    const imageUrl = await uploadToGoogleDrive(`${exercise.name}.png`, imageBuffer);
    if (!imageUrl) {
      console.error('Failed to upload image for:', exercise.name);
      continue;
    }
    exercise.image_url = imageUrl;
    await insertExercise(exercise);
  }
}

main().catch(console.error); 