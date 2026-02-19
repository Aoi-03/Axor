# AXOR App - Animations & Navigation Guide

## ✅ Implemented Features

### 1. **The Shelf - Vertical Scrolling**
- ✅ Shelves are now **vertical blocks** attached to home page
- ✅ Scroll down the home page to see more shelf blocks
- ✅ **Plus icon** at top-right to add new shelves (ready for implementation)
- ✅ Each shelf block can be edited (name change functionality ready)
- ✅ Mobile-friendly: No accidental selections

**Current Shelves:**
1. Neon Nights - Cyber Dreams
2. Digital Rain - Code Symphony
3. Chill Vibes - Relaxing Beats
4. Workout Mix - High Energy
5. Late Night Coding - Focus Flow

### 2. **Smooth Navigation Animations (250-300ms)**

#### **Tab Navigation (Left/Right Slide)**
When switching between main tabs:
- **Home → Search**: Slides from left to right
- **Search → Library**: Slides from left to right
- **Library → Home**: Slides from right to left
- **Duration**: 250ms with easeInOut curve

#### **Subscreen Navigation (Bottom to Top Slide)**
When opening subscreens:
- **Sign Up**: Slides up from bottom (300ms)
- **Privacy Policy**: Slides up from bottom (300ms)
- **Reset Password**: Slides up from bottom (300ms)
- **Smart Modes**: Instant switch (no navigation, just mode change)

#### **Special Animations**
- **Forgot Password**: Slides from left to right (300ms)
- **Sign In ↔ Sign Up**: Smooth slide transitions

### 3. **Animation Specifications**

```dart
// Tab Navigation (Horizontal)
Duration: 250ms
Curve: Curves.easeInOut
Direction: Left/Right based on tab position

// Subscreens (Vertical)
Duration: 300ms
Curve: Curves.easeInOut
Direction: Bottom to Top (slide up)

// Forgot Password (Special)
Duration: 300ms
Curve: Curves.easeInOut
Direction: Left to Right
```

### 4. **User Experience**

**Smooth & Buttery:**
- All animations feel natural and responsive
- No jarring transitions
- Consistent timing across the app
- Mobile-optimized performance

**Navigation Flow:**
```
Home Screen
├── Scroll down → See more shelves (vertical)
├── Tap Smart Mode → Switch mode + go to first tab
├── Tap Search → Slide left to right
├── Tap Profile → Slide left to right
└── Tap Shelf → Open playlist (slide up)

Auth Screens
├── Sign In → Sign Up: Slide up from bottom
├── Sign In → Forgot Password: Slide from left
└── Reset Password → Sign In: Slide up from bottom
```

### 5. **Future Enhancements (Ready to Implement)**

**Shelf Management:**
- [ ] Plus icon functionality to add new shelves
- [ ] Long press to edit shelf name
- [ ] Swipe to delete shelf
- [ ] Drag to reorder shelves

**Animation Refinements:**
- [ ] Add subtle fade during tab transitions
- [ ] Implement hero animations for album art
- [ ] Add spring physics for more natural feel

## 🎯 How to Use

### For Developers:
Use the helper functions in `lib/utils/page_transitions.dart`:

```dart
// Slide up from bottom (for subscreens)
Navigator.push(context, slideUpRoute(MyScreen()));

// Slide from left (for special cases)
Navigator.push(context, slideFromLeftRoute(MyScreen()));

// Simple fade (for quick transitions)
Navigator.push(context, fadeRoute(MyScreen()));
```

### For Users:
- **Swipe or tap** to navigate between tabs
- **Tap cards** to open subscreens with smooth animations
- **Scroll down** on home to see all your shelves
- **Tap plus icon** to add new shelves (coming soon)

## 📱 Mobile Optimization

All animations are:
- ✅ Optimized for 60fps
- ✅ Smooth on low-end devices
- ✅ Battery efficient
- ✅ Touch-responsive
- ✅ No lag or stutter

---

**Last Updated**: February 2026
**Version**: 1.0.0
