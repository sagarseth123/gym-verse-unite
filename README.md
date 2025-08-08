# Welcome to your Lovable project

## Project info

**URL**: https://lovable.dev/projects/afba984f-1c01-440d-837c-f09603bd33a6

## How can I edit this code?

There are several ways of editing your application.

**Use Lovable**

Simply visit the [Lovable Project](https://lovable.dev/projects/afba984f-1c01-440d-837c-f09603bd33a6) and start prompting.

Changes made via Lovable will be committed automatically to this repo.

**Use your preferred IDE**

If you want to work locally using your own IDE, you can clone this repo and push changes. Pushed changes will also be reflected in Lovable.

The only requirement is having Node.js & npm installed - [install with nvm](https://github.com/nvm-sh/nvm#installing-and-updating)

Follow these steps:

```sh
# Step 1: Clone the repository using the project's Git URL.
git clone <YOUR_GIT_URL>

# Step 2: Navigate to the project directory.
cd <YOUR_PROJECT_NAME>

# Step 3: Install the necessary dependencies.
npm i

# Step 4: Start the development server with auto-reloading and an instant preview.
npm run dev
```

**Edit a file directly in GitHub**

- Navigate to the desired file(s).
- Click the "Edit" button (pencil icon) at the top right of the file view.
- Make your changes and commit the changes.

**Use GitHub Codespaces**

- Navigate to the main page of your repository.
- Click on the "Code" button (green button) near the top right.
- Select the "Codespaces" tab.
- Click on "New codespace" to launch a new Codespace environment.
- Edit files directly within the Codespace and commit and push your changes once you're done.

## What technologies are used for this project?

This project is built with:

- Vite
- TypeScript
- React
- shadcn-ui
- Tailwind CSS

## How can I deploy this project?

Simply open [Lovable](https://lovable.dev/projects/afba984f-1c01-440d-837c-f09603bd33a6) and click on Share -> Publish.

## Can I connect a custom domain to my Lovable project?

Yes, you can!

To connect a domain, navigate to Project > Settings > Domains and click Connect Domain.

Read more here: [Setting up a custom domain](https://docs.lovable.dev/tips-tricks/custom-domain#step-by-step-guide)

## Running Supabase and This Project Locally

### 1. Prerequisites
- **Node.js & npm** (recommended: use [nvm](https://github.com/nvm-sh/nvm#installing-and-updating))
- **Supabase CLI** ([Install instructions](https://supabase.com/docs/guides/cli))
- **Deno** (for running edge functions, [Install instructions](https://deno.com/manual/getting_started/installation))

### 2. Clone the Repository
```sh
git clone <YOUR_GIT_URL>
cd <YOUR_PROJECT_NAME>
```

### 3. Install Dependencies
```sh
npm install
```

### 4. Set Up Supabase Locally
- Copy your `.env.local` file to the `supabase/` folder if not already present. This should include keys like `GEMINI_API_KEY`, `SUPABASE_SERVICE_KEY`, and `SUPABASE_URL`.
- Start Supabase local development environment:
```sh
supabase start
```

### 5. Serve Edge Functions Locally
- In a separate terminal, run:
```sh
supabase functions serve generate-fitness-plan --no-verify-jwt --env-file supabase/.env.local
```
- **Note:** As of June 2024, outbound HTTP requests (e.g., to Gemini API or public APIs) may not work in the local Supabase Edge runtime due to sandbox restrictions. If you encounter timeouts, test your function logic in a standalone Deno script or deploy to Supabase Cloud for full integration tests.

### 6. Start the Frontend
```sh
npm run dev
```

### 7. Access the App
- Visit [http://localhost:8080](http://localhost:8080) in your browser.

### 8. Troubleshooting
- If edge functions time out on HTTP requests locally, try:
  - Testing your logic in a standalone Deno script (`deno run --allow-net test-fetch.ts`)
  - Deploying to Supabase Cloud: `supabase functions deploy generate-fitness-plan`
  - Checking your Supabase CLI version and downgrading if needed
- For more help, see the [Supabase CLI GitHub issues](https://github.com/supabase/cli/issues).

# Exercise Category Generation & Image Mapping Architecture

## Overview
This project features a robust, automated pipeline for generating exercise categories, mapping images to exercises, and storing all data in a local Supabase database. The system is designed to maximize use of existing images, minimize API costs, and ensure a seamless experience in the frontend UI.

---

## Architecture Diagram

```
User Action/UI
    |
    v
Batch Script (Node.js: generate-40-exercises-batched.cjs)
    |
    v
[For Each Category]
    |
    v
1. Generate 40 Exercises (via Gemini API or static list)
    |
    v
2. For Each Exercise:
    a. Check for existing image in /public/images/exercise
    b. If not found, try to generate image via Gemini API
    c. If generation fails (quota/exhausted), use push-up placeholder image
    |
    v
3. Store exercise (with image URL) in Supabase table (category_exercises)
    |
    v
Frontend fetches and displays exercises/images from DB
```

---

## Detailed Workflow

### 1. **Batch Generation Script**
- Script: `generate-40-exercises-batched.cjs`
- For each exercise category (e.g., Strength, Weight Loss, Calisthenics, etc.):
  - Requests 40 exercises from Gemini API (or uses a static list if quota is exhausted).
  - Each exercise is processed for image mapping.

### 2. **Image Mapping Logic**
- For each exercise:
  1. **Normalize the exercise name** to a filename (e.g., `"Dumbbell Thrusters"` → `dumbbell_thrusters.png`).
  2. **Check if the image exists** in `/public/images/exercise`.
     - If found, use this image.
     - If not found, attempt to generate an image using the Gemini API.
     - If Gemini API fails (quota/rate limit/exhausted), fallback to `/images/exercise/push_ups.png` as a placeholder.
- This logic is implemented in the image API (`generate-exercise-image-api.cjs`) and mapping scripts.

### 3. **Database Storage**
- All exercises (with their mapped image URLs) are stored in the `category_exercises` table in Supabase.
- The `exercise_data` JSONB field contains the image URL and other metadata.
- This ensures the frontend can always fetch the correct image for each exercise.

### 4. **Frontend Consumption**
- The frontend fetches exercises and their image URLs from the database.
- If an image is missing, the UI will show the push-up placeholder.
- The UI is designed to show a loading spinner while images load and fallback gracefully if an image fails to load.

---

## Fallback & Error Handling
- **Existing images** are always prioritized to save API quota.
- **Gemini API** is only used if no local image is found.
- **Push-up image** is used as a universal fallback if image generation fails or quota is exhausted.
- **Batch scripts** log all failures and continue processing remaining exercises/categories.

---

## Manual Seeding (When Gemini API Quota is Exhausted)
- If Gemini API quota is exhausted for a category, you can manually seed the database:
  - Use a static list of 40 exercises per category.
  - Map images from `/public/images/exercise`.
  - Use the push-up image for missing ones.
  - Store all details in the `category_exercises` table.
- This ensures the app remains fully functional for demos/testing even without API access.

---

## Key Files & Scripts
- `generate-40-exercises-batched.cjs`: Main batch script for generating and storing exercises/images.
- `generate-exercise-image-api.cjs`: Local image API for mapping/generating/fallback images.
- `/public/images/exercise`: Folder containing all pre-generated and manually added exercise images.
- `category_exercises` (Supabase table): Stores all exercises, image URLs, and metadata.
- `enhanced-exercise-mapping.cjs`: Script for remapping images to exercises in the DB.

---

## Troubleshooting
- If you see repeated push-up placeholders, it means neither a local image nor Gemini-generated image was available.
- If batch scripts fail with 429/503 errors, your Gemini API quota is exhausted—wait for reset or use a new key.
- Always check your `.env` for correct Supabase and Gemini API keys.

---

## Example: Adding a New Category
1. Add the category to your batch script.
2. Run the script to generate 40 exercises and images.
3. Verify images in `/public/images/exercise` and DB entries in `category_exercises`.
4. The frontend will automatically display the new category and its exercises.

---

For further details, see the code in the batch scripts and image API, or ask for a code walkthrough.

---

## Retrieving Exercises by Category (Frontend)

### How the Frontend Fetches Exercises
- The frontend uses a service (e.g., `aiExerciseService.ts` or similar) to fetch exercises for a given category from the Supabase database.
- The service queries the `category_exercises` table, filtering by the desired category (e.g., `category_id` or category name).
- Each exercise record includes its name, metadata, and the mapped `image_url` (inside the `exercise_data` JSONB field).
- The frontend components (such as the Fitness Explorer or Category modals) call this service to retrieve and display the list of exercises and their images for the selected category.
- If an image URL is missing or the image fails to load, the UI falls back to the push-up placeholder image.

### Example (Pseudo-code)
```js
// Example: Fetching exercises for a category
const { data: exercises, error } = await supabase
  .from('category_exercises')
  .select('*')
  .eq('category_id', selectedCategoryId);

// Each exercise object contains:
// - exercise_name
// - exercise_data: { image_url, ... }
```

- The UI then renders each exercise card with its name and image.
- This ensures that the frontend always displays the correct set of exercises and images for each category, as stored in the database.

---

## Database Backup & Restore

### How to Back Up the Local Supabase Database
- You can create a backup of your current local database using the Supabase CLI:
  ```sh
  supabase db dump --file user_weekly_plans_backup.sql
  ```
- This will create a file named `user_weekly_plans_backup.sql` in your project root.
- This file contains a full SQL dump of your current local database, including all tables and data.

### How to Restore the Local Database from Backup
- To restore your database from the backup file, run:
  ```sh
  supabase db restore user_weekly_plans_backup.sql
  ```
- This will overwrite your current local database with the contents of the backup.

---

## Current State of the Local Database

- **Strength Training & Muscle Building:** 40 exercises (with images, some may use push-up placeholder)
- **Weight Loss & Fat Burning:** 0 exercises (Gemini API quota exhausted)
- **Calisthenics & Bodyweight:** 0 exercises (Gemini API quota exhausted)
- **Bulking & Mass Gain:** 0 exercises (Gemini API quota exhausted)
- **Functional Fitness:** 0 exercises (Gemini API quota exhausted)
- **Flexibility & Recovery:** 0 exercises (Gemini API quota exhausted)

- The backup file `user_weekly_plans_backup.sql` reflects this current state.
- If you restore from this backup, you will return to this exact state.

---

## ⚠️ Database Safety Warning

- **Do NOT run destructive commands** like `supabase db reset`, `supabase db restore`, or `supabase db drop` unless you are absolutely sure. These commands will erase or overwrite your local database and cannot be undone.
- **Always keep a backup (`local_db_backup.sql`) before making any major changes** to your local database. This ensures you can restore your data if something goes wrong.
- Only use `supabase db dump` to create backups (safe).
- Only trusted users should have access to your local development environment and Supabase CLI.

---

## Database Management Scripts

### List Exercises with Fallback or Missing Images

A Node.js script is provided to help you audit your exercise image mappings in the database. It will list and count all exercises that are using a fallback image (e.g., push-up or default) or have a missing image URL.

**How to run:**

```sh
node scripts/list_exercises_with_fallback_images.cjs
```

- Make sure your `.env` is configured with your local Supabase URL and anon key.
- The script will print a summary and details to the console.

**What it does:**
- Connects to your local Supabase database.
- Fetches all exercises from the `category_exercises` table.
- Lists and counts exercises with fallback or missing images.
- Helps you identify which exercises need better image mapping or manual fixes.

---
