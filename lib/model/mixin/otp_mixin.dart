import 'package:flutter/material.dart';

import '../response/verification_model.dart';

mixin OTPMixin {
  Future<VerificationModel> postData({
    required String? phone,
    required int? securityCode,
    required BuildContext context,
  });

  countDown() {}

  timerDispose() {}

  timerRestart(){}
}
