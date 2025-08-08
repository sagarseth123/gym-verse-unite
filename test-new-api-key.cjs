const fetch = require('node-fetch');

// Test the new API key
const NEW_API_KEY = 'AIzaSyB5VwcpawV1ntLKhghoarAx2x1PJwlte8w';

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
      console.log('✅ Text generation successful:', textData.candidates?.[0]?.content?.parts?.[0]?.text);
    } else {
      const errorText = await textResponse.text();
      console.log('❌ Text generation failed:', errorText);
    }

    // Test image generation
    const imageResponse = await fetch(`https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash-preview-image-generation:generateContent?key=${NEW_API_KEY}`, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify({
        contents: [{
          parts: [{
            text: 'Create a simple stick figure doing a push-up'
          }]
        }],
        generationConfig: {
          responseModalities: ["IMAGE", "TEXT"],
          temperature: 0.7
        }
      })
    });

    console.log(`Image generation status: ${imageResponse.status}`);
    
    if (imageResponse.ok) {
      const imageData = await imageResponse.json();
      console.log('✅ Image generation successful');
      console.log('Response keys:', Object.keys(imageData));
    } else {
      const errorText = await imageResponse.text();
      console.log('❌ Image generation failed:', errorText);
    }

  } catch (error) {
    console.error('❌ Test failed:', error.message);
  }
}

testGeminiAPI(); 