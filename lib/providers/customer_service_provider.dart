import 'dart:collection';
import 'dart:io';

import '../common/config/tools.dart';
import '../model/mixin/customer_service_mixin.dart';
import '../model/response/chat_message_model.dart';
import '../model/response/customer_service_model.dart';
import '../service/network/api_provider.dart';
import '../service/network/url_constants.dart';
import '../utils/delay.dart';
import '../utils/dialogs.dart';
import '../utils/easy_loading_functions.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import '../model/error_model.dart';

class CustomServiceProvider extends ChangeNotifier with CustomerServiceMixin {
  final ApiProvider _apiProvider = ApiProvider.internal();
  late ErrorModel _errorModel;
  late ChatMessageModel _chatMessageModel;
  late CustomerServiceModel _customerServiceModel;
  List<Message> _listMessages = [];

  FormData? _body;
  File? _file;
  bool? filePicked = false;
  bool loadingPagination = false;
  bool endPageAllChats = false;
  bool endPageChat = false;

  // final int? _chatID = 0;

  @override
  Future<List<Message>> getChatMessage({
    required int? page,
    required BuildContext context,
  }) async {
    if (page != 1) {
      loadingPagination = true;
      notifyListeners();
    }
    await _apiProvider.get(
      apiRoute: contactMessagesURL,
      queryParameters: {
        'chatId': _customerServiceModel.result!.chatId,
        'page': page,
      },
      successResponse: (response) {
        _chatMessageModel = ChatMessageModel.fromJson(response);
        if (_chatMessageModel.result!.messages!.isNotEmpty) {
          _listMessages.addAll(
              LinkedHashSet<Message>.from(_chatMessageModel.result!.messages!)
                  .toList());

          Map<String, Message> map = {};
          for (var item in _listMessages) {
            map[item.id.toString()] = item;
          }
          _listMessages = map.values.toSet().toList();
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
    return _listMessages;
  }

  @override
  Future<CustomerServiceModel> getCustomerData({
    required BuildContext context,
  }) async {
    await _apiProvider.post(
      apiRoute: contactCustomerServiceURL,
      successResponse: (response) {
        _customerServiceModel = CustomerServiceModel.fromJson(response);
        // _chatID = _customerServiceModel.result!.chatId;
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
      data: {},
    );
    return _customerServiceModel;
  }

  @override
  Future<void> postData({
    required String? textMsg,
    required String? fileMessage,
    required int? type,
    required BuildContext context,
  }) async {
    // circularDialog(context);
    fileMessage != null && fileMessage != ''
        ? _body = FormData.fromMap({
            "TextMessage": textMsg.toString(),
            "Type": type,
            "ContactId": _customerServiceModel.result!.chatId,
            "FileMessage": await MultipartFile.fromFile(fileMessage),
          })
        : _body = FormData.fromMap({
            "TextMessage": textMsg,
            "Type": type,
            "ContactId": _customerServiceModel.result!.chatId,
          });

    logger.i(
        'Text Message: ${_body!.fields[0].value} - Type: ${_body!.fields[1].value} - ContactID: ${_body!.fields[2].value}');

    await _apiProvider.post(
      apiRoute: contactSendMessageURL,
      successResponse: (response) {
        if (fileMessage != null && fileMessage != '') {
          filePicked = false;
        }
        // getChatMessage(page: 1, context: context).then(
        //   (value) => _listMessages.sort((a, b) => b.id!.compareTo(a.id!)),
        // );

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
    notifyListeners();
  }

  @override
  disposeData() {
    filePicked = false;
    _listMessages.clear();
    loadingPagination = false;
    endPageAllChats = false;
    endPageChat = false;
    // notifyListeners();
  }

  @override
  pickFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.image,
        // allowedExtensions: ['png', 'jpg', 'jpeg'],
      );
      _file = File(result!.files.first.path.toString());
      filePicked = true;
      notifyListeners();
      return true;
    } catch (error) {
      print("### $error - File picker ###");
      notifyListeners();
      return false;
    }
  }

  List<Message> get listMessages => _listMessages;

  // CustomerServiceModel get customerServiceModel => _customerServiceModel;

  File? get file => _file;
}
