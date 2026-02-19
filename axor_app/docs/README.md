# AXOR Music App

**Your Sound. Evolved.**

A lightweight, AI-powered music streaming app with smart modes and cloud storage.

---

## 📞 ADMIN CONTACT

**Email:** a67154512@gmail.com  
**App Name:** AXOR  
**Package:** com.example.axor_app

**Contact for:**
- 🎁 Gift card redemption (Amazon)
- 💎 Premium subscription activation
- 🐛 Bug reports
- 💡 Feature requests
- 🔧 Technical support
- 📱 App issues

**Response Time:** 24-48 hours

---

## 📚 Documentation

This project has comprehensive documentation in multiple files:

### **1. COMPLETE_APP_DOCUMENTATION.md**
Complete overview of the entire app:
- All 17 screens explained
- 9 reusable widgets
- Design system (colors, typography, spacing)
- User flows
- Feature deep dives
- Data models
- Performance optimizations

### **2. BACKEND_INTEGRATION_NOTES.md**
Everything needed to connect the backend:
- Architecture diagrams
- All API endpoints with examples
- Data storage structure (Google Drive + Cloudflare R2)
- Authentication flow
- Music streaming implementation
- Premium system details
- Testing guide

### **3. OPTIMIZATION_AND_BACKEND.md**
Performance and infrastructure:
- Battery optimization
- Background playback setup
- Android 15 bubble notifications
- Audio format support
- Backend architecture
- Cost estimates
- Scalability planning

### **4. ANIMATIONS_GUIDE.md**
Animation specifications:
- Page transitions
- Timing and curves
- Direction guidelines

### **5. AI_SYNC_FEATURE.md**
AI features documentation:
- AI-generated playlists
- Recommendation engine
- Smart mode integration

---

## 🚀 Quick Start

### **Prerequisites**
- Flutter SDK 3.10.8+
- Android Studio / VS Code
- Android device or emulator

### **Installation**

```bash
# Clone the repository
cd axor_app

# Install dependencies
flutter pub get

# Run the app
flutter run
```

### **Project Structure**

```
axor_app/
├── lib/
│   ├── constants/          # Colors, themes
│   ├── screens/            # All app screens
│   │   ├── auth/          # Login, signup, etc.
│   │   ├── home/          # Main navigation screens
│   │   ├── smart_modes/   # Gym, study, drive modes
│   │   └── playlist/      # Playlist details
│   ├── widgets/           # Reusable components
│   └── utils/             # Helpers, managers
├── assets/                # Images, logo
└── docs/                  # Documentation files
```

---

## ✨ Features

### **Core Features**
- 🎵 Music streaming (FLAC, MP3, AAC support)
- 🔍 Search songs
- 📚 Library management
- 💾 Download songs
- ❤️ Like/favorite songs

### **Smart Modes**
- 🏋️ **Gym Mode**: Workout tracking with stopwatch
- 📖 **Study Mode**: Focus sessions with timer
- 🚗 **Drive Mode**: Trip tracking with timer

### **AI Features**
- 🤖 AI-generated playlists (Your Vibe)
- 🎯 Personalized recommendations
- 📊 Listening history analysis

### **Premium Features**
- ☁️ Cloud storage ($1/GB per month)
- 📱 Unlimited downloads
- 🎨 Auto-generated playlist covers

### **Performance**
- ⚡ Lightweight (< 50MB RAM in background)
- 🔋 Low battery consumption (< 1% per hour)
- 🎮 Works while gaming on 4GB RAM phones
- 📱 Android 15 bubble notifications

---

## 🎨 Design

**Color Palette:**
- Cyan (#06B6D4) - Primary accent
- Red (#EF4444) - Gym mode
- Green (#10B981) - Drive mode
- Dark theme throughout

**Animations:**
- Smooth 250-500ms transitions
- Hardware-accelerated
- Fade, slide, and scale effects

---

## 🏗️ Backend Architecture

```
Flutter App
    ↓
Railway (API Server)
    ↓
    ├─→ Google Drive (User data)
    └─→ Cloudflare R2 (Song files)
```

**Tech Stack:**
- **Frontend**: Flutter
- **Backend**: Node.js + Express (Railway)
- **Database**: Google Drive (JSON files)
- **Storage**: Cloudflare R2 (S3-compatible)
- **Auth**: JWT tokens
- **Email**: Nodemailer

---

## 📊 Current Status

### **✅ Completed**
- All UI screens (17 screens)
- All widgets (9 components)
- Animations and transitions
- State management
- Color theming
- Smart mode system
- Auto-generated playlist covers
- Storage management UI
- Premium upgrade flow

### **🔄 In Progress**
- Backend API development
- Audio playback integration
- Background service
- Push notifications

### **📋 TODO**
- Connect to backend
- Implement actual audio playback
- Add download manager
- Integrate AI recommendations
- Deploy to Play Store

---

## 🔐 Security

- JWT authentication
- Secure token storage
- Password hashing (bcrypt)
- HTTPS only
- No sensitive data in logs

---

## 📱 Supported Platforms

- ✅ Android 8.0+ (API 26+)
- ✅ iOS 12.0+
- ✅ Web (limited features)

---

## 🎵 Audio Formats

- FLAC (lossless)
- MP3 (universal)
- AAC (Apple)
- M4A (Apple lossless)
- OGG (open source)
- WAV (uncompressed)
- OPUS (modern)

---

## 💰 Pricing

**Free Plan:**
- 1GB local storage
- Basic features
- Ads (future)

**Premium Plan:**
- $1 per GB per month
- Cloud storage
- No ads
- Unlimited downloads

**Payment:**
- Amazon Gift Cards
- Manual verification by admin

---

## 📞 Contact

**Admin Email:** a67154512@gmail.com  
**App Name:** AXOR  
**Version:** 1.0.0

**For Support:**
- Gift card redemption
- Premium subscription issues
- Technical support
- Feature requests
- Bug reports

**Email Format for Gift Card Redemption:**
```
Subject: AXOR Premium - Gift Card Redemption
Body: 
- Amazon Gift Card Code: [YOUR CODE]
- Email: [YOUR REGISTERED EMAIL]
- Requested Storage: [e.g., 10GB]
```

Admin will verify and respond within 24-48 hours.

---

## 📄 License

Proprietary - All rights reserved

---

## 🙏 Acknowledgments

- Flutter team for the amazing framework
- just_audio for audio playback
- Cloudflare for R2 storage
- Railway for hosting

---

**Built with ❤️ using Flutter**
