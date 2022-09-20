import 'package:azooz/app.dart';
import 'package:azooz/common/routes/app_router_control.dart';
import 'package:flutter/material.dart';

import '../../model/screen_argument/order_confirm_argument.dart';
import '../../view/screen/auth/fcm_notification_model.dart';
import '../../view/screen/home/home_screen.dart';
import '../routes/app_router_import.gr.dart';
import 'push_notification/notification_types.dart';

Future<void> navigateToScreen(
    BuildContext context, FCMNotificationModel notificationModel) async {
  String index = notificationModel.notificationType!;
  switch (index) {
    case NotificationTypes.openHomePage:
      getIt<AppRouter>().push(
        NavigationManagerRoute(
          selectedIndex: 0,
        ),
      );
      break;

    case NotificationTypes.refreshClientActiveOrdersPage:
      getIt<AppRouter>().push(
        NavigationManagerRoute(
          selectedIndex: 3,
        ),
      );
      break;

    case NotificationTypes.refreshClientOrderOffersPage:
      print("I am 3333 ##");
      getIt<AppRouter>().push(
        OrderConfirmRoute(
          argument: OrderConfirmArgument(
            orderID: int.parse(notificationModel.orderID!),
            storeName: "3333",
          ),
        ),
      );
      break;

    case NotificationTypes.openNotificationPage:
      getIt<AppRouter>().push(const NotificationRoute());
      break;

    case NotificationTypes.openClientChatPage:
      getIt<AppRouter>().push(
        ChatScreenRoute(
          orderID: int.parse(notificationModel.orderID!),
          chatID: int.parse(notificationModel.chatId!),
        ),
      );
      break;

    case NotificationTypes.openCustomerService:
      getIt<AppRouter>().push(const CustomerServiceRoute());
      break;

    case NotificationTypes.openClientCanceldOrders:
      getIt<AppRouter>().push(
        NavigationManagerRoute(
          selectedIndex: 3,
        ),
      );
      break;
  }
}

Future<dynamic> showDialogAlert(BuildContext context, String? currentRoute) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Current Route"),
          content: Text("$currentRoute"),
          actions: [
            TextButton(
              child: const Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      });
}

Future<void> navigateToScreenFromSplashScreen(
    BuildContext context, FCMNotificationModel notificationModel) async {
  String index = notificationModel.notificationType!;
  switch (index) {
    case NotificationTypes.openHomePage:
      routerPushAndPopUntil(
        context: context,
        route: NavigationManagerRoute(
          selectedIndex: 0,
        ),
      );
      break;
    case NotificationTypes.refreshClientActiveOrdersPage:
      routerPushAndPopUntil(
        context: context,
        route: NavigationManagerRoute(
          selectedIndex: 3,
        ),
      );
      break;
    case NotificationTypes.refreshClientOrderOffersPage:
      routerPushAndPopUntil(
        context: context,
        route: OrderConfirmRoute(
          argument: OrderConfirmArgument(
            orderID: int.parse(notificationModel.orderID!),
            storeName: notificationModel.details?.store?.name,
          ),
        ),
      );
      break;
    case NotificationTypes.openNotificationPage:
      getIt<AppRouter>().push(const NotificationRoute());
      break;
    case NotificationTypes.openClientChatPage:
      getIt<AppRouter>().push(
        ChatScreenRoute(
            chatID: int.parse(notificationModel.chatId.toString()),
            orderID: int.parse(notificationModel.orderID!)),
      );
      break;
    case NotificationTypes.openCustomerService:
      getIt<AppRouter>().push(const CustomerServiceRoute());
      break;
    case NotificationTypes.openClientCanceldOrders:
      getIt<AppRouter>().pushNativeRoute(
        MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        ),
      );
      break;
  }
}
