import 'package:flutter/material.dart';

mixin ChatMixin {
  getAllChats({
    required int? page,
    required BuildContext context,
  }) {}

  getChat({
    required int? orderID,
    required BuildContext context,
  }) {}

  getChatMessage({
    required int? page,
    required int? chatID,
    required BuildContext context,
  }) {}

  postData({
    required String? textMsg,
    required String? fileMessage,
    required int? type,
    required int? chatID,
    required BuildContext context,
    ScrollController? scrollController,
  }) {}

  pickFile(BuildContext context, int chatId) {}

  getStoreChatHud({
    required int chatId,
    required BuildContext context,
  }) {}
}
