import 'package:edufocus/core/data/curriculum_data.dart';
import 'package:edufocus/core/themes/app_colors.dart';
import 'package:edufocus/core/themes/app_theme.dart';
import 'package:edufocus/features/lessons/widgets/node_label.dart';
import 'package:flutter/material.dart';

class CompletedNode extends StatelessWidget {
  final LessonData lesson;
  final double offset;
  final Color color;

  const CompletedNode(
      {super.key, required this.lesson,
      required this.offset,
      required this.color});

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: Offset(offset, 0),
      child: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              // Glow ring
              Container(
                width: 90,
                height: 90,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.brandGreen.withValues(alpha: 0.15),
                ),
              ),
              // Main circle
              Container(
                width: 76,
                height: 76,
                decoration: BoxDecoration(
                  color: AppColors.brandGreen,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.brandGreen.withValues(alpha: 0.4),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: const Icon(Icons.check_rounded,
                    color: Colors.white, size: 38),
              ),
              // Stars
              Positioned(
                top: -14,
                right: -10,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: List.generate(3, (i) {
                    return Icon(
                      Icons.star_rounded,
                      size: 18,
                      color: i < lesson.stars
                          ? const Color(0xFFF3C344)
                          : context.colors.border,
                    );
                  }),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          NodeLabel(text: lesson.title, color: AppColors.brandGreen),
        ],
      ),
    );
  }
}