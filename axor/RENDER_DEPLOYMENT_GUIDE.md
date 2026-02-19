# Render.com Deployment Guide - AXOR Backend

## Why Render?

✅ **Actually FREE** (750 hours/month)
✅ Easy to use (like Railway)
✅ Auto-sleeps after 15 min (saves hours)
✅ Auto-wakes on request
✅ Perfect for your backend

---

## Quick Deployment (10 minutes)

### Step 1: Sign Up (1 minute)
1. Go to [render.com](https://render.com)
2. Click "Get Started"
3. Sign up with GitHub (recommended) or email

### Step 2: Create Web Service (2 minutes)
1. Click "New +" button (top right)
2. Select "Web Service"
3. Choose deployment method:
   - **Option A**: Connect GitHub repo (recommended)
   - **Option B**: Deploy from Git URL
   - **Option C**: Upload code manually

### Step 3: Configure Service (3 minutes)

**Basic Settings:**
- **Name**: `axor-backend` (or any name)
- **Region**: Choose closest to you
- **Branch**: `main` (or your branch name)
- **Root Directory**: Leave empty (or `axor_app_backend` if in subfolder)
- **Runtime**: `Node`
- **Build Command**: `npm install`
- **Start Command**: `npm start`

**Instance Type:**
- Select **"Free"** (important!)

### Step 4: Environment Variables (3 minutes)

Click "Advanced" → Add Environment Variables:

```
MEGA_EMAIL = your-mega-email@example.com
MEGA_PASSWORD = your-password
STORAGE_MODE = mega
MEGA_FOLDER_NAME = AxorMusic
PORT = 10000
NODE_ENV = production
```

**Important**: Render uses port `10000` by default!

### Step 5: Deploy (1 minute)
1. Click "Create Web Service"
2. Render will build and deploy automatically
3. Wait 5-10 minutes for first deployment
4. You'll get a URL like: `https://axor-backend.onrender.com`

---

## Update Flutter App

Edit `axor_app/lib/services/api_config.dart`:

```dart
class ApiConfig {
  // Change to your Render URL
  static const String baseUrl = 'https://axor-backend.onrender.com';
  
  // Rest stays the same...
}
```

---

## Testing

### 1. Check Health
```bash
curl https://axor-backend.onrender.com/health
```

Should return:
```json
{
  "status": "ok",
  "message": "AXOR Backend is running",
  "timestamp": "2024-..."
}
```

### 2. Check Songs
```bash
curl https://axor-backend.onrender.com/api/songs
```

Should return JSON with all your songs.

### 3. Test in App
1. Update `api_config.dart` with Render URL
2. Hot restart app
3. Go to Library tab
4. Should see all songs
5. Tap a song - should play

---

## Important: Free Tier Behavior

### Auto-Sleep
- Backend sleeps after **15 minutes** of inactivity
- Saves your free hours
- Wakes up automatically when app makes request

### First Request After Sleep
- Takes **30-60 seconds** to wake up
- Show loading indicator in app
- Subsequent requests are instant

### Monthly Limits
- **750 hours/month** FREE
- With auto-sleep: ~100-200 hours/month actual usage
- Well within free tier! ✅

---

## Adding New Songs

Same as Railway:

1. Upload songs to MEGA public folder
2. Go to Render dashboard
3. Click "Manual Deploy" → "Deploy latest commit"
4. Or just restart: Settings → "Restart Service"
5. Wait 2-3 minutes
6. New songs appear automatically!

---

## Render Dashboard

**URL**: https://dashboard.render.com

**Features:**
- View logs (real-time)
- Restart service
- Update environment variables
- Monitor usage
- Manual deploy

---

## Troubleshooting

### Service Won't Start
**Check Logs:**
- Render dashboard → Your service → Logs
- Look for errors

**Common Issues:**
- Wrong port (must be 10000 for Render)
- Missing environment variables
- Wrong MEGA credentials

### First Request Slow
**This is normal!**
- Free tier sleeps after 15 min
- First request wakes it up (30-60 sec)
- Add loading indicator in app

**Solution:**
```dart
// In your API service
Future<List<Song>> getAllSongs() async {
  try {
    final response = await http.get(
      Uri.parse('${ApiConfig.baseUrl}${ApiConfig.songs}'),
    ).timeout(
      const Duration(seconds: 90), // Longer timeout for wake-up
    );
    // ... rest of code
  }
}
```

### Songs Not Loading
**Check:**
1. MEGA folder is public
2. Environment variables are correct
3. Logs show "✅ Loaded X songs"
4. Backend is running (not sleeping)

---

## Cost

**Free Tier:**
- 750 hours/month
- 100GB bandwidth/month
- 512MB RAM
- Shared CPU

**Your Usage:**
- ~100-200 hours/month (with auto-sleep)
- ~5-10GB bandwidth/month
- ~60MB storage

**Cost: $0/month** ✅

---

## Comparison: Render vs Railway

| Feature | Render | Railway |
|---------|--------|---------|
| Free Hours | 750/month | Trial ended |
| Auto-Sleep | Yes (15 min) | Optional |
| Wake Time | 30-60 sec | Instant |
| Bandwidth | 100GB | 100GB |
| Cost | FREE | ~$5/month |
| Ease of Use | Easy | Easy |

**Winner: Render** (Actually free!)

---

## GitHub Deployment (Recommended)

### 1. Create GitHub Repo
```bash
cd axor/axor_app_backend
git init
git add .
git commit -m "Initial commit"
git branch -M main
git remote add origin https://github.com/yourusername/axor-backend.git
git push -u origin main
```

### 2. Connect to Render
1. Render dashboard → New Web Service
2. Connect GitHub account
3. Select your repo
4. Configure and deploy

### 3. Auto-Deploy
- Push to GitHub → Render auto-deploys
- No manual uploads needed
- Always up-to-date

---

## Alternative: Fly.io

If Render doesn't work, try Fly.io:

### Install CLI
```bash
npm install -g flyctl
```

### Deploy
```bash
cd axor/axor_app_backend
flyctl auth signup
flyctl launch
flyctl secrets set MEGA_EMAIL=your-email@example.com
flyctl secrets set MEGA_PASSWORD=your-password
flyctl secrets set STORAGE_MODE=mega
flyctl secrets set MEGA_FOLDER_NAME=AxorMusic
flyctl deploy
```

**Free Tier:**
- 3 VMs free
- 160GB bandwidth
- Always on (no sleep)

---

## Alternative: Cyclic.sh

Easiest option:

### Deploy
1. Go to [cyclic.sh](https://cyclic.sh)
2. Click "Connect GitHub"
3. Select repo
4. Add environment variables
5. Deploy!

**Free Tier:**
- Unlimited apps
- 10GB bandwidth/month
- Always on

---

## My Recommendation

**Use Render.com** because:
1. Actually free (750 hours)
2. Easy to use
3. Similar to Railway
4. Auto-sleep saves hours
5. Good documentation

**Backup: Fly.io** if you need always-on

**Easiest: Cyclic.sh** if you want one-click deploy

---

## Quick Checklist

### Render Deployment
- [ ] Sign up at render.com
- [ ] Create new Web Service
- [ ] Connect GitHub or upload code
- [ ] Set environment variables
- [ ] Set port to 10000
- [ ] Select Free tier
- [ ] Deploy
- [ ] Copy Render URL
- [ ] Update Flutter app
- [ ] Test health endpoint
- [ ] Test in app

---

## Summary

**Railway trial ended** → Use Render.com instead!

**Steps:**
1. Sign up at render.com (free)
2. Create Web Service
3. Upload `axor_app_backend` folder
4. Set environment variables (port = 10000)
5. Deploy
6. Update Flutter app with Render URL
7. Done!

**Cost: $0/month** ✅
**New songs: Still auto-appear** ✅
**Same functionality** ✅

---

## Need Help?

**Render Docs**: https://render.com/docs
**Render Discord**: https://discord.gg/render
**Fly.io Docs**: https://fly.io/docs
**Cyclic Docs**: https://docs.cyclic.sh

Good luck! 🚀
