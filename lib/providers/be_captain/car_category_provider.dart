import 'package:azooz/service/network/url_constants.dart';
import 'package:flutter/foundation.dart';

import '../../common/config/tools.dart';
import '../../model/error_model.dart';
import '../../model/request/driver_category_model.dart';
import '../../service/network/api_provider.dart';

class CarCategoryProvider extends ChangeNotifier {
  final ApiProvider _apiProvider = ApiProvider.internal();
  late ErrorModel _errorModel;
  CarCategoryModel? _carCategoryModel;
  CarCategory? _selectedCarCategory;

  CarCategory? get selectedCarCategory => _selectedCarCategory;

  int? _currentCarModel;

  int? get currentCarModel => _currentCarModel;

  set setCarModel(int? val) {
    _currentCarModel = val;
    notifyListeners();
  }

  set setCarCategory(CarCategory category) {
    _selectedCarCategory = category;
    notifyListeners();
  }

  List<CarCategory>? get listCarCategory =>
      _carCategoryModel!.result!.carCategory;

  Future<CarCategoryModel?> getCarCategory() async {
    _carCategoryModel = null;
    await _apiProvider.get(
      apiRoute: carCategoryURL,
      successResponse: (response) {
        _carCategoryModel = CarCategoryModel.fromJson(response);
        notifyListeners();
      },
      errorResponse: (response) {
        _errorModel = ErrorModel.fromJson(response);
        logger.e(response);
        throw Exception(_errorModel.message);
      },
    );
    notifyListeners();
    return _carCategoryModel;
  }
}
