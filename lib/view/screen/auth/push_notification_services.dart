import 'dart:async';

import 'package:azooz/app.dart';
import 'package:azooz/providers/chat_provider.dart';
import 'package:azooz/providers/offers_provider.dart';
import 'package:azooz/providers/orders_provider.dart';
import 'package:azooz/providers/user_provider.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../../../common/config/keys.dart';
import '../../../common/config/notification_types.dart';
import '../../../common/routes/app_router_import.gr.dart';
import '../../../notifications.dart';
import '../../../utils/util_shared.dart';
import 'fcm_notification_model.dart';

class PushNotificationServices {
  PushNotificationServices._();

  static final PushNotificationServices instance = PushNotificationServices._();

  static final FirebaseMessaging _fcm = FirebaseMessaging.instance;

  String? curerntScreenName(BuildContext context) {
    String? name = "";
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (ModalRoute.of(context) != null) {
        name = ModalRoute.of(context)?.settings.name;
      }
    });
    print("Current screen name:: $name ##");
    return name;
  }

  // Future initialise() async {
  //   // Requesting the permission from the user to show the notification
  //   NotificationSettings settings = await _fcm.requestPermission(
  //     alert: true,
  //     announcement: false,
  //     badge: true,
  //     carPlay: false,
  //     criticalAlert: false,
  //     provisional: false,
  //     sound: true,
  //   );

  //   // Continuosaly Listening to notification using [onMessage] stream
  //   if (settings.authorizationStatus == AuthorizationStatus.authorized) {
  //     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
  //       // Updating the local values
  //       if (message.notification != null) {}
  //     });
  //   } else if (settings.authorizationStatus ==
  //       AuthorizationStatus.provisional) {
  //   } else {}
  // }

  Future<void> init(BuildContext context) async {
    await _fcm.getInitialMessage().then((RemoteMessage? message) {
      print("## -- Message#1 init -- ##");
      if (message != null) {
        print("## -- Message#1 ${message.data} -- ##");

        FCMNotificationModel notificationModel =
            FCMNotificationModel.fromJson(message.data);

        navigateToScreenFromSplashScreen(context, notificationModel);
      }
    });
  }

  StreamSubscription<RemoteMessage> onMessage() {
    return FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        FCMNotificationModel notificationModel =
            FCMNotificationModel.fromJson(message.data);
        // print("NotificationModel1:: ${notificationModel.toJson()}");
        print("NotificationModel1:: ${notificationModel.toJson()}");

        print("Chat Idddd;: ${notificationModel.chatId}");
        print("Chat Idddd;: ${notificationModel.orderID}");

        final String? notificationType = notificationModel.notificationType;
        print("I naviation type:: $notificationType");

        // Update the UI
        if (getItContext != null) {
          var path = getIt<AppRouter>().currentPath;
          print(
              "I am currrent currentPath:: ${getIt<AppRouter>().currentPath}");
          print("I am currrent currentUrl:: ${getIt<AppRouter>().currentUrl}");
          final int index = getItContext!.read<UserProvider>().selectedIndex;
          print("I current page index:: $index");
          // Home Screen
          if (notificationType == "0" && index == 0) {
            print("Home Screen@@");
            // Active Orders Screen 3 & 4
          } else if ((notificationType == "4" || notificationType == "3") &&
              index == 3) {
            print("Drivers offers Screen || Orders Screen@@");
            getItContext!
                .read<OrdersProvider>()
                .refreshOrders(context: getItContext!, page: 1);

            // Refresh the drivers offers screen
          } else if (path == "order_confirm" && notificationType == "4") {
            print("Drivers offers screen@@");
            getItContext!.read<OffersProvider>().refresh(
                  getItContext!,
                  int.parse(
                    notificationModel.orderID!,
                  ),
                );

            // Chat History Screen
          } else if (path == "chat" && notificationType == "6") {
            print("Chat Screen@@");

            getItContext!.read<ChatProvider>().getChatMessage(
                  page: 1,
                  chatID: int.parse(notificationModel.chatId!),
                  context: getItContext!,
                );

            // Notification Screen
          } else if (path == "notification" && notificationType == "5") {
            print("Notification Screen@@");

            // Orders Canceled Screen
          } else if ((path == "orders_history" || path == "home") &&
              notificationType == "10" &&
              index == 3) {
            print("Orders Canceled Screen@@");
            // Customer Service Screen
          } else if (path == "customer_service" && notificationType == "9") {
            print("Customer Service Screen@@");
            // Show the notification
          } else {
            LocalNotificationServices().display(message);
          }
        }
      }
    });
  }

  StreamSubscription<RemoteMessage> onMessageOpened(BuildContext context) {
    return FirebaseMessaging.onMessageOpenedApp
        .listen((RemoteMessage? message) async {
      if (message != null) {
        print("## -- Message#33333 ${message.data} -- ##");
        String notificationType = message.data['notificationType'] as String;

        FCMNotificationModel notificationModel =
            FCMNotificationModel.fromJson(message.data);

        UtilShared.instance.setBool(notificationTypeKey, true);
        navigateToScreen(context, notificationModel);
        UtilShared.instance.setBool(notificationTypeKey, false);
      }
    });
  }
}
