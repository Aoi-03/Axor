import 'package:flutter/material.dart';
import '../../constants/colors.dart';
import '../../widgets/auth_card.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_field.dart';
import '../../utils/page_transitions.dart';
import 'signup_screen.dart';
import 'reset_password_email_screen.dart';
import '../home/main_screen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

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
                      'Welcome User',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 24),
                    
                    const Text(
                      'Email id',
                      style: TextStyle(
                        fontSize: 16,
                        color: AppColors.lightGray,
                      ),
                    ),
                    const SizedBox(height: 8),
                    CustomTextField(
                      controller: _emailController,
                      hintText: 'user@example.com',
                      prefixIcon: Icons.email,
                    ),
                    const SizedBox(height: 20),
                    
                    const Text(
                      'Enter Password',
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
                    const SizedBox(height: 16),
                    
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            slideFromLeftRoute(const ResetPasswordEmailScreen()),
                          );
                        },
                        child: const Text(
                          'Forgot Password?',
                          style: TextStyle(
                            color: AppColors.lightGray,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    
                    CustomButton(
                      text: 'Login',
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          fadeRoute(const MainScreen()),
                        );
                      },
                    ),
                    const SizedBox(height: 24),
                    
                    Row(
                      children: [
                        Expanded(child: Container(height: 1, color: AppColors.darkGray)),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            'OR',
                            style: TextStyle(color: AppColors.lightGray),
                          ),
                        ),
                        Expanded(child: Container(height: 1, color: AppColors.darkGray)),
                      ],
                    ),
                    const SizedBox(height: 24),
                    
                    CustomButton(
                      text: 'Continue with Google',
                      onPressed: () {},
                      isSecondary: true,
                      icon: Icons.g_mobiledata,
                    ),
                    const SizedBox(height: 24),
                    
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Don't have an account? ",
                          style: TextStyle(color: AppColors.lightGray),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              slideUpRoute(const SignUpScreen()),
                            );
                          },
                          child: const Text(
                            'Sign Up',
                            style: TextStyle(color: AppColors.cyan),
                          ),
                        ),
                      ],
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
