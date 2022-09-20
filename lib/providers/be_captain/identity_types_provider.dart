import 'package:azooz/model/request/identity_types_model.dart';
import 'package:flutter/foundation.dart';

import '../../common/config/tools.dart';
import '../../model/error_model.dart';
import '../../service/network/api_provider.dart';
import '../../service/network/url_constants.dart';

class IdentityTypesProvider extends ChangeNotifier {
  final ApiProvider _apiProvider = ApiProvider.internal();
  late ErrorModel _errorModel;
  IdentityTypesModel? _identityTypesModel;
  IdentityTypes? _identityTypes;

  set setIdentityTypes(IdentityTypes? value) {
    _identityTypes = value;
    notifyListeners();
  }

  IdentityTypes? get currentIdentityTypes => _identityTypes;

  List<IdentityTypes>? get identityTypesList =>
      _identityTypesModel!.result!.identityTypes;

  Future<IdentityTypesModel?> getIdentityTypes() async {
    await _apiProvider.get(
      apiRoute: identityTypesURL,
      successResponse: (response) {
        _identityTypesModel = IdentityTypesModel.fromJson(response);
        notifyListeners();
      },
      errorResponse: (response) {
        _errorModel = ErrorModel.fromJson(response);
        logger.e(response);
        throw Exception(_errorModel.message);
      },
    );
    notifyListeners();
    return _identityTypesModel;
  }
}
