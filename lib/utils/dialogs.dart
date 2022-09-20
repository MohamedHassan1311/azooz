import 'package:azooz/common/custom_waiting_dialog.dart';
import 'package:azooz/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../app.dart';
import '../common/circular_progress.dart';
import '../common/style/dimens.dart';

circularDialog(BuildContext context) {
  WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    showDialog(
        context: context,
        builder: (context) {
          return Center(
            child: Container(
              width: 90,
              height: 90,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                color: Colors.black87,
                // color: Colors.transparent,
                borderRadius: kBorderRadius5,
              ),
              child: const CustomProgressIndicator(isDismissible: false),
            ),
          );
        });
  });
}

dismissDialog(context) {
  if (context != null) {
    Navigator.of(context, rootNavigator: true).pop();
  }
}

errorDialog(BuildContext context, String? message) {
  return showDialog(
      context: context,
      builder: (context) {
        return SmartSingleAlertDialog(
          description: message.toString(),
          cancelPress: () {
            dismissDialog(getItContext);
          },
          cancelText: LocaleKeys.ok.tr(),
        );
      });
}

successDialog(BuildContext context, String message) {
  return showDialog(
      context: context,
      builder: (context) {
        return SmartSingleAlertDialog(
          description: message,
          cancelPress: () {
            dismissDialog(getItContext);
          },
          cancelText: LocaleKeys.ok.tr(),
        );
      });
}

Future successDialogWithTimer(BuildContext context) {
  showDialog(
      context: context,
      builder: (context) {
        return SmartAlertWithDescription(
          description: LocaleKeys.successfully.tr(),
        );
      });
  return Future.delayed(const Duration(milliseconds: 750), () {
    dismissDialog(getItContext);
  });
}
