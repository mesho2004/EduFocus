import 'package:edufocus/core/themes/app_colors.dart';
import 'package:edufocus/core/themes/app_theme.dart';
import 'package:flutter/material.dart';

class NodeLabel extends StatelessWidget {
  final String text;
  final Color color;
  final bool isActive;

  const NodeLabel(
      {super.key,
      required this.text,
      required this.color,
      this.isActive = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
      decoration: BoxDecoration(
        color: isActive ? color.withValues(alpha: 0.12) : context.colors.cardBackground,
        borderRadius: BorderRadius.circular(9999),
        border: isActive
            ? Border.all(color: color.withValues(alpha: 0.3))
            : null,
        boxShadow: isActive
            ? null
            : [
                BoxShadow(
                    color: Colors.black.withValues(alpha: 0.04),
                    blurRadius: 4)
              ],
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: isActive ? 15 : 13,
          fontWeight: isActive ? FontWeight.w900 : FontWeight.w700,
          color: isActive ? color : context.colors.textSecondary,
        ),
      ),
    );
  }
}