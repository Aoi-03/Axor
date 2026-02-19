# AI Song Matching Feature

## Overview
The AI button (4th state of shuffle/repeat button) automatically suggests and plays similar songs based on the currently playing song.

## How It Works

### 1. Metadata Fetching
- Backend fetches song metadata from **MusicBrainz API** (free, no API key needed)
- Extracts: genres, mood, energy, tempo
- Caches metadata in `song_metadata_cache/song_metadata.json` for fast access

### 2. Similarity Algorithm
Songs are matched based on:
- **Genre similarity** (40% weight) - Matches songs with same genre
- **Mood similarity** (30% weight) - Matches energetic/calm/sad/neutral moods
- **Energy similarity** (20% weight) - Matches energy levels (0.0 to 1.0)
- **Tempo similarity** (10% weight) - Matches BPM (beats per minute)

### 3. Auto-Play Logic
When AI mode is active (shuffle button shows ✨ icon):
- When current song finishes, backend finds top 20 most similar songs
- Plays the most similar song automatically
- Updates playlist with similar songs for seamless flow

## Button States
1. **Repeat** (🔁) - Repeat entire playlist
2. **Repeat One** (🔂) - Repeat current song
3. **Shuffle** (🔀) - Random shuffle
4. **AI Mode** (✨) - Smart similar song suggestions

## Backend Endpoints

### Get Similar Songs
```
POST /api/ai/similar
Body: { "songId": "song_xxx" }
Response: { "success": true, "songs": [...] }
```

### Get Song Metadata
```
GET /api/songs/metadata/:songId
Response: { "success": true, "metadata": { "genres": [...], "mood": "...", "energy": 0.7, "tempo": 120 } }
```

## Cache Management
- Metadata is cached permanently in `song_metadata_cache/song_metadata.json`
- First fetch takes ~2-5 seconds per song
- Subsequent requests are instant (from cache)
- Cache survives server restarts

## Fallback Behavior
If metadata fetch fails or no similar songs found:
- Uses basic metadata from FLAC file tags
- Falls back to playing next song in playlist
- No errors shown to user

## Performance
- Similarity calculation: ~1ms per song (225 songs = ~225ms)
- Metadata fetch: ~2-5 seconds (only first time)
- Cache lookup: <1ms
- Total response time: <500ms (with cache)

## Future Improvements
- Add more music APIs (Last.fm, Spotify) for better metadata
- Machine learning for personalized recommendations
- User feedback to improve similarity algorithm
- Collaborative filtering based on listening history
