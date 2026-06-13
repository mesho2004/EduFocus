import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:edufocus/core/themes/app_theme.dart';
import 'package:edufocus/core/routes/app_routes.dart';
import 'package:edufocus/features/auth/data/cubit/auth_cubit.dart';
import 'package:edufocus/core/bloc/curriculum_cubit.dart';
import 'package:edufocus/core/bloc/stars_cubit.dart';
import 'package:edufocus/main.dart';
import 'package:edufocus/generated/l10n.dart';
import 'package:edufocus/core/caching/app_shared_pref.dart';
import 'package:edufocus/core/caching/app_shared_pref_key.dart';
import 'profile_settings_tile.dart';

class ProfileAccountSettings extends StatelessWidget {
  final VoidCallback onProfileEdited;

  const ProfileAccountSettings({
    super.key,
    required this.onProfileEdited,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.colors.cardBackground,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: context.colors.border, width: 2),
      ),
      child: Column(
        children: [
          ProfileSettingsTile(
            icon: Icons.edit_rounded,
            title: S.of(context).editProfile,
            iconColor: context.colors.brandBlue,
            onTap: () async {
              await Navigator.pushNamed(context, AppRoutes.editProfile);
              onProfileEdited();
            },
            trailing: Icon(
              Icons.chevron_right_rounded,
              color: context.colors.textTertiary,
            ),
          ),
          Divider(height: 1, color: context.colors.border),
          ValueListenableBuilder<bool>(
            valueListenable: isArabic,
            builder: (context, arabicEnabled, _) {
              return ProfileSettingsTile(
                icon: Icons.language_rounded,
                title: S.of(context).changeLanguage,
                subtitle: arabicEnabled ? 'العربية' : 'English',
                iconColor: context.colors.brandGreen,
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (dialogCtx) => AlertDialog(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                      title: Text(
                        S.of(context).selectLanguage,
                        style: const TextStyle(fontWeight: FontWeight.w900),
                      ),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ListTile(
                            title: const Text('English', style: TextStyle(fontWeight: FontWeight.bold)),
                            trailing: !arabicEnabled ? const Icon(Icons.check, color: Colors.green) : null,
                            onTap: () async {
                              isArabic.value = false;
                              await AppSharedPref.setPref(value: 'en', key: AppSharedPrefKey.langKey);
                              Navigator.pop(dialogCtx);
                            },
                          ),
                          ListTile(
                            title: const Text('العربية', style: TextStyle(fontWeight: FontWeight.bold)),
                            trailing: arabicEnabled ? const Icon(Icons.check, color: Colors.green) : null,
                            onTap: () async {
                              isArabic.value = true;
                              await AppSharedPref.setPref(value: 'ar', key: AppSharedPrefKey.langKey);
                              Navigator.pop(dialogCtx);
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
                trailing: Icon(
                  Icons.chevron_right_rounded,
                  color: context.colors.textTertiary,
                ),
              );
            },
          ),
          Divider(height: 1, color: context.colors.border),
          ProfileSettingsTile(
            icon: Icons.logout_rounded,
            title: S.of(context).logOut,
            iconColor: context.colors.brandRed,
            titleColor: context.colors.brandRed,
            onTap: () {
              context.read<AuthCubit>().logout();
              context.read<CurriculumCubit>().clearCurriculum();
              context.read<StarsCubit>().setStars(0);
              Navigator.pushNamedAndRemoveUntil(
                context,
                AppRoutes.parentAuth,
                (r) => false,
              );
            },
          ),
        ],
      ),
    );
  }
}
