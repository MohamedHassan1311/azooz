import '../common/config/tools.dart';
import '../model/mixin/user_mixin.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class FirebaseProvider extends ChangeNotifier with UserMixin {
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;
  String? _token = '';

  @override
  Future<String> getToken() async {
    _token = await _fcm.getToken();
    logger.d('Get Token: $_token');
    // notifyListeners();
    return _token!;
  }
}
