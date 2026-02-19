# AXOR Music App 🎵

A modern music streaming app with AI-powered recommendations, built with Flutter and Node.js.

## Project Structure

```
├── axor_app/              # Flutter mobile app
│   ├── lib/               # Dart source code
│   ├── android/           # Android platform
│   └── ios/               # iOS platform
│
└── axor/                  # Backend & Documentation
    ├── axor_app_backend/  # Node.js backend server
    ├── database/          # JSON databases
    └── *.md               # Documentation files
```

## Quick Start

### Backend Setup

```bash
cd axor/axor_app_backend
npm install
cp .env.example .env
# Edit .env with your MEGA credentials
npm start
```

### Flutter App Setup

```bash
cd axor_app
flutter pub get
flutter run
```

## Features

✨ AI-powered music recommendations
🎵 Stream from MEGA cloud storage  
📱 Smart Modes (GYM, STUDY, DRIVE)
🎨 Beautiful cyberpunk UI
💾 User playlists with local storage

## Deployment

See `axor/RENDER_STEP_BY_STEP.md` for deploying backend to Render.com

## Documentation

All documentation is in the `axor/` folder:
- `RENDER_STEP_BY_STEP.md` - Deploy backend
- `GITHUB_SETUP_GUIDE.md` - GitHub setup
- `QUICK_ANSWERS.md` - Common questions
- And many more...

## Tech Stack

- **Frontend**: Flutter, Provider, just_audio
- **Backend**: Node.js, Express, MEGA.js
- **AI**: Custom emotion detection algorithm

## License

MIT License

---

Built with ❤️ by Aoi
