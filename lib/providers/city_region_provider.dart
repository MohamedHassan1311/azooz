import 'package:flutter/material.dart';

import '../common/config/tools.dart';
import '../model/error_model.dart';
import '../model/mixin/city_region_mixin.dart';
import '../model/response/city_model.dart';
import '../model/response/region_model.dart';
import '../service/network/api_provider.dart';
import '../service/network/url_constants.dart';
import '../utils/delay.dart';
import '../utils/dialogs.dart';
import '../utils/easy_loading_functions.dart';

class CityRegionProvider extends ChangeNotifier with CityRegionMixin {
  final ApiProvider _apiProvider = ApiProvider.internal();
  late CityModel _cityModel;
  late RegionModel _regionModel;
  late ErrorModel _errorModel;

  /// Master is Region
  /// Child is City

  @override
  Future<RegionModel> getRegion({
    required BuildContext context,
  }) async {
    await _apiProvider.get(
      apiRoute: regionURL,
      successResponse: (response) {
        _regionModel = RegionModel.fromJson(response);
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
    return _regionModel;
  }

  @override
  Future<CityModel> getCity({
    required BuildContext context,
    required int? id,
  }) async {
    await _apiProvider.get(
      apiRoute: cityURL,
      queryParameters: {
        'id': id,
      },
      successResponse: (response) {
        _cityModel = CityModel.fromJson(response);
        notifyListeners();
      },
      errorResponse: (response) {
        _errorModel = ErrorModel.fromJson(response);
        errorDialog(context, _errorModel.message);
        logger.e(response);
        notifyListeners();
      },
    );
    return _cityModel;
  }

  CityModel get cityModel => _cityModel;

  RegionModel get regionModel => _regionModel;
}
