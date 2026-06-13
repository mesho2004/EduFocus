import 'package:flutter/material.dart';
import 'package:edufocus/core/themes/app_theme.dart';
import 'package:edufocus/features/onboarding/onboarding_tutorial_screen.dart';

class OnboardingSlideCard extends StatelessWidget {
  final OnboardingSlideData slide;
  final Color slideColor;

  const OnboardingSlideCard({
    super.key,
    required this.slide,
    required this.slideColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 160,
            height: 160,
            decoration: BoxDecoration(
              color: slideColor.withOpacity(0.15),
              shape: BoxShape.circle,
              border: Border.all(
                color: slideColor.withOpacity(0.3),
                width: 4,
              ),
              boxShadow: [
                BoxShadow(
                  color: slideColor.withOpacity(0.1),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Center(
              child: Text(
                slide.emoji,
                style: const TextStyle(fontSize: 80),
              ),
            ),
          ),
          const SizedBox(height: 48),

          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 32,
            ),
            decoration: BoxDecoration(
              color: context.colors.cardBackground,
              borderRadius: BorderRadius.circular(32),
              border: Border.all(
                color: context.colors.border,
                width: 1.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.04),
                  blurRadius: 16,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Column(
              children: [
                Text(
                  slide.title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w900,
                    color: context.colors.textPrimary,
                    letterSpacing: -0.5,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  slide.description,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    height: 1.5,
                    color: context.colors.textSecondary,
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
}
