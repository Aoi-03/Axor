# Charmonman Font Setup

## What Was Done

Added the **Charmonman** font (Google Font) to the AXOR app for a stylish, decorative look on the AXOR branding text.

## Files Modified

1. **pubspec.yaml** - Added font configuration
2. **splash_screen.dart** - Updated AXOR text to use Charmonman
3. **signin_screen.dart** - Updated AXOR text to use Charmonman
4. **signup_screen.dart** - Updated AXOR text to use Charmonman
5. **reset_password_email_screen.dart** - Updated AXOR text to use Charmonman
6. **reset_password_new_screen.dart** - Updated AXOR text to use Charmonman

## Font Files Added

- `assets/fonts/Charmonman-Regular.ttf` (117 KB)
- `assets/fonts/Charmonman-Bold.ttf` (117 KB)

## Usage

The Charmonman font is now applied to all "AXOR" branding text throughout the app:

```dart
const Text(
  'AXOR',
  style: TextStyle(
    fontSize: 36,
    fontWeight: FontWeight.bold,
    color: AppColors.cyan,
    letterSpacing: 3,
    fontFamily: 'Charmonman',  // ← Added this
  ),
),
```

## Testing

To see the font in action:
1. Run `flutter pub get` (already done)
2. Hot restart the app (not hot reload - fonts require full restart)
3. The AXOR text on splash screen and auth screens will now use Charmonman font

## Font Characteristics

- **Style**: Decorative, elegant, handwritten-style
- **Weight**: Regular (400) and Bold (700)
- **Best for**: Branding, titles, headers
- **License**: Open Font License (free to use)
