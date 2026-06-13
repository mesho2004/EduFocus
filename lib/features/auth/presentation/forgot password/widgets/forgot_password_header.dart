import 'package:flutter/material.dart';
import 'package:edufocus/core/themes/app_theme.dart';
import 'package:edufocus/core/widgets/edufocus_logo.dart';
import 'package:edufocus/generated/l10n.dart';

class ForgotPasswordHeader extends StatelessWidget {
  const ForgotPasswordHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),
        const EduFocusLogo(fontSize: 32, animate: false),
        const SizedBox(height: 28),

        Text(
          S.of(context).forgotPassword,
          style: TextStyle(
            color: context.colors.textPrimary,
            fontSize: 26,
            fontWeight: FontWeight.bold,
            letterSpacing: -0.5,
          ),
        ),

        const SizedBox(height: 8),

        Text(
          S.of(context).forgotPasswordDescription,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: context.colors.textSecondary,
            fontSize: 14,
            height: 1.5,
          ),
        ),

        const SizedBox(height: 36),
      ],
    );
  }
}
