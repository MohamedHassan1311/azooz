import 'package:flutter/material.dart';

import '../model/error_model.dart';
import '../model/mixin/setting_mixin.dart';
import '../model/response/terms_model.dart';
import '../model/response/vehicle_type_model.dart';
import '../service/network/api_provider.dart';
import '../service/network/url_constants.dart';
import '../utils/dialogs.dart';

class SettingProvider extends ChangeNotifier with SettingMixin {
  final ApiProvider _apiProvider = ApiProvider.internal();
  late ErrorModel _errorModel;
  late TermsModel _termsModel;
  late VehicleTypeModel _vehicleTypeModel;

  @override
  Future<TermsModel> getTermsAboutUs({
    required BuildContext context,
  }) async {
    await _apiProvider.get(
      apiRoute: termsURL,
      successResponse: (response) {
        _termsModel = TermsModel.fromJson(response);
        notifyListeners();
      },
      errorResponse: (response) {
        _errorModel = ErrorModel.fromJson(response);
        errorDialog(context, _errorModel.message);
        notifyListeners();
      },
    );
    notifyListeners();

    return _termsModel;
  }

  @override
  Future<VehicleTypeModel> getVehicleType({
    required BuildContext context,
  }) async {
    await _apiProvider.get(
      apiRoute: vehicleURL,
      successResponse: (response) {
        _vehicleTypeModel = VehicleTypeModel.fromJson(response);
        notifyListeners();
      },
      errorResponse: (response) {
        _errorModel = ErrorModel.fromJson(response);
        errorDialog(context, _errorModel.message);
        notifyListeners();
      },
    );
    notifyListeners();

    return _vehicleTypeModel;
  }

  TermsModel get termsModel => _termsModel;

  VehicleTypeModel get vehicleTypeModel => _vehicleTypeModel;
}
