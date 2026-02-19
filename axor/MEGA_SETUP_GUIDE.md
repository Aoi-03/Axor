# MEGA Cloud Storage Setup Guide (Official MEGAcmd)

## Overview
This guide uses **MEGAcmd** - MEGA's official command-line tool for Node.js integration.

---

## Step 1: Install MEGAcmd (Official Tool)

### Download MEGAcmd:
Go to: **https://mega.io/cmd**

### Windows Installation:
1. Download **MEGAcmdSetup.exe**
2. Run the installer
3. Follow installation wizard
4. MEGAcmd will be added to your PATH automatically

### Verify Installation:
Open PowerShell and run:
```powershell
mega-version
```

You should see the MEGAcmd version number.

---

## Step 2: Create MEGA Account

1. Go to **https://mega.nz**
2. Click "Create Account"
3. Enter email and password
4. Verify your email
5. You get **20GB free storage**!

---

## Step 3: Upload Your Music to MEGA

### Option A: Using MEGA Desktop App (Easiest)
1. Download MEGA Desktop from https://mega.nz/desktop
2. Install and login
3. Create folder: `/AxorMusic`
4. Drag and drop all 225 FLAC files
5. Wait for upload to complete

### Option B: Using MEGAcmd (Command Line)
```powershell
# Login
mega-login your-email@example.com your-password

# Create folder
mega-mkdir /AxorMusic

# Upload all FLAC files
mega-put "C:\Users\LUNA\Downloads\AI\*.flac" /AxorMusic/

# Check upload status
mega-ls /AxorMusic
```

---

## Step 4: Configure Backend

### Edit `.env` file:
```env
# MEGA Cloud Storage Configuration
MEGA_EMAIL=your-email@example.com
MEGA_PASSWORD=your-password

# Storage Mode: 'local' or 'mega'
STORAGE_MODE=mega

# MEGA folder name
MEGA_FOLDER_NAME=/AxorMusic

# Server Port
PORT=3000
```

**Important:** Replace with your actual MEGA credentials!

---

## Step 5: Update server.js to Use MEGA

The backend is already configured to support both local and MEGA storage modes.

### Check Current Mode:
Look for this in `server.js`:
```javascript
const STORAGE_MODE = process.env.STORAGE_MODE || 'local';
```

### Switch to MEGA Mode:
In `.env` file, change:
```env
STORAGE_MODE=mega
```

---

## Step 6: Test MEGA Integration

### Start Backend:
```powershell
cd axor/axor_app_backend
node server.js
```

### Expected Output (MEGA Mode):
```
🔐 Connecting to MEGA using MEGAcmd...
✅ Connected to MEGA successfully
📦 Account: your-email@example.com
👤 Account: your-email@example.com
🔍 Scanning MEGA folder: /AxorMusic
✅ 1. Song1.flac (12.5 MB)
✅ 2. Song2.flac (15.3 MB)
...
🎵 Found 225 FLAC files in MEGA
🎵 AXOR Backend running on http://localhost:3000
```

---

## MEGAcmd Commands Reference

### Login/Logout:
```powershell
mega-login email@example.com password
mega-logout
mega-whoami
```

### File Operations:
```powershell
# List files
mega-ls /AxorMusic

# Upload file
mega-put "C:\path\to\song.flac" /AxorMusic/

# Download file
mega-get /AxorMusic/song.flac "C:\Downloads\"

# Create folder
mega-mkdir /NewFolder

# Delete file
mega-rm /AxorMusic/song.flac
```

### Account Info:
```powershell
# Check storage usage
mega-du

# Account details
mega-whoami

# Version
mega-version
```

### Export/Share:
```powershell
# Get public link
mega-export -a /AxorMusic/song.flac

# Remove public link
mega-export -d /AxorMusic/song.flac
```

---

## How It Works

### Architecture:
```
Phone App → Backend Server → MEGAcmd → MEGA Cloud → Stream to Phone
```

### Flow:
1. **App requests song** → Backend receives request
2. **Backend calls MEGAcmd** → Gets file from MEGA
3. **MEGAcmd downloads** → Temp file or direct stream
4. **Backend streams** → Sends to phone app
5. **Phone plays** → FLAC audio at full quality

---

## Advantages of MEGAcmd

✅ **Official MEGA tool** - Fully supported by MEGA
✅ **20GB free storage** - More than enough for 225 songs
✅ **Command-line interface** - Easy Node.js integration
✅ **Cross-platform** - Windows, Mac, Linux
✅ **Secure** - End-to-end encryption
✅ **No API limits** - Better than public links
✅ **Automatic sync** - Can sync folders automatically

---

## Troubleshooting

### MEGAcmd not found?
- Make sure you installed from https://mega.io/cmd
- Restart PowerShell after installation
- Check PATH: `echo $env:PATH`

### Login failed?
- Check email and password in `.env`
- Verify account at https://mega.nz
- Try logging in via MEGA website first

### Folder not found?
- Create folder: `mega-mkdir /AxorMusic`
- Check folder exists: `mega-ls /`
- Make sure folder name matches in `.env`

### Upload failed?
- Check internet connection
- Verify storage space: `mega-du`
- Try uploading one file first to test

### Streaming slow?
- MEGA free account has bandwidth limits
- Consider MEGA Pro for better speeds
- Or use local storage for development

---

## Storage Comparison

| Feature | Local Storage | MEGA Cloud |
|---------|---------------|------------|
| Storage | Unlimited (your PC) | 20GB free |
| Access | Only when PC on | Anywhere, anytime |
| Speed | Very fast | Medium (internet) |
| Setup | Easy | Medium |
| Cost | Free | Free (20GB) |
| Sharing | Difficult | Easy (public links) |
| Backup | Manual | Automatic |

---

## Next Steps

### Development (Recommended):
1. Keep `STORAGE_MODE=local` for fast development
2. Test all features with local files
3. Switch to MEGA when ready to deploy

### Production:
1. Upload all songs to MEGA
2. Set `STORAGE_MODE=mega`
3. Deploy backend to cloud (Heroku, AWS, etc.)
4. App works from anywhere!

### Hybrid Approach:
1. Use local for development
2. Use MEGA for production
3. Easy switching via `.env` file

---

## Security Notes

⚠️ **Never commit `.env` file to Git!**
- Contains your MEGA password
- Already in `.gitignore`
- Use `.env.example` for templates

🔒 **MEGA Encryption:**
- All files are encrypted
- Only you can decrypt them
- MEGA can't access your files

---

## Cost Breakdown

### MEGA Free:
- 20GB storage
- Bandwidth limits apply
- Perfect for personal use

### MEGA Pro Lite ($5.50/month):
- 400GB storage
- 1TB transfer
- Better speeds

### MEGA Pro I ($11/month):
- 2TB storage
- 2TB transfer
- Priority support

**For 225 songs (~3-4GB), free plan is perfect!**

---

## Ready to Use MEGA?

1. ✅ Install MEGAcmd from https://mega.io/cmd
2. ✅ Create MEGA account at https://mega.nz
3. ✅ Upload songs using MEGA Desktop or MEGAcmd
4. ✅ Update `.env` with your credentials
5. ✅ Set `STORAGE_MODE=mega`
6. ✅ Start backend: `node server.js`
7. ✅ Enjoy your cloud music library! 🎵☁️
