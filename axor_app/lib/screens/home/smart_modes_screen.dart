import 'package:flutter/material.dart';
import '../../constants/colors.dart';
import '../../widgets/vibe_card.dart';
import '../smart_modes/gym_mode_screen.dart';
import '../smart_modes/study_mode_screen.dart';
import '../smart_modes/drive_mode_screen.dart';

class SmartModesScreen extends StatelessWidget {
  const SmartModesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              const Text(
                'SMART MODES',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.cyan,
                  letterSpacing: 2,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Choose your activity mode for personalized music',
                style: TextStyle(
                  fontSize: 16,
                  color: AppColors.lightGray,
                ),
              ),
              const SizedBox(height: 32),
              
              // Smart Modes Grid
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 1.2,
                  children: [
                    VibeCard(
                      title: 'GYM MODE',
                      imageUrl: 'assets/images/gym_mode.jpg',
                      color: AppColors.red,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const GymModeScreen(),
                          ),
                        );
                      },
                    ),
                    VibeCard(
                      title: 'STUDY MODE',
                      imageUrl: 'assets/images/study_mode.jpg',
                      color: AppColors.cyan,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const StudyModeScreen(),
                          ),
                        );
                      },
                    ),
                    VibeCard(
                      title: 'DRIVE MODE',
                      imageUrl: 'assets/images/drive_mode.jpg',
                      color: AppColors.green,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const DriveModeScreen(),
                          ),
                        );
                      },
                    ),
                    // Placeholder for future modes
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: AppColors.darkGray,
                          width: 2,
                          style: BorderStyle.solid,
                        ),
                      ),
                      child: const Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.add,
                              color: AppColors.darkGray,
                              size: 32,
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Coming Soon',
                              style: TextStyle(
                                color: AppColors.darkGray,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}