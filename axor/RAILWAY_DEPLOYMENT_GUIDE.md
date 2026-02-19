# Railway Deployment Guide - AXOR Backend

## Quick Summary

✅ **Upload**: Just the `axor_app_backend` folder
✅ **Auto-scan**: New songs in MEGA appear automatically on restart
✅ **Time**: 10-15 minutes total
✅ **Cost**: Free tier (500 hours/month)

---

## What You Need

1. **Railway Account** - Sign up at [railway.app](https://railway.app)
2. **GitHub Account** (optional but recommended)
3. **MEGA Credentials** - Your MEGA email and password
4. **MEGA Public Folder Link** - The link to your music folder

---

## Files to Upload

Upload the entire `axor_app_backend` folder containing:

```
axor_app_backend/
├── server.js                 ✅ Main server file
├── mega_service.js           ✅ MEGA integration
├── mega_public_service.js    ✅ Public folder handler
├── analyze_songs.js          ✅ Emotion detection
├── package.json              ✅ Dependencies
├── .env.example              ✅ Environment template
└── database/                 ✅ JSON databases
    ├── songs.json
    ├── playlists.json
    └── users.json
```

**DO NOT UPLOAD**:
- ❌ `node_modules/` (Railway installs automatically)
- ❌ `mega_cache/` (created automatically)
- ❌ `song_metadata_cache/` (created automatically)
- ❌ `.env` (set in Railway dashboard)

---

## Step-by-Step Deployment

### Step 1: Prepare Your Backend (2 minutes)

1. **Make sure .gitignore exists**:
```bash
cd axor/axor_app_backend
```

Check if `.gitignore` has:
```
node_modules/
.env
mega_cache/
song_metadata_cache/
*.log
```

### Step 2: Create Railway Project (3 minutes)

1. Go to [railway.app](https://railway.app)
2. Click "Start a New Project"
3. Choose "Deploy from GitHub repo" OR "Empty Project"

**Option A: GitHub (Recommended)**
- Connect your GitHub account
- Create a new repo for `axor_app_backend`
- Push the backend folder
- Railway will auto-deploy

**Option B: Manual Upload**
- Choose "Empty Project"
- Click "Deploy from GitHub"
- Or use Railway CLI (see below)

### Step 3: Configure Environment Variables (5 minutes)

In Railway dashboard, go to your project → Variables tab:

**Required Variables**:
```bash
# MEGA Configuration
MEGA_EMAIL=your-mega-email@example.com
MEGA_PASSWORD=your-mega-password

# Storage Mode
STORAGE_MODE=mega

# MEGA Folder (your public folder name)
MEGA_FOLDER_NAME=AxorMusic

# Server Port (Railway provides this automatically)
PORT=3001

# Node Environment
NODE_ENV=production
```

**Important**: 
- Use your actual MEGA credentials
- `MEGA_FOLDER_NAME` should match your MEGA public folder name
- Railway automatically provides `PORT` variable

### Step 4: Deploy (5 minutes)

Railway will automatically:
1. Install dependencies (`npm install`)
2. Run `npm start`
3. Start your server
4. Provide a public URL

**Deployment URL**: You'll get something like:
```
https://axor-backend-production.up.railway.app
```

### Step 5: Update Flutter App (2 minutes)

Update `axor_app/lib/services/api_config.dart`:

```dart
class ApiConfig {
  // Change this to your Railway URL
  static const String baseUrl = 'https://your-app.up.railway.app';
  
  // Rest stays the same...
}
```

---

## Railway CLI Method (Alternative)

If you prefer command line:

### Install Railway CLI
```bash
npm install -g @railway/cli
```

### Login
```bash
railway login
```

### Deploy
```bash
cd axor/axor_app_backend
railway init
railway up
```

### Set Environment Variables
```bash
railway variables set MEGA_EMAIL=your-email@example.com
railway variables set MEGA_PASSWORD=your-password
railway variables set STORAGE_MODE=mega
railway variables set MEGA_FOLDER_NAME=AxorMusic
```

---

## Auto-Scan for New Songs

### How It Works

**Every time the backend starts**, it:
1. Connects to your MEGA account
2. Scans the public folder
3. Loads ALL songs (MP3 and FLAC)
4. Analyzes emotions for new songs
5. Caches metadata

### Adding New Songs

**Process**:
1. Upload songs to your MEGA public folder
2. Restart Railway backend (or it restarts automatically)
3. Backend scans and loads new songs
4. Songs appear in app immediately

**Restart Backend**:
- Railway dashboard → Your project → "Restart"
- Or redeploy: `railway up`
- Or push to GitHub (auto-deploys)

### Automatic Restarts

Railway restarts your backend:
- When you redeploy
- When you change environment variables
- When it detects crashes
- Every 24 hours (health check)

So new songs will appear within 24 hours automatically, or instantly if you restart manually.

---

## Important Notes

### 1. MEGA Public Folder
Your backend uses the **public folder link**, not private files. Make sure:
- Folder is public (has a share link)
- Songs are in the public folder
- Link is accessible without login

### 2. First Deployment
First time deployment takes longer:
- Installing dependencies: ~2 minutes
- Scanning MEGA folder: ~3-5 minutes (189 songs)
- Analyzing emotions: ~5-10 minutes
- Total: ~10-15 minutes

### 3. Subsequent Restarts
After first deployment:
- Restart: ~30 seconds
- Scan MEGA: ~1-2 minutes
- Load cached metadata: ~10 seconds
- Total: ~2-3 minutes

### 4. Storage
Railway provides:
- Free tier: 1GB storage
- Your backend uses: ~50MB (without cache)
- Cache grows: ~5MB per 100 songs
- 189 songs = ~60MB total

### 5. Bandwidth
- Free tier: 100GB/month
- Streaming 189 songs: ~500MB
- Covers cache: ~50MB
- Should be plenty for personal use

---

## Testing Deployment

### 1. Check Backend Health
```bash
curl https://your-app.up.railway.app/health
```

**Expected Response**:
```json
{
  "status": "ok",
  "message": "AXOR Backend is running",
  "timestamp": "2024-..."
}
```

### 2. Check Songs Loaded
```bash
curl https://your-app.up.railway.app/api/songs
```

**Expected**: JSON with 189 songs

### 3. Test in App
1. Update `api_config.dart` with Railway URL
2. Hot restart app
3. Go to Library tab
4. Should see all 189 songs
5. Tap a song - should play

---

## Troubleshooting

### Backend Won't Start
**Check Railway Logs**:
- Railway dashboard → Your project → Logs
- Look for errors

**Common Issues**:
- Missing environment variables
- Wrong MEGA credentials
- Invalid MEGA folder name

### Songs Not Loading
**Check**:
1. MEGA folder is public
2. `MEGA_FOLDER_NAME` matches exactly
3. Backend logs show "✅ Loaded X songs"

### App Can't Connect
**Check**:
1. Railway URL is correct in `api_config.dart`
2. Backend is running (check Railway dashboard)
3. Health endpoint works: `/health`

---

## Cost Estimate

### Railway Free Tier
- **Execution**: 500 hours/month (FREE)
- **Storage**: 1GB (FREE)
- **Bandwidth**: 100GB/month (FREE)

### Your Usage (Estimated)
- **Execution**: ~720 hours/month (always on)
- **Storage**: ~60MB
- **Bandwidth**: ~5-10GB/month (personal use)

**Cost**: 
- First 500 hours: FREE
- Additional 220 hours: ~$5/month
- **Total**: ~$5/month

**Tip**: Use Railway's "Sleep after inactivity" to stay within free tier:
- Backend sleeps after 30 minutes of no requests
- Wakes up automatically when needed
- Stays within 500 hours/month

---

## Environment Variables Reference

```bash
# Required
MEGA_EMAIL=your-email@example.com
MEGA_PASSWORD=your-password
STORAGE_MODE=mega
MEGA_FOLDER_NAME=AxorMusic

# Optional (Railway provides)
PORT=3001
NODE_ENV=production

# Optional (for local development)
MUSIC_LIBRARY_PATH=/path/to/local/music
```

---

## Quick Checklist

Before deploying:
- [ ] MEGA public folder is set up
- [ ] Songs are in MEGA folder
- [ ] Have MEGA email and password
- [ ] Know MEGA folder name
- [ ] `.gitignore` excludes node_modules
- [ ] Railway account created

After deploying:
- [ ] Environment variables set
- [ ] Backend is running (check logs)
- [ ] Health endpoint works
- [ ] Songs endpoint returns data
- [ ] Updated Flutter app with Railway URL
- [ ] Tested playback in app

---

## Adding More Songs Later

### Process
1. **Upload to MEGA**:
   - Add MP3 or FLAC files to your public folder
   - Any subfolder structure works

2. **Restart Backend**:
   - Railway dashboard → Restart
   - Or wait for automatic restart (24 hours)

3. **Verify**:
   - Check logs: "✅ Loaded X songs"
   - Open app → Library tab
   - New songs should appear

### Automatic Detection
- Backend scans MEGA on every start
- Finds all MP3 and FLAC files
- Analyzes emotions for new songs
- Updates song list automatically

**No code changes needed!** Just upload and restart.

---

## Summary

**What to upload**: `axor_app_backend` folder
**Where**: Railway.app
**Time**: 10-15 minutes
**Cost**: ~$5/month (or free with sleep mode)
**New songs**: Upload to MEGA → Restart backend → Appear automatically

**That's it!** Your backend will be live and accessible from anywhere. 🚀

---

## Need Help?

**Railway Docs**: https://docs.railway.app
**MEGA API**: https://github.com/qgustavor/mega
**Support**: Railway Discord or GitHub Issues

Good luck with deployment! 🎵
