# Quick Start: Set Up AXOR App Icon

**Admin:** a67154512@gmail.com  
**App Name:** AXOR

---

## 🚀 Super Quick Setup (3 Steps)

### **Step 1: Make sure your logo is ready**
- File location: `axor_app/assets/logo.png`
- Size: 1024x1024 pixels (recommended)
- Format: PNG with transparency

### **Step 2: Run the setup script**

**On Windows:**
```bash
cd axor_app
setup_app_icon.bat
```

**On Mac/Linux:**
```bash
cd axor_app
flutter pub get
dart run flutter_launcher_icons
flutter clean
flutter pub get
```

### **Step 3: Test the app**
```bash
flutter run
```

**Done!** Your AXOR logo is now the app icon! 🎉

---

## 📱 What You'll See

**Before:**
- Default Flutter icon (blue with white "F")

**After:**
- Your AXOR logo
- Black background (adaptive icon)
- Looks great on all Android devices
- Proper iOS rounded corners

---

## ✅ Verify It Worked

1. **Check generated files:**
   ```bash
   ls android/app/src/main/res/mipmap-*/ic_launcher.png
   ```
   You should see icons in multiple sizes.

2. **Run the app:**
   ```bash
   flutter run
   ```
   Look at your home screen - you'll see your AXOR logo!

3. **Check app drawer:**
   - Open app drawer on Android
   - Find "AXOR" (not "axor_app")
   - Icon should be your logo

---

## 🎨 Icon Locations

Your logo will appear:
- ✅ Home screen
- ✅ App drawer
- ✅ Recent apps
- ✅ Notifications
- ✅ Settings > Apps
- ✅ Play Store (when published)

---

## 🐛 Troubleshooting

**Problem:** Old icon still showing

**Solution:**
```bash
flutter clean
flutter pub get
dart run flutter_launcher_icons
flutter run
```

**Problem:** Can't find logo.png

**Solution:**
1. Check file exists: `dir assets\logo.png` (Windows) or `ls assets/logo.png` (Mac/Linux)
2. Make sure it's named exactly `logo.png` (lowercase)
3. Verify it's in the `assets` folder

**Problem:** Icons look blurry

**Solution:**
- Use a higher resolution image (1024x1024 or larger)
- Make sure it's PNG format (not JPEG)
- Ensure logo has clear, bold shapes

---

## 📞 Need Help?

**Admin Email:** a67154512@gmail.com

Include in your email:
- Screenshot of the issue
- Error messages (if any)
- Your logo file (if needed)

---

## 🎯 Next Steps

After setting up the icon:

1. **Test on real device:**
   ```bash
   flutter run --release
   ```

2. **Build release APK:**
   ```bash
   flutter build apk --release
   ```
   APK location: `build/app/outputs/flutter-apk/app-release.apk`

3. **Share with testers:**
   - Send APK file
   - They'll see your AXOR logo when installing

4. **Prepare for Play Store:**
   - Icon is ready ✅
   - App name is "AXOR" ✅
   - Just need to complete backend integration

---

**Your AXOR app now has a professional icon! 🎵**
