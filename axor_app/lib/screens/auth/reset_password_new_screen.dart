import 'package:flutter/material.dart';
import '../../constants/colors.dart';
import '../../widgets/auth_card.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_field.dart';
import '../../utils/page_transitions.dart';
import 'signin_screen.dart';

class ResetPasswordNewScreen extends StatefulWidget {
  const ResetPasswordNewScreen({super.key});

  @override
  State<ResetPasswordNewScreen> createState() => _ResetPasswordNewScreenState();
}

class _ResetPasswordNewScreenState extends State<ResetPasswordNewScreen> {
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const SizedBox(height: 60),
              // Your Logo
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.asset(
                    'assets/logo.png',
                    width: 80,
                    height: 80,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) {
                      // Fallback if logo not found
                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          gradient: const LinearGradient(
                            colors: [
                              Color(0xFF6B46C1),
                              Color(0xFF3B82F6),
                              Color(0xFF06B6D4),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                        child: const Icon(
                          Icons.music_note,
                          size: 40,
                          color: Colors.white,
                        ),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'AXOR',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.cyan,
                  letterSpacing: 2,
                  fontFamily: 'Charmonman',
                ),
              ),
              const SizedBox(height: 40),
              
              // Auth Card
              AuthCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Reset Password',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 24),
                    
                    const Text(
                      'Enter new password',
                      style: TextStyle(
                        fontSize: 16,
                        color: AppColors.lightGray,
                      ),
                    ),
                    const SizedBox(height: 8),
                    CustomTextField(
                      controller: _passwordController,
                      hintText: '••••••••••',
                      prefixIcon: Icons.lock,
                      obscureText: _obscurePassword,
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword ? Icons.visibility : Icons.visibility_off,
                          color: AppColors.lightGray,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                      ),
                    ),
                    const SizedBox(height: 20),
                    
                    const Text(
                      'Confirm new Password',
                      style: TextStyle(
                        fontSize: 16,
                        color: AppColors.lightGray,
                      ),
                    ),
                    const SizedBox(height: 8),
                    CustomTextField(
                      controller: _confirmPasswordController,
                      hintText: '••••••••••',
                      prefixIcon: Icons.lock,
                      obscureText: _obscureConfirmPassword,
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscureConfirmPassword ? Icons.visibility : Icons.visibility_off,
                          color: AppColors.lightGray,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscureConfirmPassword = !_obscureConfirmPassword;
                          });
                        },
                      ),
                    ),
                    const SizedBox(height: 32),
                    
                    CustomButton(
                      text: 'Confirm',
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          slideUpRoute(const SignInScreen()),
                          (route) => false,
                        );
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              
              const Text(
                "By continuing, you agree to AxoR's Terms of Service and\nPrivacy Policy",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.darkGray,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
