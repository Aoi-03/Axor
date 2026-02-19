# AXOR Backend TODO List

**Admin:** a67154512@gmail.com  
**Last Updated:** February 6, 2026  
**Status:** Frontend Complete - Backend Integration Needed

---

## 📋 ALL TODO ITEMS FROM CODE

This is a complete list of all backend integration points marked with TODO comments in the code.

---

## 🎵 MUSIC PLAYER (music_player_bottom.dart)

**File:** `axor_app/lib/widgets/music_player_bottom.dart`

### TODO 1: Like = Download/Save
**Line:** 224, Col 26  
**Code:** `// TODO: Backend - Like = Download/Save`

**What it does:**
- Free users: downloads to local storage
- Premium users: saves to cloud storage

**API Endpoint Needed:**
```javascript
POST /api/songs/like/:id
Body: { songId, userId }
Response: { success, storageUsed, storageLimit }
```

---

## 📚 LIBRARY SCREEN (library_screen.dart)

**File:** `axor_app/lib/screens/home/library_screen.dart`

### TODO 1: Get Premium Status from Backend
**Line:** 13, Col 8  
**Code:** `bool _isPremiumUser = true; // TODO: Get from backend/auth state`

**What it does:**
- Determines if user is free or premium
- Shows/hides cloud library toggle
- Shows/hides download buttons

**API Endpoint Needed:**
```javascript
GET /api/user/profile
Response: { isPremium, storageUsed, storageLimit }
```

### TODO 2: Download to Local Cache
**Line:** 195, Col 40  
**Code:** `// TODO: Backend - Download to local cache`

**What it does:**
- Premium users download cloud songs for offline
- Saves to local device storage

**API Endpoint Needed:**
```javascript
POST /api/songs/download/:id
Response: { downloadUrl, fileSize }
```

### TODO 3: Unlike/Remove from Library
**Line:** 212, Col 38  
**Code:** `// TODO: Backend - Unlike/remove from library`

**What it does:**
- Removes song from user's library
- Deletes from storage (local or cloud)

**API Endpoint Needed:**
```javascript
DELETE /api/songs/unlike/:id
Response: { success, storageUsed }
```

---

## 🔍 SEARCH SCREEN (search_screen.dart)

**File:** `axor_app/lib/screens/home/search_screen.dart`

### TODO 1: Search Logic
**Line:** 66, Col 24  
**Code:** `// TODO: Backend - Search logic`

**What it does:**
- If Spotify link: fetch from API
- If song name: search user's library only

**API Endpoint Needed:**
```javascript
POST /api/songs/search
Body: { query, userId }
Response: { 
  source: "spotify" | "library",
  songs: [...] 
}
```

### TODO 2: Get Search Results from Backend
**Line:** 121, Col 51  
**Code:** `// TODO: Get from backend`

**What it does:**
- Fetches search history (max 7 items)
- Shows recent searches

**API Endpoint Needed:**
```javascript
GET /api/search/history
Response: { history: [...] }
```

### TODO 3: Download to Local Cache
**Line:** 175, Col 40  
**Code:** `// TODO: Backend - Download to local cache`

**What it does:**
- Premium users download songs for offline

**API Endpoint Needed:**
```javascript
POST /api/songs/download/:id
Response: { downloadUrl, fileSize }
```

### TODO 4: Like = Download/Save
**Line:** 192, Col 38  
**Code:** `// TODO: Backend - Like = Download/Save`

**What it does:**
- Triggers download/save based on user plan

**API Endpoint Needed:**
```javascript
POST /api/songs/like/:id
Response: { success, storageUsed }
```

---

## 👤 PROFILE SCREEN (profile_screen.dart)

**File:** `axor_app/lib/screens/home/profile_screen.dart`

### TODO 1: Update Username via Backend
**Line:** 510, Col 18  
**Code:** `// TODO: Update username via backend`

**What it does:**
- Saves new username to database
- Updates user profile

**API Endpoint Needed:**
```javascript
PUT /api/user/profile
Body: { username }
Response: { success, username }
```

---

## 🎵 PLAYLIST DETAIL SCREEN (playlist_detail_screen.dart)

**File:** `axor_app/lib/screens/playlist/playlist_detail_screen.dart`

### TODO 1: Get Premium Status from Backend
**Line:** 24, Col 8  
**Code:** `bool _isPremiumUser = true; // TODO: Get from backend`

**What it does:**
- Shows/hides download buttons based on plan

**API Endpoint Needed:**
```javascript
GET /api/user/profile
Response: { isPremium }
```

### TODO 2: Play Playlist
**Line:** 87, Col 28  
**Code:** `// TODO: Backend - Play playlist`

**What it does:**
- Starts playing first song in playlist
- Queues remaining songs

**API Endpoint Needed:**
```javascript
GET /api/playlists/:id/songs
Response: { songs: [...] }
```

### TODO 3: Shuffle Playlist
**Line:** 105, Col 28  
**Code:** `// TODO: Backend - Shuffle playlist`

**What it does:**
- Randomizes playlist order
- Starts playback

**API Endpoint Needed:**
```javascript
GET /api/playlists/:id/songs?shuffle=true
Response: { songs: [...] }
```

### TODO 4: Download Entire Playlist
**Line:** 118, Col 30  
**Code:** `// TODO: Backend - Download entire playlist`

**What it does:**
- Downloads all songs in playlist for offline
- Premium feature only

**API Endpoint Needed:**
```javascript
POST /api/playlists/:id/download
Response: { success, totalSize, downloadUrls: [...] }
```

### TODO 5: Download to Local Cache
**Line:** 167, Col 26  
**Code:** `// TODO: Backend - Download to local cache`

**What it does:**
- Downloads individual song for offline

**API Endpoint Needed:**
```javascript
POST /api/songs/download/:id
Response: { downloadUrl, fileSize }
```

### TODO 6: Like = Download/Save
**Line:** 190, Col 24  
**Code:** `// TODO: Backend - Like = Download/Save`

**What it does:**
- Saves song to library based on user plan

**API Endpoint Needed:**
```javascript
POST /api/songs/like/:id
Response: { success, storageUsed }
```

---

## 📊 SUMMARY BY PRIORITY

### 🔴 HIGH PRIORITY (Core Features)

1. **User Authentication**
   - Login/signup
   - Get user profile
   - Check premium status

2. **Like = Download/Save** (CRITICAL)
   - Most important feature
   - Used in 4 different screens
   - Core functionality

3. **Search**
   - Spotify link search
   - Library search
   - Search history

4. **Library Management**
   - Get user's songs
   - Unlike/remove songs
   - Storage calculation

### 🟡 MEDIUM PRIORITY (Enhanced Features)

5. **Download for Offline**
   - Premium feature
   - Local cache management
   - Download entire playlists

6. **Playlist Playback**
   - Play playlist
   - Shuffle playlist
   - Queue management

7. **Profile Management**
   - Update username
   - Update profile picture
   - Storage usage display

### 🟢 LOW PRIORITY (Nice to Have)

8. **Search History**
   - Save recent searches
   - Max 7 items
   - Quick replay

---

## 🎯 BACKEND API ENDPOINTS NEEDED

### Authentication
```javascript
POST /api/auth/register
POST /api/auth/login
POST /api/auth/forgot-password
POST /api/auth/reset-password
GET  /api/user/profile
PUT  /api/user/profile
```

### Songs
```javascript
POST   /api/songs/search
POST   /api/songs/like/:id
DELETE /api/songs/unlike/:id
POST   /api/songs/download/:id
GET    /api/songs/:id
```

### Library
```javascript
GET /api/library
GET /api/library/local
GET /api/library/cloud
```

### Playlists
```javascript
GET  /api/playlists
GET  /api/playlists/:id
GET  /api/playlists/:id/songs
POST /api/playlists/:id/download
```

### Search
```javascript
GET /api/search/history
POST /api/search/history
```

### Storage
```javascript
GET /api/user/storage
```

### Premium
```javascript
POST /api/premium/redeem
GET  /api/premium/status
```

---

## 📝 IMPLEMENTATION ORDER

### Phase 1: Core Backend (Week 1)
1. Set up Node.js + Express
2. Create local folder structure (D:\AXOR\)
3. Implement user authentication
4. Implement user profile API
5. Test with Flutter app

### Phase 2: Music Features (Week 2)
1. Implement search API (Spotify link + library)
2. Implement like/unlike API
3. Implement library API
4. Test music discovery flow

### Phase 3: Storage & Download (Week 3)
1. Implement download API
2. Implement storage calculation
3. Implement playlist APIs
4. Test offline functionality

### Phase 4: Premium Features (Week 4)
1. Implement gift card redemption
2. Implement cloud storage
3. Implement premium checks
4. Test premium flow end-to-end

---

## 🔧 TESTING CHECKLIST

For each TODO item:
- [ ] API endpoint created
- [ ] Connected to Flutter app
- [ ] Tested on real device
- [ ] Error handling added
- [ ] Loading states added
- [ ] Success feedback shown
- [ ] TODO comment removed

---

## 📞 CONTACT

**Admin:** a67154512@gmail.com

**Questions about:**
- Backend implementation
- API design
- Testing approach
- Priority order

---

## 🎉 CURRENT STATUS

**Frontend:** ✅ 100% Complete  
**Backend TODOs:** 18 items identified  
**Documentation:** ✅ Complete  
**Ready for:** Backend development

---

**All frontend work is done! Now it's time to build the backend and connect everything!** 🚀

