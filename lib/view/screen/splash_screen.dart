import 'dart:async';

import 'package:azooz/view/screen/no_internet_connection_screen.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../common/circular_progress.dart';
import '../../common/config/keys.dart';
import '../../common/routes/app_router_control.dart';
import '../../common/routes/app_router_import.gr.dart';
import '../../notifications.dart';
import '../../utils/util_shared.dart';
import 'auth/push_notification_services.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  static const String routeName = 'initial';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  ConnectivityResult _connectionStatus = ConnectivityResult.wifi;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  @override
  void initState() {
    super.initState();
    initConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
      _updateConnectionStatus(result);
      _updateCurrentScreen(result);
    });
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  Future<void> initConnectivity() async {
    late ConnectivityResult result;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException {
      // developer.log('Couldn\'t check connectivity status', error: e);
      return;
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    setState(() {
      _connectionStatus = result;
    });
  }

  Future<void> _updateCurrentScreen(ConnectivityResult connectionResult) async {
    if (connectionResult != ConnectivityResult.none) {
      if (UtilShared.readBoolPreference(key: keyLoggedIn)) {
        LocalNotificationServices().init(context);
        PushNotificationServices.instance.init(context);
        PushNotificationServices.instance.onMessage();
        PushNotificationServices.instance.onMessageOpened(context);

        routerPushAndPopUntil(
          context: context,
          route: const HomeRoute(),
        );
      } else {
        routerPushAndPopUntil(
          context: context,
          route: const LoginScreenRoute(),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return _connectionStatus != ConnectivityResult.none
        ? Scaffold(
            // backgroundColor: Palette.primaryColor,
            backgroundColor: Colors.white,
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const SizedBox(height: 20),
                  SizedBox(
                    width: 220,
                    height: 220,
                    child: Center(
                      child: ClipOval(
                        child: Image.asset('assets/images/azooz_logo.png'),
                      ),
                    ),
                  ),
                  const CustomProgressIndicator(),
                ],
              ),
            ),
          )
        : const NoInternetConnectionScreen();
  }
}
