# Quick Start Guide - AXOR Backend

## ✅ Backend is Ready!

The backend now supports **TWO MODES**:
1. **Local Mode** - Uses files from your PC (current setup)
2. **MEGA Mode** - Uses MEGA cloud storage (for deployment)

---

## 🚀 Start Backend (Local Mode - Current)

### Option 1: Using Batch File
Double-click: `axor/START_BACKEND.bat`

### Option 2: Using Command Line
```powershell
cd axor/axor_app_backend
node server.js
```

### Expected Output:
```
========================================
  AXOR Music Backend
========================================
📦 Storage Mode: LOCAL

💻 Using Local File Storage
📁 Path: C:\Users\LUNA\Downloads\AI
🔍 Scanning music library: C:\Users\LUNA\Downloads\AI
✅ 1. Song1.flac - Artist1
✅ 2. Song2.flac - Artist2
...
✅ Successfully scanned: 225 songs
🎵 AXOR Backend running on http://localhost:3000
```

---

## 🌐 Switch to MEGA Mode (For Deployment)

### Step 1: Create MEGA Account
1. Go to https://mega.nz
2. Sign up (20GB free)
3. Verify email

### Step 2: Upload Music
1. Login to MEGA
2. Create folder: `AxorMusic`
3. Upload all 225 FLAC files

### Step 3: Configure Backend
Edit `axor/axor_app_backend/.env`:
```env
# Change these lines:
STORAGE_MODE=mega
MEGA_EMAIL=your-email@example.com
MEGA_PASSWORD=your-password
MEGA_FOLDER_NAME=AxorMusic
```

### Step 4: Start Backend
```powershell
cd axor/axor_app_backend
node server.js
```

### Expected Output (MEGA Mode):
```
========================================
  AXOR Music Backend
========================================
📦 Storage Mode: MEGA

🌐 Using MEGA Cloud Storage
🔐 Connecting to MEGA Cloud...
✅ Connected to MEGA successfully
📦 Account: your-email@example.com
🔍 Scanning MEGA folder: /AxorMusic
✅ 1. Song1.flac (12.5 MB)
✅ 2. Song2.flac (15.3 MB)
...
✅ Loaded 225 songs from MEGA
🎵 AXOR Backend running on http://localhost:3000
```

---

## 📱 Run Flutter App

### Connect Phone via USB
1. Enable USB Debugging on phone
2. Connect USB cable
3. Allow USB debugging popup

### Run App
```powershell
cd axor_app
flutter run
```

---

## 🔄 Mode Comparison

| Feature | Local Mode | MEGA Mode |
|---------|------------|-----------|
| Storage | Your PC | MEGA Cloud |
| Access | Only when PC on | Anywhere |
| Speed | Very fast | Medium |
| Setup | Easy (current) | Medium |
| Deployment | No | Yes ✅ |
| Cost | Free | Free (20GB) |

---

## 🎯 Current Status

✅ Backend supports both modes
✅ Local mode working (your current setup)
✅ MEGA mode ready (just need to configure)
✅ AI song matching implemented
✅ Flutter app connected

---

## 📝 Configuration File (.env)

Current configuration:
```env
# Storage Mode: 'local' or 'mega'
STORAGE_MODE=local

# Local music library path (for local mode)
MUSIC_LIBRARY_PATH=C:\Users\LUNA\Downloads\AI

# MEGA configuration (for mega mode)
MEGA_EMAIL=your-email@example.com
MEGA_PASSWORD=your-password
MEGA_FOLDER_NAME=AxorMusic

# Server Port
PORT=3000
```

---

## 🐛 Troubleshooting

### Backend won't start?
- Check if port 3000 is available
- Make sure you're in `axor/axor_app_backend` directory
- Run: `npm install` to install dependencies

### Songs not loading?
- **Local mode:** Check `MUSIC_LIBRARY_PATH` in `.env`
- **MEGA mode:** Check MEGA credentials in `.env`

### MEGA login failed?
- Verify email and password
- Check internet connection
- Make sure folder `AxorMusic` exists in MEGA

---

## 🚀 Next Steps

### For Development (Recommended Now):
1. ✅ Keep using local mode
2. ✅ Backend is already running
3. ✅ Connect phone via USB
4. ✅ Run Flutter app
5. ✅ Test all features

### For Deployment (Later):
1. Upload songs to MEGA
2. Switch to MEGA mode in `.env`
3. Deploy backend to Heroku/Railway
4. Update Flutter app with production URL

---

## 📞 Quick Commands

### Start Backend:
```powershell
cd axor/axor_app_backend
node server.js
```

### Run Flutter App:
```powershell
cd axor_app
flutter run
```

### Check Backend Health:
Open browser: http://localhost:3000/health

### View All Songs:
Open browser: http://localhost:3000/api/songs

---

## ✅ You're Ready!

Your backend is configured and ready to run in **both modes**:
- **Local mode** for development (current)
- **MEGA mode** for deployment (when ready)

Just start the backend and run your Flutter app! 🎵
