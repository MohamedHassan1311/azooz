import 'dart:collection';

import 'package:flutter/material.dart';

import '../common/config/tools.dart';
import '../model/error_model.dart';
import '../model/mixin/notification_mixin.dart';
import '../model/response/notification_model.dart';
import '../service/network/api_provider.dart';
import '../service/network/url_constants.dart';
import '../utils/delay.dart';
import '../utils/dialogs.dart';
import '../utils/easy_loading_functions.dart';

class NotificationProvider extends ChangeNotifier with NotificationMixin {
  final ApiProvider _apiProvider = ApiProvider.internal();
  late ErrorModel _errorModel;
  late NotificationModel _notificationModel;
  List<NotificationData> _listNotification = [];

  bool loadingPagination = false;
  bool endPage = false;

  @override
  Future<NotificationModel> getData({
    required int? page,
    required BuildContext context,
  }) async {
    if (page != 1) {
      loadingPagination = true;
      notifyListeners();
    }
    await _apiProvider.get(
      apiRoute: notificationURL,
      queryParameters: {
        'Page': page,
      },
      successResponse: (response) {
        print("I am Notification Data:: $response");
        _notificationModel = NotificationModel.fromJson(response);
        if (_notificationModel.result!.notifications!.isNotEmpty) {
          _listNotification.addAll(
            LinkedHashSet<NotificationData>.from(
                    _notificationModel.result!.notifications!)
                .toList(),
          );

          Map<String, NotificationData> map = {};

          for (var element in _listNotification) {
            map[element.orderId.toString()] = element;
          }

          _listNotification = map.values.toSet().toList();

          _listNotification = Tools.removeDuplicates(_listNotification);
          notifyListeners();
        } else {
          endPage = true;

          notifyListeners();
        }
        loadingPagination = false;
        notifyListeners();
      },
      errorResponse: (response) {
        _errorModel = ErrorModel.fromJson(response);
        dismissLoading().whenComplete(
          () => delayMilliseconds(
            250,
            () => errorDialog(context, _errorModel.message),
          ),
        );
        logger.e(response);
        loadingPagination = false;
        notifyListeners();
      },
    );

    print("Notification: $_notificationModel end");
    return _notificationModel;
  }

  NotificationModel get notificationModel => _notificationModel;

  List<NotificationData>? get listNotification => _listNotification;
}
