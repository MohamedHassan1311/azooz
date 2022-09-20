import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app.dart';
import 'common/config/keys.dart';
import 'common/routes/app_router_import.gr.dart';
import 'generated/codegen_loader.g.dart';
import 'utils/util_shared.dart';

String? currentRoute = '';
Object? currentRouteArgs = '';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  await UtilShared.init();

  UtilShared.instance.setBool(notificationTypeKey, false);
  await EasyLocalization.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Color.fromARGB(0, 255, 255, 255),
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );

  SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp],
  );

  // make sure you register it as a Singleton or a lazySingleton
  getIt.registerSingleton<AppRouter>(AppRouter());

  runApp(
    EasyLocalization(
      supportedLocales: const [
        Locale('en', ''),
        Locale('ar', ''),
      ],
      path: 'assets/locale/',
      fallbackLocale: const Locale('ar', ''),
      startLocale: const Locale('ar', ''),
      useFallbackTranslations: true,
      assetLoader: const CodegenLoader(),
      saveLocale: true,
      child: const MyApp(),
    ),
  );
}
