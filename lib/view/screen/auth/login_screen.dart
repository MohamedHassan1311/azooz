import 'package:easy_localization/easy_localization.dart' as easy_localization;
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../../common/config/tools.dart';
import '../../../common/style/colors.dart';
import '../../../common/style/dimens.dart';
import '../../../generated/locale_keys.g.dart';
import '../../../providers/app_provider.dart';
import '../../../providers/login_provider.dart';
import '../../../utils/dialogs.dart';
import '../../widget/auth/bottom_sheet_login_widget.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = 'loginScreen';

  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController? mobileController = TextEditingController();
  String? codeCountry = '+966';

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    mobileController!.dispose();
    super.dispose();
  }

  submit() {
    Tools.hideKeyboard(context);
    mobileController!.text.isEmpty
        ? errorDialog(context, LocaleKeys.enterPhoneNumber.tr())
        : Provider.of<LoginProvider>(context, listen: false).postData(
            phone: '$codeCountry${mobileController?.text.trim()}',
            context: context,
          );
  }

  @override
  Widget build(BuildContext context) {
    String currentLang = context.watch<AppProvider>().locale;
    double heightSize = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.bottom -
        MediaQuery.of(context).padding.top;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            height: heightSize,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Change Language button
                Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: SizedBox(
                        width: 110,
                        child: ElevatedButton(
                          onPressed: () async {
                            if (currentLang == "en" &&
                                context.read<AppProvider>().locale == "en") {
                              Provider.of<AppProvider>(context, listen: false)
                                  .changeLanguage(
                                ctx: context,
                                langCode: 'ar',
                              );
                            } else {
                              Provider.of<AppProvider>(context, listen: false)
                                  .changeLanguage(
                                ctx: context,
                                langCode: 'en',
                              );
                            }
                          },
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Palette.primaryColor),
                            padding: MaterialStateProperty.all(
                              const EdgeInsets.symmetric(horizontal: 5),
                            ),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              const RoundedRectangleBorder(
                                borderRadius: kBorderRadius5,
                              ),
                            ),
                          ),
                          child: Text(
                            currentLang.isEmpty
                                ? "English"
                                : (currentLang == "ar" ? "English" : "عربي"),
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                            ),
                            maxLines: 2,
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                          ),
                        )),
                  ),
                ),
                Center(
                  child: Image.asset(
                    'assets/images/azooz_logo.png',
                    width: 300,
                    // height: 200,
                  ),
                ),

                BottomSheetLoginWidget(
                  controller: mobileController,
                  onChangedCountryCode: (countryCode) {
                    codeCountry = countryCode.toString();
                  },
                  onPressed: () => submit(),
                  phoneLength:
                      codeCountry != null && codeCountry == "+966" ? 9 : 10,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
