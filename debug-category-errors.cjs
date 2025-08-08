const fetch = require('node-fetch');

// Configuration
const SUPABASE_URL = process.env.SUPABASE_URL || 'http://127.0.0.1:54321';
const SUPABASE_ANON_KEY = process.env.SUPABASE_ANON_KEY || 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZS1kZW1vIiwicm9sZSI6ImFub24iLCJleHAiOjE5ODM4MTI5OTZ9.CRXP1A7WOeoJeXxjNni43kdQwgnWNReilDMblYTn_I0';

// Test the failed categories
const FAILED_CATEGORIES = [
  {
    id: 'strength-building',
    name: 'Strength Training & Muscle Building'
  },
  {
    id: 'weight-loss',
    name: 'Weight Loss & Fat Burning'
  }
];

async function testCategoryGeneration(categoryId, categoryName) {
  try {
    console.log(`\n🔍 Testing category: ${categoryName} (${categoryId})`);
    
    // Call the AI exercise generation function
    const response = await fetch(`${SUPABASE_URL}/functions/v1/generate-ai-exercises`, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'Authorization': `Bearer ${SUPABASE_ANON_KEY}`
      },
      body: JSON.stringify({
        goalCategory: categoryId,
        exerciseCount: 5, // Test with fewer exercises
        forceRefresh: true
      })
    });

    console.log(`Response status: ${response.status}`);
    
    if (!response.ok) {
      const errorText = await response.text();
      console.error(`❌ HTTP Error for ${categoryName}:`, errorText);
      return { success: false, error: `HTTP ${response.status}: ${errorText}` };
    }

    const data = await response.json();
    console.log(`Response data keys:`, Object.keys(data));
    
    if (data.error) {
      console.error(`❌ API Error for ${categoryName}:`, data.error);
      return { success: false, error: data.error };
    }
    
    if (!data.exercises || !Array.isArray(data.exercises)) {
      console.error(`❌ Invalid response structure for ${categoryName}:`, data);
      return { success: false, error: 'Invalid response structure' };
    }

    console.log(`✅ Successfully generated ${data.exercises.length} exercises for ${categoryName}`);
    
    // Show first exercise as sample
    if (data.exercises.length > 0) {
      console.log(`Sample exercise:`, {
        name: data.exercises[0].name,
        category: data.exercises[0].category,
        difficulty: data.exercises[0].difficulty,
        muscle_groups: data.exercises[0].muscle_groups
      });
    }
    
    return { success: true, count: data.exercises.length };
  } catch (error) {
    console.error(`❌ Exception for ${categoryName}:`, error.message);
    return { success: false, error: error.message };
  }
}

async function main() {
  console.log('🚀 Debugging failed category generation...');
  
  const results = [];
  
  for (const category of FAILED_CATEGORIES) {
    const result = await testCategoryGeneration(category.id, category.name);
    results.push({
      category: category.name,
      ...result
    });
    
    // Add delay between tests
    await new Promise(resolve => setTimeout(resolve, 2000));
  }
  
  console.log(`\n${'='.repeat(60)}`);
  console.log('📊 Debug Results:');
  console.log(`${'='.repeat(60)}`);
  
  results.forEach(result => {
    console.log(`\n${result.category}:`);
    if (result.success) {
      console.log(`  ✅ Success - ${result.count} exercises generated`);
    } else {
      console.log(`  ❌ Failed - ${result.error}`);
    }
  });
  
  // Save results
  const fs = require('fs');
  fs.writeFileSync('debug-category-results.json', JSON.stringify(results, null, 2));
  console.log('\n💾 Results saved to debug-category-results.json');
}

main().catch(console.error); 