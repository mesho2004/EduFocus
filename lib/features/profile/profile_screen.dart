import 'package:edufocus/core/caching/app_shared_pref.dart';
import 'package:edufocus/core/caching/app_shared_pref_key.dart';
import 'package:edufocus/core/themes/app_colors.dart';
import 'package:edufocus/core/themes/app_theme.dart';
import 'package:edufocus/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:edufocus/core/bloc/stars_cubit.dart';
import 'package:edufocus/features/auth/cubit/auth_cubit.dart';
import 'package:edufocus/core/bloc/curriculum_cubit.dart';
import 'package:edufocus/core/bloc/curriculum_state.dart';
import 'package:edufocus/core/utils/lego_character_helper.dart';
import 'package:edufocus/core/utils/widgets/lego_character_widget.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _trackEnabled = true;

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.background,
      appBar: AppBar(
        backgroundColor: context.colors.background,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'My Profile',
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
              _buildUserCard(),
              const SizedBox(height: 24),
              _buildSectionTitle('Achievements & Rewards'),
              const SizedBox(height: 16),
              _buildAchievementsSection(context),
              const SizedBox(height: 32),
              _buildSectionTitle('Adaptive Settings'),
              const SizedBox(height: 16),
              _buildAdaptiveSettings(),
              const SizedBox(height: 32),
              _buildSectionTitle('Account Settings'),
              const SizedBox(height: 16),
              _buildAccountSettings(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w800,
        color: context.colors.textPrimary,
      ),
    );
  }

  Widget _buildUserCard() {
    return BlocBuilder<CurriculumCubit, CurriculumState>(
      builder: (context, state) {
        final profile = state is CurriculumLoaded ? state.childProfile : null;
        final name = profile?.name ?? 'Champ';
        final age = profile?.age ?? 5;

        return FutureBuilder<Map<String, dynamic>>(
          future: LegoCharacterHelper.loadConfig(),
          builder: (context, legoSnapshot) {
            final config = legoSnapshot.data;
            final headIndex = config?['headIndex'] ?? 1;
            final hairIndex = config?['hairIndex'] ?? 1;
            final bodyIndex = config?['bodyIndex'] ?? 1;
            final legIndex = config?['legIndex'] ?? 1;
            final hatIndex = config?['hatIndex'] ?? 0;
            final torsoColor = config?['torsoColor'];
            final pantsColor = config?['pantsColor'];
            final hairColor = config?['hairColor'];

            return Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [context.colors.brandBlue, const Color(0xFF5B9BD5)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: context.colors.brandBlue.withValues(alpha: 0.3),
                    blurRadius: 16,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Container(
                    height: 120,
                    alignment: Alignment.center,
                    child: LegoCharacterWidget(
                      headIndex: headIndex,
                      hairIndex: hairIndex,
                      bodyIndex: bodyIndex,
                      legIndex: legIndex,
                      hatIndex: hatIndex,
                      torsoColor: torsoColor,
                      pantsColor: pantsColor,
                      hairColor: hairColor,
                      size: 64,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: context.colors.brandYellow,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      'Age: $age · Letter Hero',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                        color: AppColors.slate900,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildAchievementsSection(BuildContext context) {
    final stars = context.watch<StarsCubit>().state;
    return BlocBuilder<CurriculumCubit, CurriculumState>(
      builder: (context, state) {
        int completedLessons = 0;
        int streakDays = 0;
        if (state is CurriculumLoaded) {
          completedLessons = state.subjects.fold<int>(0, (s, sub) => s + sub.completedLessons);
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
                    'Total Points',
                    '$stars',
                    Icons.stars_rounded,
                    context.colors.brandYellow,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildAchievementCard(
                    'Games Won',
                    '$completedLessons',
                    Icons.emoji_events_rounded,
                    context.colors.brandOrange,
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
                    'Badges',
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
                      _buildBadge('🍎', 'First Word', firstWordUnlocked),
                      _buildBadge('⭐', 'Perfect Score', perfectScoreUnlocked),
                      _buildBadge('🔥', '3 Day Streak', streakUnlocked),
                      _buildBadge('🧩', 'Puzzle Master', puzzleMasterUnlocked),
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

  Widget _buildBadge(String emoji, String title, bool unlocked) {
    return Column(
      children: [
        Container(
          height: 56,
          width: 56,
          decoration: BoxDecoration(
            color: unlocked 
                ? context.colors.brandYellow.withValues(alpha: 0.15)
                : context.colors.border.withValues(alpha: 0.3),
            shape: BoxShape.circle,
            border: Border.all(
              color: unlocked ? context.colors.brandYellow : context.colors.border,
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
              color: unlocked ? context.colors.textPrimary : context.colors.textTertiary,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAchievementCard(
    String title,
    String value,
    IconData icon,
    Color color,
  ) {
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
          Icon(icon, color: color, size: 32),
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

  Widget _buildAdaptiveSettings() {
    return Container(
      decoration: BoxDecoration(
        color: context.colors.cardBackground,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: context.colors.border, width: 2),
      ),
      child: Column(
        children: [
          _buildSettingsTile(
            icon: Icons.remove_red_eye_rounded,
            title: 'Eye-Tracking mode',
            subtitle: 'Enable Eye-Tracking Mode',
            iconColor: context.colors.brandPurple,
            trailing: Switch(
              value: _trackEnabled,
              activeColor: context.colors.brandPurple,
              onChanged: (val) => setState(() => _trackEnabled = val),
            ),
          ),
          Divider(height: 1, color: context.colors.border),
          ValueListenableBuilder<bool>(
            valueListenable: isDark,
            builder: (context, darkEnabled, _) {
              return _buildSettingsTile(
                icon: Icons.dark_mode_rounded,
                title: 'Dark mode',
                iconColor: context.colors.brandPurple,
                trailing: Switch(
                  value: darkEnabled,
                  activeColor: context.colors.brandPurple,
                  onChanged: (val) async {
                    isDark.value = val;
                    await AppSharedPref.setPref(
                      value: val,
                      key: AppSharedPrefKey.themeKey,
                    );
                  },
                ),
              );
            },
          ),
          Divider(height: 1, color: context.colors.border),
          _buildSettingsTile(
            icon: Icons.text_fields_rounded,
            title: 'Text & Icon Size',
            subtitle: 'Adjust for better visibility',
            iconColor: context.colors.brandRed,
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.remove_circle_outline),
                  color: context.colors.textTertiary,
                  onPressed: () {},
                ),
                Text(
                  'A',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: context.colors.textPrimary,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.add_circle_outline),
                  color: context.colors.textTertiary,
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAccountSettings(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.colors.cardBackground,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: context.colors.border, width: 2),
      ),
      child: Column(
        children: [
          _buildSettingsTile(
            icon: Icons.edit_rounded,
            title: 'Edit Profile',
            iconColor: context.colors.brandBlue,
            onTap: () async {
              await Navigator.pushNamed(context, '/edit_profile');
              setState(() {});
            },
            trailing: Icon(
              Icons.chevron_right_rounded,
              color: context.colors.textTertiary,
            ),
          ),
          Divider(height: 1, color: context.colors.border),
          _buildSettingsTile(
            icon: Icons.language_rounded,
            title: 'Change Language',
            subtitle: 'English',
            iconColor: context.colors.brandGreen,
            onTap: () {},
            trailing: Icon(
              Icons.chevron_right_rounded,
              color: context.colors.textTertiary,
            ),
          ),
          Divider(height: 1, color: context.colors.border),
          _buildSettingsTile(
            icon: Icons.logout_rounded,
            title: 'Logout',
            iconColor: context.colors.brandRed,
            titleColor: context.colors.brandRed,
            onTap: () {
              context.read<AuthCubit>().logout();
              context.read<CurriculumCubit>().clearCurriculum();
              context.read<StarsCubit>().setStars(0);
              Navigator.pushNamedAndRemoveUntil(
                context,
                '/parent_auth',
                (r) => false,
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsTile({
    required IconData icon,
    required String title,
    String? subtitle,
    required Color iconColor,
    Color? titleColor,
    Widget? trailing,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: iconColor.withOpacity(0.15),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: iconColor, size: 24),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: titleColor ?? context.colors.textPrimary,
                    ),
                  ),
                  if (subtitle != null) ...[
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: context.colors.textSecondary,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            if (trailing != null) trailing,
          ],
        ),
      ),
    );
  }
}
