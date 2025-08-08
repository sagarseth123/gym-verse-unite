export async function getExerciseImageUrl(exerciseName: string, description?: string): Promise<string> {
  try {
    const params = new URLSearchParams({ name: exerciseName, description: description || '' });
    const res = await fetch(`/api/exercise-image?${params.toString()}`);
    if (!res.ok) throw new Error('Image fetch failed');
    const data = await res.json();
    return data.imageUrl;
  } catch (err) {
    // Fallback to a default image if needed
    return '/images/default.png';
  }
} 