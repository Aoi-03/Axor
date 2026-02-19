# AXOR – Complete Functional Breakdown (Build-Ready)

**Admin:** a67154512@gmail.com  
**Last Updated:** February 6, 2026  
**Status:** Build-Ready Specification

This document lists every function, system, and behavior we discussed — clean, explicit, and implementation-oriented. This is what you hand to future-you or a dev team.

---

## 1. PRODUCT IDENTITY

**AXOR = Local-first, Lossless, Mood-driven Music Player**

### Key Principles:
- ✅ **FLAC-first** (no forced compression)
- ✅ **Offline-first** (works without internet)
- ✅ **AI assists, never controls**
- ✅ **User owns their music**
- ✅ **Cloud is premium + curated** (not user-upload chaos)

---

## 2. USER FLOWS

### 2.1 User Types

#### **Free User**
- No cloud required
- Local music only
- Full Smart Mode access
- AI suggestions from local library

#### **Premium User**
- Local + curated cloud music
- Offline downloads from cloud
- Advanced AI mood packs

#### **Admin (You - a67154512@gmail.com)**
- Upload curated FLAC packs
- Control cloud library
- Train / update AI mood references

---

## 3. AUTHENTICATION SYSTEM

### Functions:
- ✅ Email + password signup
- ✅ Email + password login
- ⏳ Google OAuth login (future)
- ✅ Forgot password (email reset)
- ✅ Password visibility toggle
- ✅ Optional auth (local-only users can skip login)

**Current Status:** Email/password implemented in UI, backend integration pending

---

## 4. LOCAL MUSIC SYSTEM (CORE)

### 4.1 File Handling

**Functions:**
- Scan selected folders recursively
- Detect audio formats: FLAC, WAV, MP3, AAC, M4A, OGG, OPUS
- Ignore unsupported / corrupt files

**Implementation:**
```dart
// User selects folder
// App scans recursively
// Filters by extension: .flac, .wav, .mp3, .aac, .m4a, .ogg, .opus
// Adds to local database
```

### 4.2 Metadata Extraction

**Per file:**
- Title
- Artist
- Album
- Duration
- Bitrate
- Sample rate
- File path
- Album art (embedded or folder.jpg)

**Storage:** Local DB (SQLite / Hive)

**Backend Note:** For testing, you can use local PC paths like:
```
D:\Music\FLAC\
D:\Music\MP3\
```

---

## 5. AUDIO ANALYSIS & AI ENGINE

### 5.1 Feature Extraction (One-time per song)

**Functions:**
- BPM detection
- Loudness (RMS)
- Energy level
- Spectral centroid
- Mood embedding vector

**Cached locally** (no repeat processing)

**Implementation:**
```dart
// On first scan:
// Extract features using audio analysis library
// Store in local DB
// Never re-process unless file changes
```

### 5.2 Mood Classification

**Supported moods:**
- Energetic
- Calm
- Focus
- Aggressive
- Sad
- Neutral

**AI does similarity matching, not lyric scraping.**

---

## 6. SMART MODES (KEY DIFFERENTIATOR)

All Smart Modes share:
- Dedicated theme color
- Circular timer
- AI-based queue generation
- Manual queue override
- Mini player + bottom nav

### 6.1 Gym Mode

**Functions:**
- High-energy song selection
- BPM-prioritized queue
- Red UI theme
- Workout stopwatch
- Auto-next song selection

**Current Status:** ✅ UI complete, AI queue logic pending

### 6.2 Study Mode

**Functions:**
- Low-energy, focus-safe songs
- Cyan UI theme
- Focus / Pomodoro timer
- Distraction-minimized UI

**Current Status:** ✅ UI complete, AI queue logic pending

### 6.3 Drive Mode

**Functions:**
- Medium-energy continuous flow
- Green UI theme
- Long-play preference
- Minimal interaction UI

**Current Status:** ✅ UI complete, AI queue logic pending

---

## 7. AI PLAYBACK LOGIC (CRITICAL)

### Two AI Paths:

#### **Mode A – Live AI**
1. User plays a song
2. AI analyzes last N songs
3. Next songs queued by similarity

**Implementation:**
```dart
// User plays Song A
// AI looks at Song A's features (BPM, energy, mood)
// Searches local library for similar songs
// Queues top 10 matches
// User can skip or accept
```

#### **Mode B – AI Album**
1. Pre-generated mood albums
2. User selects album
3. AI does not interfere

**Implementation:**
```dart
// Admin creates "Energetic Workout" album
// Contains 50 pre-selected songs
// User plays album
// Songs play in order (no AI interference)
// User can switch to Live AI anytime
```

**User can switch anytime.**

---

## 8. SEARCH & DISCOVERY

### Functions:
- ✅ Search by song / artist / album
- ✅ Recent search history (max 7 items)
- ✅ Quick replay from history

**Current Status:** ✅ UI complete, backend search pending

**Future (Later):**
- ⏳ Spotify link download (complex, will do later)

---

## 9. LIBRARY MANAGEMENT

### 9.1 Local Library

**Functions:**
- List all local songs
- Playlist creation
- Offline playback
- Like/favorite songs

**Current Status:** ✅ UI complete, local DB integration pending

### 9.2 Cloud Library (Premium)

**Functions:**
- Access AXOR-curated libraries
- Download FLAC once
- Offline playback
- **No user uploads**

**Current Status:** ✅ UI complete, cloud integration pending

---

## 10. PLAYER SYSTEM

### Functions:
- Lossless playback pipeline
- Mini player (bottom bar)
- Full player (expandable)
- Play / pause / skip
- Queue view
- Background playback
- Shuffle / repeat / AI sync modes

**Current Status:** ✅ UI complete, audio playback pending

**Audio Library:** `just_audio` (Flutter package)

---

## 11. PROFILE & ACCOUNT

### Functions:
- ✅ User stats (songs, playlists, listening time)
- ✅ Storage usage indicator
- ✅ Premium status
- ✅ Gift card / code redemption
- ✅ Privacy policy access
- ✅ Logout

**Current Status:** ✅ UI complete, backend integration pending

---

## 12. CLOUD STRATEGY (LIMITED & SAFE)

### Design Rules:
- ✅ **Admin-only uploads**
- ✅ **Curated FLAC packs**
- ✅ **No unlimited streaming**
- ✅ **Download-first model**

### Cloud Usage:
- AI reference music
- Premium drops
- Editorial albums

**For Testing:** You can skip cloud and use local PC paths:
```
Songs: D:\AXOR\Songs\
User Data: D:\AXOR\UserData\users.json
```

---

## 13. TECH STACK (SUGGESTED)

### Frontend:
- ✅ **Flutter** (already implemented)

### Local DB:
- **Hive** (lightweight, fast) or **SQLite** (more features)

### Audio:
- **just_audio** (Flutter package for playback)
- **audio_service** (background playback)
- **ffmpeg** (optional, for format conversion)

### AI:
- **On-device feature extraction** (BPM, energy, mood)
- **Optional cloud inference** (for advanced AI)

### Cloud (Production):
- **Cloudflare R2** (S3-compatible, cheap)
- **Signed URLs** (secure downloads)

### Cloud (Testing):
- **Local PC paths** (D:\AXOR\Songs\)
- **No cloud needed for testing**

---

## 14. NON-GOALS (IMPORTANT)

### AXOR will NOT:
- ❌ Stream licensed music (Spotify replacement)
- ❌ Replace Spotify
- ❌ Host user uploads (chaos)
- ❌ Force internet usage
- ❌ Compress FLAC to MP3 automatically
- ❌ Show ads (free users get full features)

---

## 15. CORE PROMISE

**AXOR respects music.**  
**AXOR respects users.**  
**AXOR respects physics (lossless is heavy).**

This is not hype. **This is buildable.**

---

## 16. TESTING STRATEGY

### 16.1 Testing with AVD (Android Studio Emulator)

**Question:** Can I test the app in Android Studio AVD?

**Answer:** ✅ **YES! Absolutely!**

**How it works:**
1. Run `flutter run` in Android Studio
2. App installs on AVD emulator
3. You can test all UI features
4. You can test audio playback
5. You can test local file access

**Limitations:**
- AVD can't access your PC's D:\ drive directly
- You'll need to push test files to emulator storage
- Or use Android's file picker to select files

**Better Option for Testing:**
- Use a real Android device (USB debugging)
- Much faster and more realistic
- Can access real music files

### 16.2 Testing Without Cloud

**Question:** Can I test without cloud, just using local PC paths?

**Answer:** ✅ **YES! Perfect for testing!**

**Setup:**
```
Backend (Node.js on your PC):
- Songs folder: D:\AXOR\Songs\
- User data: D:\AXOR\UserData\users.json
- Playlists: D:\AXOR\UserData\playlists.json

Flutter app connects to:
- http://localhost:3000 (your PC's backend)
- Downloads songs from local paths
- Saves to phone's local storage
```

**Advantages:**
- No cloud costs during testing
- Faster development
- Easy debugging
- Full control

**When to add cloud:**
- After testing is complete
- When ready for production
- When you want to share with testers

### 16.3 Getting APK

**Question:** Will I get an APK at the end?

**Answer:** ✅ **YES! You can build APK anytime!**

**Commands:**

**Debug APK (for testing):**
```bash
flutter build apk --debug
```
Output: `build/app/outputs/flutter-apk/app-debug.apk`

**Release APK (for distribution):**
```bash
flutter build apk --release
```
Output: `build/app/outputs/flutter-apk/app-release.apk`

**What you can do with APK:**
- Install on any Android device
- Share with testers
- Upload to Play Store
- Distribute directly

**APK Size Estimate:**
- Debug: ~50-80 MB
- Release: ~20-40 MB (optimized)

---

## 17. SPOTIFY LINK DOWNLOAD (FUTURE)

**Status:** ⏳ **Will do later** (complex feature)

**Why later:**
- Requires Spotify API integration
- Requires audio download logic
- Requires legal considerations
- Requires error handling

**Current approach:**
- Focus on local music first
- Get core features working
- Add Spotify link feature after testing

**When ready:**
- User pastes Spotify link
- Backend fetches song metadata
- Backend downloads audio (if legal)
- Saves to user's library

---

## 18. DEVELOPMENT PHASES

### Phase 1: Local-Only (CURRENT)
- ✅ UI complete
- ⏳ Local music scanning
- ⏳ Audio playback
- ⏳ Basic AI (BPM, energy)
- ⏳ Smart Modes
- ⏳ Playlists

**Testing:** AVD or real device, no cloud needed

### Phase 2: Backend Integration
- ⏳ User authentication
- ⏳ Local DB (Hive/SQLite)
- ⏳ Audio analysis
- ⏳ AI mood matching
- ⏳ Background playback

**Testing:** Local PC backend (D:\AXOR\)

### Phase 3: Cloud Integration
- ⏳ Cloudflare R2 setup
- ⏳ Admin upload system
- ⏳ Premium downloads
- ⏳ Gift card redemption

**Testing:** Real cloud, real users

### Phase 4: Advanced Features
- ⏳ Spotify link download
- ⏳ Advanced AI
- ⏳ Social features (optional)
- ⏳ Lyrics (optional)

---

## 19. BACKEND STRUCTURE (FOR TESTING)

### Local PC Setup:

```
D:\AXOR\
├── Songs\
│   ├── FLAC\
│   │   ├── song1.flac
│   │   ├── song2.flac
│   │   └── ...
│   └── MP3\
│       ├── song1.mp3
│       └── ...
├── UserData\
│   ├── users.json
│   ├── playlists.json
│   └── subscriptions.json
└── Backend\
    ├── server.js
    ├── routes\
    └── controllers\
```

### Backend API (Node.js):

```javascript
// server.js
const express = require('express');
const app = express();

// Serve songs from local path
app.use('/songs', express.static('D:/AXOR/Songs'));

// API endpoints
app.post('/api/auth/login', ...);
app.get('/api/library', ...);
app.post('/api/songs/like', ...);

app.listen(3000, () => {
  console.log('AXOR Backend running on http://localhost:3000');
});
```

### Flutter App Config:

```dart
// config.dart
class Config {
  static const String baseUrl = 'http://10.0.2.2:3000'; // AVD localhost
  // Or use your PC's IP: 'http://192.168.1.100:3000'
}
```

---

## 20. QUICK ANSWERS

### Q: Can I test in AVD?
**A:** ✅ YES! Works perfectly.

### Q: Can I skip cloud for testing?
**A:** ✅ YES! Use local PC paths (D:\AXOR\).

### Q: Will I get an APK?
**A:** ✅ YES! Run `flutter build apk --release`.

### Q: Spotify link download?
**A:** ⏳ Later (complex, focus on core first).

### Q: Can I use real device instead of AVD?
**A:** ✅ YES! Even better for testing.

### Q: Do I need internet for testing?
**A:** ❌ NO! Local-only works fine.

---

## 21. NEXT STEPS

### Immediate (Phase 1):
1. Set up local backend (Node.js)
2. Create D:\AXOR\ folder structure
3. Add test FLAC/MP3 files
4. Implement audio playback (just_audio)
5. Test on AVD or real device

### Short-term (Phase 2):
1. Implement local music scanning
2. Add audio analysis (BPM, energy)
3. Build AI mood matching
4. Test Smart Modes with real music
5. Create playlists

### Long-term (Phase 3+):
1. Set up Cloudflare R2
2. Implement premium features
3. Add Spotify link download
4. Deploy to Play Store
5. Launch! 🚀

---

## 22. CONTACT

**Admin:** a67154512@gmail.com  
**App Name:** AXOR  
**Version:** 1.0.0

**For:**
- Development questions
- Testing issues
- Feature discussions
- Bug reports

---

**This is buildable. This is testable. This is AXOR.** 🎵

