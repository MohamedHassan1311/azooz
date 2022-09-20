import 'package:azooz/model/mixin/trip_mixin.dart';
import 'package:azooz/model/request/add_client_trip_model.dart';
import 'package:azooz/model/response/trip_details_model.dart';
import 'package:azooz/service/network/api_provider.dart';
import 'package:azooz/service/network/url_constants.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../model/response/client_active_orders_model.dart';
import '../../../model/response/client_trip_resp_model.dart';

class ActiveTripsOrdersProvider extends ChangeNotifier with ClientTripsMixin {
  final ApiProvider _apiProvider = ApiProvider.internal();
  late ClientTripRespModel _clientActiveOrdersModel;

  ClientTripRespModel get clientActiveOrders => _clientActiveOrdersModel;

  @override
  addMarkerFROM(LatLng position) {}

  @override
  addMarkerTO(LatLng position) {}

  @override
  disposeData() {}

  @override
  Future<ClientTripRespModel> getActiveClientTrips(
      {required int? id, required BuildContext context}) async {
    await _apiProvider.get(
      apiRoute: activeClientTripsURL,
      successResponse: (response) {
        _clientActiveOrdersModel = ClientTripRespModel.fromJson(response);
        if (_clientActiveOrdersModel.result!.orders!.isNotEmpty) {
          notifyListeners();
        }
        notifyListeners();
      },
      errorResponse: (errorResponse) {},
    );

    notifyListeners();
    return _clientActiveOrdersModel;
  }

  @override
  Future getFinishClientTrips(
      {required int? id, required BuildContext context}) {
    throw UnimplementedError();
  }

  @override
  Future<void> getMarkerIcon(
      {required BuildContext context,
      required String? path,
      required int? width}) {
    throw UnimplementedError();
  }

  Future postData(
      {required BuildContext context,
      required ClientTripModel addClientTripModel}) {
    throw UnimplementedError();
  }

  @override
  Future<ClientActiveOrdersModel> getActiveTripOrder(
      {required int? id, required BuildContext context}) {
    throw UnimplementedError();
  }

  @override
  Future<TripDetailsModel> getTripDetailsById(
      {required int id, required BuildContext context}) {
    throw UnimplementedError();
  }
}
