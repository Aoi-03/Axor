import 'package:flutter/material.dart';
import '../constants/colors.dart';

class AuthCard extends StatelessWidget {
  final Widget child;

  const AuthCard({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: AppColors.tealCardGradient,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.cyan.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: child,
    );
  }
}
