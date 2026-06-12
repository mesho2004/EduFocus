import 'package:flutter/material.dart';
import 'package:edufocus/core/themes/app_theme.dart';

class AuthFieldLabel extends StatelessWidget {
  final String text;

  const AuthFieldLabel({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        text,
        style: TextStyle(
          color: context.colors.textSecondary,
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
