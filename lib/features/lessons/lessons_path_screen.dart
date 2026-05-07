import 'package:edufocus/core/data/curriculum_data.dart';
import 'package:edufocus/features/lessons/widgets/lesson_path_header.dart';
import 'package:edufocus/features/lessons/widgets/lesson_path_widget.dart';
import 'package:flutter/material.dart';
import 'package:edufocus/core/themes/app_colors.dart';



class LessonsPathScreen extends StatelessWidget {
  const LessonsPathScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final subject = args['subject'] as SubjectData;
    final unit = args['unit'] as UnitData;

    return Directionality(
      textDirection:
          subject.isRtl ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        backgroundColor: AppColors.backgroundLight,
        body: SafeArea(
          child: Column(
            children: [
              LessonPathHeader(subject: subject, unit: unit),

              // ── Winding path ──────────────────────────
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                      vertical: 32, horizontal: 24),
                  child: LessonPath(
                    lessons: unit.lessons,
                    subject: subject,
                    unitIndex: subject.units.indexOf(unit),
                    context: context,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}







