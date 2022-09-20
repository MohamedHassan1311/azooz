import '../model/response/banks_model.dart';
import 'package:flutter/material.dart';

import '../model/error_model.dart';
import '../model/mixin/banks_mixin.dart';
import '../service/network/api_provider.dart';
import '../service/network/url_constants.dart';
import '../utils/delay.dart';
import '../utils/dialogs.dart';
import '../utils/easy_loading_functions.dart';

class BanksProvider extends ChangeNotifier with BanksMixin {
  final ApiProvider _apiProvider = ApiProvider.internal();
  late ErrorModel _errorModel;
  late BanksModel _banksModel;

  @override
  Future<BanksModel> getBanks({
    required BuildContext context,
  }) async {
    await _apiProvider.get(
      apiRoute: bankURL,
      successResponse: (response) {
        _banksModel = BanksModel.fromJson(response);
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
        notifyListeners();
      },
    );
    return _banksModel;
  }

  BanksModel get banksModel => _banksModel;
}
