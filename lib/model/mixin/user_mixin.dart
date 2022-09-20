import 'package:flutter/material.dart';

mixin UserMixin {
  dynamic postFCM({
    required BuildContext context,
  }) {}

  dynamic logOut({
    required BuildContext context,
  }) {}

  dynamic deleteAccount({
    required BuildContext context,
  }) {}

  dynamic getDeviceData({required BuildContext context}) {}

  dynamic getToken() {}
}
