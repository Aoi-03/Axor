# Render.com Deployment - Step by Step

## Before You Start

You need:
- [ ] MEGA email and password
- [ ] MEGA folder name (e.g., "AxorMusic")
- [ ] GitHub account (optional but recommended)

---

## Step 1: Sign Up on Render (2 minutes)

1. Go to **[render.com](https://render.com)**
2. Click **"Get Started for Free"**
3. Sign up with:
   - **GitHub** (recommended - easier deployment)
   - OR **Email** (manual upload)
4. Verify your email if needed
5. You'll see the Render dashboard

**No credit card required!** ✅

---

## Step 2: Prepare Your Code (2 minutes)

### Option A: Using GitHub (Recommended)

1. Create a new GitHub repository:
   - Go to [github.com](https://github.com)
   - Click "New repository"
   - Name it: `axor-backend`
   - Make it **Public** or **Private** (your choice)
   - Click "Create repository"

2. Upload your backend folder:
   ```bash
   cd axor/axor_app_backend
   git init
   git add .
   git commit -m "Initial commit"
   git branch -M main
   git remote add origin https://github.com/YOUR_USERNAME/axor-backend.git
   git push -u origin main
   ```

### Option B: Manual Upload (Simpler)

Just have your `axor_app_backend` folder ready. We'll upload it directly to Render.

---

## Step 3: Create Web Service on Render (3 minutes)

1. In Render dashboard, click **"New +"** button (top right)
2. Select **"Web Service"**
3. You'll see connection options:

### If Using GitHub:
1. Click **"Connect GitHub"**
2. Authorize Render to access your repos
3. Find and select your `axor-backend` repo
4. Click **"Connect"**

### If Manual Upload:
1. Click **"Public Git repository"**
2. Enter: `https://github.com/YOUR_USERNAME/axor-backend.git`
3. Click **"Continue"**

---

## Step 4: Configure Your Service (5 minutes)

You'll see a configuration form. Fill it out:

### Basic Settings:

**Name:**
```
axor-backend
```
(or any name you like - this will be in your URL)

**Region:**
```
Choose closest to you (e.g., Singapore, Frankfurt, Oregon)
```

**Branch:**
```
main
```

**Root Directory:**
```
(leave empty)
```

**Runtime:**
```
Node
```

**Build Command:**
```
npm install
```

**Start Command:**
```
npm start
```

### Instance Type:

**IMPORTANT:** Select **"Free"** from the dropdown!

---

## Step 5: Add Environment Variables (3 minutes)

Scroll down to **"Environment Variables"** section:

Click **"Add Environment Variable"** and add these one by one:

**Variable 1:**
```
Key: MEGA_EMAIL
Value: your-mega-email@example.com
```

**Variable 2:**
```
Key: MEGA_PASSWORD
Value: your-mega-password
```

**Variable 3:**
```
Key: STORAGE_MODE
Value: mega
```

**Variable 4:**
```
Key: MEGA_FOLDER_NAME
Value: AxorMusic
```
(use your actual MEGA folder name)

**Variable 5:**
```
Key: PORT
Value: 10000
```

**Variable 6:**
```
Key: NODE_ENV
Value: production
```

---

## Step 6: Deploy! (1 minute)

1. Scroll to the bottom
2. Click **"Create Web Service"**
3. Render will start building your app

**Wait 5-10 minutes** for first deployment:
- Installing dependencies
- Building app
- Starting server
- Scanning MEGA folder
- Loading songs

---

## Step 7: Check Deployment Status

You'll see the deployment logs in real-time:

**Look for these messages:**
```
==> Installing dependencies
==> npm install
==> Starting service
==> 🎵 AXOR Backend running on http://localhost:10000
==> ✅ Loaded 189 songs from MEGA
```

**When you see:**
```
==> Your service is live 🎉
```

**You're done!** ✅

---

## Step 8: Get Your URL

At the top of the page, you'll see your URL:
```
https://axor-backend.onrender.com
```

**Copy this URL!** You'll need it for the Flutter app.

---

## Step 9: Test Your Backend (2 minutes)

### Test 1: Health Check

Open your browser or use curl:
```
https://axor-backend.onrender.com/health
```

**Expected response:**
```json
{
  "status": "ok",
  "message": "AXOR Backend is running",
  "timestamp": "2024-..."
}
```

### Test 2: Check Songs

```
https://axor-backend.onrender.com/api/songs
```

**Expected:** JSON with all your songs

---

## Step 10: Update Flutter App (2 minutes)

1. Open `axor_app/lib/services/api_config.dart`

2. Change the baseUrl:
```dart
class ApiConfig {
  // OLD (local WiFi):
  // static const String baseUrl = 'http://192.168.0.103:3001';
  
  // NEW (Render):
  static const String baseUrl = 'https://axor-backend.onrender.com';
  
  // Endpoints (no changes needed)
  static const String health = '/health';
  static const String songs = '/api/songs';
  // ... rest stays the same
}
```

3. Save the file

4. **Hot restart** your app (not hot reload!)
   - Stop the app
   - Run `flutter run` again

---

## Step 11: Test in App (2 minutes)

1. Open app on your phone
2. Go to **Library** tab
3. Wait a few seconds (first request after sleep takes 30-60 sec)
4. You should see all 189 songs!
5. Tap a song - it should play ✅
6. Check **Your Vibe** section - should show playlists
7. Try creating a playlist in **The Shelf**

**Everything should work!** 🎉

---

## Important: First Request After Sleep

**Render free tier sleeps after 15 minutes of inactivity.**

**What this means:**
- If no one uses the app for 15 minutes → backend sleeps
- Next request wakes it up → takes 30-60 seconds
- After wake-up → instant responses

**In your app, show a loading message:**
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
  } catch (e) {
    // Handle timeout
  }
}
```

---

## Adding New Songs Later

1. Upload songs to MEGA public folder
2. Go to Render dashboard
3. Click your service name
4. Click **"Manual Deploy"** → **"Deploy latest commit"**
5. OR click **"Settings"** → **"Restart Service"**
6. Wait 2-3 minutes
7. Backend scans MEGA and loads new songs
8. Open app - new songs appear! ✅

---

## Troubleshooting

### Service Won't Start

**Check Logs:**
- Render dashboard → Your service → Logs tab
- Look for error messages

**Common Issues:**
1. Wrong MEGA credentials
   - Fix: Update environment variables
2. Wrong MEGA folder name
   - Fix: Check exact folder name in MEGA
3. Missing environment variables
   - Fix: Add all 6 variables

### Songs Not Loading

**Check:**
1. MEGA folder is public (has share link)
2. Songs are in the folder
3. Logs show "✅ Loaded X songs"
4. Environment variables are correct

**Fix:**
- Go to Settings → Environment
- Verify all variables
- Click "Save Changes"
- Service will restart automatically

### App Can't Connect

**Check:**
1. Render URL is correct in `api_config.dart`
2. Backend is running (check Render dashboard)
3. Health endpoint works in browser
4. You did hot restart (not hot reload)

**Fix:**
- Stop app completely
- Run `flutter run` again
- Wait for first request to wake backend (60 sec)

### First Request Very Slow

**This is normal!**
- Free tier sleeps after 15 min
- First request wakes it up (30-60 sec)
- Subsequent requests are instant

**Solution:**
- Show loading indicator
- Increase timeout to 90 seconds
- Tell users "Waking up backend..."

---

## Render Dashboard Features

**URL:** https://dashboard.render.com

**What you can do:**
- ✅ View real-time logs
- ✅ Restart service
- ✅ Update environment variables
- ✅ Manual deploy
- ✅ Monitor usage (hours used)
- ✅ See deployment history

---

## Cost & Usage

**Free Tier:**
- 750 hours/month
- 100GB bandwidth/month
- 512MB RAM
- Unlimited apps

**Your Usage:**
- ~100-200 hours/month (with auto-sleep)
- ~5-10GB bandwidth/month
- ~60MB storage

**Cost: $0/month** ✅

**Check Usage:**
- Render dashboard → Account → Usage
- See hours used this month
- Resets on 1st of each month

---

## Summary Checklist

- [ ] Signed up on Render.com
- [ ] Created Web Service
- [ ] Connected GitHub or uploaded code
- [ ] Set all 6 environment variables
- [ ] Selected "Free" instance type
- [ ] Deployed successfully
- [ ] Checked logs for "✅ Loaded X songs"
- [ ] Tested health endpoint
- [ ] Tested songs endpoint
- [ ] Updated Flutter app with Render URL
- [ ] Hot restarted app
- [ ] Tested playback in app
- [ ] Everything works! 🎉

---

## Quick Reference

**Your Render URL:**
```
https://axor-backend.onrender.com
```

**Health Check:**
```
https://axor-backend.onrender.com/health
```

**Songs API:**
```
https://axor-backend.onrender.com/api/songs
```

**Dashboard:**
```
https://dashboard.render.com
```

---

## Next Steps

After deployment works:
1. Test all app features
2. Add more songs to MEGA
3. Restart backend to load new songs
4. Share app with friends!

---

**That's it! Your backend is now live and accessible from anywhere!** 🚀

**Total time: ~20 minutes**
**Cost: $0/month**
**New songs: Auto-appear on restart**

Enjoy your music app! 🎵
