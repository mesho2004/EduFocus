import 'package:flutter/material.dart';

class OnboardingBackground extends StatelessWidget {
  final Color slideColor;
  const OnboardingBackground({super.key, required this.slideColor});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: -40,
          right: -40,
          child: _buildFloatingCircle(
            size: 200,
            color: slideColor.withOpacity(0.12),
          ),
        ),
        Positioned(
          bottom: -50,
          left: -50,
          child: _buildFloatingCircle(
            size: 250,
            color: slideColor.withOpacity(0.08),
          ),
        ),
        Positioned(
          top: MediaQuery.of(context).size.height * 0.45,
          right: 30,
          child: _buildFloatingCircle(
            size: 50,
            color: slideColor.withOpacity(0.15),
          ),
        ),
      ],
    );
  }

  Widget _buildFloatingCircle({required double size, required Color color}) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      width: size,
      height: size,
      decoration: BoxDecoration(shape: BoxShape.circle, color: color),
    );
  }
}
