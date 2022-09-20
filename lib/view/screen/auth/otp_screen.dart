import '../../../common/config/assets.dart';
import '../../../common/config/tools.dart';
import '../../../common/style/colors.dart';
import '../../../common/style/dimens.dart';
import '../../../generated/locale_keys.g.dart';
import '../../../model/response/login_model.dart';
import '../../../providers/otp_provider.dart';
import '../../../utils/dialogs.dart';
import '../../custom_widget/custom_button.dart';
import '../../widget/auth/otp_code_widget.dart';
import 'package:easy_localization/easy_localization.dart' as easy_localization;
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class OTPScreen extends StatefulWidget {
  static const routeName = 'otp';
  final LoginModel? loginModel;

  const OTPScreen({
    Key? key,
    this.loginModel,
  }) : super(key: key);

  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  String? otpCode = '';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => Provider.of<OTPProvider>(context, listen: false).countDown(),
    );
  }

  @override
  void dispose() {
    // Provider.of<OTPProvider>(context, listen: false).timerDispose();
    super.dispose();
  }

  submit() {
    Tools.hideKeyboard(context);
    otpCode!.isEmpty
        ? errorDialog(context, LocaleKeys.verificationCodeMsg.tr())
        : Provider.of<OTPProvider>(context, listen: false).postData(
            phone: widget.loginModel?.result!.phone,
            securityCode: int.parse(otpCode!),
            context: context,
          );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Provider.of<OTPProvider>(context, listen: false).timerRestart();
        Navigator.pop(context);
        return true as Future<bool>;
      },
      child: Scaffold(
        // resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: edgeInsetsOnly(top: 25, bottom: 15),
                    child: Text(
                      LocaleKeys.verificationCode.tr(),
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                  ),
                  SizedBox(
                    width: 180,
                    child: otpLogoImg,
                  ),
                  Padding(
                    padding: edgeInsetsAll(10.0),
                    child: Text(
                      LocaleKeys.sentCodeToNumber.tr(),
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Palette.secondaryLight),
                    ),
                  ),
                  Padding(
                    padding: edgeInsetsAll(5.0),
                    child: Text(
                      widget.loginModel == null
                          ? ''
                          : widget.loginModel!.result!.phone.toString(),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: edgeInsetsSymmetric(horizontal: 35, vertical: 20),
                    child: Directionality(
                      textDirection: TextDirection.ltr,
                      child: OtpCodeWidget(
                        onCompleted: (value) => otpCode = value,
                      ),
                    ),
                  ),
                  Padding(
                    padding: edgeInsetsSymmetric(vertical: 40),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          LocaleKeys.resendCodeAfter.tr(),
                          textAlign: TextAlign.start,
                          style: const TextStyle(
                            decoration: TextDecoration.underline,
                            color: Palette.kAccent,
                          ),
                        ),
                        sizedBox(width: 5),
                        Consumer<OTPProvider>(
                          builder: (context, provider, child) {
                            return Text(
                              '0.${provider.count}',
                              textAlign: TextAlign.end,
                              style:
                                  const TextStyle(color: Palette.primaryColor),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  Text(
                      'For Test: ${widget.loginModel == null ? 'There is no Security Code' : widget.loginModel!.result!.securityCode}'),
                  const SizedBox(height: 20),
                  CustomButton(
                    width: MediaQuery.of(context).size.width * 0.94,
                    text: LocaleKeys.next.tr(),
                    onPressed: () => submit(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
