import 'package:flutter/foundation.dart';

import '../../common/config/tools.dart';
import '../../model/error_model.dart';
import '../../model/request/driver_types_model.dart';
import '../../service/network/api_provider.dart';
import '../../service/network/url_constants.dart';

class DriverTypesProvider extends ChangeNotifier {
  final ApiProvider _apiProvider = ApiProvider.internal();
  late ErrorModel _errorModel;
  late DriverTypesModel _driverTypesModel;
  DriverTypes? _driverType;
  late bool _showOperatingCard = false;

  bool _isStudent = false;

  bool get isStudent => _isStudent;

  set setStudent(bool val) {
    _isStudent = val;
    notifyListeners();
  }

  resetData() {
    _isStudent = false;
  }

  set setOperatingCardState(bool value) {
    _showOperatingCard = value;
    notifyListeners();
  }

  set selectedDriverType(DriverTypes? val) {
    _driverType = val;
    notifyListeners();
  }

  bool get showOperatingCardState => _showOperatingCard;
  DriverTypes? get selectedDriverType => _driverType;

  List<DriverTypes>? get driverTypesList =>
      _driverTypesModel.result!.driverTypes;
  Future<DriverTypesModel> getDriverTypes() async {
    await _apiProvider.get(
        apiRoute: driverTypesURL,
        successResponse: (response) {
          _driverTypesModel = DriverTypesModel.fromJson(response);
          notifyListeners();
        },
        errorResponse: (response) {
          _errorModel = ErrorModel.fromJson(response);
          logger.e(response);
          throw Exception(_errorModel.message);
        });
    notifyListeners();
    return _driverTypesModel;
  }
}
