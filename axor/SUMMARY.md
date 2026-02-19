# AXOR Backend - Complete Summary

## ✅ What We Built

### 1. Backend Server (`axor_app_backend/`)
- **Node.js + Express** API server
- **Port:** 3000
- **Features:**
  - User authentication (login/signup)
  - Song management and search
  - AI-powered recommendations
  - Smart Mode filtering
  - Playlist management

### 2. Database (`database/`)
- **Format:** JSON files (easy testing)
- **Files:**
  - `users.json` - 2 test accounts (admin + test user)
  - `songs.json` - 10 test songs with AI features
  - `playlists.json` - 3 pre-configured playlists
- **Features:**
  - BPM (beats per minute) for rhythm matching
  - Energy levels (0.0-1.0) for mood matching
  - Mood categories (energetic, calm, aggressive, sad)

### 3. Songs Storage (`songs/`)
- **Directories:**
  - `flac/` - Lossless audio files
  - `mp3/` - Compressed audio files
- **Status:** Ready for files (currently empty)
- **Note:** Can test without files (metadata only)

## 🎯 Key Features

### AI Modes

#### Flow Mode
- **Purpose:** Maintain consistent rhythm
- **Logic:** Prioritizes BPM similarity
- **Formula:** `similarity = 100 - (bpmDiff * 0.5 + energyDiff * 20)`
- **Use Cases:** Workouts, driving, dancing
- **Button:** AI button in music player

#### Intent Mode
- **Purpose:** Adapt to emotional state
- **Logic:** Prioritizes energy/mood similarity
- **Formula:** `similarity = 100 - (bpmDiff * 0.2 + energyDiff * 40)`
- **Use Cases:** Studying, relaxing, focusing
- **Button:** AI button in music player

### Smart Modes

#### Gym Mode (Red Theme)
- **Filter:** `energy >= 0.7 AND bpm >= 120`
- **Songs:** Thunder Strike, Gym Beast, Adrenaline Rush, Power Surge
- **Features:** Timer, high-energy queue

#### Study Mode (Cyan Theme)
- **Filter:** `energy <= 0.5 AND bpm <= 100`
- **Songs:** Focus Flow, Lost in Thought, Deep Concentration, Sunset Vibes
- **Features:** Focus timer, calm queue

#### Drive Mode (Green Theme)
- **Filter:** `energy >= 0.5 AND energy <= 0.8`
- **Songs:** Midnight Drive, Road Trip Anthem
- **Features:** Trip timer, steady rhythm

## 📊 Test Data

### Test Accounts

**Admin:**
- Email: `a67154512@gmail.com`
- Password: `admin123`
- Plan: Premium (100GB)

**Test User:**
- Email: `test@example.com`
- Password: `test123`
- Plan: Free (1GB)

### Test Songs (10 Total)

**High Energy (Gym):**
1. Thunder Strike - BPM 140, Energy 0.9
2. Gym Beast - BPM 150, Energy 0.95
3. Adrenaline Rush - BPM 160, Energy 1.0
4. Power Surge - BPM 145, Energy 0.92

**Low Energy (Study):**
1. Focus Flow - BPM 80, Energy 0.3
2. Lost in Thought - BPM 70, Energy 0.2
3. Deep Concentration - BPM 60, Energy 0.25
4. Sunset Vibes - BPM 90, Energy 0.4

**Medium Energy (Drive):**
1. Midnight Drive - BPM 110, Energy 0.6
2. Road Trip Anthem - BPM 115, Energy 0.7

## 🚀 Quick Start

### 1. Start Backend
```bash
cd axor_app_backend
npm install
npm start
```

Or double-click `START_BACKEND.bat` (Windows)

### 2. Test Backend
Open browser: `http://localhost:3000/health`

### 3. Connect Flutter App

**AVD (Emulator):**
```dart
const String baseUrl = 'http://10.0.2.2:3000';
```

**Real Device:**
```dart
const String baseUrl = 'http://YOUR_PC_IP:3000';
```

## 📡 API Endpoints

### Authentication
- `POST /api/auth/login` - User login
- `POST /api/auth/signup` - User registration

### Songs
- `GET /api/songs` - Get all songs
- `POST /api/songs/search` - Search songs
- `POST /api/songs/like/:songId` - Like/unlike song
- `GET /api/songs/liked/:userId` - Get liked songs

### AI Features
- `POST /api/ai/similar` - Get similar songs (Flow/Intent)
- `POST /api/ai/smart-mode` - Get Smart Mode songs

### Playlists
- `GET /api/playlists/:userId` - Get user playlists
- `POST /api/playlists` - Create playlist

### Profile
- `GET /api/profile/:userId` - Get user profile

### Health
- `GET /health` - Server status

## 🧪 Testing Examples

### Login
```bash
curl -X POST http://localhost:3000/api/auth/login \
  -H "Content-Type: application/json" \
  -d '{"email":"test@example.com","password":"test123"}'
```

### Get Songs
```bash
curl http://localhost:3000/api/songs
```

### Flow Mode (BPM matching)
```bash
curl -X POST http://localhost:3000/api/ai/similar \
  -H "Content-Type: application/json" \
  -d '{"songId":"song_001","mode":"flow"}'
```

### Intent Mode (Mood matching)
```bash
curl -X POST http://localhost:3000/api/ai/similar \
  -H "Content-Type: application/json" \
  -d '{"songId":"song_001","mode":"intent"}'
```

### Gym Mode
```bash
curl -X POST http://localhost:3000/api/ai/smart-mode \
  -H "Content-Type: application/json" \
  -d '{"mode":"gym","userId":"user_test1"}'
```

## 📁 File Structure

```
axor/
├── axor_app_backend/
│   ├── server.js           # Main server
│   ├── package.json        # Dependencies
│   └── README.md           # Backend docs
├── database/
│   ├── users.json          # User accounts
│   ├── songs.json          # Song metadata + AI
│   ├── playlists.json      # Playlists
│   ├── covers/             # Album covers
│   └── README.md           # Database docs
├── songs/
│   ├── flac/               # FLAC files
│   ├── mp3/                # MP3 files
│   └── README.md           # Songs docs
├── README.md               # Main docs
├── TESTING_GUIDE.md        # Testing instructions
├── SUMMARY.md              # This file
├── START_BACKEND.bat       # Windows start script
└── .gitignore              # Git ignore rules
```

## 🎨 AI Logic Explained

### Flow Mode Example
**Input:** Thunder Strike (BPM 140, Energy 0.9)

**Calculation for Gym Beast (BPM 150, Energy 0.95):**
```
bpmDiff = |140 - 150| = 10
energyDiff = |0.9 - 0.95| = 0.05
similarity = 100 - (10 * 0.5 + 0.05 * 20)
similarity = 100 - (5 + 1)
similarity = 94.0
```

**Result:** High similarity (BPM is close)

### Intent Mode Example
**Input:** Thunder Strike (BPM 140, Energy 0.9)

**Calculation for Adrenaline Rush (BPM 160, Energy 1.0):**
```
bpmDiff = |140 - 160| = 20
energyDiff = |0.9 - 1.0| = 0.1
similarity = 100 - (20 * 0.2 + 0.1 * 40)
similarity = 100 - (4 + 4)
similarity = 92.0
```

**Result:** High similarity (Energy is close)

## 🔄 How It Works

### User Plays a Song
1. User plays "Thunder Strike"
2. User taps AI button (Flow or Intent mode)
3. Backend analyzes song features (BPM 140, Energy 0.9)
4. Backend finds similar songs
5. Backend returns top 10 matches
6. App queues similar songs automatically

### Smart Mode Selection
1. User selects "Gym Mode"
2. Backend filters songs: `energy >= 0.7 AND bpm >= 120`
3. Backend returns 4 high-energy songs
4. App displays in Gym Mode screen
5. User starts workout with timer

## ✅ What's Ready

- ✅ Backend server (fully functional)
- ✅ Database with test data
- ✅ AI Flow Mode (BPM matching)
- ✅ AI Intent Mode (mood matching)
- ✅ Smart Modes (Gym, Study, Drive)
- ✅ User authentication
- ✅ Song management
- ✅ Playlist system
- ✅ API documentation
- ✅ Testing guide

## ⏳ What's Next

- ⏳ Add real audio files (optional for testing)
- ⏳ Connect Flutter app to backend
- ⏳ Test audio playback
- ⏳ Implement premium features
- ⏳ Add Spotify link download
- ⏳ Deploy to production

## 📝 Important Notes

### Flow Mode vs Intent Mode

**Flow Mode:**
- **When:** User wants consistent rhythm
- **How:** Matches BPM first
- **Example:** Running at steady pace, driving on highway
- **Button:** AI button (shows "Flow" when active)

**Intent Mode:**
- **When:** User wants similar mood/energy
- **How:** Matches energy/mood first
- **Example:** Studying (keep calm), working out (keep intense)
- **Button:** AI button (shows "Intent" when active)

### Smart Modes

**Gym Mode:**
- Pre-filtered for high energy
- No AI needed (already filtered)
- User can still use AI button for variety

**Study Mode:**
- Pre-filtered for low energy
- No AI needed (already filtered)
- User can still use AI button for variety

**Drive Mode:**
- Pre-filtered for medium energy
- No AI needed (already filtered)
- User can still use AI button for variety

## 🎯 Success Criteria

✅ **Backend is working** if:
- Server starts on port 3000
- Health check returns OK
- Login works with test accounts
- Songs API returns 10 songs
- AI modes return similar songs
- Smart Modes filter correctly

✅ **Ready for Flutter** if:
- Backend responds to all API calls
- AI logic returns expected results
- Test data is complete
- Documentation is clear

## 📞 Support

**Admin:** a67154512@gmail.com

## 🎵 Let's Build AXOR!

The backend is complete and ready for testing. All AI features are implemented and working. Connect your Flutter app and start testing!

**Everything is ready. Let's make music smart!** 🚀