# AXOR Songs Directory

This directory stores all music files for the AXOR app.

## Structure

```
songs/
├── flac/           # FLAC format (lossless)
├── mp3/            # MP3 format (compressed)
└── README.md       # This file
```

## File Organization

### FLAC Directory
Place all FLAC files here:
- `thunder_strike.flac`
- `midnight_drive.flac`
- `focus_flow.flac`
- `gym_beast.flac`
- `lost_in_thought.flac`
- `road_trip_anthem.flac`
- `deep_concentration.flac`
- `adrenaline_rush.flac`
- `sunset_vibes.flac`
- `power_surge.flac`

### MP3 Directory
Place all MP3 files here (optional, for testing):
- Same filenames as FLAC but with `.mp3` extension

## Adding Songs

### For Testing (Without Real Files)

You can test the backend without actual audio files. The API will return metadata, and the Flutter app can show UI without playback.

### For Full Testing (With Real Files)

1. **Get Test Audio Files:**
   - Use royalty-free music from:
     - [Free Music Archive](https://freemusicarchive.org/)
     - [Incompetech](https://incompetech.com/)
     - [Bensound](https://www.bensound.com/)
   
2. **Convert to FLAC (if needed):**
   ```bash
   ffmpeg -i input.mp3 -c:a flac output.flac
   ```

3. **Rename Files:**
   - Match the filenames in `database/songs.json`
   - Example: `thunder_strike.flac`

4. **Place in Directory:**
   - FLAC files → `songs/flac/`
   - MP3 files → `songs/mp3/`

## File Naming Convention

- Use lowercase
- Use underscores instead of spaces
- Match the filename in `songs.json`
- Example: `"Thunder Strike"` → `thunder_strike.flac`

## Supported Formats

- **FLAC** (recommended) - Lossless, high quality
- **WAV** - Lossless, larger files
- **MP3** - Compressed, smaller files
- **AAC/M4A** - Compressed, good quality
- **OGG** - Compressed, open format
- **OPUS** - Compressed, modern codec

## File Size Guidelines

### FLAC (Lossless)
- 3-minute song: ~25-40 MB
- 5-minute song: ~40-65 MB

### MP3 (320kbps)
- 3-minute song: ~8-12 MB
- 5-minute song: ~12-20 MB

### AAC (256kbps)
- 3-minute song: ~6-8 MB
- 5-minute song: ~10-13 MB

## Storage Calculation

### Free Plan (1GB)
- ~25-40 FLAC songs
- ~80-125 MP3 songs

### Premium Plan (10GB)
- ~250-400 FLAC songs
- ~800-1250 MP3 songs

## Backend Integration

The backend serves these files as static content:

```javascript
app.use('/songs', express.static(path.join(__dirname, '../songs')));
```

**Access URL:**
```
http://localhost:3000/songs/flac/thunder_strike.flac
http://localhost:3000/songs/mp3/thunder_strike.mp3
```

## Testing Without Files

If you don't have audio files yet:

1. Backend will still work (returns metadata)
2. Flutter app will show UI
3. Playback will fail gracefully
4. You can test all other features

## Adding Your Own Music

### Step 1: Analyze Audio
Use a tool to get BPM and energy:
- [Sonic Visualiser](https://www.sonicvisualiser.org/)
- [Essentia](https://essentia.upf.edu/)
- [librosa](https://librosa.org/) (Python)

### Step 2: Add to Database
Update `database/songs.json`:
```json
{
  "id": "song_new",
  "title": "Your Song",
  "artist": "Your Artist",
  "bpm": 120,
  "energy": 0.7,
  "filePath": "/songs/flac/your_song.flac"
}
```

### Step 3: Place File
Copy file to `songs/flac/your_song.flac`

### Step 4: Restart Backend
```bash
npm start
```

## Notes

- Keep original files as backup
- Don't commit large audio files to Git
- Use `.gitignore` to exclude audio files
- For production, use Cloudflare R2 or S3

## Future: Cloud Storage

In production, songs will be stored in Cloudflare R2:
- Admin uploads curated FLAC packs
- Users download to local storage
- Signed URLs for secure access
- No user uploads (admin-curated only)