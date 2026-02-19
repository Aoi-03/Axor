import 'package:flutter/material.dart';
import '../constants/colors.dart';

class ModeManager extends ChangeNotifier {
  int _currentMode = 0; // 0: Gym, 1: Study, 2: Drive

  int get currentMode => _currentMode;

  void setMode(int mode) {
    _currentMode = mode;
    notifyListeners();
  }

  // Get color based on current mode
  Color getModeColor() {
    switch (_currentMode) {
      case 0:
        return AppColors.red; // Gym mode
      case 1:
        return AppColors.cyan; // Study mode
      case 2:
        return AppColors.green; // Drive mode
      default:
        return AppColors.cyan;
    }
  }
}

// Global instance
final modeManager = ModeManager();
