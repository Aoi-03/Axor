# Testing the AI Song Matching Feature

## Quick Start Guide

### Step 1: Start the Backend
Open VS Code terminal and run:
```bash
cd axor/axor_app_backend
node server.js
```

Or simply double-click: `axor/START_BACKEND.bat`

**Expected Output:**
```
🎵 AXOR Backend running on http://localhost:3000
📁 Music library: C:\Users\LUNA\Downloads\AI
📊 Database path: ...
🔍 Scanning your music library...
📦 Loaded 0 cached song metadata (first time)
✅ Successfully scanned: 225 songs
```

### Step 2: Run the Flutter App
In another terminal:
```bash
cd axor_app
flutter run
```

Select your device (wireless debugging or emulator).

### Step 3: Test AI Mode

#### 3.1 Play a Song
1. Open the app
2. Go to "Library" tab
3. Tap any song to play it

#### 3.2 Activate AI Mode
1. Look at the music player at the bottom
2. Find the shuffle/repeat button (4th button from left)
3. Tap it **3 times** until you see the ✨ (sparkle) icon
   - 1st tap: 🔂 (Repeat One)
   - 2nd tap: 🔀 (Shuffle)
   - 3rd tap: ✨ (AI Mode) ← This is what you want!

#### 3.3 Watch the Magic
1. Let the current song finish playing (or seek to the end)
2. Watch the backend console - you'll see:
   ```
   🌐 Fetching metadata from internet for: [Song Name]
   ✅ Fetched and cached metadata for: [Song Name]
   🤖 AI Mode: Finding similar song to [Song Name]
   🎯 Found 20 similar songs for: [Song Name]
   ```
3. The next song will automatically play - and it will be similar!
4. Check the song title - it should match the vibe/genre/mood

### Step 4: Verify It's Working

#### Check 1: Backend Logs
You should see metadata fetching logs in the backend console.

#### Check 2: Metadata Cache
Open: `axor/axor_app_backend/song_metadata_cache/song_metadata.json`

You should see entries like:
```json
{
  "song_Aashiqui_2_Mashup_Arijit_Singh_Ankit_Tiwari": {
    "genres": ["bollywood", "romantic", "pop"],
    "mood": "upbeat",
    "energy": 0.7,
    "tempo": 125,
    "fetchedAt": "2026-02-07T..."
  }
}
```

#### Check 3: Similar Songs
Play a high-energy song (like "Arjan Vailly" or "Abrar's Entry"):
- Next song should also be high-energy
- Genre should match (rock/electronic/energetic)

Play a calm song (like "Another Love" or "Ainsi bas la vida"):
- Next song should be calm/emotional
- Lower energy level

## Example Test Scenarios

### Scenario 1: Energetic Songs
1. Play: "Arjan Vailly" (high energy, 150+ BPM)
2. Activate AI mode (✨)
3. Let it finish
4. Expected next: "Abrar's Entry" or similar high-energy song

### Scenario 2: Calm Songs
1. Play: "Another Love" (low energy, emotional)
2. Activate AI mode (✨)
3. Let it finish
4. Expected next: Another calm/emotional song

### Scenario 3: Anime/OST Songs
1. Play: "Ashes on The Fire" (Attack on Titan OST)
2. Activate AI mode (✨)
3. Let it finish
4. Expected next: Another anime/OST song

## Troubleshooting

### Problem: AI mode not working
**Solution:**
- Check backend is running (port 3000)
- Check Flutter console for errors
- Verify ✨ icon is showing (not 🔁 or 🔀)

### Problem: Same songs repeating
**Solution:**
- This means songs have very similar metadata
- Try playing songs from different genres
- Metadata cache will improve over time

### Problem: Metadata not fetching
**Solution:**
- Check internet connection
- MusicBrainz API might be slow (wait 5-10 seconds)
- Backend will use basic FLAC metadata as fallback

### Problem: Song doesn't auto-play
**Solution:**
- Make sure AI mode is active (✨ icon)
- Check backend console for errors
- Try playing next song manually first

## Performance Notes

### First Time (No Cache)
- Each song takes ~2-5 seconds to fetch metadata
- You'll see "🌐 Fetching metadata..." in backend console
- Subsequent plays are instant

### With Cache
- Similarity calculation: <500ms
- No internet requests needed
- Smooth transitions between songs

## Advanced Testing

### Test 1: Cache Persistence
1. Play 5 songs in AI mode
2. Stop backend (Ctrl+C)
3. Restart backend
4. Check console: "📦 Loaded 5 cached song metadata"
5. Play same songs - should be instant (no fetching)

### Test 2: Similarity Accuracy
1. Play a Bollywood romantic song
2. Note the next song - should be similar genre
3. Play a rock/metal song
4. Note the next song - should be different from step 2

### Test 3: Fallback Behavior
1. Disconnect internet
2. Play a song not in cache
3. Backend should use basic FLAC metadata
4. Song should still play (no crash)

## Success Criteria

✅ Backend starts without errors
✅ 225 songs scanned successfully
✅ AI button (✨) appears in player
✅ Metadata fetches from internet (first time)
✅ Metadata saves to cache file
✅ Similar songs auto-play when current finishes
✅ Backend logs show similarity scores
✅ Songs match by genre/mood/energy
✅ Cache persists across restarts
✅ No crashes or errors

## What to Look For

### Good Signs:
- Backend logs show metadata fetching
- Cache file grows with each new song
- Similar songs play automatically
- Smooth transitions between songs
- No errors in console

### Bad Signs:
- "Error fetching similar songs" in Flutter console
- Backend crashes or shows errors
- Songs don't auto-play
- Random songs play (not similar)
- Cache file stays empty

## Next Steps After Testing

1. **If it works:** Enjoy your AI-powered music experience! 🎉
2. **If issues:** Check troubleshooting section above
3. **Want to improve:** Add more songs to library for better matching
4. **Want to customize:** Adjust similarity weights in `server.js`

## Tips for Best Experience

1. **Let cache build up** - First 10-20 songs will be slow, then instant
2. **Play diverse genres** - Helps AI learn different music types
3. **Use AI mode for discovery** - Find songs you forgot you had
4. **Mix with shuffle** - Use shuffle for variety, AI for flow
5. **Check backend logs** - See what AI is thinking!

---

**Ready to test?** Start the backend and enjoy your smart music player! ✨
