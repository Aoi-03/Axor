# Quick Test Guide - Your Vibe & The Shelf

## Start Backend

```bash
cd axor/axor_app_backend
node server.js
```

**Expected Output**:
```
🎵 AXOR Backend running on http://localhost:3001
📁 Music library: ...
📊 Database path: ...
🔍 Scanning your music library...
✅ Loaded 189 songs from MEGA
```

---

## Start Flutter App

```bash
cd axor_app
flutter run
```

**Make sure**:
- Backend is running first
- Phone and laptop on same WiFi (192.168.0.103)

---

## Test Your Vibe (AI Suggestions)

### Step 1: Open Home Tab
- App should show "Hey There, Alex"
- Scroll to "> Your Vibe - AI suggestion"

### Step 2: Wait for Loading
- Should see loading spinner
- Takes 2-3 seconds to fetch from backend

### Step 3: View Vibes
- Should see 4-6 vibe cards
- Examples: "Morning Energy", "Neon Lights", "Lost in Thought"
- Cards scroll horizontally

### Step 4: Tap a Vibe
- Tap any vibe card
- Should navigate to playlist detail screen
- Should see loading spinner

### Step 5: View Songs
- Should see 15-20 songs
- Songs have real titles (not "Song 1", "Song 2")
- Songs have real artists
- Header shows song count

**Expected Vibes** (based on time):
- Morning (6am-12pm): "Morning Energy"
- Afternoon (12pm-6pm): "Afternoon Flow"
- Evening (6pm-10pm): "Evening Chill"
- Night (10pm-6am): "Midnight Thoughts"
- Always: "Lost in Thought", "Neon Lights"

---

## Test The Shelf (User Playlists)

### Step 1: Open Home Tab
- Scroll down to "> The Shelf"
- Should see "No playlists yet. Tap + to create one!"

### Step 2: Create Playlist
- Tap "+" button in top right
- Dialog appears with dark theme
- Enter playlist name: "My Favorites"
- Optionally enter description: "Best songs"
- Tap "Create"

### Step 3: View Playlist
- Should see new playlist card appear
- Shows playlist name and "0 songs"
- Tap playlist card

### Step 4: View Empty Playlist
- Should navigate to playlist detail
- Shows "No songs in this playlist"
- Header shows "0 songs"

### Step 5: Test Persistence
- Close app completely (swipe away)
- Reopen app
- Go to Home tab
- Scroll to "The Shelf"
- Playlist should still be there!

---

## Test Smart Modes

### GYM MODE
- Tap "GYM MODE" card (red)
- Should activate gym mode
- Returns to first tab

### STUDY MODE
- Tap "STUDY MODE" card (cyan)
- Should activate study mode
- Returns to first tab

### DRIVE MODE
- Tap "DRIVE MODE" card (green)
- Should activate drive mode
- Returns to first tab

---

## Troubleshooting

### Vibes Not Loading
**Problem**: Shows loading spinner forever
**Solution**:
1. Check backend is running
2. Check WiFi connection (same network)
3. Check backend console for errors
4. Verify IP address in `api_config.dart` is `192.168.0.103`

### Playlists Not Saving
**Problem**: Playlist disappears after closing app
**Solution**:
1. Check SharedPreferences is working
2. Try creating playlist again
3. Check Flutter console for errors

### Songs Not Showing
**Problem**: Playlist shows "No songs"
**Solution**:
1. This is expected for new playlists (empty)
2. For vibes, check backend has songs loaded
3. Check backend console shows "189 songs loaded"

### Backend Not Starting
**Problem**: "Cannot find module" or port error
**Solution**:
```bash
cd axor/axor_app_backend
npm install
node server.js
```

### App Not Connecting
**Problem**: "Connection refused" or timeout
**Solution**:
1. Check both devices on same WiFi
2. Find laptop IP: `ipconfig` (Windows) or `ifconfig` (Mac/Linux)
3. Update `api_config.dart` with correct IP
4. Restart Flutter app

---

## Expected Behavior

### Your Vibe
✅ Shows 4-6 dynamic vibes
✅ Vibes change based on time of day
✅ Each vibe has 15-20 songs
✅ Songs have real titles and artists
✅ Loading states work
✅ Navigation works

### The Shelf
✅ Shows empty state initially
✅ Create playlist dialog works
✅ Playlists appear in list
✅ Playlists persist after restart
✅ Shows song count (0 for new)
✅ Navigation works

### Smart Modes
✅ GYM MODE activates
✅ STUDY MODE activates
✅ DRIVE MODE activates
✅ Returns to first tab

---

## Backend API Endpoints

Test manually with curl or Postman:

### Get Vibes
```bash
curl -X POST http://192.168.0.103:3001/api/ai/vibes \
  -H "Content-Type: application/json" \
  -d '{"userId":"user_test1"}'
```

### Get All Songs
```bash
curl http://192.168.0.103:3001/api/songs
```

### Health Check
```bash
curl http://192.168.0.103:3001/health
```

**Expected Response**:
```json
{
  "status": "ok",
  "message": "AXOR Backend is running",
  "timestamp": "2024-..."
}
```

---

## Success Criteria

### Your Vibe ✅
- [ ] Vibes load from backend
- [ ] Shows 4-6 vibe cards
- [ ] Tap vibe shows songs
- [ ] Songs have real data
- [ ] No errors in console

### The Shelf ✅
- [ ] Can create playlist
- [ ] Playlist appears in list
- [ ] Playlist persists after restart
- [ ] Shows song count
- [ ] No errors in console

### Overall ✅
- [ ] Backend running without errors
- [ ] App connects to backend
- [ ] No Flutter errors
- [ ] Navigation works
- [ ] UI looks good

---

## Next Steps

Once everything above works:

1. **Add Songs to Playlist**
   - Create song selection screen
   - Browse Master Library
   - Add songs to playlists

2. **Playlist Management**
   - Edit playlist name
   - Delete playlist
   - Remove songs

3. **Playback**
   - Play songs from vibes
   - Play songs from playlists
   - Queue management

---

## Quick Commands

### Start Everything
```bash
# Terminal 1 - Backend
cd axor/axor_app_backend && node server.js

# Terminal 2 - Flutter
cd axor_app && flutter run
```

### Check Backend
```bash
curl http://192.168.0.103:3001/health
```

### Check Logs
- Backend: Check Terminal 1
- Flutter: Check Terminal 2 or VS Code Debug Console

---

## Contact Points

If something doesn't work:
1. Check backend console for errors
2. Check Flutter console for errors
3. Verify WiFi connection
4. Restart both backend and app
5. Check this guide again

**Everything should work!** 🎵
