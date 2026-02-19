# AI Emotion Detection System

## Overview

The backend now uses **Last.fm API** to fetch accurate emotion and mood data for songs, with MusicBrainz as a fallback.

## How It Works

### 1. Data Sources (Priority Order)

```
1. Last.fm API (Primary)
   ├── Emotion tags: energetic, sad, happy, chill, etc.
   ├── Genre tags: rock, pop, electronic, etc.
   └── Community-tagged by millions of users

2. MusicBrainz (Fallback)
   ├── Genre tags
   └── Estimated mood from genres

3. Filename Heuristics (Last Resort)
   └── Basic estimation from title/genre
```

### 2. Emotion Mapping

Last.fm tags are mapped to emotions and energy levels:

**High Energy (0.8-0.9)**:
- energetic, powerful, intense, aggressive, angry, epic

**Happy (0.7-0.75)**:
- happy, uplifting, cheerful, joyful, beautiful

**Sad (0.25-0.4)**:
- sad, melancholic, depressing, emotional, dark

**Calm (0.3-0.4)**:
- chill, calm, peaceful, relaxing, ambient, mellow

**Neutral (0.5-0.6)**:
- atmospheric, other unmatched tags

### 3. Metadata Structure

```javascript
{
  genres: ['rock', 'alternative'],
  mood: 'energetic',
  energy: 0.85,
  emotions: ['energetic', 'powerful', 'intense'],
  tags: ['energetic', 'rock', 'powerful', 'epic', 'intense'],
  tempo: 120,
  source: 'lastfm',
  fetchedAt: '2026-02-19T...'
}
```

### 4. AI Similarity Algorithm (Enhanced)

**Weights**:
- Emotion similarity: 40% (NEW!)
- Genre similarity: 30%
- Energy similarity: 20%
- Tempo similarity: 10%

**Example**:
```
Song A: energetic, rock, 0.85 energy
Song B: energetic, metal, 0.9 energy
Similarity: 95/100 (same emotion, similar genre, close energy)

Song A: energetic, rock, 0.85 energy
Song C: sad, classical, 0.3 energy
Similarity: 20/100 (different emotion, genre, energy)
```

## Usage

### Analyze All Songs (One-Time Setup)

```bash
# Method 1: Via API
curl -X POST http://localhost:3001/api/ai/analyze-all

# Method 2: Via script
node analyze_songs.js
```

This will:
1. Fetch emotion data from Last.fm for each song
2. Cache results in `song_metadata_cache/song_metadata.json`
3. Take ~5 seconds per song (with 0.5s delay to avoid rate limits)
4. For 8 songs: ~40 seconds total

### Get Similar Songs

```bash
curl -X POST http://localhost:3001/api/ai/similar \
  -H "Content-Type: application/json" \
  -d '{"songId": "mega_public_1"}'
```

Returns top 20 similar songs based on emotions, genre, energy, and tempo.

### Smart Modes

```bash
# Gym Mode (high energy)
curl -X POST http://localhost:3001/api/ai/smart-mode \
  -H "Content-Type: application/json" \
  -d '{"mode": "gym"}'

# Study Mode (low energy, calm)
curl -X POST http://localhost:3001/api/ai/smart-mode \
  -H "Content-Type: application/json" \
  -d '{"mode": "study"}'

# Drive Mode (medium energy)
curl -X POST http://localhost:3001/api/ai/smart-mode \
  -H "Content-Type: application/json" \
  -d '{"mode": "drive"}'
```

## Benefits

✅ **Accurate**: Community-tagged emotions from millions of Last.fm users
✅ **Fast**: Cached results, only fetch once per song
✅ **Free**: No API key needed for basic Last.fm features
✅ **Reliable**: Fallback to MusicBrainz if Last.fm fails
✅ **Smart**: Better AI recommendations based on real emotions

## Example Output

```
🔍 Analyzing: Star Odyssey - HOYO-MiX, 鈴木愛理
✅ Last.fm: Star Odyssey - Tags: epic, orchestral, energetic, powerful, uplifting
✅ 1/8: Star Odyssey → energetic (epic, powerful, energetic)

🔍 Analyzing: SPECIALZ - King Gnu
✅ Last.fm: SPECIALZ - Tags: energetic, rock, intense, powe