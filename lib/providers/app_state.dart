import 'package:flutter/foundation.dart';

enum AppScreen { login, signup, launch, home, workout, search, profile }

class Song {
  final String title;
  final String artist;
  final String cover;
  
  Song({
    required this.title,
    required this.artist,
    required this.cover,
  });
}

class AppState extends ChangeNotifier {
  AppScreen _currentScreen = AppScreen.login;
  bool _isPlaying = false;
  Song _currentSong = Song(
    title: 'Neon Nights',
    artist: 'Cyber Dreams',
    cover: 'https://images.unsplash.com/photo-1470225620780-dba8ba36b745?w=400&h=400&fit=crop',
  );

  AppScreen get currentScreen => _currentScreen;
  bool get isPlaying => _isPlaying;
  Song get currentSong => _currentSong;

  void setScreen(AppScreen screen) {
    _currentScreen = screen;
    notifyListeners();
  }

  void togglePlayback() {
    _isPlaying = !_isPlaying;
    notifyListeners();
  }

  void setCurrentSong(Song song) {
    _currentSong = song;
    notifyListeners();
  }

  void login() {
    setScreen(AppScreen.launch);
    // Auto-transition to home after 3 seconds
    Future.delayed(const Duration(seconds: 3), () {
      setScreen(AppScreen.home);
    });
  }

  void signup() {
    setScreen(AppScreen.launch);
    // Auto-transition to home after 3 seconds
    Future.delayed(const Duration(seconds: 3), () {
      setScreen(AppScreen.home);
    });
  }
}