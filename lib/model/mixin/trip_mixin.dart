import 'package:azooz/model/request/delayed_client_trip_model.dart';
import 'package:azooz/model/response/trip_details_model.dart';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../request/trip_price_calculate_model.dart';
import '../response/client_active_orders_model.dart';

mixin ClientTripsMixin {
  Future<void> getMarkerIcon({
    required BuildContext context,
    required String? path,
    required int? width,
  });

  addMarkerTO(LatLng position);

  addMarkerFROM(LatLng position);

  Future getActiveClientTrips({
    required int? id,
    required BuildContext context,
  });

  Future<ClientActiveOrdersModel> getActiveTripOrder({
    required int? id,
    required BuildContext context,
  });

  Future getFinishClientTrips({
    required int? id,
    required BuildContext context,
  });

  Future<TripDetailsModel> getTripDetailsById(
      {required int id, required BuildContext context});

  // getTrip(String id);

  disposeData();
}

mixin DelayedClientTripsMixin {
  Future postData({
    required BuildContext context,
    required DelayedClientTripModel delayedClientTripModel,
  });

  Future<void> getMarkerIcon({
    required BuildContext context,
    required String? path,
    required int? width,
  });

  addMarkerTO(LatLng position);

  addMarkerFROM(LatLng position);

  Future getActiveClientTrips({
    required int? id,
    required BuildContext context,
  });
  Future getFinishClientTrips({
    required int? id,
    required BuildContext context,
  });

  // getTrip(String id);

  disposeData();
}

mixin DelayedClientTripPriceMixin {
  setTripLocationDetails({
    required BuildContext context,
    required TripPriceCalculateModel tripPriceCalculate,
  });

  Future getPrice({
    required BuildContext context,
  });
}
