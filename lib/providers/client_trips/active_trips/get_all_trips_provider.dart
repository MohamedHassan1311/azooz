import 'package:azooz/model/response/client_trip_resp_model.dart';
import 'package:flutter/material.dart';

import '../../../service/network/api_provider.dart';
import '../../../service/network/url_constants.dart';

class GetAllTripProvider extends ChangeNotifier {
  final ApiProvider _apiProvider = ApiProvider.internal();
  late ClientTripRespModel clientTripModelResp;
  List<TripOrders> activeTrips = [];
  List<TripOrders> finishedTrips = [];
  List<TripOrders> filterOrdersCurrentList = [];
  List<TripOrders> filterOrdersPreviousList = [];

  // final List<TripOrders> _paginationOrdersCurrentList = [];

  // final List<TripOrders> _paginationOrdersPreviousList = [];

  bool endPagePrevious = false;
  bool endPageCurrent = false;

  Future<ClientTripRespModel> getAllActiveTrips({int? page}) async {
    await _apiProvider.get(
      apiRoute: activeClientTripsURL,
      queryParameters: {'Page': page},
      successResponse: (response) {
        clientTripModelResp = ClientTripRespModel.fromJson(response);
        if (clientTripModelResp.result!.orders!.isNotEmpty) {
          activeTrips.addAll(clientTripModelResp.result!.orders!);
          final Map<String, TripOrders> map = {};
          for (var item in activeTrips) {
            map[item.id.toString()] = item;
          }

          activeTrips = map.values.toSet().toList();
          // filterOrdersCurrentList = activeTrips;
          notifyListeners();
        } else {
          endPageCurrent = true;
          notifyListeners();
        }
      },
      errorResponse: (errorResponse) {
        print(errorResponse);
      },
    );
    notifyListeners();
    return clientTripModelResp;
  }

  Future<ClientTripRespModel> getAllFinishTrips({int? page}) async {
    await _apiProvider.get(
      apiRoute: finishClientTripsURL,
      queryParameters: {'Page': page},
      successResponse: (response) {
        clientTripModelResp = ClientTripRespModel.fromJson(response);
        if (clientTripModelResp.result!.orders!.isNotEmpty) {
          finishedTrips.addAll(clientTripModelResp.result!.orders!);

          final Map<String, TripOrders> map = {};
          for (var item in finishedTrips) {
            map[item.id.toString()] = item;
          }

          finishedTrips = map.values.toSet().toList();
          notifyListeners();
        } else {
          endPagePrevious = true;
          notifyListeners();
        }
      },
      errorResponse: (errorResponse) {
        print(errorResponse);
      },
    );
    notifyListeners();
    return clientTripModelResp;
  }

  List<TripOrders>? filterPreviousOrders(String queryWord) {
    Iterable<TripOrders> result = [];
    if (queryWord.trim().isNotEmpty) {
      result = filterOrdersPreviousList.where(
        (element) {
          return element.createdAt!
                  .toLowerCase()
                  .contains(queryWord.toLowerCase().trim()) ||
              element.details.toString().contains(queryWord.trim()) ||
              element.id.toString().contains(queryWord.trim());
        },
      );
      print('Result Filter: $result');

      notifyListeners();
    } else {
      result = filterOrdersPreviousList;
      notifyListeners();
    }
    filterOrdersPreviousList = result.toSet().toList();
    filterOrdersPreviousList.sort(
      (a, b) => b.id!.compareTo(a.id!),
    );
    final Map<String, TripOrders> map = {};
    for (var item in filterOrdersPreviousList) {
      map[item.id.toString()] = item;
    }
    filterOrdersPreviousList = map.values.toList();
    notifyListeners();

    return filterOrdersPreviousList;
  }
}
