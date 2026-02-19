# Backend Integration Notes

**Last Updated:** February 6, 2026

---

## 📋 Table of Contents

1. [Architecture Overview](#architecture-overview)
2. [API Endpoints](#api-endpoints)
3. [Data Storage](#data-storage)
4. [Authentication](#authentication)
5. [Music Streaming](#music-streaming)
6. [Premium System](#premium-system)
7. [AI Features](#ai-features)
8. [Push Notifications](#push-notifications)
9. [Testing](#testing)

---

## 🏗️ Architecture Overview

```
┌─────────────────────────────────────────────────────┐
│              AXOR Mobile App (Flutter)               │
│                                                       │
│  • UI/UX Layer                                       │
│  • State Management (Provider)                       │
│  • Local Cache (Hive)                                │
│  • Audio Player (just_audio)                         │
└─────────────────┬───────────────────────────────────┘
                  │
                  │ HTTPS REST API
                  │ JWT Authentication
                  │
┌─────────────────▼───────────────────────────────────┐
│         Backend Server (Railway/Render)              │
│              Node.js + Express                       │
│                                                       │
│  Routes:                                             │
│  • /api/auth/*        - Authentication               │
│  • /api/user/*        - User management              │
│  • /api/songs/*       - Song operations              │
│  • /api/playlists/*   - Playlist management          │
│  • /api/premium/*     - Subscription handling        │
│  • /api/ai/*          - AI recommendations           │
│                                                       │
│  Services:                                           │
│  • Email Service (Nodemailer)                        │
│  • JWT Token Generation                              │
│  • File Upload Handler                               │
│  • AI Recommendation Engine                          │
└──────┬──────────────────────┬────────────────────────┘
       │                      │
       │                      │
       ▼                      ▼
┌──────────────────┐   ┌──────────────────────────────┐
│  Google Drive    │   │   Cloudflare R2 Storage      │
│  (User Data)     │   │   (Media Files)              │
│                  │   │                              │
│  Files:          │   │  Buckets:                    │
│  • users.json    │   │  • songs/                    │
│  • playlists.json│   │    - *.flac, *.mp3, *.aac   │
│  • subs.json     │   │  • albums/                   │
│  • history.json  │   │    - *.jpg, *.png            │
│                  │   │  • metadata/                 │
│  API: Drive v3   │   │    - songs.json              │
│  Auth: OAuth2    │   │                              │
│                  │   │  CDN: Global edge network    │
│                  │   │  API: S3-compatible          │
└──────────────────┘   └──────────────────────────────┘
```

---

## 🔌 API Endpoints

### **Authentication**

#### POST `/api/auth/signup`
Create new user account.

**Request:**
```json
{
  "email": "user@example.com",
  "password": "securePassword123",
  "username": "Alex"
}
```

**Response:**
```json
{
  "success": true,
  "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
  "user": {
    "id": "user123",
    "email": "user@example.com",
    "username": "Alex",
    "isPremium": false,
    "storageLimit": 1.0
  }
}
```

#### POST `/api/auth/login`
User login.

**Request:**
```json
{
  "email": "user@example.com",
  "password": "securePassword123"
}
```

**Response:**
```json
{
  "success": true,
  "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
  "user": {
    "id": "user123",
    "email": "user@example.com",
    "username": "Alex",
    "isPremium": true,
    "storageLimit": 10.0,
    "storageUsed": 2.5
  }
}
```

#### POST `/api/auth/forgot-password`
Send password reset code.

**Request:**
```json
{
  "email": "user@example.com"
}
```

**Response:**
```json
{
  "success": true,
  "message": "Reset code sent to email"
}
```

#### POST `/api/auth/reset-password`
Reset password with code.

**Request:**
```json
{
  "email": "user@example.com",
  "code": "123456",
  "newPassword": "newSecurePassword123"
}
```

**Response:**
```json
{
  "success": true,
  "message": "Password updated successfully"
}
```

---

### **User Management**

#### GET `/api/user/profile`
Get user profile.

**Headers:**
```
Authorization: Bearer <token>
```

**Response:**
```json
{
  "id": "user123",
  "email": "user@example.com",
  "username": "Alex",
  "profileImage": "https://cdn.axor.com/profiles/user123.jpg",
  "isPremium": true,
  "storageLimit": 10.0,
  "storageUsed": 2.5,
  "stats": {
    "totalSongs": 150,
    "totalPlaylists": 8,
    "listeningTime": "45h 30min"
  },
  "createdAt": "2026-01-01T00:00:00Z"
}
```

#### PUT `/api/user/username`
Update username.

**Headers:**
```
Authorization: Bearer <token>
```

**Request:**
```json
{
  "username": "NewUsername"
}
```

**Response:**
```json
{
  "success": true,
  "username": "NewUsername"
}
```

#### POST `/api/user/profile-image`
Upload profile picture.

**Headers:**
```
Authorization: Bearer <token>
Content-Type: multipart/form-data
```

**Request:**
```
FormData with 'image' field
```

**Response:**
```json
{
  "success": true,
  "imageUrl": "https://cdn.axor.com/profiles/user123.jpg"
}
```

---

### **Songs**

#### GET `/api/songs/search?q=query`
Search songs.

**Headers:**
```
Authorization: Bearer <token>
```

**Response:**
```json
{
  "results": [
    {
      "id": "song123",
      "title": "Song Name",
      "artist": "Artist Name",
      "album": "Album Name",
      "duration": 225,
      "albumArt": "https://r2.axor.com/albums/album123.jpg",
      "isLiked": false,
      "isDownloaded": false
    }
  ],
  "total": 1
}
```

#### GET `/api/songs/stream/:id`
Stream song (returns audio file).

**Headers:**
```
Authorization: Bearer <token>
Range: bytes=0-
```

**Response:**
```
Audio stream (FLAC/MP3/AAC)
Content-Type: audio/flac
Content-Length: 12345678
Accept-Ranges: bytes
```

#### POST `/api/songs/like/:id`
Like/unlike song.

**Headers:**
```
Authorization: Bearer <token>
```

**Response:**
```json
{
  "success": true,
  "isLiked": true
}
```

#### GET `/api/songs/liked`
Get liked songs.

**Headers:**
```
Authorization: Bearer <token>
```

**Response:**
```json
{
  "songs": [
    {
      "id": "song123",
      "title": "Song Name",
      "artist": "Artist Name",
      "albumArt": "https://r2.axor.com/albums/album123.jpg",
      "likedAt": "2026-02-06T10:00:00Z"
    }
  ]
}
```

---

### **Playlists**

#### GET `/api/playlists`
Get user playlists.

**Headers:**
```
Authorization: Bearer <token>
```

**Response:**
```json
{
  "playlists": [
    {
      "id": "playlist123",
      "name": "Workout Mix",
      "description": "High Energy",
      "isVibe": false,
      "songCount": 25,
      "albumArts": [
        "https://r2.axor.com/albums/song1.jpg",
        "https://r2.axor.com/albums/song2.jpg",
        "https://r2.axor.com/albums/song3.jpg",
        "https://r2.axor.com/albums/song4.jpg"
      ],
      "createdAt": "2026-02-01T00:00:00Z"
    }
  ]
}
```

#### POST `/api/playlists`
Create playlist.

**Headers:**
```
Authorization: Bearer <token>
```

**Request:**
```json
{
  "name": "My New Playlist",
  "description": "Description here"
}
```

**Response:**
```json
{
  "success": true,
  "playlist": {
    "id": "playlist456",
    "name": "My New Playlist",
    "description": "Description here",
    "songs": [],
    "createdAt": "2026-02-06T15:00:00Z"
  }
}
```

#### GET `/api/playlists/:id`
Get playlist details with songs.

**Headers:**
```
Authorization: Bearer <token>
```

**Response:**
```json
{
  "id": "playlist123",
  "name": "Workout Mix",
  "description": "High Energy",
  "isVibe": false,
  "songs": [
    {
      "id": "song123",
      "title": "Song Name",
      "artist": "Artist Name",
      "duration": 225,
      "albumArt": "https://r2.axor.com/albums/album123.jpg"
    }
  ],
  "totalDuration": "1h 30min",
  "createdAt": "2026-02-01T00:00:00Z"
}
```

#### PUT `/api/playlists/:id`
Update playlist.

**Headers:**
```
Authorization: Bearer <token>
```

**Request:**
```json
{
  "name": "Updated Name",
  "description": "Updated description"
}
```

**Response:**
```json
{
  "success": true,
  "playlist": {
    "id": "playlist123",
    "name": "Updated Name",
    "description": "Updated description"
  }
}
```

#### POST `/api/playlists/:id/songs`
Add song to playlist.

**Headers:**
```
Authorization: Bearer <token>
```

**Request:**
```json
{
  "songId": "song456"
}
```

**Response:**
```json
{
  "success": true,
  "message": "Song added to playlist"
}
```

#### DELETE `/api/playlists/:id/songs/:songId`
Remove song from playlist.

**Headers:**
```
Authorization: Bearer <token>
```

**Response:**
```json
{
  "success": true,
  "message": "Song removed from playlist"
}
```

---

### **Premium System**

#### POST `/api/premium/redeem-code`
Redeem Amazon Gift Card.

**Headers:**
```
Authorization: Bearer <token>
```

**Request:**
```json
{
  "code": "XXXX-XXXX-XXXX-XXXX"
}
```

**Response:**
```json
{
  "success": true,
  "message": "Request sent to admin for verification",
  "requestId": "req123"
}
```

**Backend Process:**
1. Receive gift card code
2. Send email to a67154512@gmail.com:
   ```
   Subject: New Gift Card Redemption Request
   
   User: user@example.com
   Code: XXXX-XXXX-XXXX-XXXX
   Request ID: req123
   Timestamp: 2026-02-06 15:30:00
   
   Please verify this code on Amazon and reply with the amount.
   ```
3. Admin verifies on Amazon
4. Admin replies: "Verified: $10 = 10GB"
5. Backend parses reply (or manual update)
6. Update user in Google Drive:
   ```json
   {
     "isPremium": true,
     "storageLimit": 10.0,
     "subscription": {
       "code": "XXXX-XXXX-XXXX-XXXX",
       "amount": 10.0,
       "storageGB": 10,
       "startDate": "2026-02-06",
       "endDate": "2026-03-06",
       "status": "active"
     }
   }
   ```
7. Send push notification to user

#### GET `/api/premium/status`
Check premium status.

**Headers:**
```
Authorization: Bearer <token>
```

**Response:**
```json
{
  "isPremium": true,
  "storageLimit": 10.0,
  "storageUsed": 2.5,
  "subscription": {
    "startDate": "2026-02-06",
    "endDate": "2026-03-06",
    "daysRemaining": 28,
    "autoRenew": false
  }
}
```

---

### **AI Features**

#### GET `/api/ai/vibes`
Get AI-generated playlists.

**Headers:**
```
Authorization: Bearer <token>
```

**Response:**
```json
{
  "vibes": [
    {
      "id": "vibe123",
      "name": "Midnight Drive",
      "description": "Late night vibes for your journey",
      "mood": "chill",
      "songCount": 30,
      "albumArts": [
        "https://r2.axor.com/albums/song1.jpg",
        "https://r2.axor.com/albums/song2.jpg"
      ]
    }
  ]
}
```

#### GET `/api/ai/recommendations`
Get personalized song recommendations.

**Headers:**
```
Authorization: Bearer <token>
```

**Response:**
```json
{
  "recommendations": [
    {
      "id": "song789",
      "title": "Recommended Song",
      "artist": "Artist Name",
      "reason": "Based on your recent listening",
      "albumArt": "https://r2.axor.com/albums/album789.jpg"
    }
  ]
}
```

---

## 💾 Data Storage

### **Google Drive Structure**

```
AXOR_Data/
├── users.json              # All user accounts
├── playlists.json          # All playlists
├── subscriptions.json      # Premium subscriptions
├── listening_history.json  # User listening data
└── ai_preferences.json     # AI learning data
```

### **users.json**
```json
{
  "users": [
    {
      "id": "user123",
      "email": "user@example.com",
      "passwordHash": "$2b$10$...",
      "username": "Alex",
      "profileImage": "https://cdn.axor.com/profiles/user123.jpg",
      "isPremium": false,
      "storageLimit": 1.0,
      "storageUsed": 0.0,
      "playlists": ["playlist1", "playlist2"],
      "likedSongs": ["song1", "song2"],
      "createdAt": "2026-01-01T00:00:00Z",
      "lastLogin": "2026-02-06T15:30:00Z"
    }
  ]
}
```

### **playlists.json**
```json
{
  "playlists": [
    {
      "id": "playlist123",
      "userId": "user123",
      "name": "Workout Mix",
      "description": "High Energy",
      "isVibe": false,
      "songs": ["song1", "song2", "song3"],
      "createdAt": "2026-02-01T00:00:00Z",
      "updatedAt": "2026-02-06T10:00:00Z"
    }
  ]
}
```

### **subscriptions.json**
```json
{
  "subscriptions": [
    {
      "id": "sub123",
      "userId": "user123",
      "giftCardCode": "XXXX-XXXX-XXXX-XXXX",
      "amount": 10.0,
      "storageGB": 10,
      "startDate": "2026-02-06",
      "endDate": "2026-03-06",
      "status": "active",
      "verifiedBy": "admin",
      "verifiedAt": "2026-02-06T16:00:00Z"
    }
  ]
}
```

### **Cloudflare R2 Structure**

```
axor-music/
├── songs/
│   ├── song1.flac          # Lossless audio
│   ├── song2.mp3           # Compressed audio
│   └── song3.aac           # Apple format
├── albums/
│   ├── album1.jpg          # Album artwork
│   └── album2.png
├── profiles/
│   └── user123.jpg         # User profile pictures
└── metadata/
    └── songs.json          # Song metadata database
```

### **songs.json (in R2)**
```json
{
  "songs": [
    {
      "id": "song123",
      "title": "Song Name",
      "artist": "Artist Name",
      "album": "Album Name",
      "duration": 225,
      "format": "flac",
      "bitrate": 1411,
      "sampleRate": 44100,
      "fileSize": 25600000,
      "fileUrl": "songs/song123.flac",
      "albumArt": "albums/album123.jpg",
      "genre": "Electronic",
      "mood": "energetic",
      "uploadedAt": "2026-01-01T00:00:00Z"
    }
  ]
}
```

---

## 🔐 Authentication

### **JWT Token Structure**

```json
{
  "userId": "user123",
  "email": "user@example.com",
  "isPremium": false,
  "iat": 1707228000,
  "exp": 1707314400
}
```

### **Token Storage (Flutter)**

```dart
// Store token securely
final prefs = await SharedPreferences.getInstance();
await prefs.setString('auth_token', token);

// Retrieve token
final token = prefs.getString('auth_token');

// Add to API requests
final response = await http.get(
  Uri.parse('https://api.axor.com/api/user/profile'),
  headers: {
    'Authorization': 'Bearer $token',
  },
);
```

---

## 🎵 Music Streaming

### **Streaming Implementation**

**Backend (Node.js):**
```javascript
app.get('/api/songs/stream/:id', async (req, res) => {
  const { id } = req.params;
  const range = req.headers.range;
  
  // Get song from R2
  const song = await r2.getObject({
    Bucket: 'axor-music',
    Key: `songs/${id}.flac`,
    Range: range
  });
  
  // Stream to client
  res.writeHead(206, {
    'Content-Type': 'audio/flac',
    'Content-Length': song.ContentLength,
    'Content-Range': song.ContentRange,
    'Accept-Ranges': 'bytes'
  });
  
  song.Body.pipe(res);
});
```

**Flutter (just_audio):**
```dart
final player = AudioPlayer();

// Stream song
await player.setUrl(
  'https://api.axor.com/api/songs/stream/song123',
  headers: {
    'Authorization': 'Bearer $token'
  }
);

// Play
await player.play();

// Pause
await player.pause();

// Seek
await player.seek(Duration(seconds: 30));
```

---

## 🔔 Push Notifications

### **Setup (Firebase Cloud Messaging)**

**When to Send:**
1. Premium activated
2. Download complete
3. Playlist shared
4. New AI vibe available

**Example Payload:**
```json
{
  "notification": {
    "title": "Premium Activated!",
    "body": "10GB cloud storage added to your account",
    "icon": "app_icon",
    "color": "#06B6D4"
  },
  "data": {
    "type": "premium_activated",
    "storageGB": "10"
  }
}
```

---

## 🧪 Testing

### **API Testing (Postman/Thunder Client)**

**1. Sign Up**
```
POST https://api.axor.com/api/auth/signup
Body: {
  "email": "test@example.com",
  "password": "test123",
  "username": "TestUser"
}
```

**2. Login**
```
POST https://api.axor.com/api/auth/login
Body: {
  "email": "test@example.com",
  "password": "test123"
}
```

**3. Get Profile**
```
GET https://api.axor.com/api/user/profile
Headers: Authorization: Bearer <token>
```

**4. Search Songs**
```
GET https://api.axor.com/api/songs/search?q=test
Headers: Authorization: Bearer <token>
```

**5. Stream Song**
```
GET https://api.axor.com/api/songs/stream/song123
Headers: Authorization: Bearer <token>
```

---

## ✅ Frontend Integration Checklist

### **Authentication**
- [ ] Implement signup API call
- [ ] Implement login API call
- [ ] Store JWT token securely
- [ ] Add token to all API requests
- [ ] Handle token expiration
- [ ] Implement logout

### **User Profile**
- [ ] Fetch user profile
- [ ] Update username
- [ ] Upload profile picture
- [ ] Display storage usage

### **Music Playback**
- [ ] Integrate just_audio package
- [ ] Stream songs from API
- [ ] Implement play/pause/skip
- [ ] Add background service
- [ ] Show media notifications

### **Playlists**
- [ ] Fetch user playlists
- [ ] Create new playlist
- [ ] Add/remove songs
- [ ] Update playlist details
- [ ] Delete playlist

### **Search**
- [ ] Implement search API call
- [ ] Display search results
- [ ] Add to playlist from search
- [ ] Like songs from search

### **Premium**
- [ ] Implement gift card redemption
- [ ] Check premium status
- [ ] Display storage limits
- [ ] Show subscription details

### **AI Features**
- [ ] Fetch AI vibes
- [ ] Display recommendations
- [ ] Track listening history

---

## 📞 Support

**Backend Issues:** Contact backend team  
**Admin Email:** a67154512@gmail.com  
**API Base URL:** https://api.axor.com

---

**End of Backend Integration Notes**
