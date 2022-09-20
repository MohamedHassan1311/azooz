import 'package:shared_preferences/shared_preferences.dart';

class UtilShared {
  static const String themeKey = 'selected_theme';

  static late final SharedPreferences instance;

  static Future<SharedPreferences> init() async =>
      instance = await SharedPreferences.getInstance();

  /// Read Integer
  static int readIntPreference({
    required String key,
  }) {
    return instance.getInt(key) ?? 0;
  }

  /// Read String
  static String readStringPreference({
    required String key,
  }) {
    return instance.getString(key) ?? '';
  }

  /// Read Boolean
  static bool readBoolPreference({
    required String key,
  }) {
    return instance.getBool(key) ?? false;
  }

  /// Save Integer
  static saveIntPreference({
    required String key,
    required int value,
  }) {
    instance.setInt(key, value);
  }

  /// Save String
  static saveStringPreference({
    required String key,
    required String value,
  }) {
    instance.setString(key, value);
  }

  /// Save Bool
  static saveBoolPreference({
    required String key,
    required bool value,
  }) {
    instance.setBool(key, value);
  }
}