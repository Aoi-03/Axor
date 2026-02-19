# Flutter App Design Analysis

## App Logo
**File:** logo.png
**Description:** 
- Stylized ram's head silhouette
- Color scheme: Blue to purple/pink gradient with cyan accents
- Curved horns with white striped pattern
- Flowing, flame-like elements at the bottom
- Modern, dynamic aesthetic
- Works well on dark backgrounds
- Suggests strength/performance theme

## Screen Designs Analysis

### Screen 1: Launch/Splash Screen
**File:** Screenshot 2026-02-04 223639.png
**Screen Type:** Splash Screen / App Launch
**Key Elements:**
- Centered app logo (same ram design as logo.png)
- App name "AXOR" in cyan/turquoise color
- Tagline "Your Sound. Evolved." in gray text
- Clean, minimalist layout

**Colors:**
- Background: Pure black (#000000)
- Logo: Blue to purple gradient with cyan accents
- App name: Cyan/turquoise (#00FFFF or similar)
- Tagline: Light gray (#CCCCCC or similar)

**Layout:**
- Vertical center alignment
- Logo positioned in upper-middle area
- App name directly below logo
- Tagline below app name
- Generous white space around elements

**Components:**
- Logo image widget
- App name text (large, bold, cyan)
- Tagline text (smaller, regular weight, gray)

**Notes:**
- This appears to be an audio/music app based on "Your Sound. Evolved."
- Very clean, professional splash screen design
- Logo has glow/neon effect
- Typography is modern and clean
- Perfect for Flutter SplashScreen widget

### Screen 2: Sign Up Screen
**File:** Screenshot 2026-02-04 223645.png
**Screen Type:** User Registration/Sign Up
**Key Elements:**
- Small logo at top
- "Welcome User" heading
- Email input field with placeholder "user@example.com"
- Password input field with lock icon and eye toggle
- Confirm Password field with lock icon and eye toggle
- Primary "Sign Up" button (cyan gradient)
- "OR" divider with dashed lines
- "Continue with Google" button with Google icon
- "Already have an account? Sign in" link
- Terms of Service and Privacy Policy disclaimer

**Colors:**
- Background: Black with dark teal/green card overlay
- Card background: Dark teal/green with rounded corners
- Text: White for headings, light gray for labels
- Input fields: Dark with cyan borders
- Primary button: Cyan to blue gradient
- Google button: Dark with white border
- Links: Cyan color

**Layout:**
- Centered card design with rounded corners
- Logo positioned at top center
- Form fields stacked vertically with consistent spacing
- Button full-width within card
- Footer links at bottom

**Components:**
- Logo widget (smaller version)
- Text input fields with icons and validation
- Password visibility toggle buttons
- Gradient button widget
- Social login button
- Text links with different colors
- Card container with rounded corners

**Notes:**
- Clean, modern form design
- Good UX with password visibility toggles
- Social login integration (Google)
- Proper terms/privacy disclaimer
- Card-based layout creates focus
- Consistent with app's cyan/teal color scheme

### Screen 3: Sign In Screen
**File:** Screenshot 2026-02-04 223657.png
**Screen Type:** User Login/Sign In
**Key Elements:**
- Small logo at top
- "Welcome User" heading (same as signup)
- Email input field with placeholder "user@example.com"
- Password input field with lock icon and eye toggle
- "Forgot Password?" link (right-aligned)
- Primary "Login" button (cyan gradient)
- "OR" divider with dashed lines
- "Continue with Google" button with Google icon
- "Don't have an account? Sign Up" link
- Terms of Service and Privacy Policy disclaimer

**Colors:**
- Background: Black with dark teal/green card overlay
- Card background: Dark teal/green with rounded corners
- Text: White for headings, light gray for labels
- Input fields: Dark with cyan borders
- Primary button: Cyan to blue gradient
- Google button: Dark with white border
- Links: Cyan color
- "Forgot Password?" link: Light gray/white

**Layout:**
- Identical card design to signup screen
- Logo positioned at top center
- Form fields stacked vertically
- "Forgot Password?" aligned to right
- Button full-width within card
- Footer links at bottom

**Components:**
- Logo widget (smaller version)
- Text input fields with icons
- Password visibility toggle button
- Gradient button widget
- Social login button
- Text links with navigation
- Card container with rounded corners

**Notes:**
- Consistent design with signup screen
- Simplified form (no confirm password)
- "Forgot Password?" functionality included
- Same social login integration
- Proper navigation between signin/signup
- Maintains brand consistency and UX patterns

### Screen 4: Reset Password (Email) Screen
**File:** Screenshot 2026-02-04 223704.png
**Screen Type:** Password Reset - Email Input
**Key Elements:**
- Small logo at top center
- "Reset Password" heading
- "Enter your Email id" instruction text
- Email input field with placeholder "user@example.com"
- Primary "Confirm" button (cyan gradient)
- Terms of Service and Privacy Policy disclaimer

**Colors:**
- Background: Black with dark teal/green card overlay
- Card background: Dark teal/green with rounded corners
- Text: White for headings, light gray for labels
- Input field: Dark with cyan border
- Primary button: Cyan to blue gradient
- Footer text: Light gray

**Layout:**
- Same card design pattern as previous screens
- Logo positioned at top center
- Minimal form with single input field
- Button full-width within card
- Footer disclaimer at bottom
- Generous spacing and clean layout

**Components:**
- Logo widget (smaller version)
- Single text input field with email icon
- Gradient button widget
- Card container with rounded corners
- Footer text widget

**Notes:**
- Simplified, focused design for password reset flow
- Maintains consistent branding and layout patterns
- Clear instruction text for user guidance
- Single-purpose screen with minimal distractions
- Same visual hierarchy as other auth screens
- Clean, user-friendly password recovery process

### Screen 5: Reset Password (New Password) Screen
**File:** Screenshot 2026-02-04 223711.png
**Screen Type:** Password Reset - New Password Input
**Key Elements:**
- Small logo at top center
- "Reset Password" heading
- "Enter new password" label
- New password input field with lock icon and eye toggle
- "Confirm new Password" label
- Confirm password input field with lock icon and eye toggle
- Primary "Confirm" button (cyan gradient)
- Terms of Service and Privacy Policy disclaimer

**Colors:**
- Background: Black with dark teal/green card overlay
- Card background: Dark teal/green with rounded corners
- Text: White for headings, light gray for labels
- Input fields: Dark with cyan borders
- Primary button: Cyan to blue gradient
- Footer text: Light gray

**Layout:**
- Same card design pattern as previous screens
- Logo positioned at top center
- Two password fields stacked vertically
- Button full-width within card
- Footer disclaimer at bottom
- Consistent spacing with other auth screens

**Components:**
- Logo widget (smaller version)
- Two password input fields with lock icons
- Password visibility toggle buttons (eye icons)
- Gradient button widget
- Card container with rounded corners
- Footer text widget

**Notes:**
- Completes the password reset flow
- Maintains design consistency with signup screen (similar dual password fields)
- Password visibility toggles for better UX
- Clear labeling for new vs confirm password
- Same visual hierarchy and branding as other auth screens
- Secure password entry with proper validation setup

### Screen 6: Home Screen (Main Dashboard)
**File:** Screenshot 2026-02-04 223719.png
**Screen Type:** Main Home/Dashboard Screen
**Key Elements:**
- Top header with "Hey There, user" greeting in white/cyan
- Status indicator "Playing on Discord" (green dot + text)
- Phone/device icon in top right
- "Your Vibe" section with AI suggestion note
- Two vibe cards: "Midnight Drive" (blue/purple) and "Lost in Thought" (grayscale)
- "Smart Modes" section with mode cards
- "GYM MODE" card (red with dumbbell icon)
- "STUDY MODE" card (teal with book icon, partially visible)
- "The Shelf" section with music/playlist cards
- "Neon Nights - Cyber Dreams" card (blue/purple concert scene)
- "Digital Rain - Code Symphony" card (grayscale artistic)
- Bottom music player with album art, song info, and controls
- Bottom navigation bar with 5 icons (gallery, search, home, folder, profile)

**Colors:**
- Background: Black with cyan accent borders
- Headers: Cyan color for section titles
- Cards: Various themed colors (blue/purple, red, teal, grayscale)
- Text: White for main text, gray for subtitles
- Player: Dark teal background
- Nav bar: Dark with white icons

**Layout:**
- Vertical scrolling layout
- Section-based organization with clear headers
- Card-based UI for content items
- Fixed bottom player and navigation
- Consistent spacing and margins
- Grid layout for cards (2 columns in some sections)

**Components:**
- Status indicators and greeting text
- Image-based content cards with overlays
- Mode selection cards with icons
- Music player widget with controls
- Bottom navigation bar
- Section headers with arrows (>)

**Notes:**
- This is clearly a music/audio app with mood-based recommendations
- AI-powered suggestions ("AI suggestion" note)
- Integration with Discord (status showing)
- Smart modes for different activities (gym, study)
- Music library organization ("The Shelf")
- Rich visual design with themed artwork
- Full music player functionality
- Comprehensive navigation structure

### Screen 7: Smart Mode - Gym Mode Screen
**File:** Screenshot 2026-02-04 223742.png
**Screen Type:** Gym Mode - Workout Interface
**Key Elements:**
- "GYM MODE" header in red text
- Large circular timer/stopwatch showing "00:00:00"
- Red circular progress ring around timer
- Dumbbell icon on the right side (vertical orientation)
- "START WORKOUT" button (red gradient)
- "Song Queue" section with table layout
- Column headers: "Title", "Artist", "Timeline"
- Numbered song list (1-10+ visible) with placeholders
- Each row shows: number, album art placeholder, "Song name", "signer", "00:00"
- Bottom music player with controls
- Bottom navigation bar

**Colors:**
- Background: Black
- Theme: Red color scheme (matching gym/fitness theme)
- Timer: White text with red circular progress
- Button: Red gradient
- Song queue: White text with gray subtitles
- Headers: Red accent color

**Layout:**
- Top section: Timer and workout controls
- Middle section: Song queue table
- Bottom: Music player and navigation
- Vertical layout with clear sections
- Table format for song organization
- Fixed header and bottom elements

**Components:**
- Circular timer widget with progress ring
- Icon button (dumbbell)
- Gradient action button
- Data table/list view for songs
- Album art placeholders
- Music player controls
- Navigation bar

**Notes:**
- Specialized interface for gym workouts
- Timer/stopwatch functionality for tracking workout duration
- Curated song queue optimized for gym sessions
- Red theme creates energy and motivation
- Table format allows easy song management
- Integration with main music player
- Activity-specific UI adaptation
- Workout tracking capabilities

### Screen 8: Smart Mode - Study Mode Screen
**File:** Screenshot 2026-02-04 223754.png
**Screen Type:** Study Mode - Focus Interface
**Key Elements:**
- "STUDY MODE" header in cyan text
- Large circular timer/stopwatch showing "00:00:00"
- Cyan circular progress ring around timer
- Book/study icon on the right side (vertical orientation)
- "START STUDY" button (cyan gradient)
- "Song Queue" section with table layout
- Column headers: "Title", "Artist", "Timeline"
- Numbered song list (1-10+ visible) with placeholders
- Each row shows: number, album art placeholder, "Song name", "signer", "00:00"
- Bottom music player with controls
- Bottom navigation bar

**Colors:**
- Background: Black
- Theme: Cyan/teal color scheme (matching focus/calm theme)
- Timer: White text with cyan circular progress
- Button: Cyan gradient
- Song queue: White text with gray subtitles
- Headers: Cyan accent color

**Layout:**
- Identical layout structure to Gym Mode
- Top section: Timer and study controls
- Middle section: Song queue table
- Bottom: Music player and navigation
- Vertical layout with clear sections
- Table format for song organization
- Fixed header and bottom elements

**Components:**
- Circular timer widget with progress ring
- Icon button (book/study icon)
- Gradient action button
- Data table/list view for songs
- Album art placeholders
- Music player controls
- Navigation bar

**Notes:**
- Specialized interface for study sessions
- Timer/stopwatch for tracking study duration (Pomodoro technique support)
- Curated song queue optimized for focus and concentration
- Cyan theme creates calm, focused atmosphere
- Same functional layout as Gym Mode but different theming
- Activity-specific music curation
- Consistent Smart Mode design pattern
- Focus-oriented user experience

### Screen 9: Smart Mode - Drive Mode Screen
**File:** Screenshot 2026-02-04 223839.png
**Screen Type:** Drive Mode - Driving Interface
**Key Elements:**
- "DRIVE MODE" header in green text
- Large circular timer/stopwatch showing "00:00:00"
- Green circular progress ring around timer
- Car/drive icon on the right side (vertical orientation)
- "START STUDY" button (green gradient) - *Note: Button text appears to be incorrect, should be "START DRIVE"*
- "Song Queue" section with table layout
- Column headers: "Title", "Artist", "Timeline"
- Numbered song list (1-10+ visible) with placeholders
- Each row shows: number, album art placeholder, "Song name", "signer", "00:00"
- Bottom music player with controls (green theme)
- Bottom navigation bar

**Colors:**
- Background: Black
- Theme: Green color scheme (matching drive/journey theme)
- Timer: White text with green circular progress
- Button: Green gradient
- Song queue: White text with gray subtitles
- Headers: Green accent color
- Music player: Green themed controls

**Layout:**
- Identical layout structure to Gym and Study Modes
- Top section: Timer and drive controls
- Middle section: Song queue table
- Bottom: Music player and navigation
- Vertical layout with clear sections
- Table format for song organization
- Fixed header and bottom elements

**Components:**
- Circular timer widget with progress ring
- Icon button (car/drive icon)
- Gradient action button
- Data table/list view for songs
- Album art placeholders
- Music player controls (green themed)
- Navigation bar

**Notes:**
- Specialized interface for driving sessions
- Timer for tracking drive duration/trip time
- Curated song queue optimized for road trips and driving
- Green theme suggests adventure, journey, nature
- Consistent Smart Mode design pattern maintained
- Button text error suggests this might be a template/prototype
- Activity-specific music curation for driving experience
- Safe, distraction-free interface for vehicle use

### Screen 10: Search/Discover Screen
**File:** Screenshot 2026-02-04 223846.png
**Screen Type:** Search and Discovery Interface
**Key Elements:**
- "SEARCH" header in cyan text
- Search bar with placeholder "Search your song"
- "History" section with clock icon
- List of recent searches/songs with:
  - Clock icons (indicating history items)
  - Album art placeholders
  - "Song name" and "signer" text
  - Circular arrow/refresh icons on the right
- Clean list layout with consistent spacing
- Bottom navigation bar (search icon highlighted)

**Colors:**
- Background: Black
- Header: Cyan text
- Search bar: Dark with rounded corners
- History items: White text for song names, gray for artists
- Icons: Cyan color (clock and refresh icons)
- Navigation: Cyan highlight on search icon

**Layout:**
- Top: Header and search bar
- Main content: Scrollable history list
- Bottom: Navigation bar
- Vertical list layout with consistent item spacing
- Full-width search bar with rounded corners
- List items with left-aligned content and right-aligned actions

**Components:**
- Search input field with placeholder text
- Section header with icon
- List view with custom list items
- Album art placeholder widgets
- Icon buttons (clock, refresh/replay)
- Bottom navigation bar

**Notes:**
- Clean, focused search interface
- Search history functionality for easy re-access
- Consistent with app's cyan color scheme
- Simple, intuitive layout
- Quick access to previously searched content
- Refresh/replay functionality for history items
- Search-focused navigation state
- Minimalist design prioritizing functionality

### Screen 11: Master Library (Cloud) Screen
**File:** Screenshot 2026-02-04 223855.png
**Screen Type:** Music Library - Cloud Storage View
**Key Elements:**
- Top card showing "Master Library (cloud)" with large album art placeholder
- "Playlist" label and "0 songs" count
- "Local" button in top right corner (toggle between cloud/local)
- List of songs with:
  - Small album art placeholders
  - "Song name" and "signer" text
  - Cloud sync icons (circular arrows)
  - Download icons (down arrows)
- Bottom navigation bar (folder icon highlighted)

**Colors:**
- Background: Black
- Top card: Teal/cyan gradient background
- Card content: White text on teal background
- Song list: White text for song names, gray for artists
- Icons: Cyan color (cloud sync and download icons)
- Navigation: Cyan highlight on folder/library icon

**Layout:**
- Top: Featured library card with large artwork
- Toggle button for Local/Cloud view
- Main content: Scrollable song list
- Bottom: Navigation bar
- Card-based header design
- Vertical list layout for songs
- Consistent spacing and alignment

**Components:**
- Featured library card with artwork and metadata
- Toggle button (Local/Cloud)
- List view with song items
- Album art placeholder widgets
- Action icons (cloud sync, download)
- Bottom navigation bar

**Notes:**
- Cloud-based music library management
- Toggle between local and cloud storage
- Download functionality for offline access
- Cloud sync status indicators
- Library organization with playlist structure
- Consistent with app's teal/cyan theme
- Shows current library is empty (0 songs)
- Dual storage system (local + cloud)
- Download management for offline listening

### Screen 12: Master Library (Local) Screen
**File:** Screenshot 2026-02-04 223903.png
**Screen Type:** Music Library - Local Storage View
**Key Elements:**
- Top card showing "Master Library (local)" with large album art placeholder
- "Playlist" label and "*premium plan" note
- "0 songs" count
- "Cloud" button in top right corner (toggle between local/cloud)
- List of songs with:
  - Small album art placeholders
  - "Song name" and "signer" text
  - Cloud sync icons (circular arrows)
  - Download icons (down arrows)
- Bottom navigation bar (folder icon highlighted)

**Colors:**
- Background: Black
- Top card: Teal/cyan gradient background
- Card content: White text on teal background
- Song list: White text for song names, gray for artists
- Icons: Cyan color (cloud sync and download icons)
- Navigation: Cyan highlight on folder/library icon

**Layout:**
- Identical layout to cloud library screen
- Top: Featured library card with large artwork
- Toggle button for Cloud/Local view
- Main content: Scrollable song list
- Bottom: Navigation bar
- Card-based header design
- Vertical list layout for songs

**Components:**
- Featured library card with artwork and metadata
- Toggle button (Cloud/Local)
- List view with song items
- Album art placeholder widgets
- Action icons (cloud sync, download)
- Bottom navigation bar

**Notes:**
- Local storage view of music library
- Premium plan feature indication (*premium plan)
- Same functionality as cloud view but for local files
- Toggle between cloud and local storage views
- Consistent design with cloud library screen
- Shows local library is also empty (0 songs)
- Premium features for local storage management
- Unified interface for both storage types
- Download and sync capabilities maintained

### Screen 13: Profile Screen
**File:** Screenshot 2026-02-04 223913.png
**Screen Type:** User Profile and Account Management
**Key Elements:**
- "PROFILE" header in cyan text
- User profile card with:
  - Circular profile picture placeholder "PFP" with green online indicator
  - "User_X" username
  - "user@gmail.com" email
  - "Free Plan" badge
  - Stats: "0 Songs", "0 Playlists", "0h Listened"
- Storage usage card showing "0GB/ 1GB" with 0% usage bar
- Premium upgrade card with:
  - Gift icon and "Unlock Premium" title
  - "Ad-free + Unlimited Storage" benefits
  - Code input field "XXXX-XXXX-XXXX-XXXX"
  - "Send Request" button (cyan)
  - "Redeem Amazon Gift Card codes for Premium access" text
- Privacy Policy button with shield icon
- Log Out button with exit icon
- Bottom navigation bar (profile icon highlighted)

**Colors:**
- Background: Black
- Header: Cyan text
- Cards: Dark teal/green with cyan borders
- Profile elements: White text, cyan accents
- Online indicator: Green dot
- Plan badge: Gray
- Premium card: Cyan highlights
- Buttons: Cyan gradient and dark variants

**Layout:**
- Vertical card-based layout
- Profile information at top
- Storage and premium sections in middle
- Account actions at bottom
- Consistent card spacing and rounded corners
- Full-width elements within cards

**Components:**
- Profile avatar with status indicator
- Statistics display (songs, playlists, listening time)
- Progress bar for storage usage
- Code input field for premium redemption
- Action buttons (Send Request, Privacy Policy, Log Out)
- Bottom navigation bar

**Notes:**
- Comprehensive user profile with account stats
- Clear freemium model with upgrade path
- Amazon Gift Card redemption system for premium
- Storage limit enforcement (1GB for free users)
- Online status indicator
- Clean account management options
- Privacy policy access
- Secure logout functionality
- Profile shows new user state (all zeros)

## Video Demo Analysis
**File:** WhatsApp Video 2026-02-04 at 10.34.27 PM.mp4
**Navigation Flow:**
**Animations:**
**Interactions:**
**User Journey:**

## Flutter Implementation Plan
[To be filled after analyzing all screens]

### App Structure:
### Required Widgets:
### Navigation Setup:
### State Management:
### Color Scheme:
### Typography:
### Assets Needed: