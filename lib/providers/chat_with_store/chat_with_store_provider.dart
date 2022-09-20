import 'package:azooz/service/network/url_constants.dart';
import 'package:flutter/cupertino.dart';

import '../../model/response/chat_with_store_model.dart';
import '../../service/network/api_provider.dart';

class ChatWithStoreProvider extends ChangeNotifier {
  final ApiProvider _apiProvider = ApiProvider.internal();
  late int chatId;
  late ChatWithStoreModel _chatWithStoreModel;

  Future<ChatWithStoreModel> postChatId(
      {required BuildContext context, required int storeId}) async {
    await _apiProvider.post(
      apiRoute: createChatWithStoreURL,
      data: {
        'storeId': storeId,
      },
      successResponse: (response) {
        _chatWithStoreModel = ChatWithStoreModel.fromJson(response);
        print("I am chatId #${_chatWithStoreModel.result!.chatid} end");
        notifyListeners();
      },
      errorResponse: (error) {},
    );

    return _chatWithStoreModel;
  }
}
