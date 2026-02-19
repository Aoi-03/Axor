# Railway Deployment Checklist

## Before You Start

- [ ] Have MEGA account with public folder
- [ ] Know your MEGA email and password
- [ ] Know your MEGA folder name (e.g., "AxorMusic")
- [ ] Songs are uploaded to MEGA public folder
- [ ] Have Railway account (sign up at railway.app)

---

## Deployment Steps

### Step 1: Prepare Files (1 minute)
- [ ] Open `axor_app_backend` folder
- [ ] Make sure these files exist:
  - [ ] server.js
  - [ ] mega_service.js
  - [ ] mega_public_service.js
  - [ ] package.json
  - [ ] database/ folder

### Step 2: Railway Setup (2 minutes)
- [ ] Go to railway.app
- [ ] Click "New Project"
- [ ] Choose deployment method (GitHub or CLI)

### Step 3: Environment Variables (3 minutes)
In Railway dashboard, add these variables:

- [ ] `MEGA_EMAIL` = your-email@example.com
- [ ] `MEGA_PASSWORD` = your-password
- [ ] `STORAGE_MODE` = mega
- [ ] `MEGA_FOLDER_NAME` = AxorMusic
- [ ] `PORT` = 3001

### Step 4: Deploy (5 minutes)
- [ ] Upload code to Railway
- [ ] Wait for build to complete
- [ ] Check logs for "✅ Loaded X songs"
- [ ] Copy your Railway URL

### Step 5: Update Flutter App (2 minutes)
- [ ] Open `axor_app/lib/services/api_config.dart`
- [ ] Change `baseUrl` to your Railway URL
- [ ] Save file
- [ ] Hot restart app

### Step 6: Test (3 minutes)
- [ ] Test health endpoint: `curl https://your-app.up.railway.app/health`
- [ ] Open app on phone
- [ ] Go to Library tab
- [ ] See all songs loaded
- [ ] Tap a song - should play
- [ ] Check Your Vibe section
- [ ] Create a playlist in The Shelf

---

## After Deployment

### Adding New Songs
- [ ] Upload songs to MEGA public folder
- [ ] Go to Railway dashboard
- [ ] Click "Restart" button
- [ ] Wait 2-3 minutes
- [ ] Open app - new songs appear

### Monitoring
- [ ] Check Railway logs occasionally
- [ ] Monitor usage (should be under free tier)
- [ ] Enable "Sleep after inactivity" if needed

---

## Troubleshooting

### Backend Won't Start
- [ ] Check Railway logs for errors
- [ ] Verify all environment variables are set
- [ ] Check MEGA credentials are correct
- [ ] Verify MEGA folder name matches exactly

### Songs Not Loading
- [ ] Check MEGA folder is public
- [ ] Verify songs are in the folder
- [ ] Check backend logs: "✅ Loaded X songs"
- [ ] Restart backend

### App Can't Connect
- [ ] Verify Railway URL in api_config.dart
- [ ] Check backend is running (Railway dashboard)
- [ ] Test health endpoint
- [ ] Restart app

---

## Success Indicators

✅ Railway shows "Deployed"
✅ Logs show "✅ Loaded 189 songs from MEGA"
✅ Health endpoint returns {"status": "ok"}
✅ App shows songs in Library
✅ Songs play when tapped
✅ Your Vibe shows playlists
✅ Can create playlists in The Shelf

---

## Quick Reference

**Railway Dashboard**: https://railway.app/dashboard
**Your Backend URL**: https://your-app.up.railway.app
**Health Check**: https://your-app.up.railway.app/health
**Songs API**: https://your-app.up.railway.app/api/songs

**Files to Upload**: `axor_app_backend/` folder
**Don't Upload**: node_modules, .env, cache folders
**Cost**: ~$5/month (or free with sleep mode)

---

## Done! 🎉

Your backend is now live and accessible from anywhere!

New songs will appear automatically when you:
1. Upload to MEGA
2. Restart backend
3. Wait 2-3 minutes

No code changes needed! 🚀
