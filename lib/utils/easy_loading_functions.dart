import '../generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

Future showLoading() => EasyLoading.show(dismissOnTap: false);

Future dismissLoading() => EasyLoading.dismiss();

Future showError({
  String? msg = '',
  int? durationMilliseconds = 1500,
}) =>
    EasyLoading.showError(
      msg! == '' ? LocaleKeys.errorHappened.tr() : msg,
      duration: Duration(
        milliseconds: durationMilliseconds!,
      ),
      dismissOnTap: true,
    );

Future showInfo({
  String? msg = '',
  int? durationMilliseconds = 800,
}) =>
    EasyLoading.showInfo(
      msg! == '' ? LocaleKeys.warning.tr() : msg,
      duration: Duration(
        milliseconds: durationMilliseconds!,
      ),
      dismissOnTap: true,
    );

Future showToast({
  String? msg = '',
  int? durationMilliseconds = 800,
}) =>
    EasyLoading.showToast(
      msg! == '' ? LocaleKeys.messages.tr() : msg,
      duration: Duration(
        milliseconds: durationMilliseconds!,
      ),
      dismissOnTap: true,
    );

// Future showSuccess({
//   String? msg = '',
//   int? durationMilliseconds = 800,
// }) =>
//     EasyLoading.showSuccess(
//       msg! == '' ? LocaleKeys.successfully.tr() : msg,
//       duration: Duration(
//         milliseconds: durationMilliseconds!,
//       ),
//       dismissOnTap: true,
//     );
