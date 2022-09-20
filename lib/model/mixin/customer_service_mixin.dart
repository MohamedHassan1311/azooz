import '../response/chat_message_model.dart';
import '../response/customer_service_model.dart';
import 'package:flutter/material.dart';

mixin CustomerServiceMixin {
  Future<CustomerServiceModel> getCustomerData({
    required BuildContext context,
  });

  Future<List<Message>> getChatMessage({
    required int? page,
    required BuildContext context,
  });

  Future<void> postData({
    required String? textMsg,
    required String? fileMessage,
    required int? type,
    required BuildContext context,
  });

  Future<bool> pickFile();

  disposeData();
}
