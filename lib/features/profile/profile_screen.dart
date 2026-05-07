import 'package:edufocus/core/themes/app_colors.dart';
import 'package:edufocus/widgets/custom_bottom_nav_bar.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _sfxEnabled = true;
  bool _musicEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundLight,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'My Profile',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w900,
            color: AppColors.slate900,
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
              _buildAchievementsSection(),
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
      bottomSheet: CustomBottomNavBar(
        currentIndex: 2,
        onTap: (index) {
          if (index == 0) {
            Navigator.pushReplacementNamed(context, '/subjects_grid_view');
          } else if (index == 1) {
            Navigator.pushReplacementNamed(context, '/progress');
          }
        },
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w800,
        color: AppColors.slate900,
      ),
    );
  }

  Widget _buildUserCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.brandBlue, Color(0xFF5B9BD5)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: AppColors.brandBlue.withOpacity(0.3),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: CircleAvatar(
              radius: 48,
              backgroundColor: AppColors.slate100,
              // Fallback to a fun icon if no image
              child: const Text('🦁', style: TextStyle(fontSize: 50)),
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Youssef Ahmed',
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.w900,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: AppColors.brandYellow,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Text(
              'Level 5 - Letter Hero',
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
  }

  Widget _buildAchievementsSection() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _buildAchievementCard(
                'Total Points',
                '1,250',
                Icons.stars_rounded,
                AppColors.brandYellow,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildAchievementCard(
                'Games Won',
                '42',
                Icons.emoji_events_rounded,
                AppColors.brandOrange,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppColors.slate200, width: 2),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    'Next Level Progress',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: AppColors.slate700,
                    ),
                  ),
                  Text(
                    '80%',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w900,
                      color: AppColors.brandGreen,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: LinearProgressIndicator(
                  value: 0.8,
                  backgroundColor: AppColors.slate100,
                  valueColor: const AlwaysStoppedAnimation<Color>(
                    AppColors.brandGreen,
                  ),
                  minHeight: 12,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppColors.slate200, width: 2),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Badges',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: AppColors.slate700,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildBadge('🍎', 'First Word'),
                  _buildBadge('⭐', 'Perfect Score'),
                  _buildBadge('🔥', '3 Day Streak'),
                  _buildBadge('🧩', 'Puzzle Master'),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildBadge(String emoji, String title) {
    return Column(
      children: [
        Container(
          height: 56,
          width: 56,
          decoration: BoxDecoration(
            color: AppColors.slate100,
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.slate200, width: 2),
          ),
          child: Center(
            child: Text(emoji, style: const TextStyle(fontSize: 28)),
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          width: 64,
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: AppColors.slate500,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAchievementCard(
      String title, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.slate200, width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 32),
          const SizedBox(height: 12),
          Text(
            value,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w900,
              color: AppColors.slate900,
            ),
          ),
          Text(
            title,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: AppColors.slate500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAdaptiveSettings() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.slate200, width: 2),
      ),
      child: Column(
        children: [
          _buildSettingsTile(
            icon: Icons.remove_red_eye_rounded,
            title: 'Eye-Tracking Calibration',
            subtitle: 'Recalibrate tracking precision',
            iconColor: AppColors.brandPurple,
            trailing: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.brandPurple.withOpacity(0.1),
                foregroundColor: AppColors.brandPurple,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text('Calibrate',
                  style: TextStyle(fontWeight: FontWeight.w700)),
            ),
          ),
          const Divider(height: 1, color: AppColors.slate200),
          _buildSettingsTile(
            icon: Icons.music_note_rounded,
            title: 'Background Music',
            iconColor: AppColors.brandCyan,
            trailing: Switch(
              value: _musicEnabled,
              activeColor: AppColors.brandCyan,
              onChanged: (val) => setState(() => _musicEnabled = val),
            ),
          ),
          const Divider(height: 1, color: AppColors.slate200),
          _buildSettingsTile(
            icon: Icons.volume_up_rounded,
            title: 'Sound Effects',
            iconColor: AppColors.brandOrange,
            trailing: Switch(
              value: _sfxEnabled,
              activeColor: AppColors.brandOrange,
              onChanged: (val) => setState(() => _sfxEnabled = val),
            ),
          ),
          const Divider(height: 1, color: AppColors.slate200),
          _buildSettingsTile(
            icon: Icons.text_fields_rounded,
            title: 'Text & Icon Size',
            subtitle: 'Adjust for better visibility',
            iconColor: AppColors.brandRed,
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.remove_circle_outline),
                  color: AppColors.slate400,
                  onPressed: () {},
                ),
                const Text('A',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                IconButton(
                  icon: const Icon(Icons.add_circle_outline),
                  color: AppColors.slate400,
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
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.slate200, width: 2),
      ),
      child: Column(
        children: [
          _buildSettingsTile(
            icon: Icons.edit_rounded,
            title: 'Edit Profile',
            iconColor: AppColors.brandBlue,
            onTap: () {},
            trailing: const Icon(Icons.chevron_right_rounded,
                color: AppColors.slate400),
          ),
          const Divider(height: 1, color: AppColors.slate200),
          _buildSettingsTile(
            icon: Icons.language_rounded,
            title: 'Change Language',
            subtitle: 'English',
            iconColor: AppColors.brandGreen,
            onTap: () {},
            trailing: const Icon(Icons.chevron_right_rounded,
                color: AppColors.slate400),
          ),
          const Divider(height: 1, color: AppColors.slate200),
          _buildSettingsTile(
            icon: Icons.logout_rounded,
            title: 'Logout',
            iconColor: AppColors.brandRed,
            titleColor: AppColors.brandRed,
            onTap: () {
              // Navigate back to splash or auth
              Navigator.pushNamedAndRemoveUntil(context, '/', (r) => false);
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
                      color: titleColor ?? AppColors.slate700,
                    ),
                  ),
                  if (subtitle != null) ...[
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: AppColors.slate500,
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
