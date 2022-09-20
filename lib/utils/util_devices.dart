// import 'dart:io';
//
// import 'package:device_info_plus/device_info_plus.dart';
// import 'package:flutter/material.dart';
//
// class UtilDevices {
//   static bool get isDesktop => !isWeb && (isWindows || isLinux || isMacOS);
//
//   static bool get isMobile => isAndroid || isIOS;
//
//   static bool get isWeb => kIsWeb;
//
//   static bool get isWindows => !isWeb && Platform.isWindows;
//
//   static bool get isLinux => !isWeb && Platform.isLinux;
//
//   static bool get isMacOS => !isWeb && Platform.isMacOS;
//
//   static bool get isAndroid => !isWeb && Platform.isAndroid;
//
//   static bool get isFuchsia => !isWeb && Platform.isFuchsia;
//
//   static bool get isIOS => !isWeb && Platform.isIOS;
//
//   static late AndroidDeviceInfo _androidInfo;
//   static late IosDeviceInfo _iosInfo;
//
//   static Future<void> initDeviceInfo() async {
//     final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
//     if (isAndroid) {
//       _androidInfo = await deviceInfo.androidInfo;
//     } else if (isIOS) {
//       _iosInfo = await deviceInfo.iosInfo;
//     }
//   }
//
//   static bool isDriverTest = false;
//
//   static int getAndroidSdkInt() {
//     if (isDriverTest) {
//       return -1;
//     }
//     if (isAndroid) {
//       return _androidInfo.version.sdkInt ?? -1;
//     } else {
//       return -1;
//     }
//   }
// }