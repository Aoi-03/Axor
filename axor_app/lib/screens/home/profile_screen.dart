import 'package:flutter/material.dart';
import '../../constants/colors.dart';
import '../../widgets/auth_card.dart';
import '../../utils/page_transitions.dart';
import '../auth/signin_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController _codeController = TextEditingController();
  
  // These should come from user data/state management
  final String userName = "Alex"; // Dynamic from user signup
  final String userEmail = "alex@gmail.com"; // Dynamic from user signup
  String? userProfileImage; // Will be set when user uploads image
  
  // Storage management - Backend will handle this
  // FREE USER: Shows app data storage used on device (local storage)
  // PREMIUM USER: Shows cloud storage used vs purchased amount
  final bool isPremiumUser = false; // From backend
  final double storageUsed = 0.0; // GB - From backend
  final double storageLimit = 1.0; // GB - Free: 1GB local, Premium: purchased amount
  
  String get storageText {
    if (isPremiumUser) {
      // Premium: Show cloud storage
      return '${storageUsed.toStringAsFixed(2)}GB / ${storageLimit.toStringAsFixed(0)}GB';
    } else {
      // Free: Show local device storage
      return '${storageUsed.toStringAsFixed(2)}GB / ${storageLimit.toStringAsFixed(0)}GB';
    }
  }
  
  double get storagePercentage {
    if (storageLimit == 0) return 0.0;
    return storageUsed / storageLimit;
  }

  @override
  void dispose() {
    _codeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              const Text(
                'PROFILE',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.cyan,
                  letterSpacing: 2,
                ),
              ),
              const SizedBox(height: 24),
              
              // Profile Card
              AuthCard(
                child: Column(
                  children: [
                    Row(
                      children: [
                        // Profile Picture
                        Stack(
                          children: [
                            GestureDetector(
                              onTap: () {
                                // Handle profile picture selection
                                _selectProfileImage();
                              },
                              child: Container(
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                  color: AppColors.darkTeal,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: AppColors.cyan,
                                    width: 2,
                                  ),
                                ),
                                child: userProfileImage != null
                                    ? ClipOval(
                                        child: Image.asset(
                                          userProfileImage!,
                                          width: 60,
                                          height: 60,
                                          fit: BoxFit.cover,
                                        ),
                                      )
                                    : const Center(
                                        child: Text(
                                          'PFP',
                                          style: TextStyle(
                                            color: AppColors.cyan,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: Container(
                                width: 16,
                                height: 16,
                                decoration: const BoxDecoration(
                                  color: AppColors.green,
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(width: 16),
                        
                        // User Info
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  _showEditUsernameDialog(context);
                                },
                                child: Row(
                                  children: [
                                    Text(
                                      userName,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    const Icon(
                                      Icons.edit,
                                      color: AppColors.cyan,
                                      size: 16,
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                userEmail,
                                style: const TextStyle(
                                  color: AppColors.lightGray,
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.darkGray,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: const Text(
                                  'Free Plan',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    
                    // Stats Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildStatColumn('0', 'Songs'),
                        _buildStatColumn('0', 'Playlists'),
                        _buildStatColumn('0h', 'Listened'),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              
              // Storage Card
              AuthCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      isPremiumUser ? 'Cloud Storage Used' : 'Local Storage Used',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          storageText,
                          style: const TextStyle(
                            color: AppColors.lightGray,
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          '${(storagePercentage * 100).toStringAsFixed(0)}%',
                          style: const TextStyle(
                            color: AppColors.cyan,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    LinearProgressIndicator(
                      value: storagePercentage,
                      backgroundColor: AppColors.darkGray,
                      valueColor: const AlwaysStoppedAnimation<Color>(AppColors.cyan),
                    ),
                    if (!isPremiumUser)
                      const Padding(
                        padding: EdgeInsets.only(top: 8),
                        child: Text(
                          'Upgrade to Premium for cloud storage',
                          style: TextStyle(
                            color: AppColors.lightGray,
                            fontSize: 12,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              
              // Premium Upgrade Card
              AuthCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.card_giftcard,
                          color: AppColors.cyan,
                          size: 24,
                        ),
                        const SizedBox(width: 12),
                        const Text(
                          'Unlock Premium',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Cloud Storage • \$1/GB per month',
                      style: TextStyle(
                        color: AppColors.lightGray,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 16),
                    
                    // Code Input
                    TextField(
                      controller: _codeController,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: 'XXXX-XXXX-XXXX-XXXX',
                        hintStyle: const TextStyle(color: AppColors.darkGray),
                        filled: true,
                        fillColor: AppColors.darkTeal,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    
                    // Send Request Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          // Handle premium code submission
                          // BACKEND FLOW:
                          // 1. User enters Amazon Gift Card code
                          // 2. Backend sends email to a67154512@gmail.com with:
                          //    - User email
                          //    - Gift card code
                          //    - Timestamp
                          // 3. Admin redeems code on Amazon to verify
                          // 4. Admin replies with storage allocation (e.g., "5 GB")
                          // 5. Backend updates user's cloud storage limit
                          // 6. User gets notification of successful upgrade
                          // 
                          // Pricing: $1 = 1GB cloud storage
                          // Example: $10 gift card = 10GB cloud storage
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.cyan,
                          foregroundColor: Colors.black,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          'Send Request',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    
                    const Text(
                      'Redeem Amazon Gift Card codes for Premium access',
                      style: TextStyle(
                        color: AppColors.lightGray,
                        fontSize: 12,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              
              // Privacy Policy Button
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.darkTeal,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: TextButton(
                  onPressed: () {
                    // Navigate to privacy policy screen
                    Navigator.push(
                      context,
                      slideUpRoute(const PrivacyPolicyScreen()),
                    );
                  },
                  child: const Row(
                    children: [
                      Icon(
                        Icons.shield,
                        color: Colors.white,
                        size: 20,
                      ),
                      SizedBox(width: 12),
                      Text(
                        'Privacy Policy',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12),
              
              // Log Out Button
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.darkTeal,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: TextButton(
                  onPressed: () {
                    // Handle logout - navigate back to sign-in screen
                    Navigator.of(context).pushAndRemoveUntil(
                      fadeRoute(const SignInScreen()),
                      (route) => false,
                    );
                  },
                  child: const Row(
                    children: [
                      Icon(
                        Icons.exit_to_app,
                        color: Colors.white,
                        size: 20,
                      ),
                      SizedBox(width: 12),
                      Text(
                        'Log Out',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _selectProfileImage() {
    // This would typically open image picker
    // For now, just show a placeholder dialog
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.darkTeal,
        title: const Text(
          'Select Profile Image',
          style: TextStyle(color: Colors.white),
        ),
        content: const Text(
          'Image picker functionality would be implemented here.',
          style: TextStyle(color: AppColors.lightGray),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'OK',
              style: TextStyle(color: AppColors.cyan),
            ),
          ),
        ],
      ),
    );
  }

  void _showEditUsernameDialog(BuildContext context) {
    final TextEditingController usernameController = TextEditingController(text: userName);
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.darkTeal,
        title: const Text(
          'Edit Username',
          style: TextStyle(color: Colors.white),
        ),
        content: TextField(
          controller: usernameController,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: 'Enter new username',
            hintStyle: const TextStyle(color: AppColors.darkGray),
            filled: true,
            fillColor: AppColors.black,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'Cancel',
              style: TextStyle(color: AppColors.lightGray),
            ),
          ),
          TextButton(
            onPressed: () {
              // TODO: Update username via backend
              // Backend will update in Google Drive
              Navigator.pop(context);
            },
            child: const Text(
              'Save',
              style: TextStyle(color: AppColors.cyan),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatColumn(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            color: AppColors.cyan,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            color: AppColors.lightGray,
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}

// Privacy Policy Screen
class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Privacy Policy',
          style: TextStyle(
            color: AppColors.cyan,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'AXOR Privacy Policy',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Your privacy is important to us. This privacy policy explains how AXOR collects, uses, and protects your information.',
              style: TextStyle(
                color: AppColors.lightGray,
                fontSize: 16,
                height: 1.5,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Information We Collect',
              style: TextStyle(
                color: AppColors.cyan,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              '• Account information (email, username)\n• Music preferences and listening history\n• Device information\n• Usage analytics',
              style: TextStyle(
                color: AppColors.lightGray,
                fontSize: 16,
                height: 1.5,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'How We Use Your Information',
              style: TextStyle(
                color: AppColors.cyan,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              '• Provide personalized music recommendations\n• Improve our services\n• Communicate with you about updates\n• Ensure security and prevent fraud',
              style: TextStyle(
                color: AppColors.lightGray,
                fontSize: 16,
                height: 1.5,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Payment and Refund Policy',
              style: TextStyle(
                color: AppColors.cyan,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              '• All purchases are non-refundable\n• Cloud storage purchases are final and cannot be reversed\n• Amazon Gift Card codes are verified before activation\n• Storage allocation is based on the gift card value redeemed\n• Pricing: \$1 per GB per month of cloud storage\n• Subscription renews monthly',
              style: TextStyle(
                color: AppColors.lightGray,
                fontSize: 16,
                height: 1.5,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Contact Us',
              style: TextStyle(
                color: AppColors.cyan,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'If you have any questions about this privacy policy, please contact us at a67154512@gmail.com',
              style: TextStyle(
                color: AppColors.lightGray,
                fontSize: 16,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}