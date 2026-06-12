import 'package:flutter/material.dart';
import 'package:edufocus/core/themes/app_theme.dart';

class AuthFooter extends StatelessWidget {
  const AuthFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'Once signed in, the child\'s world begins.\nThis screen will not appear again.',
      textAlign: TextAlign.center,
      style: TextStyle(
        color: context.colors.textTertiary,
        fontSize: 12,
        height: 1.5,
      ),
    );
  }
}
