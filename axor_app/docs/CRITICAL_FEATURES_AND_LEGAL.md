# AXOR - Critical Features & Legal Strategy

**Last Updated:** February 6, 2026  
**Status:** CONFIDENTIAL - Legal Strategy Document

---

## ⚠️ IMPORTANT: Legal Strategy

### **Search System - Spotify Link Only**

**To stay legal and avoid issues like Spotify:**

❌ **DOES NOT WORK:**
- Searching by song name
- Searching by artist name
- Browsing songs without link

✅ **ONLY WORKS:**
- User provides Spotify link
- Example: `https://open.spotify.com/track/xxxxx`
- Backend fetches song from Spotify API
- User can then like/download

**Why This Works:**
- User already has access to song on Spotify
- We're just providing alternative storage
- Not distributing copyrighted content
- User-initiated download only

**Exception:**
- Searching by name ONLY shows user's already saved songs
- Cannot discover new songs without Spotify link
- This keeps us legal and safe

---

## ❤️ Like Button - The Most Important Feature

### **Like Button = Download/Save**

The like button is NOT just for favorites - it's the primary download mechanism!

**How It Works:**

#### **For Free Users:**
```
User taps Like button
  ↓
Song downloads to LOCAL storage
  ↓
Shows in "Master Library (Local)"
  ↓
Counts toward 1GB local limit
```

#### **For Premium Users:**
```
User taps Like button
  ↓
Song saves to CLOUD storage
  ↓
Shows in "Master Library (Cloud)"
  ↓
Counts toward purchased cloud limit (e.g., 10GB)
```

**Additional Download Button (Premium Only):**
- Separate download button for offline cache
- Downloads cloud song to local device
- Doesn't count toward storage limit
- For offline playback when no internet

---

## 📚 Master Library System

### **Two Separate Libraries**

#### **1. Master Library (Local)**

**Who Sees It:**
- ✅ Free users (their only library)
- ✅ Premium users (offline cache)

**What's In It:**
- **Free users**: All liked/downloaded songs (max 1GB)
- **Premium users**: Offline cached songs from cloud

**Storage:**
- Device local storage
- Limited by plan (1GB free)
- Managed by app

#### **2. Master Library (Cloud)**

**Who Sees It:**
- ✅ Premium users only
- ❌ Free users don't see this

**What's In It:**
- All liked/saved songs
- Stored in Cloudflare R2
- Accessible from any device
- Limited by purchased storage (e.g., 10GB)

**Storage:**
- Cloudflare R2 cloud storage
- Synced across devices
- Accessible with internet

---

## 🔄 Offline Mode (Premium Feature)

### **Automatic Switching**

**When Online:**
```
Premium user opens app
  ↓
Shows "Master Library (Cloud)"
  ↓
Streams songs from cloud
  ↓
Low data usage
```

**When Offline:**
```
Premium user opens app (no internet)
  ↓
Automatically switches to "Master Library (Local)"
  ↓
Shows only downloaded/cached songs
  ↓
Plays from local storage
```

**Implementation:**
```dart
// Check internet connection
bool isOnline = await checkConnectivity();

if (isPremiumUser && isOnline) {
  // Show cloud library
  showCloudLibrary();
} else {
  // Show local library
  showLocalLibrary();
}
```

---

## 🔍 Search Screen - Detailed Behavior

### **Search Input**

**Placeholder Text:**
```
"Search your song"
```

**What User Can Enter:**

1. **Spotify Link** (Primary Method)
   ```
   https://open.spotify.com/track/xxxxx
   ```
   - Backend fetches song from Spotify API
   - Shows song details
   - User can like/download

2. **Song Name** (Limited)
   ```
   "Song Name"
   ```
   - ONLY searches user's saved songs
   - Shows results from Master Library (Local/Cloud)
   - Cannot discover new songs
   - Legal and safe

### **Search History**

**Rules:**
- Maximum 7 recent searches
- Oldest automatically removed
- Stored locally
- Each item shows:
  - Song name
  - Artist name
  - Like button (cyan when liked)
  - Download button (premium only, for offline)

**Storage:**
```json
{
  "searchHistory": [
    {
      "query": "https://open.spotify.com/track/xxxxx",
      "songId": "song123",
      "title": "Song Name",
      "artist": "Artist Name",
      "timestamp": "2026-02-06T15:30:00Z",
      "isLiked": true
    }
  ]
}
```

---

## 💾 Storage Logic

### **Free User Flow**

```
1. User searches with Spotify link
   ↓
2. Song appears in results
   ↓
3. User taps LIKE button (heart)
   ↓
4. Song downloads to LOCAL storage
   ↓
5. Shows in "Master Library (Local)"
   ↓
6. Storage used: 0.05GB / 1GB
   ↓
7. Can play offline
```

### **Premium User Flow**

```
1. User searches with Spotify link
   ↓
2. Song appears in results
   ↓
3. User taps LIKE button (heart)
   ↓
4. Song saves to CLOUD storage
   ↓
5. Shows in "Master Library (Cloud)"
   ↓
6. Storage used: 0.05GB / 10GB
   ↓
7. Streams when online
   ↓
8. (Optional) Tap DOWNLOAD button
   ↓
9. Downloads to local cache for offline
   ↓
10. Shows in both Cloud and Local libraries
```

---

## 🎵 Song Availability Logic

### **Search Results**

**Scenario 1: User searches by Spotify link**
```
Input: https://open.spotify.com/track/xxxxx
  ↓
Backend fetches from Spotify API
  ↓
Shows song details
  ↓
User can like/download
```

**Scenario 2: User searches by name**
```
Input: "Song Name"
  ↓
Backend searches ONLY user's saved songs
  ↓
Shows results from Master Library
  ↓
Cannot discover new songs
  ↓
Legal and safe
```

### **Library Display**

**Free User Library Screen:**
```
┌─────────────────────────────────────┐
│  Master Library (Local)             │
│  0.5GB / 1GB                        │
├─────────────────────────────────────┤
│  ♪ Song 1                    ❤️     │
│  ♪ Song 2                    ❤️     │
│  ♪ Song 3                    ❤️     │
└─────────────────────────────────────┘
```

**Premium User Library Screen:**
```
┌─────────────────────────────────────┐
│  Master Library (Cloud)             │
│  2.5GB / 10GB                       │
├─────────────────────────────────────┤
│  ♪ Song 1              ❤️  ⬇️       │
│  ♪ Song 2              ❤️  ⬇️       │
│  ♪ Song 3              ❤️  ⬇️       │
└─────────────────────────────────────┘

┌─────────────────────────────────────┐
│  Master Library (Local)             │
│  Offline Cache                      │
├─────────────────────────────────────┤
│  ♪ Song 1 (Downloaded)       ❤️     │
│  ♪ Song 5 (Downloaded)       ❤️     │
└─────────────────────────────────────┘
```

---

## 🔘 Button Behavior

### **Like Button (Heart Icon)**

**Visual States:**
- ❤️ Filled cyan = Liked/Saved
- 🤍 Outline gray = Not liked

**Functionality:**

**When NOT liked:**
```
User taps heart
  ↓
Shows loading indicator
  ↓
Downloads/Saves song (based on plan)
  ↓
Heart turns cyan (filled)
  ↓
Shows in Master Library
```

**When already liked:**
```
User taps heart
  ↓
Shows confirmation dialog:
"Remove from library?"
  ↓
If confirmed:
  - Deletes from storage
  - Heart turns gray (outline)
  - Removes from Master Library
```

### **Download Button (Premium Only)**

**Visual States:**
- ⬇️ Gray = Not downloaded
- ✓ Cyan = Downloaded

**Functionality:**
```
User taps download
  ↓
Downloads to local cache
  ↓
Shows in Local library
  ↓
Available offline
  ↓
Icon changes to checkmark
```

**Note:** This is SEPARATE from like button!
- Like = Save to cloud
- Download = Cache locally for offline

---

## 📊 Storage Calculation

### **Song Size Estimates**

- **FLAC**: ~25-40MB per song
- **MP3 320kbps**: ~8-12MB per song
- **AAC 256kbps**: ~6-8MB per song

### **Storage Limits**

**Free Plan (1GB):**
- ~25-40 FLAC songs
- ~80-125 MP3 songs
- ~125-166 AAC songs

**Premium Plan (10GB example):**
- ~250-400 FLAC songs
- ~800-1250 MP3 songs
- ~1250-1666 AAC songs

---

## 🔐 Legal Protection Strategy

### **Why This Approach is Legal**

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

4. **Spotify API Compliance**
   - Use official Spotify API
   - Follow their terms of service
   - Proper attribution

### **What We Avoid**

❌ Public music catalog
❌ Song discovery without link
❌ Sharing between users
❌ Public playlists
❌ Social features with songs
❌ Lyrics display (copyright)
❌ Album art hosting (use Spotify's)

---

## 🎯 User Experience Flow

### **New User Journey**

```
1. User signs up (free account)
   ↓
2. Opens search screen
   ↓
3. Sees: "Search your song"
   ↓
4. Tries typing song name
   ↓
5. No results (expected)
   ↓
6. Sees hint: "Paste Spotify link to add songs"
   ↓
7. Opens Spotify app
   ↓
8. Finds song they want
   ↓
9. Copies Spotify link
   ↓
10. Pastes in AXOR search
   ↓
11. Song appears!
   ↓
12. Taps heart (like button)
   ↓
13. Song downloads to local storage
   ↓
14. Shows in Master Library (Local)
   ↓
15. Can play offline anytime
```

### **Premium User Journey**

```
1. User upgrades to premium
   ↓
2. Gets 10GB cloud storage
   ↓
3. Searches with Spotify link
   ↓
4. Taps heart (like button)
   ↓
5. Song saves to CLOUD
   ↓
6. Shows in Master Library (Cloud)
   ↓
7. Streams when online
   ↓
8. (Optional) Taps download button
   ↓
9. Caches locally for offline
   ↓
10. Shows in both libraries
   ↓
11. Auto-switches to local when offline
```

---

## 🔄 Backend Implementation

### **Search Endpoint**

```javascript
POST /api/songs/search

// Request
{
  "query": "https://open.spotify.com/track/xxxxx"
  // OR
  "query": "Song Name" // Only searches user's library
}

// Response (Spotify link)
{
  "source": "spotify",
  "song": {
    "id": "song123",
    "title": "Song Name",
    "artist": "Artist Name",
    "album": "Album Name",
    "duration": 225,
    "spotifyId": "xxxxx",
    "albumArt": "https://i.scdn.co/image/xxxxx",
    "isLiked": false,
    "isDownloaded": false
  }
}

// Response (name search)
{
  "source": "library",
  "results": [
    {
      "id": "song123",
      "title": "Song Name",
      "artist": "Artist Name",
      "isLiked": true,
      "isDownloaded": true
    }
  ]
}
```

### **Like/Save Endpoint**

```javascript
POST /api/songs/like/:id

// Request
{
  "spotifyLink": "https://open.spotify.com/track/xxxxx"
}

// Backend Process:
1. Fetch song from Spotify API
2. Download audio file
3. Upload to Cloudflare R2 (premium) or local (free)
4. Update user's library
5. Return success

// Response
{
  "success": true,
  "song": {
    "id": "song123",
    "title": "Song Name",
    "storageLocation": "cloud", // or "local"
    "fileSize": 25600000, // bytes
    "downloadUrl": "https://r2.axor.com/songs/song123.flac"
  },
  "storageUsed": 2.5, // GB
  "storageLimit": 10.0 // GB
}
```

---

## ✅ Implementation Checklist

### **Frontend (Flutter)**

- [x] Update search screen placeholder text
- [x] Add Spotify link detection hint
- [x] Implement like button as download trigger (with backend TODO)
- [x] Show separate libraries (Cloud/Local)
- [x] Add offline mode detection (ready for backend)
- [x] Auto-switch libraries when offline (ready for backend)
- [x] Limit search history to 7 items
- [x] Update library screen labels (Cloud for premium, Local for free)
- [x] Add download button for premium users
- [x] Show storage usage correctly (ready for backend)
- [x] Make all buttons interactive with backend comments
- [x] Playlist detail screens have interactive buttons

### **Backend (Node.js)**

- [ ] Integrate Spotify API
- [ ] Implement link parsing
- [ ] Add song download from Spotify
- [ ] Upload to Cloudflare R2
- [ ] Manage user storage limits
- [ ] Track liked songs
- [ ] Implement offline sync
- [ ] Add search history storage
- [ ] Validate storage before download

---

## 📱 Button Functionality Status

### **All Buttons Are Ready for Backend Integration**

**Current State:**
- All like buttons show visual feedback (cyan when liked)
- All download buttons show visual feedback (for premium users)
- All buttons show snackbar messages indicating they'll work with backend
- State management is in place (liked/unliked tracking)
- Premium/free user logic is implemented

**What Happens When Backend is Connected:**
1. Like button → Triggers API call to download/save song
2. Download button → Triggers API call to cache song locally
3. Search → Sends query to backend (Spotify link or name search)
4. Play/Shuffle → Starts playback from backend audio URLs
5. Storage display → Shows real usage from backend

**All buttons WILL work in the final program once backend is connected!**

---

## 🔍 Search History Implementation

**Maximum Items:** 7 songs
- Oldest automatically removed when 8th is added
- Stored locally on device
- Each item shows song name, artist, album art
- Like and download buttons functional
- Backend will persist history across devices for premium users

---

## 📚 Library Labels - FIXED

**Free Users:**
- See: "Master Library (Local)"
- No toggle button
- Shows local storage only

**Premium Users:**
- Default: "Master Library (Cloud)" with *premium plan label
- Toggle button to switch to "Master Library (Local)"
- Cloud library shows download buttons for offline cache
- Local library shows cached songs

**Offline Mode (Premium):**
- Automatically switches to "Master Library (Local)"
- Shows only downloaded/cached songs
- No streaming, plays from local storage

---

## 📞 Legal Disclaimer

**This strategy is designed to:**
- Comply with copyright laws
- Respect Spotify's terms of service
- Provide personal use storage only
- Avoid content distribution

**Always consult with a lawyer before launch!**

---

**End of Critical Features Document**
