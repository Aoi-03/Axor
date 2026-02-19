# MEGA Cloud Storage Integration Guide

## Overview
Replace local file server with MEGA cloud storage for 20GB free music library hosting.

## Architecture

### Current Setup:
```
Phone App → Local Backend (PC) → Local Files (C:\Users\LUNA\Downloads\AI)
```

### New Setup with MEGA:
```
Phone App → Backend (PC/Cloud) → MEGA Cloud Storage → Stream to Phone
```

## Implementation Options

---

## Option 1: Public Links (Quick & Easy)

### Pros:
- ✅ No authentication needed
- ✅ Direct streaming URLs
- ✅ Easy to implement
- ✅ Works from anywhere

### Cons:
- ❌ 5GB transfer limit per 6 hours (free account)
- ❌ Need to generate link for each song
- ❌ Links can expire or be revoked

### Steps:

#### 1. Upload to MEGA
```
1. Go to https://mega.nz
2. Create account (20GB free)
3. Create folder: /AxorMusic
4. Upload all 225 FLAC files
5. Right-click folder → "Get link"
6. Copy the public folder link
```

#### 2. Generate Song Links
You'll need to get individual file links. Two ways:

**Manual (for testing):**
- Right-click each song → "Get link"
- Save links in a JSON file

**Automated (better):**
- Use MEGA's web interface API
- Or use MEGAcmd tool

#### 3. Update Database
Create `songs_mega.json`:
```json
{
  "songs": [
    {
      "id": "song_1",
      "title": "Song Name",
      "artist": "Artist Name",
      "megaUrl": "https://mega.nz/file/XXXXXXXX#YYYYYYYY",
      "fileSize": 12345678
    }
  ]
}
```

#### 4. Update Backend
Modify `server.js`:
```javascript
// Instead of serving local files
app.use('/songs', express.static(MUSIC_LIBRARY_PATH));

// Stream from MEGA URLs
app.get('/api/songs/stream/:songId', async (req, res) => {
  const song = songsCache.find(s => s.id === req.params.songId);
  const megaUrl = song.megaUrl;
  
  // Redirect to MEGA URL
  res.redirect(megaUrl);
});
```

---

## Option 2: MEGA SDK Integration (Recommended)

### Pros:
- ✅ Full 20GB storage
- ✅ Better transfer limits
- ✅ Secure authentication
- ✅ Automatic file management
- ✅ Can scan files programmatically

### Cons:
- ❌ More complex setup
- ❌ Requires MEGA SDK
- ❌ Need to keep credentials secure

### Steps:

#### 1. Install MEGA SDK for Node.js
```bash
cd axor/axor_app_backend
npm install megajs
```

#### 2. Upload Files to MEGA
Use MEGA desktop app or MEGAcmd:
```bash
# Install MEGAcmd from https://mega.nz/cmd
mega-login your-email@example.com
mega-mkdir /AxorMusic
mega-put "C:\Users\LUNA\Downloads\AI\*" /AxorMusic/
```

#### 3. Update Backend Code

**New file: `axor/axor_app_backend/mega_service.js`**
```javascript
const { File } = require('megajs');

class MegaService {
  constructor(email, password) {
    this.email = email;
    this.password = password;
    this.storage = null;
  }

  async login() {
    const { Storage } = require('megajs');
    this.storage = await new Storage({
      email: this.email,
      password: this.password
    }).ready;
    console.log('✅ Connected to MEGA');
  }

  async listFiles(folderPath = '/AxorMusic') {
    const folder = this.storage.root.children.find(f => f.name === 'AxorMusic');
    if (!folder) throw new Error('Folder not found');
    
    const songs = [];
    for (const file of folder.children) {
      if (file.name.endsWith('.flac')) {
        songs.push({
          id: file.nodeId,
          name: file.name,
          size: file.size,
          downloadUrl: await file.link()
        });
      }
    }
    return songs;
  }

  async getDownloadUrl(fileId) {
    const file = this.storage.files[fileId];
    return await file.link();
  }

  async streamFile(fileId) {
    const file = this.storage.files[fileId];
    return file.download();
  }
}

module.exports = MegaService;
```

**Update `server.js`:**
```javascript
const MegaService = require('./mega_service');

// Initialize MEGA
const megaService = new MegaService(
  process.env.MEGA_EMAIL,
  process.env.MEGA_PASSWORD
);

// On startup
(async () => {
  await megaService.login();
  songsCache = await megaService.listFiles('/AxorMusic');
  console.log(`✅ Loaded ${songsCache.length} songs from MEGA`);
})();

// Stream endpoint
app.get('/api/songs/stream/:songId', async (req, res) => {
  try {
    const stream = await megaService.streamFile(req.params.songId);
    stream.pipe(res);
  } catch (error) {
    res.status(500).json({ error: 'Failed to stream' });
  }
});
```

#### 4. Create `.env` file
```
MEGA_EMAIL=your-email@example.com
MEGA_PASSWORD=your-password
```

#### 5. Install dotenv
```bash
npm install dotenv
```

Add to `server.js`:
```javascript
require('dotenv').config();
```

---

## Option 3: Hybrid Approach (Best of Both)

### Setup:
1. **Development:** Use local files (current setup)
2. **Production:** Use MEGA cloud storage

### Benefits:
- Fast development with local files
- Deploy to cloud when ready
- Easy switching between modes

### Implementation:
```javascript
const USE_MEGA = process.env.USE_MEGA === 'true';

if (USE_MEGA) {
  // Use MEGA service
  await megaService.login();
  songsCache = await megaService.listFiles();
} else {
  // Use local files (current)
  songsCache = await scanMusicLibrary();
}
```

---

## Comparison Table

| Feature | Local Files | MEGA Public Links | MEGA SDK |
|---------|-------------|-------------------|----------|
| Storage | Unlimited (your PC) | 20GB free | 20GB free |
| Access | Only when PC on | Anywhere | Anywhere |
| Speed | Very fast | Medium | Medium |
| Setup | Easy | Medium | Complex |
| Cost | Free | Free | Free |
| Transfer Limit | None | 5GB/6hrs | Better |
| Security | Private | Public links | Authenticated |

---

## My Recommendation

### For Testing/Development:
**Keep current local setup** - It's fast and works great for development.

### For Production/Sharing:
**Use MEGA SDK (Option 2)** - Best balance of features and control.

### Quick Win:
**Use MEGA Public Links (Option 1)** - Upload 10-20 favorite songs to test the concept.

---

## What Do You Want to Do?

### Option A: Test with Public Links (Quick)
1. Upload 10 songs to MEGA
2. Get public links
3. Update backend to stream from MEGA
4. Test on phone

### Option B: Full MEGA SDK Integration
1. Upload all 225 songs to MEGA
2. Install megajs package
3. Implement MEGA service
4. Update backend completely

### Option C: Keep Local + Add MEGA Later
1. Keep current setup for now
2. Develop all features with local files
3. Add MEGA integration when app is complete

**Which option sounds best to you?** 🤔
