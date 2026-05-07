import 'package:edufocus/core/themes/app_colors.dart';
import 'package:flutter/material.dart';

class SubjectScreenHeader extends StatelessWidget {
  const SubjectScreenHeader({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: AppColors.slate100, width: 1)),
      ),
      child: Row(
        children: [
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Hi champ! 👋',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w900,
                    color: AppColors.slate900,
                  ),
                ),
                Text(
                  'Choose your subject and start playing!',
                  style: TextStyle(fontSize: 12, color: AppColors.slate500),
                ),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: const Icon(
                Icons.notifications_rounded,
                color: AppColors.primary,
              ),
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}
