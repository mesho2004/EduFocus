import 'package:flutter/material.dart';
import 'package:edufocus/core/themes/app_colors.dart';
import 'package:edufocus/core/widgets/edufocus_logo.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.pushReplacementNamed(context, '/parent_auth');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:AppColors.backgroundLight,
      body: Stack(
        children: [
          // Background Decorative Elements
          Positioned(
            top: 50,
            left: -40,
            child: _buildFloatingCircle(
              size: 150,
              color: AppColors.brandYellow.withOpacity(0.2),
            ),
          ),
          Positioned(
            bottom: 100,
            right: -60,
            child: _buildFloatingCircle(
              size: 200,
              color: AppColors.brandCyan.withOpacity(0.2),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.4,
            left: 30,
            child: _buildFloatingCircle(
              size: 40,
              color: AppColors.brandRed.withOpacity(0.3),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.2,
            right: 80,
            child: _buildFloatingCircle(
              size: 20,
              color: AppColors.brandGreen.withOpacity(0.4),
            ),
          ),
          Positioned(
            bottom: MediaQuery.of(context).size.height * 0.3,
            right: 40,
            child: _buildFloatingCircle(
              size: 60,
              color: AppColors.brandPurple.withOpacity(0.2),
            ),
          ),

          // Main Content
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const EduFocusLogo(fontSize: 48),
                const SizedBox(height: 16),
                const Text(
                  'Learning that feels like playing.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.slate500,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFloatingCircle({required double size, required Color color}) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(shape: BoxShape.circle, color: color),
    );
  }
}
