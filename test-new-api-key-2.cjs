const fetch = require('node-fetch');

// Test the new API key
const NEW_API_KEY = 'AIzaSyBQwXqQqQqQqQqQqQqQqQqQqQqQqQqQqQ';

async function testGeminiAPI() {
  console.log('🧪 Testing new Gemini API key...');
  
  try {
    // Test text generation first
    const textResponse = await fetch(`https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash:generateContent?key=${NEW_API_KEY}`, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify({
        contents: [{
          parts: [{
            text: 'Say "Hello, this is a test"'
          }]
        }],
        generationConfig: {
          temperature: 0.7,
          maxOutputTokens: 100,
        }
      })
    });

    console.log(`Text generation status: ${textResponse.status}`);
    
    if (textResponse.ok) {
      const textData = await textResponse.json();
      console.log('✅ Text generation successful:', textData.candidates[0].content.parts[0].text);
    } else {
      const errorData = await textResponse.json();
      console.log('❌ Text generation failed:', errorData);
    }

    // Test image generation
    const imageResponse = await fetch(`https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash:generateContent?key=${NEW_API_KEY}`, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify({
        contents: [{
          parts: [{
            text: 'Generate a simple image of a push-up exercise, showing proper form from the side view. Make it clean and clear.'
          }]
        }],
        generationConfig: {
          temperature: 0.7,
          maxOutputTokens: 2048,
        }
      })
    });

    console.log(`\nImage generation status: ${imageResponse.status}`);
    
    if (imageResponse.ok) {
      const imageData = await imageResponse.json();
      console.log('✅ Image generation successful');
      console.log('Response preview:', JSON.stringify(imageData, null, 2).substring(0, 500) + '...');
    } else {
      const errorData = await imageResponse.json();
      console.log('❌ Image generation failed:', errorData);
    }

  } catch (error) {
    console.error('❌ Error testing API:', error.message);
  }
}

testGeminiAPI(); 