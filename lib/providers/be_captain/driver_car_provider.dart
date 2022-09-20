import 'package:azooz/model/response/cars_kind_model.dart';
import 'package:flutter/foundation.dart';

import '../../common/config/tools.dart';
import '../../model/error_model.dart';
import '../../model/request/car_types_model.dart';
import '../../service/network/api_provider.dart';
import '../../service/network/url_constants.dart';

class DriverCarProvider extends ChangeNotifier {
  final ApiProvider _apiProvider = ApiProvider.internal();
  late ErrorModel _errorModel;
  CarTypesModel? _carTypesModel;
  CarsKindModel? _carsKindModel;

  CarTypes? _carTypes;
  CarsKind? _carsKind;

  CarTypes? get currentVehicleType => _carTypes;
  CarsKind? get currentCarKind => _carsKind;

  set setVehicleType(CarTypes? val) {
    _carTypes = val;
    notifyListeners();
  }

  set setCarKindId(CarsKind? val) {
    _carsKind = val;
    notifyListeners();
  }

  List<CarTypes>? get carTypes => _carTypesModel?.result!.cartypes;
  List<CarsKind>? get carsKind => _carsKindModel?.result!.carsKind;

  Future<CarTypesModel?> getCarTypes(int driverTypeId) async {
    clear();
    await _apiProvider.get(
        apiRoute: carTypesURL,
        queryParameters: {
          "driverTypeId": driverTypeId,
        },
        successResponse: (response) {
          _carTypesModel = CarTypesModel.fromJson(response);
          notifyListeners();
        },
        errorResponse: (response) {
          _errorModel = ErrorModel.fromJson(response);
          logger.e(response);
          throw Exception(_errorModel.message);
        });
    notifyListeners();
    return _carTypesModel;
  }

  Future<CarsKindModel?> getCarsKind() async {
    _carsKindModel = null;
    await _apiProvider.get(
        apiRoute: carsKindURL,
        successResponse: (response) {
          _carsKindModel = CarsKindModel.fromJson(response);
          notifyListeners();
        },
        errorResponse: (response) {
          _errorModel = ErrorModel.fromJson(response);
          logger.e(response);
          throw Exception(_errorModel.message);
        });
    notifyListeners();
    return _carsKindModel;
  }

  void clear() {
    _carTypesModel = null;
    _carTypes = null;
    // notifyListeners();
  }
}
