# GitHub Setup Guide - AXOR Backend

## What to Push to GitHub

### ✅ Push These Files:

```
axor_app_backend/
├── server.js                 ✅ Main server
├── mega_service.js           ✅ MEGA integration
├── mega_public_service.js    ✅ Public folder handler
├── analyze_songs.js          ✅ Emotion detection
├── package.json              ✅ Dependencies
├── .env.example              ✅ Environment template (safe)
├── .gitignore                ✅ Ignore rules
├── README.md                 ✅ Documentation
└── database/                 ✅ JSON databases
    ├── songs.json
    ├── playlists.json
    └── users.json
```

### ❌ DON'T Push These:

```
❌ .env                       (has passwords!)
❌ node_modules/              (too large, auto-installed)
❌ mega_cache/                (covers - generated automatically)
❌ song_metadata_cache/       (metadata - generated automatically)
❌ *.log                      (log files)
```

---

## Why Covers Are NOT Pushed

### The Problem:
- 189 songs = ~189 cover images
- Each cover = ~200-500KB
- Total = ~50-100MB
- GitHub has 100MB file limit
- Pushing covers = slow, unnecessary

### The Solution:
**Covers are generated automatically!**

1. Backend starts on Render
2. Scans MEGA folder
3. Downloads covers from MEGA
4. Caches in `mega_cache/covers/`
5. Render's disk stores them
6. Cache persists across restarts

**You don't need to push covers!** ✅

---

## Step-by-Step GitHub Setup

### Step 1: Check .gitignore (1 minute)

Make sure `.gitignore` exists in `axor_app_backend/`:

```bash
cd axor/axor_app_backend
cat .gitignore
```

Should contain:
```
node_modules/
.env
mega_cache/
song_metadata_cache/
*.log
```

**Already created for you!** ✅

### Step 2: Check .env.example (1 minute)

Make sure `.env.example` exists (safe to push):

```bash
cat .env.example
```

Should contain:
```
MEGA_EMAIL=your-email@example.com
MEGA_PASSWORD=your-password
STORAGE_MODE=mega
MEGA_FOLDER_NAME=AxorMusic
PORT=3001
```

**This is safe to push** (no real passwords) ✅

### Step 3: Create GitHub Repository (2 minutes)

1. Go to [github.com](https://github.com)
2. Click **"New repository"** (green button)
3. Fill in:
   - **Name**: `axor-backend`
   - **Description**: "AXOR Music App Backend Server"
   - **Visibility**: 
     - **Private** (recommended - keeps code private)
     - OR **Public** (if you want to share)
   - **DON'T** check "Add README" (we have one)
   - **DON'T** add .gitignore (we have one)
4. Click **"Create repository"**

### Step 4: Initialize Git (1 minute)

```bash
cd axor/axor_app_backend

# Initialize git
git init

# Add all files (respects .gitignore)
git add .

# Check what will be committed
git status
```

**Verify:**
- ✅ Should see: server.js, package.json, etc.
- ❌ Should NOT see: .env, node_modules, mega_cache

### Step 5: Commit Files (1 minute)

```bash
# Commit
git commit -m "Initial commit: AXOR backend with MEGA integration"

# Set main branch
git branch -M main
```

### Step 6: Push to GitHub (1 minute)

```bash
# Add remote (replace YOUR_USERNAME)
git remote add origin https://github.com/YOUR_USERNAME/axor-backend.git

# Push
git push -u origin main
```

**Enter your GitHub username and password when prompted.**

**Done!** ✅ Your code is on GitHub (without sensitive data)

---

## Verify What Was Pushed

Go to your GitHub repo: `https://github.com/YOUR_USERNAME/axor-backend`

**Should see:**
- ✅ server.js
- ✅ mega_service.js
- ✅ package.json
- ✅ .env.example (safe template)
- ✅ .gitignore
- ✅ database/ folder

**Should NOT see:**
- ❌ .env (your real passwords)
- ❌ node_modules/
- ❌ mega_cache/
- ❌ song_metadata_cache/

**Perfect!** ✅

---

## How Render Handles Covers

### First Deployment (5-10 minutes):

```
1. Render clones your GitHub repo
2. Runs: npm install
3. Starts: npm start
4. Backend connects to MEGA
5. Scans public folder (finds 189 songs)
6. Downloads covers from MEGA
7. Saves to mega_cache/covers/
8. Render's disk stores them
9. Backend serves covers from cache
```

**Logs will show:**
```
🖼️  Cached cover 1/189: Song Name
🖼️  Cached cover 2/189: Song Name
...
✅ All covers cached!
```

### Subsequent Restarts (1-2 minutes):

```
1. Backend starts
2. Checks mega_cache/covers/
3. Finds existing covers
4. Only downloads NEW covers
5. Much faster!
```

### Storage on Render:

**Free Tier:**
- Disk: Persistent (survives restarts)
- Size: ~1GB available
- Your usage:
  - Backend code: ~5MB
  - node_modules: ~50MB
  - Covers cache: ~50-100MB
  - Metadata cache: ~5MB
  - **Total: ~110MB** (well within 1GB!)

**Covers persist across restarts!** ✅

---

## Environment Variables (Sensitive Data)

**NEVER push .env to GitHub!**

Instead:
1. Push `.env.example` (template, no real passwords)
2. Set real values in Render dashboard
3. Render injects them at runtime

**In Render:**
```
MEGA_EMAIL = your-real-email@example.com
MEGA_PASSWORD = your-real-password
```

**In GitHub (.env.example):**
```
MEGA_EMAIL = your-email@example.com
MEGA_PASSWORD = your-password
```

**Safe!** ✅

---

## Updating Code Later

### Make Changes:

```bash
cd axor/axor_app_backend

# Edit files
nano server.js

# Check changes
git status

# Add changes
git add .

# Commit
git commit -m "Added new feature"

# Push
git push
```

### Auto-Deploy on Render:

1. You push to GitHub
2. Render detects changes
3. Auto-deploys new version
4. Backend restarts
5. Covers are still cached (not re-downloaded)

**Automatic!** ✅

---

## Adding New Songs

### Process:

1. Upload songs to MEGA public folder
2. Render backend restarts (manual or auto)
3. Backend scans MEGA
4. Finds new songs
5. Downloads new covers
6. Caches them
7. New songs appear in app

**No GitHub push needed!** ✅

---

## Summary

### What to Push:
✅ All code files (server.js, etc.)
✅ package.json
✅ .env.example (template)
✅ .gitignore
✅ database/ folder

### What NOT to Push:
❌ .env (real passwords)
❌ node_modules/ (too large)
❌ mega_cache/ (covers - auto-generated)
❌ song_metadata_cache/ (auto-generated)

### Covers:
- ✅ NOT pushed to GitHub
- ✅ Generated automatically on Render
- ✅ Downloaded from MEGA
- ✅ Cached on Render's disk
- ✅ Persist across restarts
- ✅ ~50-100MB (well within 1GB limit)

### Storage on Render:
- ✅ 1GB available
- ✅ Your usage: ~110MB
- ✅ Plenty of space!

---

## Quick Checklist

Before pushing to GitHub:
- [ ] .gitignore exists
- [ ] .env is in .gitignore
- [ ] mega_cache/ is in .gitignore
- [ ] node_modules/ is in .gitignore
- [ ] .env.example exists (safe template)
- [ ] No real passwords in code

After pushing:
- [ ] Check GitHub repo
- [ ] Verify .env is NOT there
- [ ] Verify node_modules is NOT there
- [ ] Verify mega_cache is NOT there
- [ ] Only code files are there

---

## GitHub Commands Reference

```bash
# Initial setup
git init
git add .
git commit -m "Initial commit"
git branch -M main
git remote add origin https://github.com/YOUR_USERNAME/axor-backend.git
git push -u origin main

# Update code
git add .
git commit -m "Your message"
git push

# Check status
git status

# View changes
git diff

# View history
git log
```

---

**You're all set!** Push your code to GitHub (without covers and passwords), then deploy to Render. Covers will be generated automatically! 🚀
