import 'package:flutter/material.dart';
import 'package:edufocus/core/themes/app_colors.dart';
import 'package:edufocus/core/themes/app_theme.dart';

/// A reusable header bar for auth screens with a back button,
/// optional centered title, and balanced spacing.
class AuthHeader extends StatelessWidget {
  final String? title;
  final VoidCallback? onBack;

  const AuthHeader({
    super.key,
    this.title,
    this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        children: [
          IconButton(
            icon: Icon(Icons.arrow_back, color: context.colors.textPrimary),
            onPressed: onBack ?? () => Navigator.pop(context),
          ),
          if (title != null)
            Expanded(
              child: Text(
                title!,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: context.colors.textPrimary,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          if (title != null) const SizedBox(width: 48),
          if (title == null) const Spacer(),
        ],
      ),
    );
  }
}
