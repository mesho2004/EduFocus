import 'package:edufocus/core/themes/app_colors.dart';
import 'package:edufocus/core/themes/app_theme.dart';
import 'package:flutter/material.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 72,
      decoration: BoxDecoration(
        color: context.colors.cardBackground.withOpacity(0.9),
        border: Border(top: BorderSide(color: context.colors.border)),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildBottomNav(
                context,
                Icons.home,
                'Home',
                currentIndex == 0,
                () => onTap(0),
              ),
              _buildBottomNav(
                context,
                Icons.trending_up,
                'Progress',
                currentIndex == 1,
                () => onTap(1),
              ),
              _buildBottomNav(
                context,
                Icons.person,
                'Profile',
                currentIndex == 2,
                () => onTap(2),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBottomNav(
    BuildContext context,
    IconData icon,
    String label,
    bool isActive,
    VoidCallback onTap,
  ) {
    final color = isActive
        ? context.colors.primary
        : context.colors.textTertiary;

    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color, size: 28),
          const SizedBox(height: 4),
          Text(
            label.toUpperCase(),
            style: TextStyle(
              color: color,
              fontSize: 10,
              fontWeight: isActive ? FontWeight.bold : FontWeight.w600,
              letterSpacing: 1.0,
            ),
          ),
        ],
      ),
    );
  }
}
