import '../common/config/tools.dart';
import '../model/error_model.dart';
import '../model/mixin/gender_mixin.dart';
import '../model/response/gender_model.dart';
import '../service/network/api_provider.dart';
import '../service/network/url_constants.dart';
import '../utils/delay.dart';
import '../utils/dialogs.dart';
import '../utils/easy_loading_functions.dart';
import 'package:flutter/material.dart';

class GenderProvider extends ChangeNotifier with GenderMixin {
  final ApiProvider _apiProvider = ApiProvider.internal();
  late GenderModel _genderModel;
  int? _selectedGenderModel;
  late ErrorModel _errorModel;
  UserGender? _gender;

  UserGender? get gender => _gender ?? const UserGender(id: 3, name: "any");

  int? get selectedGenderId => _selectedGenderModel;

  @override
  Future<GenderModel> getGenderData({
    required BuildContext context,
  }) async {
    await _apiProvider.get(
      apiRoute: gendersURL,
      successResponse: (response) {
        _genderModel = GenderModel.fromJson(response);
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
    return _genderModel;
  }

  GenderModel get genderModel => _genderModel;

  @override
  setGenderData({required BuildContext context, required UserGender gender}) {
    _selectedGenderModel = gender.id ?? 3;

    _gender = gender;
    notifyListeners();
  }
}
