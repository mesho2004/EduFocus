import 'package:edufocus/features/subjects/widgets/overall_progress_card.dart';
import 'package:edufocus/features/subjects/widgets/subject_card.dart';
import 'package:edufocus/features/subjects/widgets/subject_screen_header.dart';
import 'package:flutter/material.dart';
import 'package:edufocus/core/themes/app_colors.dart';
import 'package:edufocus/widgets/custom_bottom_nav_bar.dart';
import 'package:edufocus/core/data/curriculum_data.dart';

class SubjectsGridViewScreen extends StatelessWidget {
  const SubjectsGridViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<SubjectData>>(
      future: CurriculumData.loadAllSubjects(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            backgroundColor: AppColors.backgroundLight,
            body: Center(
              child: CircularProgressIndicator(color: AppColors.primary),
            ),
          );
        }

        final subjects = snapshot.data ?? [];

        // Overall progress across all subjects
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
          backgroundColor: AppColors.backgroundLight,
          body: SafeArea(
            child: Column(
              children: [
                SubjectScreenHeader(),

                // ── Scrollable content ────────────────────────
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 80),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 16),

                        // ── Overall progress card ───────────────
                        OverallProgressCard(
                          progress: overallProgress,
                          pct: overallPct,
                          completed: completedLessons,
                          total: totalLessons,
                        ),
                        const SizedBox(height: 28),

                        // ── Section label ───────────────────────
                        const Text(
                          "Let's start playing",
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w900,
                            color: AppColors.slate900,
                          ),
                        ),

                        const SizedBox(height: 16),

                        // ── Subject cards — 2 × 2 grid ──────────
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
                                  '/units',
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
          bottomSheet: CustomBottomNavBar(
            currentIndex: 0,
            onTap: (index) {
              if (index == 1) {
                Navigator.pushReplacementNamed(context, '/progress');
              } else if (index == 2) {
                Navigator.pushReplacementNamed(context, '/profile');
              }
            },
          ),
        );
      },
    );
  }
}



