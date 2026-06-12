import 'package:flutter/material.dart';
import 'package:edufocus/core/themes/app_theme.dart';

class ChildFooter extends StatelessWidget {
  final String text;

  const ChildFooter({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(color: context.colors.textTertiary, fontSize: 12),
      ),
    );
  }
}
