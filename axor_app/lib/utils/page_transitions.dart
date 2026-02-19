import 'package:flutter/material.dart';

// Slide from bottom to top (for subscreens like smart modes, privacy policy, etc.)
Route slideUpRoute(Widget page) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionDuration: const Duration(milliseconds: 300),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, 1.0); // Start from bottom
      const end = Offset.zero;
      const curve = Curves.easeInOut;
      
      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      var offsetAnimation = animation.drive(tween);
      
      return SlideTransition(
        position: offsetAnimation,
        child: child,
      );
    },
  );
}

// Slide from left to right (for forgot password)
Route slideFromLeftRoute(Widget page) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionDuration: const Duration(milliseconds: 300),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(-1.0, 0.0); // Start from left
      const end = Offset.zero;
      const curve = Curves.easeInOut;
      
      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      var offsetAnimation = animation.drive(tween);
      
      return SlideTransition(
        position: offsetAnimation,
        child: child,
      );
    },
  );
}

// Fade transition (for splash to sign-in and sign-in to main)
Route fadeRoute(Widget page) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionDuration: const Duration(milliseconds: 500),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const curve = Curves.easeInOut;
      var curvedAnimation = CurvedAnimation(
        parent: animation,
        curve: curve,
      );
      
      return FadeTransition(
        opacity: curvedAnimation,
        child: child,
      );
    },
  );
}
