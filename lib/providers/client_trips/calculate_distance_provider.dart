import 'package:azooz/model/response/calculated_distance_result_model.dart';
import 'package:flutter/cupertino.dart';
import '../../service/network/url_constants.dart';
import '../../model/request/calculate_distance_model.dart';
import 'package:azooz/service/network/api_provider.dart';

class CalculateDistanceProvider extends ChangeNotifier {
  final ApiProvider _apiProvider = ApiProvider.internal();
  CalculatedDistanceResultModel? _calculatedDistanceResultModel;

  Future<CalculatedDistanceResultModel?> getDistance(
    BuildContext context,
    CalculateDistanceModel calculateDistanceModel,
  ) async {
    await _apiProvider.get(
      apiRoute: calculateDistanceURL,
      queryParameters: {
        'fromLat': calculateDistanceModel.fromLat,
        'fromLng': calculateDistanceModel.fromLng,
        'toLat': calculateDistanceModel.toLat,
        'toLng': calculateDistanceModel.toLng,
      },
      successResponse: (response) {
        _calculatedDistanceResultModel =
            CalculatedDistanceResultModel.fromJson(response);
        notifyListeners();
      },
      errorResponse: (response) {
        notifyListeners();
        throw Exception(response);
      },
    );
    notifyListeners();
    return _calculatedDistanceResultModel;
  }
}
