import '../../../common/config/assets.dart';
import '../../../common/config/keys.dart';
import '../../../common/routes/app_router_import.gr.dart';
import '../../../common/routes/app_router_control.dart';
import '../../../common/style/dimens.dart';
import '../../../common/style/style.dart';
import '../../../generated/locale_keys.g.dart';
import '../../../utils/util_shared.dart';
import '../../custom_widget/custom_button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class AuthSuccessfulScreen extends StatelessWidget {
  static const routeName = 'auth_successful';

  const AuthSuccessfulScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: edgeInsetsOnly(top: 70, bottom: 40),
                child: Text(
                  LocaleKeys.createAccountSuccessfullyMsg.tr(),
                  style: headline1,
                ),
              ),
              SizedBox(
                width: 250,
                child: successfulLogoImg,
              ),
              Padding(
                padding: edgeInsetsOnly(top: 50, bottom: 40),
                child: Text(
                  LocaleKeys.hello.tr(),
                  style: headline1,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: CustomButton(
                  text: LocaleKeys.next.tr(),
                  onPressed: () => {
                    UtilShared.saveBoolPreference(
                      key: keyLoggedIn,
                      value: true,
                    ),
                    routerPushAndPopUntil(
                      context: context,
                      route: const HomeRoute(),
                    ),
                  },
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
