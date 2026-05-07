import 'package:edufocus/core/data/curriculum_data.dart';
import 'package:edufocus/core/themes/app_colors.dart';
import 'package:edufocus/features/lessons/widgets/node_label.dart';
import 'package:flutter/material.dart';

class LockedNode extends StatelessWidget {
  final LessonData lesson;
  final double offset;

  const LockedNode({required this.lesson, required this.offset});

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: Offset(offset, 0),
      child: Opacity(
        opacity: 0.5,
        child: Column(
          children: [
            Container(
              width: 76,
              height: 76,
              decoration: BoxDecoration(
                color: AppColors.slate200,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 4,
                  ),
                ],
              ),
              child: const Icon(Icons.lock_rounded,
                  color: AppColors.slate400, size: 34),
            ),
            const SizedBox(height: 8),
            NodeLabel(text: lesson.title, color: AppColors.slate400),
          ],
        ),
      ),
    );
  }
}