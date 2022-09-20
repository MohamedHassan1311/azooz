import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'common/config/notification_types.dart';
import 'view/screen/auth/fcm_notification_model.dart';

class LocalNotificationServices extends ChangeNotifier {
  final FlutterLocalNotificationsPlugin _localNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  late AndroidNotificationChannel channel;
  late FCMNotificationModel notificationModel;
  bool _isInitialized = false;

  bool get isItNotification => _isInitialized;

  set setItsNotification(bool value) {
    _isInitialized = value;
    notifyListeners();
  }

  void init(BuildContext context) async {
    InitializationSettings initializationSettings =
        const InitializationSettings(
      android: AndroidInitializationSettings(
        "@drawable/ic_skylight_notification",
      ),
      iOS: IOSInitializationSettings(),
    );
    _localNotificationsPlugin.initialize(
      initializationSettings,
      onSelectNotification: (payload) {
        print("## -- Notification payload :: $payload -- ##");
        // TODO: ON SCREEN NOTIFICATION
        if (payload != null) {
          Map<String, dynamic> data = json.decode(payload);
          print("#### -- Notification data :: $data -- ##");
          FCMNotificationModel payloadData =
              FCMNotificationModel.fromPayload(data);
          navigateToScreen(context, payloadData);
        }
      },
    );
  }

  void display(RemoteMessage message) async {
    try {
      final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;
      notificationModel = FCMNotificationModel.fromJson(message.data);
      NotificationDetails notificationDetails = const NotificationDetails(
        android: AndroidNotificationDetails(
          "MainActivity",
          "AzoozApp",
          importance: Importance.max,
          priority: Priority.high,
        ),
        iOS: IOSNotificationDetails(),
      );

      final RemoteNotification? notification = message.notification;
      final AndroidNotification? android = notification?.android;

      String payloadNotificationData = notificationModel.toJsonString();

      if (notification != null && android != null) {
        await _localNotificationsPlugin.show(
          id,
          notificationModel.title,
          notificationModel.body,
          notificationDetails,
          payload: payloadNotificationData,
        );
      }
    } on Exception {
      print("Failed to show notification");
    }
  }
}
