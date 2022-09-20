import 'dart:convert';

import '../common/style/app_theme.dart';
import 'util_shared.dart';

class ThemeSelection {
  static void saveTheme(AppTheme selectedTheme) async {
    // if (selectedTheme == null) {
    //   selectedTheme = AppTheme.lightTheme;
    // }

    String theme = jsonEncode(selectedTheme.toString());
    UtilShared.saveStringPreference(key: UtilShared.themeKey, value: theme);
  }

  static AppTheme getTheme() {
    String? theme = UtilShared.readStringPreference(key: UtilShared.themeKey);
    if (theme.isEmpty) {
      return AppTheme.lightTheme;
    }
    return getThemeFromString(jsonDecode(theme));
  }

  static AppTheme getThemeFromString(String themeString) {
    for (AppTheme theme in AppTheme.values) {
      if (theme.toString() == themeString) {
        return theme;
      }
    }
    return AppTheme.lightTheme;
  }
}
