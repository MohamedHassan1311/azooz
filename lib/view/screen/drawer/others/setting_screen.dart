import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../common/style/colors.dart';
import '../../../../common/style/dimens.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../../../providers/app_provider.dart';

class SettingsScreen extends StatelessWidget {
  static const routeName = 'setting';

  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
          title: Text(
        LocaleKeys.setting.tr(),
      )),
      body: SafeArea(
        child: Padding(
          padding: edgeInsetsSymmetric(horizontal: 8),
          child: Column(
            children: [
              ListTile(
                leading: const Icon(Icons.language),
                title: Text(
                  LocaleKeys.arabic.tr(),
                ),
                iconColor: Palette.secondaryLight,
                onTap: () => Provider.of<AppProvider>(context, listen: false)
                    .changeLanguage(
                  ctx: context,
                  langCode: 'ar',
                ),
              ),
              ListTile(
                leading: const Icon(Icons.language),
                iconColor: Palette.secondaryLight,
                title: Text(
                  LocaleKeys.english.tr(),
                ),
                onTap: () {
                  Provider.of<AppProvider>(context, listen: false)
                      .changeLanguage(
                    ctx: context,
                    langCode: 'en',
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
