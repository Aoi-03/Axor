# AXOR Backend - Railway Deployment

## TL;DR (Too Long; Didn't Read)

**What to upload**: `axor_app_backend` folder
**Where**: railway.app
**Time**: 10 minutes
**Cost**: ~$5/month
**New songs**: Upload to MEGA → Restart → Auto-appear ✅

---

## Quick Answer to Your Questions

### Q: What do I need to upload to Railway?
**A**: Just the `axor_app_backend` folder. That's it!

### Q: Will new songs in MEGA appear automatically?
**A**: YES! ✅ 
- Upload songs to MEGA public folder
- Restart Railway backend (or wait 24 hours)
- Backend scans MEGA and loads ALL songs
- New songs appear in app automatically
- No code changes needed!

---

## Files to Upload

```
axor_app_backend/
├── server.js                 ← Main server
├── mega_service.js           ← MEGA integration
├── mega_public_service.js    ← Public folder handler
├── analyze_songs.js          ← Emotion detection
├── package.json              ← Dependencies
└── database/                 ← JSON databases
    ├── songs.json
    ├── playlists.json
    └── users.json
```

**DON'T upload**:
- node_modules (Railway installs automatically)
- .env (set in Railway dashboard)
- cache folders (created automatically)

---

## Deployment Process

### 1. Sign Up (1 minute)
Go to [railway.app](https://railway.app) and create account

### 2. Create Project (1 minute)
Click "New Project" → "Empty Project"

### 3. Set Environment Variables (2 minutes)
Add these in Railway dashboard:
```
MEGA_EMAIL = your-mega-email@example.com
MEGA_PASSWORD = your-password
STORAGE_MODE = mega
MEGA_FOLDER_NAME = AxorMusic
PORT = 3001
```

### 4. Deploy Code (5 minutes)
**Option A**: Connect GitHub repo
**Option B**: Use Railway CLI
```bash
npm install -g @railway/cli
cd axor/axor_app_backend
railway login
railway init
railway up
```

### 5. Update App (1 minute)
Change `axor_app/lib/services/api_config.dart`:
```dart
static const String baseUrl = 'https://your-app.up.railway.app';
```

**Done!** 🎉

---

## How Auto-Scan Works

### Every Backend Start:
1. Connects to MEGA
2. Scans public folder
3. Finds ALL MP3 and FLAC files
4. Analyzes emotions for new songs
5. Loads into app

### Adding New Songs:
```
You: Upload songs to MEGA
You: Click "Restart" in Railway dashboard
Backend: Scans MEGA folder
Backend: Finds new songs
Backend: Analyzes emotions
Backend: Loads into database
App: Shows new songs automatically
```

**No code changes needed!** ✅

---

## Cost Breakdown

### Railway Free Tier
- 500 hours/month execution (FREE)
- 1GB storage (FREE)
- 100GB bandwidth (FREE)

### Your Backend
- Runs 24/7 = 720 hours/month
- Uses ~60MB storage
- Uses ~5-10GB bandwidth

### Total Cost
- First 500 hours: FREE
- Extra 220 hours: ~$5/month
- **Total: ~$5/month**

### Stay Free
Enable "Sleep after inactivity":
- Backend sleeps after 30 min idle
- Wakes up automatically when needed
- Stays within 500 hours = FREE!

---

## Testing Deployment

### 1. Check Health
```bash
curl https://your-app.up.railway.app/health
```
Should return: `{"status": "ok"}`

### 2. Check Songs
```bash
curl https://your-app.up.railway.app/api/songs
```
Should return: JSON with all songs

### 3. Test in App
- Open app
- Go to Library
- Should see all songs
- Tap song → Should play

---

## Adding More Songs

### Process
1. Upload MP3/FLAC to MEGA public folder
2. Go to Railway dashboard
3. Click "Restart" button
4. Wait 2-3 minutes
5. Open app → New songs appear!

### Automatic
Backend restarts automatically:
- Every 24 hours
- When you redeploy
- When you change variables

So new songs appear within 24 hours max, or instantly if you restart manually.

---

## Important Notes

### MEGA Public Folder
- Must be PUBLIC (has share link)
- Songs must be in this folder
- Backend uses public link (no login needed)

### First Deployment
Takes longer (~10-15 minutes):
- Installing dependencies
- Scanning MEGA
- Analyzing 189 songs
- Caching metadata

### Subsequent Restarts
Much faster (~2-3 minutes):
- Loads cached metadata
- Only analyzes new songs
- Quick startup

### Storage
- Backend: ~50MB
- Cache: ~5MB per 100 songs
- 189 songs: ~60MB total
- Well within 1GB limit ✅

---

## Troubleshooting

### Backend Won't Start
Check Railway logs for:
- Missing environment variables
- Wrong MEGA credentials
- Invalid folder name

### Songs Not Loading
Check:
- MEGA folder is public
- Folder name matches exactly
- Logs show "✅ Loaded X songs"

### App Can't Connect
Check:
- Railway URL in api_config.dart
- Backend is running
- Health endpoint works

---

## Documentation Files

I created these guides for you:

1. **RAILWAY_QUICK_START.md** ← Start here! (5 min read)
2. **RAILWAY_DEPLOYMENT_GUIDE.md** ← Full details (15 min read)
3. **DEPLOYMENT_CHECKLIST.md** ← Step-by-step checklist
4. **README_DEPLOYMENT.md** ← This file (overview)

---

## Summary

**Upload**: `axor_app_backend` folder to Railway
**Configure**: Set MEGA credentials in environment variables
**Deploy**: Railway builds and runs automatically
**Update**: Change Flutter app URL to Railway URL
**Test**: Open app and play songs

**New Songs**: Upload to MEGA → Restart backend → Auto-appear ✅

**That's it!** Your backend will be live and accessible from anywhere. 🚀

---

## Get Some Rest! 😴

You've done great work! The deployment is straightforward:
1. Upload backend folder to Railway
2. Set environment variables
3. Deploy
4. Update app URL
5. Done!

New songs will appear automatically when you upload to MEGA and restart.

Take a break, you deserve it! 🎵
