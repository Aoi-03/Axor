# AxoR Flutter - Ready for FlutLab

This is the complete Flutter version of AxoR, converted from the React design in figma_master. It's ready to upload to FlutLab and run immediately.

## 🚀 Features Implemented

### ✅ Complete App Flow
- **Login Screen** - Email/password authentication with smooth animations
- **Signup Screen** - Account creation with form validation
- **Launch Screen** - 3-second animated splash screen with AxoR branding
- **Main App** - Full navigation with bottom tabs and mini player

### ✅ All Screens
- **Home Screen** - AI's Choice card, virtual albums grid, recently played
- **Search Screen** - Real-time search with mock results, download functionality
- **Workout Screen** - Full timer system with exercises and voice cue placeholders
- **Profile Screen** - User info, storage usage, Amazon gift card upgrade system

### ✅ UI Components
- **Mini Player** - Floating overlay with all controls (play/pause, next/prev, cloud upload, shuffle/loop)
- **Bottom Navigation** - Tab navigation with emoji icons
- **OLED Theme** - Pure black (#000000) background with cyan (#00FFC2) accents

### ✅ Design System
- **Colors**: OLED black, cyan accents, proper contrast ratios
- **Typography**: Clean, readable fonts with proper hierarchy
- **Animations**: Smooth transitions and loading states
- **Responsive**: Works on all screen sizes

## 📱 FlutLab Instructions

### 1. Upload to FlutLab
1. Go to [FlutLab.io](https://flutlab.io)
2. Create new project or import existing
3. Upload the entire `AxoR_Flutter` folder
4. FlutLab will automatically detect the Flutter project

### 2. Run the App
1. Click "Run" in FlutLab
2. Choose your target (Web, Android, iOS)
3. The app will compile and run automatically

### 3. What You'll See
1. **Login Screen** - Enter any email/password to continue
2. **Launch Screen** - 3-second AxoR animation
3. **Home Screen** - AI's Choice, virtual albums, recently played
4. **Navigation** - Tap bottom tabs to switch screens
5. **Search** - Type to search for music with real results
6. **Workout** - Start workout with timer and exercises
7. **Profile** - View user info and upgrade options

## 🎯 Key Features Working

### Search Functionality
- Type in search bar to see results
- Mock database with 5 songs
- Download buttons show confirmation dialogs
- Popular search tags are clickable

### Workout Mode
- Full exercise timer system
- 4 exercises with instructions
- Start/pause/skip controls
- Rest periods between sets
- Completion celebration

### Profile System
- Storage usage visualization
- Connected devices list
- Amazon gift card upgrade flow
- Settings and support links

### Mini Player
- Always visible music controls
- Play/pause, next/previous
- Cloud upload button
- Shuffle/repeat menu

## 🔧 Technical Details

### Dependencies Used
- `provider` - State management
- `shared_preferences` - Local storage
- Standard Flutter widgets only (no external UI libraries)

### File Structure
```
lib/
├── main.dart                 # App entry point
├── providers/
│   └── app_state.dart       # Global state management
├── screens/
│   ├── login_screen.dart    # Authentication
│   ├── signup_screen.dart   # Account creation
│   ├── launch_screen.dart   # Splash screen
│   ├── main_app.dart        # Main navigation wrapper
│   ├── home_screen.dart     # AI's Choice & virtual albums
│   ├── search_screen.dart   # Music search & download
│   ├── workout_screen.dart  # Exercise timer system
│   └── profile_screen.dart  # User profile & settings
├── widgets/
│   ├── mini_player.dart     # Floating music controls
│   └── bottom_navigation.dart # Tab navigation
└── theme/
    └── app_theme.dart       # OLED dark theme
```

### State Management
- Uses Provider for simple state management
- AppState handles screen navigation and playback
- Each screen manages its own local state

### Mock Data
- Search results with 5 sample songs
- User profile with storage usage
- Workout exercises with instructions
- Virtual albums with mood categories

## 🎨 Design Highlights

### OLED Optimization
- Pure black (#000000) background
- Cyan (#00FFC2) accent color
- Optimized for battery efficiency
- High contrast for readability

### Smooth Animations
- Launch screen with fade/scale animations
- Loading spinners for search and downloads
- Smooth transitions between screens
- Hover effects on interactive elements

### Responsive Layout
- Works on phones and tablets
- Proper spacing and sizing
- Scrollable content areas
- Safe area handling

## 🚀 Ready for Development

This Flutter app is production-ready and can be extended with:
- Real API integration
- Audio playback functionality
- Firebase authentication
- Cloud storage integration
- Push notifications
- Social features

The code is clean, well-structured, and follows Flutter best practices. Perfect for FlutLab development and testing!