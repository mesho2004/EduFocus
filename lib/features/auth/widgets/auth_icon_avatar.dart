import 'package:flutter/material.dart';
import 'package:edufocus/core/themes/app_colors.dart';
import 'package:edufocus/core/themes/app_theme.dart';

/// A circular icon avatar used at the top of auth screens for branding.
class AuthIconAvatar extends StatelessWidget {
  final IconData icon;
  final double size;
  final double iconSize;
  final Color? iconColor;
  final Color? backgroundColor;

  const AuthIconAvatar({
    super.key,
    required this.icon,
    this.size = 96,
    this.iconSize = 56,
    this.iconColor,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveIconColor = iconColor ?? context.colors.brandPurple;
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: backgroundColor ?? effectiveIconColor.withOpacity(0.15),
        shape: BoxShape.circle,
      ),
      child: Icon(
        icon,
        size: iconSize,
        color: effectiveIconColor,
      ),
    );
  }
}
