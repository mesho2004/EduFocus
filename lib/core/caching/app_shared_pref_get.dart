import 'package:edufocus/core/caching/app_shared_pref.dart';
import 'package:edufocus/core/caching/app_shared_pref_key.dart';

class AppSharedPrefGet {
  static bool getLang() {
    final lang = AppSharedPref.getData(key: AppSharedPrefKey.langKey);
    if (lang is bool) return lang;
    return lang == 'ar';
  }

  static bool getTheme() {
    final theme = AppSharedPref.getData(key: AppSharedPrefKey.themeKey);
    if (theme is bool) return theme;
    return theme == 'dark';
  }

  String getProfileImage() {
    final image = AppSharedPref.getData(key: AppSharedPrefKey.profileImageKey);
    if (image is String) return image;
    return '';
  }

  String getProfileName() {
    final name = AppSharedPref.getData(key: AppSharedPrefKey.profileNameKey);
    if (name is String) return name;
    return '';
  }

  String getProfileEmail() {
    final email = AppSharedPref.getData(key: AppSharedPrefKey.profileEmailKey);
    if (email is String) return email;
    return '';
  }

  static bool getEyeTracking() {
    final enabled = AppSharedPref.getData(key: AppSharedPrefKey.eyeTrackingKey);
    if (enabled is bool) return enabled;
    return false;
  }
}
