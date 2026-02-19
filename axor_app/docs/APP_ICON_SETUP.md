# AXOR App Icon Setup Guide

**Last Updated:** February 6, 2026  
**App Name:** AXOR  
**Admin:** a67154512@gmail.com

---

## 📱 App Icon Overview

The AXOR app icon will be your logo displayed on:
- Android home screen
- iOS home screen
- App drawer
- Recent apps list
- Notification icons
- Splash screen

---

## 🎨 Icon Requirements

### **Image Specifications**

**Source Image:**
- File: `assets/logo.png`
- Recommended size: 1024x1024 pixels (minimum)
- Format: PNG with transparency
- Background: Transparent or black
- Design: Your AXOR logo

**Android Requirements:**
- Multiple sizes generated automatically
- Adaptive icon support (Android 8.0+)
- Background color: Black (#000000)
- Foreground: Your logo

**iOS Requirements:**
- Multiple sizes generated automatically
- Rounded corners applied automatically
- No transparency (will be removed)

---

## 🚀 Setup Instructions

### **Method 1: Automatic (Recommended)**

We've already configured `flutter_launcher_icons` in `pubspec.yaml`. Follow these steps:

#### **Step 1: Install Dependencies**
```bash
cd axor_app
flutter pub get
```

#### **Step 2: Generate Icons**
```bash
dart run flutter_launcher_icons
```

This will automatically:
- Generate all required icon sizes
- Place them in correct directories
- Update Android and iOS configurations
- Create adaptive icons for Android

#### **Step 3: Verify**
```bash
# Check Android icons
ls android/app/src/main/res/mipmap-*/ic_launcher.png

# Run the app to see the icon
flutter run
```

---

### **Method 2: Manual (Advanced)**

If you want to manually place icons:

#### **Android Icon Sizes**

Place your logo in these directories with these sizes:

```
android/app/src/main/res/
├── mipmap-mdpi/ic_launcher.png       (48x48 px)
├── mipmap-hdpi/ic_launcher.png       (72x72 px)
├── mipmap-xhdpi/ic_launcher.png      (96x96 px)
├── mipmap-xxhdpi/ic_launcher.png     (144x144 px)
└── mipmap-xxxhdpi/ic_launcher.png    (192x192 px)
```

#### **iOS Icon Sizes**

Place your logo in `ios/Runner/Assets.xcassets/AppIcon.appiconset/`:

```
Icon-App-20x20@1x.png       (20x20 px)
Icon-App-20x20@2x.png       (40x40 px)
Icon-App-20x20@3x.png       (60x60 px)
Icon-App-29x29@1x.png       (29x29 px)
Icon-App-29x29@2x.png       (58x58 px)
Icon-App-29x29@3x.png       (87x87 px)
Icon-App-40x40@1x.png       (40x40 px)
Icon-App-40x40@2x.png       (80x80 px)
Icon-App-40x40@3x.png       (120x120 px)
Icon-App-60x60@2x.png       (120x120 px)
Icon-App-60x60@3x.png       (180x180 px)
Icon-App-76x76@1x.png       (76x76 px)
Icon-App-76x76@2x.png       (152x152 px)
Icon-App-83.5x83.5@2x.png   (167x167 px)
Icon-App-1024x1024@1x.png   (1024x1024 px)
```

---

## 🎨 Design Tips

### **Logo Optimization**

1. **Keep It Simple**
   - Logo should be recognizable at small sizes
   - Avoid fine details that won't show at 48x48 px
   - Use bold, clear shapes

2. **Color Contrast**
   - Ensure logo stands out on black background
   - Use your cyan (#06B6D4) accent color
   - Avoid pure white (use off-white or cyan)

3. **Safe Area**
   - Keep important elements in center 80%
   - Android adaptive icons may crop edges
   - iOS rounds corners automatically

4. **Test at Different Sizes**
   - View at 48px, 96px, 192px
   - Check on light and dark backgrounds
   - Verify on actual devices

---

## 📱 Android Adaptive Icons

### **What Are Adaptive Icons?**

Android 8.0+ uses adaptive icons with two layers:
- **Background**: Solid color or image
- **Foreground**: Your logo (with transparency)

This allows the system to:
- Apply different shapes (circle, square, rounded)
- Animate icons
- Create consistent look across devices

### **Our Configuration**

```yaml
adaptive_icon_background: "#000000"  # Black
adaptive_icon_foreground: "assets/logo.png"  # Your logo
```

**Result:**
- Black background layer
- Your logo on top
- System applies shape (circle/square/rounded)
- Looks great on all Android devices

---

## 🔧 Configuration Details

### **pubspec.yaml Configuration**

```yaml
flutter_launcher_icons:
  android: true                              # Generate Android icons
  ios: true                                  # Generate iOS icons
  image_path: "assets/logo.png"             # Source image
  min_sdk_android: 21                        # Android 5.0+
  adaptive_icon_background: "#000000"        # Black background
  adaptive_icon_foreground: "assets/logo.png" # Logo foreground
  remove_alpha_ios: true                     # Remove transparency for iOS
```

---

## 📋 Checklist

### **Before Generating Icons**

- [ ] Logo file exists at `assets/logo.png`
- [ ] Logo is at least 1024x1024 pixels
- [ ] Logo has transparent background (or black)
- [ ] Logo looks good at small sizes
- [ ] Logo uses AXOR brand colors

### **After Generating Icons**

- [ ] Run `flutter pub get`
- [ ] Run `dart run flutter_launcher_icons`
- [ ] Check Android icons in `mipmap-*` folders
- [ ] Check iOS icons (if applicable)
- [ ] Test on Android device/emulator
- [ ] Test on iOS device/simulator (if applicable)
- [ ] Verify icon appears correctly
- [ ] Check adaptive icon on Android 8.0+

---

## 🐛 Troubleshooting

### **Icons Not Showing**

**Problem:** Old icon still appears after generating new ones

**Solution:**
```bash
# Clean build
flutter clean
flutter pub get

# Regenerate icons
dart run flutter_launcher_icons

# Rebuild app
flutter run
```

### **Image Not Found**

**Problem:** `Error: Cannot find image at assets/logo.png`

**Solution:**
1. Verify file exists: `ls assets/logo.png`
2. Check file name (case-sensitive)
3. Ensure `assets/logo.png` is in `pubspec.yaml`

### **Icons Look Blurry**

**Problem:** Icons appear pixelated or blurry

**Solution:**
1. Use higher resolution source image (1024x1024+)
2. Ensure logo is PNG format
3. Avoid JPEG (causes compression artifacts)
4. Use vector graphics if possible

### **Adaptive Icon Issues**

**Problem:** Logo gets cropped on Android

**Solution:**
1. Add padding around logo in source image
2. Keep important elements in center 80%
3. Test with different Android shapes
4. Adjust `adaptive_icon_foreground` if needed

---

## 🎯 Quick Commands

```bash
# Install dependencies
flutter pub get

# Generate app icons
dart run flutter_launcher_icons

# Clean and rebuild
flutter clean
flutter pub get
flutter run

# Check generated icons
ls android/app/src/main/res/mipmap-*/ic_launcher.png

# Build release APK with new icon
flutter build apk --release
```

---

## 📱 Testing

### **Android Testing**

1. **Emulator:**
   ```bash
   flutter run
   ```
   - Check home screen
   - Check app drawer
   - Check recent apps

2. **Physical Device:**
   ```bash
   flutter run --release
   ```
   - Install on device
   - Check all icon locations
   - Test adaptive icon shapes

### **iOS Testing**

1. **Simulator:**
   ```bash
   flutter run -d "iPhone 15"
   ```
   - Check home screen
   - Check app switcher

2. **Physical Device:**
   - Requires Apple Developer account
   - Build and install via Xcode
   - Test on actual iPhone/iPad

---

## 🎨 Icon Variations

### **Notification Icon (Android)**

For notification icons, you may want a simpler version:

1. Create `assets/notification_icon.png`
2. Use white/transparent only
3. Simple silhouette design
4. Update `AndroidManifest.xml`:

```xml
<meta-data
    android:name="com.google.firebase.messaging.default_notification_icon"
    android:resource="@drawable/notification_icon" />
```

### **Splash Screen Icon**

Already configured in your splash screen:
- Uses `assets/logo.png`
- Displays during app launch
- Fades in/out smoothly

---

## 📞 Support

**Admin Email:** a67154512@gmail.com  
**App Name:** AXOR  
**Package:** com.example.axor_app

---

## 🔗 Resources

- [Flutter Launcher Icons Package](https://pub.dev/packages/flutter_launcher_icons)
- [Android Icon Guidelines](https://developer.android.com/guide/practices/ui_guidelines/icon_design_launcher)
- [iOS Icon Guidelines](https://developer.apple.com/design/human-interface-guidelines/app-icons)
- [Adaptive Icons Guide](https://developer.android.com/guide/practices/ui_guidelines/icon_design_adaptive)

---

**Your AXOR logo will look great on every device! 🎵**
