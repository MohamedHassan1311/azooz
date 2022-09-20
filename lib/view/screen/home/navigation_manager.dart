import 'package:azooz/common/routes/app_router_import.gr.dart';
import 'package:azooz/providers/client_trips_provider.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

import '../../../app.dart';
import '../../../common/config/assets.dart';
import '../../../common/style/colors.dart';
import '../../../common/style/dimens.dart';
import '../../../generated/locale_keys.g.dart';
import '../../../providers/app_provider.dart';
import '../../../providers/home_provider.dart';
import '../../../providers/profile_provider.dart';
import '../../../providers/user_provider.dart';
import '../../widget/drawer/drawer_widget.dart';
import 'favorite_screen.dart';
import 'stores_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'chat_history_screen.dart';
import 'driver_screen.dart';
import 'orders_history_screen.dart';

class NavigationManager extends StatefulWidget {
  const NavigationManager({
    Key? key,
    this.selectedIndex,
  }) : super(key: key);

  final int? selectedIndex;

  static const routeName = 'navManager';

  @override
  NavigationManagerState createState() => NavigationManagerState();
}

class NavigationManagerState extends State<NavigationManager> {
  int? valueCheck;

  final GlobalKey _scaffoldKey = GlobalKey<ScaffoldState>();

  ZoomDrawerController zoomController = ZoomDrawerController();

  @override
  void initState() {
    super.initState();

    Provider.of<UserProvider>(context, listen: false)
        .getDeviceData(context: context)
        .then(
      (value) {
        return Provider.of<UserProvider>(context, listen: false)
            .postFCM(context: context);
      },
    ).then((value) {});

    Provider.of<HomeProvider>(context, listen: false)
        .getAppStatus(context: context);

    Provider.of<ProfileProvider>(context, listen: false)
        .getData(context: context);

    if (mounted) {
      context.read<UserProvider>().setSelectedIndex = widget.selectedIndex ?? 0;
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    context.read<ClientTripsProvider>().disposeData();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    int currentIndex = context.watch<UserProvider>().selectedIndex;
    return Consumer<AppProvider>(builder: (context, provider, child) {
      return ZoomDrawer(
        controller: zoomController,
        style: DrawerStyle.Style1,
        borderRadius: 24,
        showShadow: true,
        angle: provider.locale == 'en' ? -5 : -6,
        backgroundColor: Palette.kDarkAccent.withOpacity(0.4),
        slideWidth:
            provider.locale == 'en' ? size.width * 0.7 : size.width * 0.5,
        disableGesture: true,
        openCurve: Curves.easeInCubic,
        closeCurve: Curves.easeInCubic,
        isRtl: provider.locale == 'en' ? false : true,
        duration: const Duration(milliseconds: 250),
        menuScreen: DrawerWidget(zoomDrawerController: zoomController),
        mainScreen: Scaffold(
          // backgroundColor: Palette.kSelectorColor,
          // extendBody: true,

          key: _scaffoldKey,
          resizeToAvoidBottomInset: false,
          appBar: _buildAppBars().elementAt(currentIndex),
          body: _buildScreens().elementAt(currentIndex),
          // body: SafeArea(
          //     child: _buildScreens()
          //         .elementAt(context.read<UserProvider>().selectedIndex)),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.miniCenterDocked,

          floatingActionButton: FittedBox(
            child: FloatingActionButton(
              onPressed: () => _onItemTapped(2),
              backgroundColor: context.read<UserProvider>().selectedIndex == 2
                  ? Palette.secondaryLight
                  : Palette.activeWidgetsColor,
              elevation: 3,
              child: sizedBox(
                height: 30,
                width: 30,
                child: context.read<UserProvider>().selectedIndex == 2
                    ? chat2SVG
                    : chatSVG,
              ),
            ),
          ),

          // bottomNavigationBar: BottomNavigationBar(
          //   currentIndex: context.read<UserProvider>().selectedIndex,
          //   backgroundColor: Colors.greenAccent,
          //   showUnselectedLabels: true,
          //   showSelectedLabels: true,
          //   // landscapeLayout: BottomNavigationBarLandscapeLayout.linear,
          //   type: BottomNavigationBarType.fixed,

          //   onTap: _onItemTapped,
          //   items: const [
          //     BottomNavigationBarItem(
          //       icon: Icon(Icons.home),
          //       label: "Home",
          //     ),
          //     BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          //     BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          //     BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          //     BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          //   ],
          // ),

          bottomNavigationBar: SafeArea(
            child: BottomAppBar(
              shape: const CircularNotchedRectangle(),
              notchMargin: 7,
              color: Palette.activeWidgetsColor,
              child: SizedBox(
                height: 60,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: _navBarsItems(context),
                ),
              ),
            ),
          ),
        ),
      );
    });
  }

  List<Widget> _buildScreens() {
    return [
      const DriverScreen(),
      const StoresScreen(),
      const ChatHistoryScreen(),
      const OrdersHistoryScreen(),
      const FavoriteScreen(),
    ];
  }

  List<PreferredSizeWidget> _buildAppBars() {
    var iconButton = IconButton(
        onPressed: () {
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) => const NotificationScreen(),
          //   ),
          // );
          getIt<AppRouter>().push(const NotificationRoute());
        },
        icon: alertSVG);
    return [
      AppBar(
        title: Consumer<ProfileProvider>(
          builder: (context, provider, child) {
            // return Text(
            //   LocaleKeys.meshwar.tr(),
            //   maxLines: 1,
            //   overflow: TextOverflow.ellipsis,
            //   textAlign: TextAlign.end,
            //   style: const TextStyle(color: Palette.secondaryLight),
            // );

            return Text(
              LocaleKeys.needRide.tr(),
              style: Theme.of(context).textTheme.subtitle1,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.end,
            );
          },
        ),
        leading: IconButton(
          onPressed: () => zoomController.toggle!(),
          icon: const Icon(Icons.menu),
        ),
        actions: [
          iconButton,
        ],
      ),
      AppBar(
        title: Consumer<ProfileProvider>(
          builder: (context, provider, child) {
            return Text(
              LocaleKeys.areYouHungary.tr(),
              style: Theme.of(context).textTheme.subtitle1,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.end,
            );
          },
        ),
        leading: IconButton(
          onPressed: () => zoomController.toggle!(),
          icon: const Icon(Icons.menu),
        ),
        actions: [
          iconButton,
        ],
      ),
      AppBar(
        title: Text(
          LocaleKeys.messages.tr(),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.end,
          style: Theme.of(context).textTheme.subtitle1,
        ),
        leading: IconButton(
          onPressed: () => zoomController.toggle!(),
          icon: const Icon(Icons.menu),
        ),
        actions: [
          iconButton,
        ],
      ),
      AppBar(
        title: Text(
          LocaleKeys.myOrders.tr(),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.end,
          style: Theme.of(context).textTheme.subtitle1,
        ),
        leading: IconButton(
          onPressed: () => zoomController.toggle!(),
          icon: const Icon(Icons.menu),
        ),
        actions: [
          iconButton,
        ],
      ),
      AppBar(
        title: Text(
          LocaleKeys.wishlist.tr(),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.end,
          style: Theme.of(context).textTheme.subtitle1,
        ),
        leading: IconButton(
          onPressed: () => zoomController.toggle!(),
          icon: const Icon(Icons.menu),
        ),
        actions: [
          IconButton(
              onPressed: () {
                getIt<AppRouter>().push(const NotificationRoute());
              },
              icon: alertSVG),
        ],
      ),
    ];
  }

  List<Widget> _navBarsItems(BuildContext context) {
    return [
      Expanded(
        child: TextButton(
          style: ButtonStyle(
            // overlayColor: MaterialStateProperty.all(kLightGrey),
            // foregroundColor: MaterialStateProperty.all(Palette.kBlack),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0),
              ),
            ),
            backgroundColor: MaterialStateProperty.all(
              context.read<UserProvider>().selectedIndex == 0
                  ? Palette.kSelectedBottom
                  : Palette.activeWidgetsColor,
              // Colors.orange,
            ),
          ),
          onPressed: () => _onItemTapped(0),
          child: Column(
            children: <Widget>[
              Expanded(child: driverSVG),
              Expanded(
                child: Text(
                  LocaleKeys.meshwar.tr(),
                  style: const TextStyle(
                    color: Palette.kBlack,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      Expanded(
        child: TextButton(
          style: ButtonStyle(
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0),
              ),
            ),
            backgroundColor: MaterialStateProperty.all(
              context.read<UserProvider>().selectedIndex == 1
                  ? Palette.kSelectedBottom
                  : Palette.activeWidgetsColor,
            ),
          ),
          onPressed: () => _onItemTapped(1),
          child: Column(
            children: <Widget>[
              Expanded(child: storesSVG),
              Expanded(
                child: Text(
                  LocaleKeys.stores.tr(),
                  style: const TextStyle(
                    color: Palette.kBlack,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      const Expanded(child: Text('')),
      Expanded(
        child: TextButton(
          style: ButtonStyle(
            // overlayColor: MaterialStateProperty.all(kLightGrey),
            // foregroundColor: MaterialStateProperty.all(Palette.kBlack),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0),
              ),
            ),
            backgroundColor: MaterialStateProperty.all(
              context.read<UserProvider>().selectedIndex == 3
                  ? Palette.kSelectedBottom
                  : Palette.activeWidgetsColor,
            ),
          ),
          onPressed: () => _onItemTapped(3),
          child: Column(
            children: <Widget>[
              Expanded(child: ordersSVG),
              Expanded(
                child: Text(
                  LocaleKeys.myOrders.tr(),
                  style: const TextStyle(
                    color: Palette.kBlack,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      Expanded(
        child: TextButton(
          style: ButtonStyle(
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0),
              ),
            ),
            backgroundColor: MaterialStateProperty.all(
              context.read<UserProvider>().selectedIndex == 4
                  ? Palette.kSelectedBottom
                  : Palette.activeWidgetsColor,
            ),
          ),
          onPressed: () => _onItemTapped(4),

          // _myPage.animateToPage(1,
          // duration: const Duration(milliseconds: 500), curve: Curves.ease),
          child: Column(
            children: <Widget>[
              Expanded(child: heart2SVG),
              Expanded(
                child: Text(
                  LocaleKeys.wishlist.tr(),
                  style: const TextStyle(
                    color: Palette.kBlack,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ];
  }

  void _onItemTapped(int index) {
    if (mounted) {
      context.read<UserProvider>().setSelectedIndex = index;
    }
  }
}
