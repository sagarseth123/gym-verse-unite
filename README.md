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
