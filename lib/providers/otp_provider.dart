import 'dart:async';

import '../common/config/keys.dart';
import '../common/config/tools.dart';
import '../common/routes/app_router_control.dart';
import '../common/routes/app_router_import.gr.dart';
import '../model/error_model.dart';
import '../model/mixin/otp_mixin.dart';
import '../model/response/verification_model.dart';
import '../service/network/api_provider.dart';
import '../service/network/url_constants.dart';
import '../utils/delay.dart';
import '../utils/dialogs.dart';
import '../utils/easy_loading_functions.dart';
import '../utils/util_shared.dart';
import 'package:flutter/material.dart';

class OTPProvider extends ChangeNotifier with OTPMixin {
  final ApiProvider _apiProvider = ApiProvider.internal();
  late VerificationModel _verificationModel;
  late ErrorModel _errorModel;
  late Map? _body = {};

  Timer? timer;

  int count = 45;

  @override
  Future<VerificationModel> postData({
    required String? phone,
    required int? securityCode,
    required BuildContext context,
  }) async {
    circularDialog(context);
    _body = {
      "phone": phone,
      "securityCode": securityCode,
      "ruleId": 61,
    };
    await _apiProvider.post(
      apiRoute: verificationURL,
      successResponse: (response) {
        _verificationModel = VerificationModel.fromJson(response);
        UtilShared.saveStringPreference(
          key: keyToken,
          value: _verificationModel.result!.authorization!.toString(),
        );
        UtilShared.saveBoolPreference(
          key: keyLoggedIn,
          value: _verificationModel.result!.authorized!,
        );
        dismissDialog(context);
        successDialogWithTimer(context).then((value) {
          _verificationModel.result!.authorized == true
              ? routerPushAndPopUntil(
                  context: context,
                  route: const HomeRoute(),
                )
              : routerPush(
                  context: context,
                  route: const RegisterRoute(),
                );
        });
        notifyListeners();
      },
      errorResponse: (response) {
        _errorModel = ErrorModel.fromJson(response);
        dismissLoading().whenComplete(
          () => delayMilliseconds(
            250,
            () => errorDialog(context, _errorModel.message),
          ),
        );
        logger.e(response);
        notifyListeners();
      },
      data: _body,
    );

    return _verificationModel;
  }

  @override
  countDown() {
    const oneSec = Duration(seconds: 1);
    timer = Timer.periodic(
      oneSec,
      (time) {
        if (count == 0) {
          // timer?.cancel();
          count = 45;
          notifyListeners();
        } else {
          count--;
          notifyListeners();
        }
      },
    );
  }

  @override
  timerDispose() => timer!.cancel();

  @override
  timerRestart() {
    count = 45;
    timer!.cancel();
    notifyListeners();
  }
}
