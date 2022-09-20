import '../response/notification_model.dart';
import 'package:flutter/material.dart';

mixin NotificationMixin {
  Future<NotificationModel> getData({
    required int? page,
    required BuildContext context,
  });
}
