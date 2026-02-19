# AXOR Backend - Using Your Music Library

## 🎵 Your Music Library

**Path:** `C:\Users\LUNA\Downloads\AI`

The backend now scans your existing FLAC files directly!

## ✅ What the Backend Does

1. **Scans** your `C:\Users\LUNA\Downloads\AI` folder
2. **Reads** all `.flac` files
3. **Extracts** metadata from FLAC tags:
   - Title
   - Artist
   - Album
   - Duration
   - Genre
   - Album art (embedded)
   - Sample rate, bitrate
4. **Estimates** AI features:
   - BPM (beats per minute)
   - Energy level (0.0-1.0)
   - Mood (energetic, calm, sad, neutral)
5. **Serves** songs via API

## 🚀 Quick Start

### 1. Install Dependencies

```bash
cd axor_app_backend
npm install
```

This will install:
- `express` - Web server
- `cors` - Cross-origin requests
- `music-metadata` - FLAC metadata extraction

### 2. Start Backend

```bash
npm start
```

Or double-click `START_BACKEND.bat`

### 3. Watch the Scan

You'll see:
```
🎵 AXOR Backend running on http://localhost:3000
📁 Music library: C:\Users\LUNA\Downloads\AI
🔍 Scanning music library...
✅ Added: Song Title by Artist Name
✅ Added: Another Song by Another Artist
...
🎵 Total songs scanned: 25
```

### 4. Test It

Open browser: `http://localhost:3000/api/songs`

You'll see all your songs with metadata!

## 🎨 AI Features

### Automatic Estimation

The backend automatically estimates:

**BPM (Beats Per Minute):**
- Based on song title keywords
- "gym", "workout" → 150 BPM
- "study", "focus" → 80 BPM
- "drive", "road" → 110 BPM
- Default: 120 BPM

**Energy Level:**
- Based on genre
- EDM, Electronic → 0.9 (very high)
- Rock, Metal → 0.8 (high)
- Pop → 0.7 (medium-high)
- Ambient, Classical → 0.3 (low)
- Default: 0.6 (medium)

**Mood:**
- Energy >= 0.8 → "energetic"
- Energy >= 0.6 → "neutral"
- Energy >= 0.4 → "calm"
- Energy < 0.4 → "sad"

### Future: Real Analysis

Later we can add real audio analysis:
- Use `librosa` (Python) for accurate BPM detection
- Use `essentia` for energy/mood analysis
- Store results in cache for faster loading

## 📡 API Endpoints

### Get All Songs
```bash
curl http://localhost:3000/api/songs
```

Returns all songs from your library with metadata.

### Rescan Library
```bash
curl -X POST http://localhost:3000/api/songs/rescan
```

Rescans your folder if you added new songs.

### Search Songs
```bash
curl -X POST http://localhost:3000/api/songs/search \
  -H "Content-Type: application/json" \
  -d '{"query":"song name"}'
```

### AI Flow Mode
```bash
curl -X POST http://localhost:3000/api/ai/similar \
  -H "Content-Type: application/json" \
  -d '{"songId":"song_id","mode":"flow"}'
```

### AI Intent Mode
```bash
curl -X POST http://localhost:3000/api/ai/similar \
  -H "Content-Type: application/json" \
  -d '{"songId":"song_id","mode":"intent"}'
```

### Smart Modes
```bash
curl -X POST http://localhost:3000/api/ai/smart-mode \
  -H "Content-Type: application/json" \
  -d '{"mode":"gym","userId":"user_test1"}'
```

## 🎵 Song Access

Your songs are served at:
```
http://localhost:3000/songs/your_song.flac
```

The Flutter app can stream directly from this URL!

## 🔄 Adding New Songs

1. Add FLAC files to `C:\Users\LUNA\Downloads\AI`
2. Restart backend OR call rescan API:
   ```bash
   curl -X POST http://localhost:3000/api/songs/rescan
   ```
3. New songs appear automatically!

## 📊 Metadata Extraction

The backend reads these FLAC tags:
- `title` - Song title
- `artist` - Artist name
- `album` - Album name
- `genre` - Music genre
- `year` - Release year
- `picture` - Embedded album art
- `duration` - Song length
- `sampleRate` - Audio quality
- `bitrate` - Audio bitrate

## 🎨 Album Art

Album art is extracted from FLAC files:
- If embedded → Shows in app
- If not embedded → Shows placeholder

## ⚡ Performance

**First scan:** Takes a few seconds (depends on library size)
**Subsequent requests:** Instant (uses cache)
**Rescan:** Only when you add new songs

## 🐛 Troubleshooting

### No songs found?
- Check path: `C:\Users\LUNA\Downloads\AI`
- Make sure FLAC files exist
- Check console for errors

### Metadata not showing?
- FLAC files must have embedded tags
- Use a tool like MusicBrainz Picard to add tags

### Songs not playing?
- Check file permissions
- Make sure backend is running
- Check Flutter app URL configuration

## 🎯 Next Steps

1. ✅ Backend scans your library
2. ✅ Metadata extracted from FLAC
3. ✅ AI features estimated
4. ⏳ Connect Flutter app
5. ⏳ Test playback
6. ⏳ Improve AI estimation (optional)

## 📝 Notes

- No separate database needed for songs
- Songs stay in your folder
- Backend just reads and serves
- Fast and simple!

**Your music, your way!** 🎵