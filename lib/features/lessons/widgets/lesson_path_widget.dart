import 'package:edufocus/core/data/curriculum_data.dart';
import 'package:edufocus/features/game_engine/data/services/curriculum_service.dart';
import 'package:edufocus/features/lessons/widgets/lesson_node.dart';
import 'package:edufocus/features/lessons/widgets/path_line_painter.dart';

import 'package:flutter/material.dart';
import 'package:edufocus/core/routes/app_routes.dart';

class LessonPath extends StatelessWidget {
  final List<LessonData> lessons;
  final SubjectData subject;
  final int unitIndex;
  final BuildContext context;

  const LessonPath({
    super.key,
    required this.lessons,
    required this.subject,
    required this.unitIndex,
    required this.context,
  });

  static const _offsets = [40.0, -32.0, 16.0, -40.0, 24.0, -16.0, 32.0];

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Positioned.fill(
          child: Align(
            alignment: Alignment.center,
            child: CustomPaint(
              painter: PathLinePainter(color: subject.color),
              child: const SizedBox(width: 200, height: double.infinity),
            ),
          ),
        ),

        Column(
          children: List.generate(lessons.length * 2 - 1, (i) {
            if (i.isOdd) return const SizedBox(height: 56);
            final lessonIdx = i ~/ 2;
            final lesson = lessons[lessonIdx];
            final offset = _offsets[lessonIdx % _offsets.length];

            return LessonNode(
              lesson: lesson,
              index: lessonIdx,
              offset: offset,
              subject: subject,
              onTap: () => _launchLesson(context, lessonIdx),
            );
          }),
        ),
      ],
    );
  }

  void _launchLesson(BuildContext ctx, int lessonIdx) async {
    try {
      final content = await CurriculumService().getLessonContent(
        subject.id,
        unitIndex,
        lessonIdx,
      );
      if (ctx.mounted && content != null) {
        Navigator.pushNamed(ctx, AppRoutes.gameEngine, arguments: content);
      } else if (ctx.mounted) {
        ScaffoldMessenger.of(ctx).showSnackBar(
          const SnackBar(
            content: Text('عذرًا، محتوى هذا الدرس غير متوفر حاليًا.'),
          ),
        );
      }
    } catch (e) {
      if (ctx.mounted) {
        ScaffoldMessenger.of(
          ctx,
        ).showSnackBar(SnackBar(content: Text('خطأ في تحميل الدرس: $e')));
      }
    }
  }
}
