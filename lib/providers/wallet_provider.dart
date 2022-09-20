import 'package:flutter/material.dart';

import '../model/error_model.dart';
import '../model/mixin/wallet_mixin.dart';
import '../model/response/wallet_model.dart';
import '../service/network/api_provider.dart';
import '../service/network/url_constants.dart';
import '../utils/dialogs.dart';
import '../utils/easy_loading_functions.dart';

class WalletProvider extends ChangeNotifier with WalletMixin {
  final ApiProvider _apiProvider = ApiProvider.internal();
  late ErrorModel _errorModel;
  late WalletModel _walletModel;

  WalletModel get walletModelData => _walletModel;

  @override
  Future<WalletModel> getData({
    required BuildContext context,
  }) async {
    await _apiProvider.get(
      apiRoute: walletURL,
      successResponse: (response) {
        _walletModel = WalletModel.fromJson(response);
        notifyListeners();
      },
      errorResponse: (response) {
        _errorModel = ErrorModel.fromJson(response);
        errorDialog(context, _errorModel.message);
        notifyListeners();
      },
    );
    notifyListeners();

    return _walletModel;
  }

  @override
  Future sendData({
    required BuildContext context,
    required double? amount,
  }) async {
    circularDialog(context);
    Map body = {
      "amount": amount,
    };
    await _apiProvider.post(
      apiRoute: walletSendURL,
      successResponse: (response) {
        dismissLoading();
        getData(context: context);
        notifyListeners();
      },
      errorResponse: (response) {
        _errorModel = ErrorModel.fromJson(response);
        errorDialog(context, _errorModel.message);
        notifyListeners();
      },
      data: body,
    );
    notifyListeners();
  }
}
