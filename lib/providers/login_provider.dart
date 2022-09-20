import '../common/config/keys.dart';
import '../common/config/tools.dart';
import '../common/routes/app_router_control.dart';
import '../common/routes/app_router_import.gr.dart';
import '../model/error_model.dart';
import '../model/response/login_model.dart';
import '../model/mixin/login_mixin.dart';
import '../service/network/api_provider.dart';
import '../service/network/url_constants.dart';
import '../utils/dialogs.dart';
import '../utils/util_shared.dart';
import 'package:flutter/material.dart';

class LoginProvider extends ChangeNotifier with LoginMixin {
  final ApiProvider _apiProvider = ApiProvider.internal();
  late LoginModel _loginModel;
  late ErrorModel _errorModel;
  late Map? _body = {};

  String? _currentScreen;
  get currentRouteName => _currentScreen;
  Future<String?> initScreen(BuildContext context) async {
    if (ModalRoute.of(context) != null) {
      _currentScreen = ModalRoute.of(context)!.settings.name;
      notifyListeners();
      return _currentScreen;
    }
    return null;
  }

  @override
  Future<LoginModel> postData({
    required String? phone,
    required BuildContext context,
  }) async {
    circularDialog(context);
    _body = {
      "phone": phone,
      "ruleId": 61,
    };
    await _apiProvider.post(
      apiRoute: loginURL,
      successResponse: (response) {
        _loginModel = LoginModel.fromJson(response);

        if (_loginModel.result!.authorization!.isNotEmpty) {
          UtilShared.saveStringPreference(
            key: keyToken,
            value: _loginModel.result!.authorization.toString(),
          );
        }
        dismissDialog(context);
        successDialogWithTimer(context).then((value) => routerPush(
              context: context,
              route: OTPRoute(loginModel: _loginModel),
            ));
        notifyListeners();
      },
      errorResponse: (response) {
        print('Error Response: $response');
        _errorModel = ErrorModel.fromJson(response);
        dismissDialog(context);
        errorDialog(context, _errorModel.message);
        logger.e(response);
        notifyListeners();
      },
      data: _body,
    );

    return _loginModel;
  }
}
