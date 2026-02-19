# AXOR Backend Server

Backend API for AXOR Music App with AI-powered recommendations.

## Features

- 🔐 User authentication (login/signup)
- 🎵 Song management and search
- ❤️ Like/unlike songs
- 🤖 AI-powered song recommendations
- 📊 Smart Mode suggestions (Gym, Study, Drive)
- 📁 Playlist management
- 👤 User profile management

## Setup

### 1. Install Dependencies

```bash
npm install
```

### 2. Start Server

**Development mode (with auto-reload):**
```bash
npm run dev
```

**Production mode:**
```bash
npm start
```

Server will run on `http://localhost:3000`

## API Endpoints

### Authentication

- `POST /api/auth/login` - User login
- `POST /api/auth/signup` - User registration

### Songs

- `GET /api/songs` - Get all songs
- `POST /api/songs/search` - Search songs
- `POST /api/songs/like/:songId` - Like/unlike song
- `GET /api/songs/liked/:userId` - Get user's liked songs

### AI Features

- `POST /api/ai/similar` - Get similar songs (Flow/Intent mode)
- `POST /api/ai/smart-mode` - Get songs for Smart Modes

### Playlists

- `GET /api/playlists/:userId` - Get user playlists
- `POST /api/playlists` - Create new playlist

### Profile

- `GET /api/profile/:userId` - Get user profile

### Health Check

- `GET /health` - Server health status

## AI Modes

### Flow Mode
- Prioritizes BPM similarity
- Maintains consistent rhythm
- Perfect for workouts and driving

### Intent Mode
- Prioritizes energy/mood similarity
- Adapts to emotional state
- Perfect for studying and relaxing

## Smart Modes

### Gym Mode
- High energy songs (energy >= 0.7)
- High BPM (>= 120)
- Motivational tracks

### Study Mode
- Low energy songs (energy <= 0.5)
- Low BPM (<= 100)
- Focus-friendly music

### Drive Mode
- Medium energy (0.5 - 0.8)
- Steady rhythm
- Road trip vibes

## Database Structure

### Users (users.json)
```json
{
  "id": "user_123",
  "email": "user@example.com",
  "username": "user",
  "plan": "free",
  "storageUsed": 0,
  "storageLimit": 1,
  "likedSongs": [],
  "playlists": []
}
```

### Songs (songs.json)
```json
{
  "id": "song_123",
  "title": "Song Name",
  "artist": "Artist Name",
  "album": "Album Name",
  "duration": 225,
  "bpm": 120,
  "energy": 0.8,
  "mood": "energetic",
  "filePath": "/songs/flac/song.flac",
  "coverPath": "/covers/song.jpg"
}
```

### Playlists (playlists.json)
```json
{
  "id": "playlist_123",
  "userId": "user_123",
  "name": "My Playlist",
  "description": "Description",
  "songs": ["song_1", "song_2"],
  "createdAt": "2026-02-06T00:00:00Z"
}
```

## Testing

### Using AVD (Android Emulator)

Flutter app should connect to:
```dart
const String baseUrl = 'http://10.0.2.2:3000';
```

### Using Real Device

Find your PC's IP address and use:
```dart
const String baseUrl = 'http://192.168.1.100:3000';
```

## Admin Account

**Email:** a67154512@gmail.com  
**Default Password:** (set in users.json)

## Notes

- All data stored in JSON files for easy testing
- Songs served as static files from `/songs` directory
- Album covers served from `/covers` directory
- No database setup required for testing
- Ready for production database migration later

## Future Enhancements

- [ ] Spotify link download integration
- [ ] Advanced AI mood detection
- [ ] Collaborative filtering
- [ ] Cloud storage integration (Cloudflare R2)
- [ ] Gift card redemption system
- [ ] Premium subscription management