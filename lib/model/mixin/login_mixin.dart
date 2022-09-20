import 'package:flutter/material.dart';

import '../response/login_model.dart';

mixin LoginMixin {
  Future<LoginModel> postData({
    required String? phone,
    required BuildContext context,
  });
}