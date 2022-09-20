import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../../common/routes/app_router_control.dart';
import '../../common/routes/app_router_import.gr.dart';

class NoInternetConnectionScreen extends StatefulWidget {
  const NoInternetConnectionScreen({Key? key}) : super(key: key);

  static const String routeName = 'no_internet_connection';
  @override
  NoInternetConnectionScreenState createState() => NoInternetConnectionScreenState();
}

class NoInternetConnectionScreenState extends State<NoInternetConnectionScreen> {
  late InternetChecker internetChecker;

  @override
  void initState() {
    super.initState();
    internetChecker = InternetChecker.getInstance();

    internetChecker.checker();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(30),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color.fromARGB(255, 250, 243, 243),
            ),
            child: const Icon(
              Icons.wifi_off_outlined,
              size: 150,
              color: Color.fromARGB(192, 222, 25, 25),
            ),
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 45),
            child: Center(
              child: Text(
                "No internet connection",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.subtitle1,
              ),
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          // Reload the page
          TextButton(
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 45, vertical: 10),
              backgroundColor: const Color.fromARGB(255, 235, 244, 236),
              elevation: 0.0,
            ),
            onPressed: () async {
              bool isConnected =
                  await InternetConnectionChecker().hasConnection;

              if (isConnected) {
                if (!mounted) return;
                routerPushAndPopUntil(
                  context: context,
                  route: const HomeRoute(),
                );
              }
            },
            child: const Text(
              "Try again",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color.fromARGB(255, 61, 172, 67),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class InternetChecker {
  static final InternetChecker _singleton = InternetChecker._internal();

  InternetChecker._internal();

  static InternetChecker getInstance() => _singleton;

  late bool hasConnection;

  late StreamSubscription<InternetConnectionStatus> listener;

  Future<void> dispose() async {
    await Future<void>.delayed(const Duration(seconds: 3));
    await listener.cancel();
  }

  _checkInternetConnection(InternetConnectionStatus status) async {
    hasConnection = await InternetConnectionChecker().hasConnection;
    switch (status) {
      case InternetConnectionStatus.connected:
        hasConnection = true;
        break;
      case InternetConnectionStatus.disconnected:
        hasConnection = false;
        break;
    }
  }

  Future<void> checker() async {
    listener = InternetConnectionChecker()
        .onStatusChange
        .listen(_checkInternetConnection);

    await dispose();
  }
}

class ConnectionUtil {
  static final ConnectionUtil _singleton = ConnectionUtil._internal();
  ConnectionUtil._internal();

  static ConnectionUtil getInstance() => _singleton;

  bool hasConnection = false;

  StreamController connectionChangeController = StreamController();

  final Connectivity _connectivity = Connectivity();
  void initialize() {
    _connectivity.onConnectivityChanged.listen(_connectionChange);
  }

  void _connectionChange(ConnectivityResult result) {
    _hasInternetInternetConnection();
  }

  Stream get connectionChange => connectionChangeController.stream;
  Future<bool> _hasInternetInternetConnection() async {
    bool previousConnection = hasConnection;
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      // this is the different
      if (await InternetConnectionChecker().hasConnection) {
        hasConnection = true;
      } else {
        hasConnection = false;
      }
    } else {
      hasConnection = false;
    }

    if (previousConnection != hasConnection) {
      connectionChangeController.add(hasConnection);
    }
    return hasConnection;
  }
}
