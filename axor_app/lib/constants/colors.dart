import 'package:flutter/material.dart';

class AppColors {
  static const Color black = Color(0xFF000000);
  static const Color white = Color(0xFFFFFFFF);
  static const Color cyan = Color(0xFF00FFFF);
  static const Color darkTeal = Color(0xFF1A4A4A);
  static const Color lightGray = Color(0xFFCCCCCC);
  static const Color darkGray = Color(0xFF666666);
  static const Color red = Color(0xFFFF4444);
  static const Color green = Color(0xFF44FF44);
  
  // Gradient colors
  static const LinearGradient cyanGradient = LinearGradient(
    colors: [Color(0xFF00FFFF), Color(0xFF0088FF)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static const LinearGradient redGradient = LinearGradient(
    colors: [Color(0xFFFF4444), Color(0xFFCC0000)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static const LinearGradient greenGradient = LinearGradient(
    colors: [Color(0xFF44FF44), Color(0xFF00CC00)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static const LinearGradient tealCardGradient = LinearGradient(
    colors: [Color(0xFF2A5A5A), Color(0xFF1A4A4A)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
