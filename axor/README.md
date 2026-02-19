# AXOR Music App 🎵

A modern music streaming app with AI-powered recommendations, built with Flutter and Node.js.

## Features

**AI-Powered Recommendations**
- Smart emotion detection
- AI similarity algorithm
- Dynamic "Your Vibe" playlists based on time and mood

**Music Streaming**
- Stream from MEGA cloud storage
- 189+ songs library
- High-quality audio (MP3/FLAC)

**Smart Features**
- Smart Modes (GYM, STUDY, DRIVE)
- User playlists ("The Shelf")
- Like/favorite system
- Shuffle, repeat, and AI auto-play

**Beautiful UI**
- Cyberpunk-inspired design
- Smooth animations
- Custom Charmonman font
- Dark theme

## Project Structure

```
axor/
├── axor_app/              # Flutter mobile app
│   ├── lib/
│   │   ├── screens/       # UI screens
│   │   ├── services/      # API & audio services
│   │   ├── models/        # Data models
│   │   └── widgets/       # Reusable widgets
│   └── android/ios/       # Platform-specific code
│
└── axor_app_backend/      # Node.js backend
    ├── server.js          # Main server
    ├── mega_service.js    # MEGA integration
    └── database/          # JSON databases
```

## Tech Stack

**Frontend:**
- Flutter 3.x
- Provider (state management)
- just_audio (audio playback)
- http (API calls)

**Backend:**
- Node.js + Express
- MEGA.js (cloud storage)
- music-metadata (audio analysis)
- Custom AI emotion detection

## Getting Started

### Prerequisites

- Flutter SDK 3.x
- Node.js 18+
- MEGA account with public folder

### Backend Setup

1. Navigate to backend:
```bash
cd axor_app_backend
```

2. Install dependencies:
```bash
npm install
```

3. Create `.env` file:
```bash
cp .env.example .env
```

4. Edit `.env` with your MEGA credentials:
```
MEGA_EMAIL=your-email@example.com
MEGA_PASSWORD=your-password
STORAGE_MODE=mega
MEGA_FOLDER_NAME=AxorMusic
PORT=3001
```

5. Start server:
```bash
npm start
```

### Flutter App Setup

1. Navigate to app:
```bash
cd axor_app
```

2. Install dependencies:
```bash
flutter pub get
```

3. Update API URL in `lib/services/api_config.dart`:
```dart
static const String baseUrl = 'http://your-backend-url';
```

4. Run app:
```bash
flutter run
```

## Deployment

### Backend (Render.com)

1. Sign up at [render.com](https://render.com)
2. Create new Web Service
3. Connect this GitHub repo
4. Set root directory: `axor_app_backend`
5. Add environment variables
6. Deploy!

See `RENDER_STEP_BY_STEP.md` for detailed instructions.

### Flutter App

Build APK:
```bash
cd axor_app
flutter build apk --release
```

APK location: `build/app/outputs/flutter-apk/app-release.apk`

## Features in Detail

### AI Emotion Detection
- Analyzes song titles and metadata
- Detects 6 emotions: energetic, sad, happy, calm, epic, neutral
- Assigns energy levels (0.3-0.9)
- Powers AI recommendations

### Your Vibe
- Dynamic playlists based on time of day
- Morning Energy, Afternoon Flow, Evening Chill, Midnight Thoughts
- Mood-based suggestions
- Updates automatically

### The Shelf
- Create unlimited playlists
- Stored locally on device
- Add songs from Master Library
- Sync-free (no server pressure)

### Smart Modes
- **GYM MODE**: High-energy workout tracks
- **STUDY MODE**: Focus and concentration music
- **DRIVE MODE**: Smooth driving vibes

## API Endpoints

```
GET  /health                    # Health check
GET  /api/songs                 # Get all songs
POST /api/search                # Search songs
POST /api/ai/similar            # Get similar songs
POST /api/ai/vibes              # Get AI vibes
POST /api/smart-mode            # Get smart mode songs
GET  /api/stream/:songId        # Stream song
GET  /api/cover/:songId         # Get cover art
```

## Contributing

This is a personal project, but feel free to fork and customize!

## License

MIT License - See LICENSE file for details

## Author

Built by Aoi

## Acknowledgments

- MEGA.js for cloud storage
- Flutter team for amazing framework
- just_audio for audio playback
- All open-source contributors

---

**Enjoy your music!** 
