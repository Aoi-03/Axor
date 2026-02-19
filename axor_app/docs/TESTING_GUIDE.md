# AXOR Testing Guide - Local Setup (No Cloud Needed)

**Admin:** a67154512@gmail.com  
**Last Updated:** February 6, 2026

---

## ✅ YES, YOU CAN TEST WITHOUT CLOUD!

All your questions answered:

### 1. Can I test in Android Studio AVD?
**✅ YES!** The AVD emulator works perfectly for testing AXOR.

### 2. Can I use local PC paths instead of cloud?
**✅ YES!** Perfect for testing. Use paths like `D:\AXOR\Songs\`

### 3. Will I get an APK?
**✅ YES!** You can build APK anytime with `flutter build apk --release`

### 4. Spotify link download?
**⏳ LATER** - Focus on core features first, add Spotify later

---

## 🚀 TESTING SETUP (3 OPTIONS)

### Option 1: AVD Emulator (Easiest)

**Pros:**
- No physical device needed
- Built into Android Studio
- Easy debugging

**Cons:**
- Slower than real device
- Can't easily access PC files
- Limited storage

**How to use:**
1. Open Android Studio
2. Start AVD emulator
3. Run `flutter run`
4. App installs automatically

**Accessing music files:**
```bash
# Push test files to emulator
adb push D:\Music\song.flac /sdcard/Music/
```

---

### Option 2: Real Android Device (RECOMMENDED)

**Pros:**
- Much faster
- Real-world testing
- Easy file access
- Better audio quality

**Cons:**
- Need USB cable
- Need to enable USB debugging

**⚠️ SAFETY NOTE:**
**Is this safe?** ✅ **YES! 100% SAFE!**
- Used by millions of developers daily
- Cannot damage your phone
- Cannot delete your data
- Completely reversible
- See `DEVICE_SAFETY_GUIDE.md` for details

**Setup:**
1. Enable Developer Options on phone
2. Enable USB Debugging
3. Connect via USB
4. Run `flutter run`

**Accessing music files:**
- Copy files directly to phone
- Or use backend to serve from PC

---

### Option 3: Backend on PC + App on Device (BEST FOR TESTING)

**Setup:**

```
Your PC (Windows):
├── Backend (Node.js)
│   └── Runs on http://localhost:3000
├── Songs Folder
│   └── D:\AXOR\Songs\
└── User Data
    └── D:\AXOR\UserData\

Your Phone/Emulator:
└── AXOR App
    └── Connects to http://192.168.1.100:3000
```

**Advantages:**
- No cloud costs
- Fast development
- Easy debugging
- Full control
- Real music files

---

## 📁 LOCAL FOLDER STRUCTURE

Create this on your PC:

```
D:\AXOR\
├── Songs\
│   ├── FLAC\
│   │   ├── song1.flac
│   │   ├── song2.flac
│   │   ├── song3.flac
│   │   └── ... (add your test songs)
│   ├── MP3\
│   │   ├── song1.mp3
│   │   ├── song2.mp3
│   │   └── ...
│   └── AlbumArt\
│       ├── album1.jpg
│       └── ...
├── UserData\
│   ├── users.json
│   ├── playlists.json
│   └── subscriptions.json
└── Backend\
    ├── server.js
    ├── package.json
    └── routes\
```

---

## 🔧 BACKEND SETUP (Node.js)

### 1. Install Node.js

Download from: https://nodejs.org/

### 2. Create Backend

```bash
mkdir D:\AXOR\Backend
cd D:\AXOR\Backend
npm init -y
npm install express cors body-parser
```

### 3. Create server.js

```javascript
const express = require('express');
const cors = require('cors');
const path = require('path');

const app = express();
app.use(cors());
app.use(express.json());

// Serve songs from local folder
app.use('/songs', express.static('D:/AXOR/Songs'));

// Test endpoint
app.get('/api/test', (req, res) => {
  res.json({ message: 'AXOR Backend is running!' });
});

// Get all songs
app.get('/api/songs', (req, res) => {
  // TODO: Scan D:\AXOR\Songs\ and return list
  res.json({ songs: [] });
});

// User login
app.post('/api/auth/login', (req, res) => {
  const { email, password } = req.body;
  // TODO: Check users.json
  res.json({ success: true, token: 'test-token' });
});

const PORT = 3000;
app.listen(PORT, () => {
  console.log(`AXOR Backend running on http://localhost:${PORT}`);
});
```

### 4. Start Backend

```bash
node server.js
```

You should see: `AXOR Backend running on http://localhost:3000`

---

## 📱 FLUTTER APP CONFIGURATION

### 1. Find Your PC's IP Address

**Windows:**
```bash
ipconfig
```
Look for "IPv4 Address" (e.g., 192.168.1.100)

### 2. Update Flutter Config

Create `axor_app/lib/config/api_config.dart`:

```dart
class ApiConfig {
  // For AVD emulator
  static const String baseUrlAVD = 'http://10.0.2.2:3000';
  
  // For real device (replace with your PC's IP)
  static const String baseUrlDevice = 'http://192.168.1.100:3000';
  
  // Use this in your app
  static const String baseUrl = baseUrlDevice; // Change as needed
}
```

### 3. Test Connection

```dart
// In your app
import 'package:http/http.dart' as http;
import 'config/api_config.dart';

Future<void> testBackend() async {
  final response = await http.get(
    Uri.parse('${ApiConfig.baseUrl}/api/test')
  );
  print(response.body); // Should print: {"message":"AXOR Backend is running!"}
}
```

---

## 🎵 ADDING TEST MUSIC

### 1. Copy Your Music Files

```
D:\AXOR\Songs\FLAC\
├── song1.flac
├── song2.flac
└── song3.flac
```

### 2. Backend Serves Files

```javascript
// In server.js
app.use('/songs', express.static('D:/AXOR/Songs'));

// Now accessible at:
// http://localhost:3000/songs/FLAC/song1.flac
```

### 3. Flutter Downloads and Plays

```dart
// Download song
final url = '${ApiConfig.baseUrl}/songs/FLAC/song1.flac';
// Use just_audio to play
```

---

## 🧪 TESTING WORKFLOW

### Daily Development:

1. **Start Backend**
   ```bash
   cd D:\AXOR\Backend
   node server.js
   ```

2. **Run Flutter App**
   ```bash
   cd axor_app
   flutter run
   ```

3. **Test Features**
   - Login/signup
   - Browse local music
   - Play songs
   - Create playlists
   - Test Smart Modes

4. **Check Logs**
   - Backend: Terminal output
   - Flutter: Android Studio console

---

## 📦 BUILDING APK

### Debug APK (for testing):

```bash
flutter build apk --debug
```

**Output:** `build/app/outputs/flutter-apk/app-debug.apk`

**Size:** ~50-80 MB

**Use for:** Quick testing, sharing with friends

### Release APK (for distribution):

```bash
flutter build apk --release
```

**Output:** `build/app/outputs/flutter-apk/app-release.apk`

**Size:** ~20-40 MB (optimized)

**Use for:** Final testing, Play Store, distribution

### Install APK on Device:

```bash
# Via ADB
adb install build/app/outputs/flutter-apk/app-release.apk

# Or copy APK to phone and install manually
```

---

## 🔍 TESTING CHECKLIST

### Phase 1: UI Testing (No Backend)
- [ ] All screens display correctly
- [ ] Navigation works
- [ ] Animations smooth
- [ ] Buttons respond
- [ ] Colors change in Smart Modes

### Phase 2: Backend Testing (Local)
- [ ] Backend starts successfully
- [ ] App connects to backend
- [ ] Login works
- [ ] Songs list loads
- [ ] Music plays

### Phase 3: Feature Testing
- [ ] Local music scanning
- [ ] Playlist creation
- [ ] Smart Modes work
- [ ] AI suggestions
- [ ] Background playback

### Phase 4: APK Testing
- [ ] Build APK successfully
- [ ] Install on device
- [ ] App runs without crashes
- [ ] All features work
- [ ] Performance is good

---

## 🐛 TROUBLESHOOTING

### Problem: Can't connect to backend

**Solution:**
```dart
// For AVD, use:
static const String baseUrl = 'http://10.0.2.2:3000';

// For real device, use your PC's IP:
static const String baseUrl = 'http://192.168.1.100:3000';

// Make sure:
// 1. Backend is running
// 2. Phone and PC on same WiFi
// 3. Firewall allows port 3000
```

### Problem: Songs won't play

**Solution:**
1. Check file path is correct
2. Check file format is supported
3. Check `just_audio` package is installed
4. Check audio permissions in AndroidManifest.xml

### Problem: AVD is slow

**Solution:**
1. Use real device instead
2. Or increase AVD RAM in Android Studio
3. Or use x86 emulator image (faster)

---

## 📊 PERFORMANCE TIPS

### For Testing:
- Use MP3 files (smaller, faster)
- Limit test library to 50-100 songs
- Use debug APK for quick iteration

### For Production:
- Use FLAC files (lossless)
- Optimize images
- Use release APK
- Enable ProGuard

---

## 🎯 TESTING PRIORITIES

### Week 1: Core Features
1. Audio playback
2. Local music scanning
3. Basic UI navigation
4. Playlist creation

### Week 2: Smart Modes
1. Gym Mode
2. Study Mode
3. Drive Mode
4. AI queue generation

### Week 3: Backend Integration
1. User authentication
2. Cloud library (if ready)
3. Premium features
4. Gift card redemption

### Week 4: Polish & APK
1. Bug fixes
2. Performance optimization
3. Build release APK
4. Test on multiple devices

---

## 🚀 WHEN TO ADD CLOUD

**Add cloud when:**
- ✅ Local testing is complete
- ✅ All core features work
- ✅ Ready for production
- ✅ Have budget for Cloudflare R2

**Don't need cloud for:**
- ❌ Initial development
- ❌ UI testing
- ❌ Feature testing
- ❌ Local music playback

---

## 📞 NEED HELP?

**Admin:** a67154512@gmail.com

**Common Issues:**
- Backend connection problems
- Audio playback issues
- APK build errors
- Device testing problems

---

## ✅ SUMMARY

**YES, you can test everything locally!**

1. ✅ Use AVD or real device
2. ✅ Backend on your PC (D:\AXOR\)
3. ✅ No cloud needed for testing
4. ✅ Build APK anytime
5. ✅ Spotify link feature later

**Start with local, add cloud later!**

---

**Happy Testing! 🎵**

