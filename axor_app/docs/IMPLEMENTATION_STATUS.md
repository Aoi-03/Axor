# AXOR App - Implementation Status

**Last Updated:** February 6, 2026  
**Status:** Frontend Complete - Ready for Backend Integration

---

## ✅ COMPLETED FEATURES

### 1. Like Button = Download/Save (CRITICAL FEATURE)

**Implementation:**
- Like button in music player triggers download/save logic
- Like button in search history triggers download/save logic
- Like button in library shows songs are already saved
- Like button in playlist detail screens triggers download/save logic
- Visual feedback: Cyan when liked, gray when not liked
- State management in place for all screens

**Backend Integration Points:**
```dart
// When user taps like button:
// TODO: Backend - Like = Download/Save
// Free users: downloads to local storage
// Premium users: saves to cloud storage
```

---

### 2. Library Screen Labels (FIXED)

**Free Users:**
- Display: "Master Library (Local)"
- No toggle button (only have local storage)
- Shows songs downloaded to device

**Premium Users:**
- Default: "Master Library (Cloud)" with *premium plan label
- Toggle button to switch between Cloud and Local
- Cloud view: Shows download buttons for offline cache
- Local view: Shows cached songs for offline playback

**Offline Mode (Premium):**
- Automatically switches to "Master Library (Local)"
- Shows only downloaded/cached songs
- Backend will detect connectivity and switch

---

### 3. Search Screen

**Features:**
- Placeholder text: "Search your song"
- Hint text: "Tip: Paste Spotify link to discover new songs"
- Search history limited to 7 items maximum
- Like and download buttons functional
- Backend integration ready

**Search Logic (Backend):**
- Spotify link → Fetch from Spotify API
- Song name → Search user's saved songs only
- Legal protection: No discovery without Spotify link

---

### 4. Download Button (Premium Only)

**Where It Appears:**
- Search history (premium users)
- Library screen cloud view (premium users)
- Playlist detail screens (premium users)

**Functionality:**
- Separate from like button
- Downloads cloud songs to local cache
- For offline playback
- Visual feedback: Check icon when downloaded

---

### 5. Interactive Buttons

**All Buttons Are Ready:**
- ✅ Like buttons (all screens)
- ✅ Download buttons (premium users)
- ✅ Play/Pause buttons
- ✅ Shuffle/Repeat/AI sync toggle
- ✅ Skip previous/next buttons
- ✅ Search functionality
- ✅ Playlist play/shuffle buttons

**Current Behavior:**
- Show visual feedback (state changes)
- Display snackbar messages: "Will work with backend"
- State management in place
- Premium/free user logic implemented

**When Backend Connected:**
- All buttons will trigger API calls
- Real download/save functionality
- Real playback control
- Real search results

---

## 🔄 BACKEND INTEGRATION CHECKLIST

### Required API Endpoints

1. **POST /api/songs/like/:id**
   - Like/save song to library
   - Free: Download to local
   - Premium: Save to cloud
   - Returns: Song details, storage used

2. **POST /api/songs/unlike/:id**
   - Remove song from library
   - Delete from storage
   - Returns: Success status

3. **POST /api/songs/download/:id**
   - Download cloud song to local cache (premium only)
   - Returns: Download URL, file size

4. **POST /api/songs/search**
   - Search by Spotify link or song name
   - Returns: Song details or library results

5. **GET /api/library**
   - Get user's library (cloud or local)
   - Returns: List of songs, storage info

6. **GET /api/user/storage**
   - Get storage usage and limits
   - Returns: Used GB, Total GB, Plan type

---

## 📊 Storage Logic

### Free Users (1GB Local)
```
User taps like button
  ↓
Backend downloads song from Spotify
  ↓
Saves to device local storage
  ↓
Shows in "Master Library (Local)"
  ↓
Storage: 0.05GB / 1GB
```

### Premium Users (Cloud + Local)
```
User taps like button
  ↓
Backend downloads song from Spotify
  ↓
Uploads to Cloudflare R2 (cloud)
  ↓
Shows in "Master Library (Cloud)"
  ↓
Storage: 2.5GB / 10GB

(Optional) User taps download button
  ↓
Downloads to local cache
  ↓
Shows in "Master Library (Local)" too
  ↓
Available offline
```

---

## 🔍 Search Behavior

### Spotify Link Search
```
Input: https://open.spotify.com/track/xxxxx
  ↓
Backend detects Spotify link
  ↓
Fetches song from Spotify API
  ↓
Shows song details
  ↓
User can like/download
```

### Name Search
```
Input: "Song Name"
  ↓
Backend searches user's library only
  ↓
Shows results from Master Library
  ↓
Cannot discover new songs
  ↓
Legal and safe
```

---

## 🎯 Legal Strategy

### Why This Approach Works

1. **User-Initiated Downloads**
   - User provides Spotify link
   - User already has access on Spotify
   - We're just alternative storage

2. **No Content Distribution**
   - We don't host music catalog
   - We don't enable discovery without link
   - We don't share between users

3. **Personal Use Only**
   - Songs saved to user's personal library
   - No sharing features
   - No public playlists

---

## 📱 User Experience

### New User Journey
1. Sign up (free account)
2. Open search screen
3. See hint: "Paste Spotify link to discover new songs"
4. Copy Spotify link from Spotify app
5. Paste in AXOR search
6. Song appears
7. Tap like button (heart)
8. Song downloads to local storage
9. Shows in Master Library (Local)
10. Can play offline anytime

### Premium User Journey
1. Upgrade to premium
2. Get 10GB cloud storage
3. Search with Spotify link
4. Tap like button
5. Song saves to cloud
6. Shows in Master Library (Cloud)
7. Streams when online
8. (Optional) Tap download button
9. Caches locally for offline
10. Auto-switches to local when offline

---

## 🚀 Next Steps

### Backend Development
1. Set up Railway server
2. Integrate Spotify API
3. Set up Google Drive for user data
4. Set up Cloudflare R2 for song files
5. Implement API endpoints
6. Test with Flutter app

### Testing
1. Test like button with real downloads
2. Test search with Spotify links
3. Test storage limits
4. Test offline mode switching
5. Test premium/free user differences

### Deployment
1. Deploy backend to Railway
2. Configure Google Drive API
3. Configure Cloudflare R2
4. Update Flutter app with API URLs
5. Test end-to-end
6. Launch!

---

## 📞 Contact

**Admin Email:** a67154512@gmail.com  
**Purpose:** Gift card redemption, support

---

**All frontend features are complete and ready for backend integration!**
