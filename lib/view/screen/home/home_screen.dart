import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/services.dart';

import '../../../common/config/keys.dart';
import '../../../common/style/colors.dart';
import '../../../main.dart';
import '../../../providers/client_trips_provider.dart';
import '../../../providers/app_provider.dart';
import '../../../providers/location_provider.dart';
import '../../../providers/register_provider.dart';
import '../../../utils/util_shared.dart';
import 'navigation_manager.dart';
import '../../widget/drawer/drawer_widget.dart';

import 'package:flutter/material.dart';

import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = 'home';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ZoomDrawerController _zoomDrawerController = ZoomDrawerController();
  late StreamSubscription<ConnectivityResult> subscription;
  @override
  void initState() {
    super.initState();
    Provider.of<LocationProvider>(context, listen: false).handlePermission();
    Provider.of<ClientTripsProvider>(context, listen: false).disposeData();
    Provider.of<RegisterProvider>(context, listen: false).cityID = 0;
    UtilShared.instance.setBool(notificationTypeKey, false);
    // subscription = Connectivity()
    //     .onConnectivityChanged
    //     .listen((ConnectivityResult result) {
    //       print("I am connected to internet");
    //   // Got a new connectivity status!
    // });
  }

  @override
  void didChangeDependencies() {
    currentRoute = ModalRoute.of(context)?.settings.name;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // currentRoute = ModalRoute.of(context)?.settings.name;
    return WillPopScope(
      onWillPop: () {
        SystemNavigator.pop();
        exit(0);
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Consumer<AppProvider>(
          builder: (context, provider, child) {
            return SafeArea(
              child: ZoomDrawer(
                controller: _zoomDrawerController,
                style: DrawerStyle.Style1,
                menuScreen:
                    DrawerWidget(zoomDrawerController: _zoomDrawerController),
                mainScreen: const NavigationManager(),
                borderRadius: 24,
                showShadow: true,
                angle: provider.locale == 'en' ? -5 : -6,
                backgroundColor: Palette.kDarkAccent.withOpacity(0.4),
                slideWidth: provider.locale == 'en' ? 0.7 : 0.5,
                disableGesture: true,
                openCurve: Curves.easeInCubic,
                closeCurve: Curves.easeInCubic,
                isRtl: provider.locale == 'en' ? false : true,
                duration: const Duration(milliseconds: 250),
              ),
            );
          },
        ),
      ),
    );
  }
}
