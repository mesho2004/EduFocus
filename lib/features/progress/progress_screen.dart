import 'package:edufocus/core/themes/app_theme.dart';
import 'package:edufocus/features/main_navigation_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:edufocus/core/bloc/stars_cubit.dart';
import 'package:edufocus/core/bloc/curriculum_cubit.dart';
import 'package:edufocus/core/bloc/curriculum_state.dart';
import 'package:edufocus/core/routes/app_routes.dart';
import 'package:edufocus/generated/l10n.dart';

class ProgressScreen extends StatelessWidget {
  const ProgressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.background,
      appBar: AppBar(
        backgroundColor: context.colors.background,
        elevation: 0,
        centerTitle: true,
        title: Text(
          S.of(context).myProgress,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w900,
            color: context.colors.textPrimary,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 100),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildHeroSection(context),

              const SizedBox(height: 32),
              _buildSectionTitle(
                context,
                S.of(context).trophyRoom,
                Icons.emoji_events_rounded,
                context.colors.brandYellow,
              ),
              const SizedBox(height: 16),
              _buildTrophyRoom(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(
    BuildContext context,
    String title,
    IconData icon,
    Color color,
  ) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withOpacity(0.15),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: color, size: 24),
        ),
        const SizedBox(width: 12),
        Text(
          title,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w800,
            color: context.colors.textPrimary,
          ),
        ),
      ],
    );
  }

  Widget _buildHeroSection(BuildContext context) {
    final stars = context.watch<StarsCubit>().state;
    return BlocBuilder<CurriculumCubit, CurriculumState>(
      builder: (context, state) {
        int totalLessons = 0;
        int completedLessons = 0;
        double progress = 0.0;
        int streakDays = 0;

        if (state is CurriculumLoaded) {
          totalLessons = state.subjects.fold<int>(
            0,
            (s, sub) => s + sub.totalLessons,
          );
          completedLessons = state.subjects.fold<int>(
            0,
            (s, sub) => s + sub.completedLessons,
          );
          progress = totalLessons == 0 ? 0.0 : completedLessons / totalLessons;
          if (state.progressModel != null) {
            streakDays = state.progressModel!.streakDays;
          }
        }

        final pct = (progress * 100).round();

        return Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF8B59A7), Color(0xFF6B4282)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF8B59A7).withValues(alpha: 0.3),
                blurRadius: 16,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildHeroStat(
                    icon: '🔥',
                    label: S.of(context).streak,
                    value: S.of(context).streakDaysValue(streakDays),
                    color: context.colors.brandOrange,
                  ),
                  Container(
                    width: 2,
                    height: 50,
                    color: Colors.white.withValues(alpha: 0.2),
                  ),
                  _buildHeroStat(
                    icon: '🪙',
                    label: S.of(context).coins,
                    value: '$stars',
                    color: context.colors.brandYellow,
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        S.of(context).completedLessonsProgress(completedLessons, totalLessons),
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        '$pct%',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w900,
                          color: context.colors.brandYellow,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: LinearProgressIndicator(
                      value: progress,
                      backgroundColor: Colors.white.withValues(alpha: 0.2),
                      valueColor: AlwaysStoppedAnimation<Color>(
                        context.colors.brandYellow,
                      ),
                      minHeight: 14,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildHeroStat({
    required String icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.15),
            shape: BoxShape.circle,
          ),
          child: Text(icon, style: const TextStyle(fontSize: 28)),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w900,
            color: Colors.white,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: Colors.white.withOpacity(0.8),
          ),
        ),
      ],
    );
  }

  Widget _buildLearningMap(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      decoration: BoxDecoration(
        color: context.colors.cardBackground,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: context.colors.border, width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned.fill(
            child: Align(
              alignment: Alignment.center,
              child: Container(
                width: 8,
                decoration: BoxDecoration(
                  color: context.colors.border,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
          ),
          Positioned.fill(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: FractionallySizedBox(
                heightFactor: 0.65,
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: 8,
                  decoration: BoxDecoration(
                    color: context.colors.brandGreen,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ),
          ),

          Column(
            children: [
              _buildMapNode(
                context,
                title: S.of(context).sentencesUnit,
                isLocked: true,
                isActive: false,
                isCompleted: false,
                color: context.colors.textTertiary,
                icon: Icons.lock_rounded,
                alignment: Alignment.centerRight,
              ),
              const SizedBox(height: 32),
              _buildMapNode(
                context,
                title: S.of(context).wordsUnit2,
                isLocked: true,
                isActive: false,
                isCompleted: false,
                color: context.colors.textTertiary,
                icon: Icons.lock_rounded,
                alignment: Alignment.centerLeft,
              ),
              const SizedBox(height: 32),
              _buildMapNode(
                context,
                title: S.of(context).wordsUnit1,
                isLocked: false,
                isActive: true,
                isCompleted: false,
                color: context.colors.brandBlue,
                icon: Icons.play_arrow_rounded,
                alignment: Alignment.centerRight,
              ),
              const SizedBox(height: 32),
              _buildMapNode(
                context,
                title: S.of(context).lettersUnit2,
                isLocked: false,
                isActive: false,
                isCompleted: true,
                color: context.colors.brandGreen,
                icon: Icons.check_rounded,
                alignment: Alignment.centerLeft,
              ),
              const SizedBox(height: 32),
              _buildMapNode(
                context,
                title: S.of(context).lettersUnit1,
                isLocked: false,
                isActive: false,
                isCompleted: true,
                color: context.colors.brandGreen,
                icon: Icons.check_rounded,
                alignment: Alignment.centerRight,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMapNode(
    BuildContext context, {
    required String title,
    required bool isLocked,
    required bool isActive,
    required bool isCompleted,
    required Color color,
    required IconData icon,
    required Alignment alignment,
  }) {
    return Align(
      alignment: alignment,
      child: FractionallySizedBox(
        widthFactor: 0.6,
        child: Row(
          mainAxisAlignment: alignment == Alignment.centerLeft
              ? MainAxisAlignment.end
              : MainAxisAlignment.start,
          children: [
            if (alignment == Alignment.centerLeft) ...[
              _buildNodeLabel(context, title, isActive, color),
              const SizedBox(width: 16),
            ],
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: isLocked ? context.colors.cardBackground : color,
                shape: BoxShape.circle,
                border: Border.all(
                  color: isLocked ? context.colors.border : color,
                  width: 3,
                ),
                boxShadow: isActive
                    ? [
                        BoxShadow(
                          color: color.withOpacity(0.4),
                          blurRadius: 16,
                          spreadRadius: 4,
                        ),
                      ]
                    : [],
              ),
              child: Center(
                child: Icon(
                  icon,
                  color: isLocked ? context.colors.textTertiary : Colors.white,
                  size: 28,
                ),
              ),
            ),
            if (alignment == Alignment.centerRight) ...[
              const SizedBox(width: 16),
              _buildNodeLabel(context, title, isActive, color),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildNodeLabel(
    BuildContext context,
    String title,
    bool isActive,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: isActive
            ? color.withOpacity(0.1)
            : context.colors.cardBackground,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isActive ? color : context.colors.border,
          width: 2,
        ),
      ),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w800,
          color: isActive ? color : context.colors.textTertiary,
        ),
      ),
    );
  }

  Widget _buildTrophyRoom(BuildContext context) {
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

        final firstWinUnlocked = completedLessons > 0;
        final speedyUnlocked = completedLessons >= 2;
        final streakUnlocked = streakDays >= 3;
        final wordsUnlocked = completedLessons >= 4;
        final numbersUnlocked = completedLessons >= 6;
        final masterUnlocked = completedLessons >= 10;

        return Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: context.colors.cardBackground,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: context.colors.border, width: 2),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.04),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: GridView.count(
            crossAxisCount: 3,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 20,
            crossAxisSpacing: 16,
            childAspectRatio: 0.8,
            children: [
              _buildTrophyBadge(context, S.of(context).trophyFirstWin, '🌟', firstWinUnlocked),
              _buildTrophyBadge(context, S.of(context).trophySpeedy, '⚡', speedyUnlocked),
              _buildTrophyBadge(context, S.of(context).trophyStreak3, '🔥', streakUnlocked),
              _buildTrophyBadge(context, S.of(context).trophyWords, '📖', wordsUnlocked),
              _buildTrophyBadge(context, S.of(context).trophyNumbers, '🔢', numbersUnlocked),
              _buildTrophyBadge(context, S.of(context).trophyMaster, '👑', masterUnlocked),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTrophyBadge(
    BuildContext context,
    String title,
    String emoji,
    bool unlocked,
  ) {
    return Column(
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: unlocked
                  ? context.colors.brandYellow.withOpacity(0.2)
                  : context.colors.border.withOpacity(0.5),
              shape: BoxShape.circle,
              border: Border.all(
                color: unlocked
                    ? context.colors.brandYellow
                    : context.colors.border,
                width: 3,
              ),
              boxShadow: unlocked
                  ? [
                      BoxShadow(
                        color: context.colors.brandYellow.withOpacity(0.3),
                        blurRadius: 12,
                      ),
                    ]
                  : [],
            ),
            child: Center(
              child: Opacity(
                opacity: unlocked ? 1.0 : 0.3,
                child: Text(emoji, style: const TextStyle(fontSize: 32)),
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          title,
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w700,
            color: unlocked
                ? context.colors.textSecondary
                : context.colors.textTertiary,
          ),
        ),
      ],
    );
  }

  Widget _buildJumpBackInCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: context.colors.brandRed.withOpacity(0.1),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: context.colors.brandRed.withOpacity(0.3),
          width: 2,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: context.colors.cardBackground,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: context.colors.brandRed.withOpacity(0.2),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: const Center(
              child: Text('🛒', style: TextStyle(fontSize: 40)),
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  S.of(context).supermarketTitle,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                    color: context.colors.textPrimary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  S.of(context).supermarketDesc,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: context.colors.textSecondary,
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      final mainNavState = context
                          .findAncestorStateOfType<MainNavigationScreenState>();
                      if (mainNavState != null) {
                        mainNavState.setIndex(0);
                      } else {
                        Navigator.pushReplacementNamed(
                          context,
                          AppRoutes.subjectsGridView,
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: context.colors.brandRed,
                      foregroundColor: Colors.white,
                      elevation: 4,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: Text(
                      S.of(context).playAgain,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
