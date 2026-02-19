# Test MEGA Streaming NOW! 🎵

## Backend Status: ✅ RUNNING

**Backend Details:**
- Port: 3001
- IP: 10.47.179.162
- Songs: 3 FLAC files from MEGA
- Mode: Public Folder (megajs)

## Songs Loaded:
1. Star Odyssey - HOYO-MiX, 鈴木愛理.flac (38.7 MB)
2. SPECIALZ - King Gnu.flac (52.9 MB)
3. Paisa Hai Toh - Sachin-Jigar, Vishal Dadlani, Mellow D, Jigar Saraiya.flac (57.5 MB)

## Testing Steps

### 1. Connect Your Phone

**Make sure:**
- ✅ Phone and laptop on SAME WiFi network (not hotspot!)
- ✅ WiFi name matches on both devices
- ✅ Phone can access: http://10.47.179.162:3001/health

**Test connection from phone browser:**
Open Chrome/Safari on phone and go to:
```
http://10.47.179.162:3001/health
```

Should see:
```json
{
  "status": "ok",
  "message": "AXOR Backend is running"
}
```

### 2. Open Flutter App

1. Open Axor app on your phone
2. Wait for songs to load (should see 3 songs)
3. Tap any song to play

### 3. What to Expect

**✅ If Working:**
- Songs appear in list
- Tapping song starts playback
- Progress bar moves
- Song plays smoothly from MEGA

**❌ If Not Working:**
- No songs appear → Check WiFi connection
- Songs appear but won't play → Check backend logs
- "Source error" → Backend streaming issue

### 4. Watch Backend Logs

While testing, watch the backend terminal. You should see:
```
📋 Songs list requested - returning 3 songs
🎵 Streaming from MEGA: Star Odyssey - HOYO-MiX
✅ Finished streaming: Star Odyssey - HOYO-MiX
```

## Troubleshooting

### No songs appearing?
```bash
# Check backend is accessible from phone
# Open phone browser: http://10.47.179.162:3001/api/songs
# Should see JSON with 3 songs
```

### Songs won't play?
- Check backend logs for errors
- Make sure MEGA public folder is accessible
- Check phone internet connection

### Connection refused?
- Verify IP address: `ipconfig`
- Check Windows Firewall (allow port 3001)
- Make sure both devices on same WiFi

## Backend URL

Your Flutter app is configured to use:
```
http://10.47.179.162:3001
```

If your IP changed, update `axor_app/lib/services/api_config.dart`

## Ready to Test!

1. Connect phone to same WiFi as laptop
2. Open Axor app
3. See if songs appear and play

Let me know what happens!
