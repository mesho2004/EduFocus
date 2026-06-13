import 'package:edufocus/features/subjects/widgets/overall_progress_card.dart';
import 'package:edufocus/features/subjects/widgets/subject_card.dart';
import 'package:edufocus/features/subjects/widgets/subject_screen_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:edufocus/core/themes/app_theme.dart';
import 'package:edufocus/core/bloc/curriculum_cubit.dart';
import 'package:edufocus/core/bloc/curriculum_state.dart';
import 'package:edufocus/core/routes/app_routes.dart';
import 'package:edufocus/generated/l10n.dart';

class SubjectsGridViewScreen extends StatelessWidget {
  const SubjectsGridViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CurriculumCubit, CurriculumState>(
      builder: (context, state) {
        if (state is CurriculumLoading || state is CurriculumInitial) {
          return Scaffold(
            backgroundColor: context.colors.background,
            body: Center(
              child: CircularProgressIndicator(color: context.colors.primary),
            ),
          );
        }

        if (state is CurriculumError) {
          return Scaffold(
            backgroundColor: context.colors.background,
            body: Center(
              child: Text(
                state.message,
                style: TextStyle(color: context.colors.textPrimary),
              ),
            ),
          );
        }

        final subjects = (state as CurriculumLoaded).subjects;

        final totalLessons = subjects.fold<int>(
          0,
          (s, sub) => s + sub.totalLessons,
        );
        final completedLessons = subjects.fold<int>(
          0,
          (s, sub) => s + sub.completedLessons,
        );
        final overallProgress = totalLessons == 0
            ? 0.0
            : completedLessons / totalLessons;
        final overallPct = (overallProgress * 100).round();

        return Scaffold(
          backgroundColor: context.colors.background,
          body: SafeArea(
            child: Column(
              children: [
                SubjectScreenHeader(),

                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 80),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 16),

                        OverallProgressCard(
                          progress: overallProgress,
                          pct: overallPct,
                          completed: completedLessons,
                          total: totalLessons,
                        ),
                        const SizedBox(height: 28),

                        Text(
                          S.of(context).letsStartPlaying,
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w900,
                            color: context.colors.textPrimary,
                          ),
                        ),

                        const SizedBox(height: 16),

                        GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: 16,
                                crossAxisSpacing: 16,
                                childAspectRatio: 0.82,
                              ),
                          itemCount: subjects.length,
                          itemBuilder: (context, i) {
                            return SubjectCard(
                              subject: subjects[i],
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  AppRoutes.units,
                                  arguments: subjects[i],
                                );
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
