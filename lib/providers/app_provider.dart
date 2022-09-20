import '../common/config/keys.dart';
import '../common/config/tools.dart';
import '../utils/util_shared.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class AppProvider with ChangeNotifier {
  List languageCode = ["en", "ar"];
  List countryCode = ["US", "AR"];

  // bool darkTheme = false;

  String locale = 'en';

  Future<void> changeLanguage({
    required BuildContext ctx,
    required String langCode,
  }) async {
    await ctx.setLocale(Locale(langCode, ''));
    await UtilShared.saveStringPreference(key: keyLocale, value: langCode);
    locale = langCode;
    logger.i('Change Locale $locale');
    notifyListeners();
  }

  getConfig() async {
    locale = UtilShared.readStringPreference(key: keyLocale);
    logger.i('Locale in AppProvider [getConfig()] $locale');
    notifyListeners();
  }

  AppProvider() {
    getConfig();
  }
}
