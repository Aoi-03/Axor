import 'package:flutter/material.dart';
import '../../constants/colors.dart';
import '../../utils/mode_manager.dart';
import '../../widgets/music_player_bottom.dart';
import 'home_screen.dart';
import 'search_screen.dart';
import 'library_screen.dart';
import 'profile_screen.dart';
import '../smart_modes/gym_mode_screen.dart';
import '../smart_modes/study_mode_screen.dart';
import '../smart_modes/drive_mode_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with SingleTickerProviderStateMixin {
  int _currentIndex = 2; // Start with home screen
  int _previousIndex = 2;
  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;

  // Check if we're on the smart modes tab
  bool get _isOnModesTab => _currentIndex == 0;

  @override
  void initState() {
    super.initState();
    // Listen to mode changes
    modeManager.addListener(_onModeChanged);
    
    // Initialize animation controller
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 250),
      vsync: this,
    );
    
    _slideAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    modeManager.removeListener(_onModeChanged);
    _animationController.dispose();
    super.dispose();
  }

  void _onModeChanged() {
    // Rebuild when mode changes and switch to first tab
    if (mounted) {
      setState(() {
        _previousIndex = _currentIndex;
        _currentIndex = 0; // Switch to modes tab
        _updateSlideAnimation();
      });
    }
  }

  void _updateSlideAnimation() {
    // Determine slide direction based on tab change
    Offset begin;
    if (_currentIndex > _previousIndex) {
      // Moving right - slide from right
      begin = const Offset(1.0, 0.0);
    } else if (_currentIndex < _previousIndex) {
      // Moving left - slide from left
      begin = const Offset(-1.0, 0.0);
    } else {
      begin = Offset.zero;
    }
    
    _slideAnimation = Tween<Offset>(
      begin: begin,
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
    
    _animationController.forward(from: 0.0);
  }

  Widget _getCurrentModeScreen() {
    switch (modeManager.currentMode) {
      case 0:
        return const GymModeScreen();
      case 1:
        return const StudyModeScreen();
      case 2:
        return const DriveModeScreen();
      default:
        return const GymModeScreen();
    }
  }

  List<Widget> get _screens => [
    _getCurrentModeScreen(), // Current active mode screen
    const SearchScreen(),
    const HomeScreen(),
    const LibraryScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    // Get current mode color only if on modes tab, otherwise use cyan
    final modeColor = _isOnModesTab ? modeManager.getModeColor() : AppColors.cyan;
    // Show music player on all tabs except Profile (index 4)
    final showMusicPlayer = _currentIndex != 4;
    
    return Scaffold(
      backgroundColor: AppColors.black,
      body: Stack(
        children: [
          SlideTransition(
            position: _slideAnimation,
            child: _screens[_currentIndex],
          ),
          // Music player overlay (except on Profile screen)
          if (showMusicPlayer)
            Positioned(
              left: 0,
              right: 0,
              bottom: 4, // Very close to taskbar - just 4px gap
              child: MusicPlayerBottom(isOnModesTab: _isOnModesTab),
            ),
        ],
      ),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.black,
            border: Border(
              top: BorderSide(
                color: modeColor.withValues(alpha: 0.2),
                width: 1,
              ),
            ),
          ),
          child: BottomNavigationBar(
            currentIndex: _currentIndex,
            onTap: (index) {
              setState(() {
                _previousIndex = _currentIndex;
                _currentIndex = index;
                _updateSlideAnimation();
              });
            },
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.transparent,
            selectedItemColor: modeColor,
            unselectedItemColor: AppColors.lightGray,
            elevation: 0,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.dashboard),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.search),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.folder),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: '',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
