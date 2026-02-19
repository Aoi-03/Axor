# Railway Deployment - Super Quick Guide

## 5-Minute Setup

### 1. Go to Railway
👉 [railway.app](https://railway.app) → Sign up/Login

### 2. Create New Project
- Click "New Project"
- Choose "Empty Project"

### 3. Add Environment Variables
Click "Variables" tab and add:

```
MEGA_EMAIL = your-mega-email@example.com
MEGA_PASSWORD = your-mega-password
STORAGE_MODE = mega
MEGA_FOLDER_NAME = AxorMusic
PORT = 3001
```

### 4. Deploy Code

**Option A: GitHub (Easiest)**
1. Create GitHub repo
2. Upload `axor_app_backend` folder
3. Connect to Railway
4. Auto-deploys ✅

**Option B: Railway CLI**
```bash
npm install -g @railway/cli
cd axor/axor_app_backend
railway login
railway init
railway up
```

### 5. Get Your URL
Railway gives you: `https://your-app.up.railway.app`

### 6. Update Flutter App
Edit `axor_app/lib/services/api_config.dart`:
```dart
static const String baseUrl = 'https://your-app.up.railway.app';
```

### 7. Test
```bash
curl https://your-app.up.railway.app/health
```

**Done!** 🎉

---

## Adding New Songs

1. Upload songs to MEGA public folder
2. Railway dashboard → Click "Restart"
3. Wait 2-3 minutes
4. New songs appear in app automatically ✅

**That's it!** No code changes needed.

---

## What Gets Uploaded

Upload this folder:
```
axor_app_backend/
├── server.js
├── mega_service.js
├── mega_public_service.js
├── analyze_songs.js
├── package.json
└── database/
```

**Don't upload**:
- ❌ node_modules
- ❌ .env
- ❌ cache folders

---

## Cost

- **Free tier**: 500 hours/month
- **Your usage**: ~720 hours/month
- **Cost**: ~$5/month

**Tip**: Enable "Sleep after inactivity" to stay free!

---

## Questions?

**Will new songs appear automatically?**
✅ YES! Just upload to MEGA and restart backend.

**Do I need to change code?**
❌ NO! Backend scans MEGA on every start.

**How long does deployment take?**
⏱️ First time: 10-15 minutes
⏱️ Restarts: 2-3 minutes

**Can I use free tier?**
✅ YES! With sleep mode enabled.

---

That's all you need to know! 🚀
