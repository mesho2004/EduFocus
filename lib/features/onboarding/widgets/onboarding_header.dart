import 'package:flutter/material.dart';
import 'package:edufocus/core/themes/app_theme.dart';
import 'package:edufocus/generated/l10n.dart';

class OnboardingHeader extends StatelessWidget {
  final VoidCallback onSkipPressed;
  const OnboardingHeader({super.key, required this.onSkipPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 8.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          TextButton(
            onPressed: onSkipPressed,
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
              backgroundColor: context.colors.cardBackground.withOpacity(0.5),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: BorderSide(color: context.colors.border),
              ),
            ),
            child: Text(
              S.of(context).skip,
              style: TextStyle(
                color: context.colors.textSecondary,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
