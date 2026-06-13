import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:edufocus/core/themes/app_theme.dart';
import 'package:edufocus/core/bloc/stars_cubit.dart';
import 'package:edufocus/core/bloc/curriculum_cubit.dart';
import 'package:edufocus/core/bloc/curriculum_state.dart';
import 'package:edufocus/generated/l10n.dart';

class ProfileAchievements extends StatelessWidget {
  const ProfileAchievements({super.key});

  @override
  Widget build(BuildContext context) {
    final stars = context.watch<StarsCubit>().state;
    return BlocBuilder<CurriculumCubit, CurriculumState>(
      builder: (context, state) {
        int completedLessons = 0;
        int streakDays = 0;
        if (state is CurriculumLoaded) {
          completedLessons = state.subjects.fold<int>(
            0,
            (s, sub) => s + sub.completedLessons,
          );
          streakDays = state.progressModel?.streakDays ?? 0;
        }

        final firstWordUnlocked = completedLessons > 0;
        final perfectScoreUnlocked = completedLessons >= 3;
        final streakUnlocked = streakDays >= 3;
        final puzzleMasterUnlocked = completedLessons >= 5;

        return Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: _buildAchievementCard(
                    context,
                    S.of(context).coins,
                    '$stars',
                    const Text('🪙', style: TextStyle(fontSize: 32)),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildAchievementCard(
                    context,
                    S.of(context).gamesWon,
                    '$completedLessons',
                    Icon(
                      Icons.emoji_events_rounded,
                      color: context.colors.brandOrange,
                      size: 32,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: context.colors.cardBackground,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: context.colors.border, width: 2),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    S.of(context).Badges,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: context.colors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildBadge(context, '🍎', S.of(context).badgeFirstWord, firstWordUnlocked),
                      _buildBadge(context, '⭐', S.of(context).badgePerfectScore, perfectScoreUnlocked),
                      _buildBadge(context, '🔥', S.of(context).badgeStreak3, streakUnlocked),
                      _buildBadge(context, '🧩', S.of(context).badgePuzzleMaster, puzzleMasterUnlocked),
                    ],
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildBadge(BuildContext context, String emoji, String title, bool unlocked) {
    return Column(
      children: [
        Container(
          height: 56,
          width: 56,
          decoration: BoxDecoration(
            color: unlocked
                ? context.colors.brandYellow.withOpacity(0.15)
                : context.colors.border.withOpacity(0.3),
            shape: BoxShape.circle,
            border: Border.all(
              color: unlocked
                  ? context.colors.brandYellow
                  : context.colors.border,
              width: 2,
            ),
          ),
          child: Center(
            child: Opacity(
              opacity: unlocked ? 1.0 : 0.4,
              child: Text(emoji, style: const TextStyle(fontSize: 28)),
            ),
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          width: 64,
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: unlocked
                  ? context.colors.textPrimary
                  : context.colors.textTertiary,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAchievementCard(BuildContext context, String title, String value, Widget iconWidget) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.colors.cardBackground,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: context.colors.border, width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          iconWidget,
          const SizedBox(height: 12),
          Text(
            value,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w900,
              color: context.colors.textPrimary,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: context.colors.textTertiary,
            ),
          ),
        ],
      ),
    );
  }
}
