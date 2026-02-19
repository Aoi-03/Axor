import 'package:flutter/material.dart';

class VibeCard extends StatelessWidget {
  final String title;
  final String imageUrl;
  final bool isGrayscale;
  final Color? color;
  final VoidCallback onTap;

  const VibeCard({
    super.key,
    required this.title,
    required this.imageUrl,
    this.isGrayscale = false,
    this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 120,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: color != null
              ? LinearGradient(
                  colors: [
                    color!.withValues(alpha: 0.8),
                    color!.withValues(alpha: 0.6),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )
              : isGrayscale
                  ? const LinearGradient(
                      colors: [Color(0xFF666666), Color(0xFF333333)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    )
                  : const LinearGradient(
                      colors: [
                        Color(0xFF6B46C1),
                        Color(0xFF3B82F6),
                        Color(0xFF06B6D4),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
        ),
        child: Stack(
          children: [
            // Background pattern or image placeholder
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.black.withValues(alpha: 0.3),
              ),
            ),
            // Title
            Positioned(
              bottom: 12,
              left: 12,
              right: 12,
              child: Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
