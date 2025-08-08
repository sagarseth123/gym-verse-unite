# Exercise Image Mapping System

## Overview

The AI exercise planner generates exercise names that may not have corresponding images in the `/public/images/exercise/` directory. To handle this, we've implemented a smart mapping system that:

1. **Maps similar exercises** to available images
2. **Falls back to default image** when no mapping exists
3. **Validates image existence** before returning URLs

## Available Images

The following exercise images are currently available:
- `push_ups.png`
- `pull_ups.png`
- `squats.png`
- `bench_press.png`
- `deadlift.png`
- `plank.png`
- `burpees.png`
- `lunges.png`
- `mountain_climbers.png`
- `jumping_jacks.png`
- `sit_ups.png`
- `crunches.png`
- `dumbbell_curls.png`
- `shoulder_press.png`
- `rows.png`
- `lat_pulldowns.png`
- `leg_press.png`

## Mapping Examples

### Direct Matches
- "Push-ups" → `/images/exercise/push_ups.png`
- "Squats" → `/images/exercise/squats.png`
- "Bench Press" → `/images/exercise/bench_press.png`

### Smart Mappings
- "Dumbbell Thrusters" → `/images/exercise/squats.png` (closest available)
- "Wall Balls" → `/images/exercise/squats.png` (similar movement)
- "Box Jumps" → `/images/exercise/jumping_jacks.png` (jumping movement)
- "Kettlebell Swings" → `/images/exercise/deadlift.png` (hip hinge movement)
- "Russian Twists" → `/images/exercise/crunches.png` (core exercise)

### Fallback
- "Non-existent Exercise" → `/images/default.png`

## How It Works

1. **Sanitization**: Exercise names are converted to lowercase and special characters are replaced with underscores
2. **Mapping Lookup**: The system checks if the sanitized name exists in the mapping dictionary
3. **Image Validation**: If a mapping exists, it checks if the target image file exists
4. **Fallback**: If no mapping exists or the target image doesn't exist, it returns the default image

## Adding New Images

To add new exercise images:

1. Add the image file to `/public/images/exercise/`
2. Update the `availableImages` array in the function
3. Add appropriate mappings in the `exerciseMappings` object

## Adding New Mappings

To add new exercise name mappings:

1. Add the mapping to the `exerciseMappings` object in `supabase/functions/generate-fitness-plan/index.ts`
2. Map the exercise name to the closest available image
3. Deploy the function: `npx supabase functions deploy generate-fitness-plan`

## Example Mapping Addition

```typescript
// Add this to exerciseMappings
'new_exercise_name': 'closest_available_image',
'variation_name': 'base_exercise_name',
```

## Testing

You can test the mapping system by running:

```bash
node test-image-mapping.js
```

This will show how different exercise names are mapped to image URLs. 