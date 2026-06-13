import 'package:edufocus/core/data/curriculum_data.dart';
import 'package:edufocus/features/units/widgets/stat_chip.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:edufocus/core/bloc/stars_cubit.dart';
import 'package:edufocus/generated/l10n.dart';

class SubjectSliverHeader extends StatelessWidget {
  final SubjectData subject;

  const SubjectSliverHeader({super.key, required this.subject});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 200,
      pinned: true,
      backgroundColor: subject.color,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
        onPressed: () => Navigator.pop(context),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 16.0),
          child: Center(
            child: BlocBuilder<StarsCubit, int>(
              builder: (context, stars) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text('🪙', style: TextStyle(fontSize: 16)),
                        const SizedBox(width: 4),
                        Text(
                          '$stars',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w900,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [subject.color, subject.color.withValues(alpha: 0.75)],
            ),
          ),
          child: Stack(
            children: [
              Positioned(
                top: -30,
                right: -30,
                child: Container(
                  width: 160,
                  height: 160,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withValues(alpha: 0.08),
                  ),
                ),
              ),
              Positioned(
                bottom: -40,
                left: -20,
                child: Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withValues(alpha: 0.06),
                  ),
                ),
              ),

              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(24, 48, 24, 24),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Center(
                          child: Text(
                            subject.emoji,
                            style: const TextStyle(fontSize: 44),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              subject.title,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 28,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                StatChip('${subject.units.length} ${S.of(context).units.toLowerCase()}'),
                                const SizedBox(width: 8),
                                StatChip('${subject.totalLessons} ${S.of(context).lessons.toLowerCase()}'),
                              ],
                            ),
                            const SizedBox(height: 8),

                            ClipRRect(
                              borderRadius: BorderRadius.circular(9999),
                              child: LinearProgressIndicator(
                                value: subject.overallProgress,
                                minHeight: 8,
                                backgroundColor: Colors.white.withValues(
                                  alpha: 0.25,
                                ),
                                valueColor: const AlwaysStoppedAnimation<Color>(
                                  Color(0xFFF3C344),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
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
