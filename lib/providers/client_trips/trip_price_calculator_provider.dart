import 'package:azooz/model/mixin/trip_mixin.dart';
import 'package:azooz/model/request/trip_price_calculate_model.dart';
import 'package:azooz/service/network/url_constants.dart';
import 'package:flutter/cupertino.dart';

import '../../service/network/api_provider.dart';

class TripPriceCalculatorProvider extends ChangeNotifier
    with DelayedClientTripPriceMixin {
  final ApiProvider _apiProvider = ApiProvider.internal();
  late TripPriceCalculateModel _tripPriceCalculateModel;
  late double _tripPrice;

  double get tripPrice => _tripPrice;
  TripPriceCalculateModel? get tripPriceCalculateModel =>
      _tripPriceCalculateModel;

  @override
  setTripLocationDetails(
      {required BuildContext context,
      required TripPriceCalculateModel tripPriceCalculate}) {
    _tripPriceCalculateModel = tripPriceCalculate;
    notifyListeners();
  }

  @override
  Future getPrice({
    required BuildContext context,
  }) async {
    _tripPrice = 0.0;
    await _apiProvider.get(
      apiRoute: tripCostCalculatorURL,
      queryParameters: _tripPriceCalculateModel.fromMap(),
      successResponse: (dynamic response) {
        _tripPrice = response['result']['price'];
        notifyListeners();
      },
      errorResponse: (error) {},
    );
    notifyListeners();
    return _tripPrice;
  }
}
