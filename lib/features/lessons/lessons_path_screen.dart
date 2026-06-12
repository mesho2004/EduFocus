import 'package:edufocus/core/data/curriculum_data.dart';
import 'package:edufocus/features/lessons/widgets/lesson_path_header.dart';
import 'package:edufocus/features/lessons/widgets/lesson_path_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:edufocus/core/themes/app_theme.dart';
import 'package:edufocus/core/bloc/curriculum_cubit.dart';
import 'package:edufocus/core/bloc/curriculum_state.dart';

class LessonsPathScreen extends StatelessWidget {
  const LessonsPathScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final initialSubject = args['subject'] as SubjectData;
    final initialUnit = args['unit'] as UnitData;

    return BlocBuilder<CurriculumCubit, CurriculumState>(
      builder: (context, state) {
        final subject = state is CurriculumLoaded
            ? state.subjects.firstWhere(
                (s) => s.id == initialSubject.id,
                orElse: () => initialSubject,
              )
            : initialSubject;
        final unit = subject.units.firstWhere(
          (u) => u.id == initialUnit.id,
          orElse: () => initialUnit,
        );

        return Directionality(
          textDirection: subject.isRtl ? TextDirection.rtl : TextDirection.ltr,
          child: Scaffold(
            backgroundColor: context.colors.background,
            body: SafeArea(
              child: Column(
                children: [
                  LessonPathHeader(subject: subject, unit: unit),

                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(
                        vertical: 32,
                        horizontal: 24,
                      ),
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
      },
    );
  }
}
