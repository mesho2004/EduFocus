import 'package:shared_preferences/shared_preferences.dart';

class AppSharedPref {
  static late SharedPreferences _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static Future<void> setPref({
    required dynamic value,
    required String key,
  }) async {
    if (value is String) {
      await _prefs.setString(key, value);
    } else if (value is int) {
      await _prefs.setInt(key, value);
    } else if (value is bool) {
      await _prefs.setBool(key, value);
    } else if (value is double) {
      await _prefs.setDouble(key, value);
    }
  }

  static dynamic getData({required String key}) {
    return _prefs.get(key);
  }

  static Future<void> removeData({required String key}) async {
    await _prefs.remove(key);
  }
}
