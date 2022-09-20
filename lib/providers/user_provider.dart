import 'dart:io';

import 'package:android_id/android_id.dart';

import '../app.dart';
import '../common/config/global.dart';
import '../common/config/keys.dart';
import '../common/config/tools.dart';
import '../common/routes/app_router_control.dart';
import '../common/routes/app_router_import.gr.dart';
import '../model/error_model.dart';
import '../model/mixin/user_mixin.dart';
import '../model/request/fcm_model.dart';
import '../utils/dialogs.dart';
import 'firebase_provider.dart';
import '../service/network/api_provider.dart';
import '../service/network/url_constants.dart';
import '../utils/delay.dart';
import '../utils/easy_loading_functions.dart';
import '../utils/util_shared.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:device_info_plus/device_info_plus.dart';

class UserProvider extends ChangeNotifier with UserMixin {
  final ApiProvider _apiProvider = ApiProvider.internal();
  static final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  final _androidIdPlugin = const AndroidId();

  late ErrorModel _errorModel;
  late FcmModel _fcmModel;
  String? _deviceType = '';
  String? _deviceID = '';
  String? _fcm = '';

  int _selectedIndex = 0;

  int get selectedIndex => _selectedIndex;

  set setSelectedIndex(int value) {
    _selectedIndex = value;
    notifyListeners();
  }

  @override
  Future<void> postFCM({
    required BuildContext context,
  }) async {
    _fcmModel = FcmModel(
      fcm: _fcm,
      mobileID: _deviceID,
      mobileType: _deviceType,
      userRule: userRole,
    );
    logger.d(
        'FCM Body: FCM => $_fcm & MobileID => $_deviceID & MobileType => $_deviceType & UserRule => 61');
    await _apiProvider.put(
      apiRoute: fcmURL,
      successResponse: (response) {
        notifyListeners();
      },
      errorResponse: (response) {
        _errorModel = ErrorModel.fromJson(response);
        errorDialog(context, _errorModel.message);
        logger.e(response);
        notifyListeners();
      },
      data: _fcmModel.toJson(),
    );
    notifyListeners();
  }

  @override
  Future<void> logOut({
    required BuildContext context,
  }) async {
    circularDialog(context);
    await _apiProvider.get(
      apiRoute: logoutURL,
      queryParameters: {
        "mobileID": _deviceID,
        'UserRule': userRole,
      },
      successResponse: (response) {
        dismissDialog(context);
        successDialogWithTimer(context).then((value) {
          UtilShared.saveStringPreference(key: keyToken, value: '');

          UtilShared.saveBoolPreference(key: keyLoggedIn, value: false);
          getItRouter.pushAndPopUntil(
            const LoginScreenRoute(),
            predicate: (route) => false,
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
        notifyListeners();
      },
    );
    notifyListeners();
  }

  @override
  Future<void> deleteAccount({
    required BuildContext context,
  }) async {
    circularDialog(context);
    await _apiProvider.get(
      apiRoute: deleteAccountURL,
      queryParameters: {
        'UserRule': userRole,
      },
      successResponse: (response) {
        dismissDialog(context);
        successDialogWithTimer(context).then((value) {
          UtilShared.saveStringPreference(key: keyToken, value: '');
          UtilShared.saveBoolPreference(key: keyLoggedIn, value: false);
          routerPushAndPopUntil(
            context: context,
            route: const LoginScreenRoute(),
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
        notifyListeners();
      },
    );
    notifyListeners();
  }

  @override
  Future<void> getDeviceData({
    required BuildContext context,
  }) async {
    await Provider.of<FirebaseProvider>(context, listen: false)
        .getToken()
        .then((value) {
      notifyListeners();
      return _fcm = value;
    });
    if (Platform.isIOS) {
      var iosDeviceInfo = await deviceInfo.iosInfo;
      _deviceType = 'IOS';
      _deviceID = iosDeviceInfo.identifierForVendor;
      notifyListeners();
    } else if (Platform.isAndroid) {
      // AndroidDeviceInfo androidDeviceInfo = await deviceInfo.androidInfo;
      final androidId = await _androidIdPlugin.getId();
      print("androidDeviceInfo - androidId: $androidId");
      _deviceType = 'ANDROID';
      _deviceID = androidId;
      notifyListeners();
    }
    notifyListeners();
  }
}
