@echo off
echo ========================================
echo AXOR App Icon Setup
echo ========================================
echo.
echo This script will:
echo 1. Install dependencies
echo 2. Generate app icons for Android and iOS
echo 3. Clean and rebuild the app
echo.
echo Admin: a67154512@gmail.com
echo.
pause

echo.
echo [1/4] Installing dependencies...
call flutter pub get

echo.
echo [2/4] Generating app icons...
call dart run flutter_launcher_icons

echo.
echo [3/4] Cleaning build...
call flutter clean

echo.
echo [4/4] Getting dependencies again...
call flutter pub get

echo.
echo ========================================
echo Setup Complete!
echo ========================================
echo.
echo Your AXOR logo is now set as the app icon.
echo.
echo To test:
echo   flutter run
echo.
echo To build release APK:
echo   flutter build apk --release
echo.
echo Check icons at:
echo   android/app/src/main/res/mipmap-*/ic_launcher.png
echo.
pause
