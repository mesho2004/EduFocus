import 'package:flutter/material.dart';
import 'package:edufocus/core/themes/app_colors.dart';

/// A full-width primary action button used across auth screens.
/// Supports a trailing icon and customisable height/color.
class AuthPrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final IconData? trailingIcon;
  final double height;
  final Color backgroundColor;

  const AuthPrimaryButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.trailingIcon,
    this.height = 56,
    this.backgroundColor = AppColors.brandGreen,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 4,
          shadowColor: backgroundColor.withOpacity(0.35),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              text,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            if (trailingIcon != null) ...[
              const SizedBox(width: 8),
              Icon(trailingIcon, color: Colors.white),
            ],
          ],
        ),
      ),
    );
  }
}
