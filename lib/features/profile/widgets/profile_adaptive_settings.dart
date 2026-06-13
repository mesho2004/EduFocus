import 'package:flutter/material.dart';
import 'package:edufocus/core/themes/app_theme.dart';
import 'package:edufocus/core/caching/app_shared_pref.dart';
import 'package:edufocus/core/caching/app_shared_pref_key.dart';
import 'package:edufocus/main.dart';
import 'package:edufocus/generated/l10n.dart';
import 'profile_settings_tile.dart';

class ProfileAdaptiveSettings extends StatelessWidget {
  const ProfileAdaptiveSettings({super.key});

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
          ValueListenableBuilder<bool>(
            valueListenable: isEyeTrackingEnabled,
            builder: (context, trackingEnabled, _) {
              return ProfileSettingsTile(
                icon: Icons.remove_red_eye_rounded,
                title: S.of(context).eyeMode,
                subtitle: S.of(context).eyeModeDescription,
                iconColor: context.colors.brandPurple,
                trailing: Switch(
                  value: trackingEnabled,
                  activeColor: context.colors.brandPurple,
                  onChanged: (val) async {
                    isEyeTrackingEnabled.value = val;
                    await AppSharedPref.setPref(
                      value: val,
                      key: AppSharedPrefKey.eyeTrackingKey,
                    );
                  },
                ),
              );
            },
          ),
          Divider(height: 1, color: context.colors.border),
          ValueListenableBuilder<bool>(
            valueListenable: isDark,
            builder: (context, darkEnabled, _) {
              return ProfileSettingsTile(
                icon: Icons.dark_mode_rounded,
                title: S.of(context).darkMode,
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
        ],
      ),
    );
  }
}
