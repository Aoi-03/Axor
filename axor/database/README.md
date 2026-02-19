# AXOR Database

JSON-based database for AXOR Music App testing.

## Structure

```
database/
├── users.json          # User accounts and profiles
├── songs.json          # Song metadata and AI features
├── playlists.json      # User playlists
└── covers/             # Album cover images
```

## Files

### users.json

Stores user account information:
- User ID
- Email and password
- Username
- Plan (free/premium)
- Storage usage and limits
- Liked songs
- Playlists

**Admin Account:**
- Email: a67154512@gmail.com
- Password: admin123
- Plan: Premium (100GB)

**Test Account:**
- Email: test@example.com
- Password: test123
- Plan: Free (1GB)

### songs.json

Stores song metadata and AI features:
- Song ID
- Title, artist, album
- Duration
- **BPM** (beats per minute)
- **Energy** (0.0 - 1.0)
- **Mood** (energetic, calm, aggressive, sad, neutral)
- Genre
- File path (FLAC/MP3)
- Cover image path
- File size, format, sample rate, bitrate

**AI Features:**
- BPM: Used for rhythm matching
- Energy: Used for mood matching
- Mood: Used for Smart Mode filtering

### playlists.json

Stores user playlists:
- Playlist ID
- User ID
- Name and description
- Song IDs array
- Creation date

**Pre-created Playlists:**
- Gym Mode - High Energy
- Study Mode - Focus
- Drive Mode - Road Trip

## Sample Songs

10 test songs with varied characteristics:

### High Energy (Gym Mode)
1. **Thunder Strike** - BPM: 140, Energy: 0.9
2. **Gym Beast** - BPM: 150, Energy: 0.95
3. **Adrenaline Rush** - BPM: 160, Energy: 1.0
4. **Power Surge** - BPM: 145, Energy: 0.92

### Low Energy (Study Mode)
1. **Focus Flow** - BPM: 80, Energy: 0.3
2. **Lost in Thought** - BPM: 70, Energy: 0.2
3. **Deep Concentration** - BPM: 60, Energy: 0.25
4. **Sunset Vibes** - BPM: 90, Energy: 0.4

### Medium Energy (Drive Mode)
1. **Midnight Drive** - BPM: 110, Energy: 0.6
2. **Road Trip Anthem** - BPM: 115, Energy: 0.7

## AI Modes

### Flow Mode
- Prioritizes **BPM similarity**
- Maintains consistent rhythm
- Formula: `similarity = 100 - (bpmDiff * 0.5 + energyDiff * 20)`

### Intent Mode
- Prioritizes **energy/mood similarity**
- Adapts to emotional state
- Formula: `similarity = 100 - (bpmDiff * 0.2 + energyDiff * 40)`

## Smart Modes

### Gym Mode
- Filter: `energy >= 0.7 AND bpm >= 120`
- Returns: High-energy, fast-paced songs

### Study Mode
- Filter: `energy <= 0.5 AND bpm <= 100`
- Returns: Low-energy, calm songs

### Drive Mode
- Filter: `energy >= 0.5 AND energy <= 0.8`
- Returns: Medium-energy, steady rhythm

## Usage

### Add New User
```json
{
  "id": "user_new",
  "email": "newuser@example.com",
  "password": "password123",
  "username": "NewUser",
  "plan": "free",
  "storageUsed": 0,
  "storageLimit": 1,
  "likedSongs": [],
  "playlists": [],
  "createdAt": "2026-02-06T00:00:00Z"
}
```

### Add New Song
```json
{
  "id": "song_new",
  "title": "New Song",
  "artist": "New Artist",
  "album": "New Album",
  "duration": 240,
  "bpm": 120,
  "energy": 0.7,
  "mood": "energetic",
  "genre": "Pop",
  "filePath": "/songs/flac/new_song.flac",
  "coverPath": "/covers/new_song.jpg",
  "fileSize": 35000000,
  "format": "FLAC",
  "sampleRate": 44100,
  "bitrate": 1411
}
```

## Notes

- All passwords are stored in plain text for testing (use hashing in production)
- File paths are relative to backend server
- Song files should be placed in `../songs/flac/` or `../songs/mp3/`
- Cover images should be placed in `covers/`
- Storage sizes are in bytes
- Energy values range from 0.0 (calm) to 1.0 (aggressive)
- BPM values typically range from 60 (slow) to 180 (very fast)

## Migration to Production

When ready for production:
1. Replace JSON files with PostgreSQL/MongoDB
2. Add password hashing (bcrypt)
3. Add JWT authentication
4. Add file upload handling
5. Add Cloudflare R2 integration
6. Add proper error handling
7. Add data validation