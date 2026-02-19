// Quick script to analyze all songs
const axios = require('axios');

async function analyzeSongs() {
  console.log('🤖 Starting song analysis...\n');
  
  try {
    const response = await axios.post('http://localhost:3001/api/ai/analyze-all', {}, {
      timeout: 300000 // 5 minutes timeout
    });
    
    console.log('\n✅ Analysis complete!');
    console.log(`📊 Results:`);
    console.log(`   - Analyzed: ${response.data.analyzed}`);
    console.log(`   - Already cached: ${response.data.cached}`);
    console.log(`   - Failed: ${response.data.failed}`);
    console.log(`   - Total songs: ${response.data.total}`);
    
  } catch (error) {
    console.error('❌ Error:', error.message);
  }
}

analyzeSongs();
