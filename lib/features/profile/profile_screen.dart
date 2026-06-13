import 'package:edufocus/core/themes/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:edufocus/generated/l10n.dart';

import 'widgets/profile_user_card.dart';
import 'widgets/profile_achievements.dart';
import 'widgets/profile_adaptive_settings.dart';
import 'widgets/profile_account_settings.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.background,
      appBar: AppBar(
        backgroundColor: context.colors.background,
        elevation: 0,
        centerTitle: true,
        title: Text(
          S.of(context).myProfile,
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
              const ProfileUserCard(),
              const SizedBox(height: 24),
              _buildSectionTitle(S.of(context).AchievementsRewards),
              const SizedBox(height: 16),
              const ProfileAchievements(),
              const SizedBox(height: 32),
              _buildSectionTitle(S.of(context).adaptiveSettings),
              const SizedBox(height: 16),
              const ProfileAdaptiveSettings(),
              const SizedBox(height: 32),
              _buildSectionTitle(S.of(context).AccountSettings),
              const SizedBox(height: 16),
              ProfileAccountSettings(
                onProfileEdited: () {
                  setState(() {});
                },
              ),
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
}
