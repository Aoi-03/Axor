import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_state.dart';
import '../widgets/mini_player.dart';
import '../widgets/bottom_navigation.dart';
import 'launch_screen.dart';
import 'home_screen.dart';
import 'workout_screen.dart';
import 'search_screen.dart';
import 'profile_screen.dart';

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  int _currentIndex = 0;
  bool _showLaunch = true;

  @override
  void initState() {
    super.initState();
    // Show launch screen for 3 seconds
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        setState(() {
          _showLaunch = false;
        });
      }
    });
  }

  final List<Widget> _screens = [
    const HomeScreen(),
    const SearchScreen(),
    const WorkoutScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    if (_showLaunch) {
      return const LaunchScreen();
    }

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Main content
          Padding(
            padding: const EdgeInsets.only(bottom: 140), // Space for mini player + nav
            child: _screens[_currentIndex],
          ),
          
          // Mini Player
          const Positioned(
            left: 0,
            right: 0,
            bottom: 80,
            child: MiniPlayer(),
          ),
          
          // Bottom Navigation
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: BottomNavigation(
              currentIndex: _currentIndex,
              onTap: (index) => setState(() => _currentIndex = index),
            ),
          ),
        ],
      ),
    );
  }
}