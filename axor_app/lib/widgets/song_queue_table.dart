import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../utils/mode_manager.dart';

class SongQueueTable extends StatelessWidget {
  const SongQueueTable({super.key});

  @override
  Widget build(BuildContext context) {
    // Get current mode color
    final modeColor = modeManager.getModeColor();
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '> Song Queue',
          style: TextStyle(
            fontSize: 18,
            color: modeColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        
        // Table Header
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: AppColors.darkTeal.withValues(alpha: 0.3),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(8),
              topRight: Radius.circular(8),
            ),
          ),
          child: const Row(
            children: [
              Expanded(
                flex: 3,
                child: Text(
                  'Title',
                  style: TextStyle(
                    color: AppColors.lightGray,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Text(
                  'Artist',
                  style: TextStyle(
                    color: AppColors.lightGray,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  'Timeline',
                  style: TextStyle(
                    color: AppColors.lightGray,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
        
        // Song List - Fixed height with internal scrolling
        Container(
          height: 400, // Fixed height for scrollable area
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.3),
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(8),
              bottomRight: Radius.circular(8),
            ),
          ),
          child: ListView.builder(
            // Remove shrinkWrap and NeverScrollableScrollPhysics
            // This allows proper lazy loading
            itemCount: 500, // Can handle 500+ songs now!
            itemBuilder: (context, index) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: AppColors.darkGray.withValues(alpha: 0.3),
                      width: 0.5,
                    ),
                  ),
                ),
                child: Row(
                  children: [
                    // Number and Album Art
                    Text(
                      '${index + 1}.',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: AppColors.lightGray,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    const SizedBox(width: 12),
                    
                    // Song Info
                    Expanded(
                      flex: 3,
                      child: Text(
                        'Song name ${index + 1}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text(
                        'Artist ${index + 1}',
                        style: const TextStyle(
                          color: AppColors.lightGray,
                          fontSize: 14,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const Expanded(
                      flex: 1,
                      child: Text(
                        '3:45',
                        style: TextStyle(
                          color: AppColors.lightGray,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
