import 'dart:async';
import 'dart:collection';
import 'dart:developer';
import 'dart:io';

import '../common/config/tools.dart';
import '../model/error_model.dart';
import '../model/mixin/chat_mixin.dart';
import '../model/response/all_chat_model.dart';
import '../model/response/chat_message_model.dart';
import '../model/response/chat_model.dart';
import '../model/response/store_hud_model.dart';
import '../service/network/api_provider.dart';
import '../service/network/url_constants.dart';
import '../utils/delay.dart';
import '../utils/dialogs.dart';
import '../utils/easy_loading_functions.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class ChatProvider extends ChangeNotifier with ChatMixin {
  final ApiProvider _apiProvider = ApiProvider.internal();
  late ErrorModel _errorModel;
  late AllChatModel _allChatModel;
  ChatModel? _chatModel;
  late ChatMessageModel _chatMessageModel;
  List<Message> _listMessages = [];
  List<AllChat> _listAllChats = [];
  bool isRead = false;
  addFavDriver(context, String orderID) {
    log('orderID: $orderID');
    circularDialog(context);
    _apiProvider.post(
      apiRoute: '${baseURL}FavoriteDrivers',
      data: {'orderId': orderID},
      successResponse: (response) {
        log('successResponse');
        dismissDialog(context);
        errorDialog(context, response['message']);
        notifyListeners();
      },
      errorResponse: (response) {
        log('errorResponse');
        _errorModel = ErrorModel.fromJson(response);
        dismissDialog(context);
        errorDialog(context, _errorModel.message);
        notifyListeners();
      },
    );
    notifyListeners();
  }

  Future refresh(BuildContext context) async {
    _listAllChats = [];
    _listMessages = [];
    Future.delayed(const Duration(milliseconds: 300), () {
      getAllChats(context: context, page: 1);
      notifyListeners();
    });
    notifyListeners();
  }

  int? get tabInd => _tabInd;

  late StoreHudModel _storeHudModel;

  StoreHudModel get storeHudModel => _storeHudModel;
  FormData? _body;
  File? _file;
  bool? filePicked = false;
  bool loadingPagination = false;
  bool endPageAllChats = false;
  bool endPageChat = false;
  bool startPageChat = false;

  late int _globalChatId;

  int get currentChatId => _globalChatId;

  set newMessage(Message message) {
    _listMessages.add(message);
    notifyListeners();
  }

  @override
  Future<List<AllChat>> getAllChats({
    required int? page,
    required BuildContext context,
  }) async {
    log('page: $page');
    if (page != 1) {
      loadingPagination = true;
      notifyListeners();
    }
    await _apiProvider.get(
      apiRoute: allChatURL,
      queryParameters: {
        'Page': page,
      },
      successResponse: (response) {
        _allChatModel = AllChatModel.fromJson(response);
        if (_allChatModel.result!.chats!.isNotEmpty) {
          log('Chats: ${_allChatModel.result!.chats!}');
          _listAllChats.addAll(
              LinkedHashSet<AllChat>.from(_allChatModel.result!.chats!)
                  .toList());

          final Map<String, AllChat> map = {};
          for (var item in _listAllChats) {
            map[item.id.toString()] = item;
          }

          _listAllChats = map.values.toSet().toList();
        } else {
          endPageAllChats = true;
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
    return _listAllChats;
  }

  int _tabInd = 0;
  @override
  Future<ChatModel?> getChat({
    required int? orderID,
    required BuildContext context,
  }) async {
    await _apiProvider.get(
      apiRoute: chatURL,
      queryParameters: {
        'OrderId': orderID,
      },
      successResponse: (response) {
        _chatModel = ChatModel.fromJson(response); ////
        _tabInd = _chatModel!.result!.chat!.tabsInd!;
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
        notifyListeners();
      },
    );
    notifyListeners();
    return _chatModel;
  }

  @override
  Future<List<Message>> getChatMessage({
    required int? page,
    required int? chatID,
    required BuildContext context,
  }) async {
    if (page == 1) {
      _listMessages.clear();
    }
    if (page != 1) {
      loadingPagination = true;

      notifyListeners();
    }

    await _apiProvider.get(
      apiRoute: chatMessageURL,
      queryParameters: {
        'chatId': chatID,
        'page': page,
      },
      successResponse: (response) {
        _chatMessageModel = ChatMessageModel.fromJson(response);
        if (_chatMessageModel.result!.messages!.isNotEmpty) {
          _listMessages.addAll(
            LinkedHashSet<Message>.from(
                    _chatMessageModel.result!.messages!.reversed)
                .toList(),
          );

          Map<String, Message> map = {};
          for (Message message in _listMessages) {
            map[message.id.toString()] = message;
          }

          notifyListeners();
        } else {
          endPageChat = true;
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
    notifyListeners();
    return _listMessages;
  }

  @override
  Future<void> postData({
    required String? textMsg,
    required String? fileMessage,
    required int? type,
    required int? chatID,
    required BuildContext context,
    ScrollController? scrollController,
  }) async {
    // circularDialog(context);
    Message newMsg = Message(
      createdAt: "الآن",
      fromMe: true,
      typeId: type,
      message: textMsg,
      isRead: false,
    );
    _listMessages.insert(0, newMsg);

    fileMessage != null && fileMessage != ''
        ? _body = FormData.fromMap({
            "TextMessage": textMsg.toString(),
            "Type": type,
            "ChatId": chatID,
            "FileMessage": await MultipartFile.fromFile(fileMessage),
          })
        : _body = FormData.fromMap({
            "TextMessage": textMsg,
            "Type": type,
            "ChatId": chatID,
          });
    _body!.fields.map((element) {
      print('Key: ${element.key} - Value: ${element.value}');
    });
    // Future.delayed(const Duration(seconds: 1), () {
    _apiProvider.post(
      apiRoute: createChatMessageURL,
      successResponse: (response) {
        if (fileMessage != null && fileMessage != '') {
          filePicked = false;
        }

        newMsg.isRead = true;

        if (scrollController != null) {
          if (scrollController.hasClients) {
            scrollController.animateTo(
              scrollController.position.minScrollExtent,
              duration: const Duration(milliseconds: 350),
              curve: Curves.easeInOut,
            );
          }
        }
        notifyListeners();
      },
      errorResponse: (response) {
        _errorModel = ErrorModel.fromJson(response);

        // dismissDialog(context);
        errorDialog(context, _errorModel.message);

        notifyListeners();
      },
      data: _body,
    );
    // });
    if (scrollController != null) {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 350),
          curve: Curves.easeInOut,
        );
      }
    }
    notifyListeners();
  }

  @override
  pickFile(BuildContext context, int chatId) async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.image,
        // allowedExtensions: ['png', 'jpg', 'jpeg'],
      );
      _file = File(result!.files.first.path.toString());
      filePicked = true;

      postData(
          textMsg: "",
          fileMessage: _file!.path,
          type: 202,
          chatID: chatId,
          context: context);
      notifyListeners();
      return true;
    } catch (error) {
      notifyListeners();
      return false;
    }
  }

  Future<StoreHudModel> getStoreHud(
      {required BuildContext context, required int chatId}) async {
    await _apiProvider.get(
      apiRoute: getStoreHudURL,
      queryParameters: {
        'chatId': chatId,
      },
      successResponse: (response) {
        _storeHudModel = StoreHudModel.fromJson(response);

        getChatMessage(page: 1, chatID: chatId, context: context);
        notifyListeners();
      },
      errorResponse: (error) {},
    );

    return _storeHudModel;
  }

  disposeData() {
    filePicked = false;
    _listMessages.clear();
    listMessages.clear();
    _chatMessageModel = const ChatMessageModel();
    loadingPagination = false;
    endPageAllChats = false;
    endPageChat = false;
  }

  clearMe() {
    if (_listMessages.isNotEmpty) {
      _listMessages.clear();
    }
  }

  AllChatModel get allChatModel => _allChatModel;

  ChatModel? get chatModel => _chatModel;

  ChatMessageModel get chatMessageModel => _chatMessageModel;

  File get file => _file!;

  List<Message> get listMessages => _listMessages;

  List<AllChat> get listAllChats => _listAllChats;
}
