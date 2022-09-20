import 'dart:developer';

import 'package:azooz/model/response/client_active_orders_model.dart';

import '../app.dart';
import '../common/config/tools.dart';
import '../generated/locale_keys.g.dart';
import '../model/error_model.dart';
import '../model/mixin/trip_mixin.dart';
import '../model/request/add_client_trip_model.dart';
import '../model/request/calculate_distance_model.dart';
import '../model/request/delayed_trip_model.dart';
import '../model/response/calculated_distance_result_model.dart';
import '../model/response/trip_details_model.dart';
import '../utils/dialogs.dart';
import '../view/screen/maps/get_location_api.dart';
import 'location_provider.dart';
import '../service/network/api_provider.dart';
import '../service/network/url_constants.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class ClientTripsProvider extends ChangeNotifier with ClientTripsMixin {
  final ApiProvider _apiProvider = ApiProvider.internal();
  late ErrorModel _errorModel;
  CalculatedDistanceResultModel? _calculatedDistanceResultModel;

  Marker? markerTO;
  Marker? markerFROM;
  Set<Marker> markerBOTH = {};
  late LatLng positionTO;
  late LatLng positionFROM;
  late BitmapDescriptor markerIcon;
  bool? hasMarkerTO = false;
  bool? hasMarkerFROM = false;
  bool? hasMarkerBOTH = false;
  late String addressDetailsFROM;
  late String addressDetailsTO;
  late List<DelayedTripModel> listTrips;

  late TripDetailsModel _tripDetailsModel;
  // late LatLng _currentLatLng;

  // LatLng getCurrentLatLng() => _currentLatLng;

  TripDetailsModel get getTripDetails => _tripDetailsModel;

  final TextEditingController controller = TextEditingController();

  bool _showConfirmButton() {
    if (positionFROM != const LatLng(0, 0) &&
        positionFROM != const LatLng(0, 0)) {
      return true;
    } else if (positionFROM != const LatLng(0, 0) ||
        positionFROM != const LatLng(0, 0)) {
      return true;
    } else if (positionFROM == const LatLng(0, 0) ||
        positionFROM == const LatLng(0, 0)) {
      return true;
    }
    notifyListeners();
    return false;
  }

  Future<bool> isDistanceConfirmed(
    BuildContext context, {
    required LatLng fromLatLng,
    required LatLng toLatLng,
  }) async {
    if (fromLatLng != const LatLng(0, 0) && toLatLng != const LatLng(0, 0)) {
      bool? status;
      CalculateDistanceModel calculateDistanceModel = CalculateDistanceModel(
        fromLat: fromLatLng.latitude,
        fromLng: fromLatLng.longitude,
        toLat: toLatLng.latitude,
        toLng: toLatLng.longitude,
      );

      await getDistance(context, calculateDistanceModel).then((value) {
        if (value!.result!.status == true) {
          status = true;
        } else {
          status = false;
        }
      });

      print("I am here:: $status");

      notifyListeners();
      return status ?? false;
    } else {
      return false;
    }
    // if (positionFROM != const LatLng(0, 0) &&
    //     positionTO != const LatLng(0, 0)) {
    //   bool? status;
    //   CalculateDistanceModel calculateDistanceModel = CalculateDistanceModel(
    //     fromLat: positionFROM.latitude,
    //     fromLng: positionFROM.longitude,
    //     toLat: positionTO.latitude,
    //     toLng: positionTO.longitude,
    //   );

    //   await getDistance(context, calculateDistanceModel).then((value) {
    //     if (value!.result!.status == true) {
    //       status = true;
    //     } else {
    //       status = false;
    //     }
    //   });

    //   print("I am here:: $status");

    //   notifyListeners();
    //   return status ?? false;
    // } else {
    //   return false;
    // }
  }

  List taxiDrivers = [];
  Future getFavDrivers(int code) async {
    await _apiProvider.get(
      apiRoute: '${baseURL}FavoriteDrivers',
      queryParameters: {
        'orderRequestType': code,
      },
      successResponse: (response) {
        taxiDrivers = response['result']['favorites'] as List;
        notifyListeners();
      },
      errorResponse: (response) {
        notifyListeners();
        log('response error: $response');
      },
    );
    return taxiDrivers;
  }

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

  get showButton => _showConfirmButton();

  Future postData({
    required BuildContext context,
    required ClientTripModel clientTripData,
  }) async {
    logger.d('Post Data: $clientTripData');
    print("### Trip data: $clientTripData ###");
    circularDialog(context);
    await _apiProvider.post(
      apiRoute: clientTripsURL,
      successResponse: (response) {
        disposeData();

        dismissDialog(context);

        // successDialogWithTimer(context);
        notifyListeners();
      },
      errorResponse: (response) {
        _errorModel = ErrorModel.fromJson(response);

        dismissDialog(context);
        errorDialog(context, _errorModel.message);
        notifyListeners();
      },
      data: clientTripData.toJson(),
    );
  }

  @override
  addMarkerTO(LatLng position) async {
    positionTO = position;
    hasMarkerTO = true;
    logger.d(
        'Position Detected: Lat => ${positionTO.latitude} - Lng => ${positionTO.longitude}');
    markerTO = Marker(
      markerId: MarkerId(UniqueKey().toString()),
      position: LatLng(positionTO.latitude, positionTO.longitude),
      icon: markerIcon,
      infoWindow: InfoWindow(title: LocaleKeys.arrivePoint.tr()),
    );
    print('@@@ ${markerBOTH.length}');
    // await placemarkFromCoordinates(
    //   position.latitude,
    //   position.longitude,
    //   localeIdentifier: "ar_EG",
    // ).then((value) => addressDetailsTO = value[0].street.toString());
    await getItContext!
        .read<MapServicesProvider>()
        .getAddress(LatLng(position.latitude, position.longitude))
        .then((value) {
      addressDetailsTO = value.results![0].formattedAddress!;

      notifyListeners();
    });

    notifyListeners();
  }

  @override
  addMarkerFROM(LatLng position) async {
    positionFROM = position;
    hasMarkerFROM = true;
    logger.d(
        'Position Detected: Lat => ${positionFROM.latitude} - Lng => ${positionFROM.longitude}');
    markerFROM = Marker(
      markerId: MarkerId(UniqueKey().toString()),
      position: LatLng(positionFROM.latitude, positionFROM.longitude),
      icon: markerIcon,
      infoWindow: InfoWindow(title: LocaleKeys.pickUpPoint.tr()),
    );
    markerBOTH.add(markerFROM!);
    print('@@@ 22 ${markerBOTH.length}');
    try {
      // await placemarkFromCoordinates(
      //   position.latitude,
      //   position.longitude,
      //   localeIdentifier: "ar_EG",
      // ).then((value) {
      //   return addressDetailsFROM = value[0].street.toString();
      // });
      await getItContext!
          .read<MapServicesProvider>()
          .getAddress(LatLng(position.latitude, position.longitude))
          .then((value) {
        addressDetailsFROM = value.results![0].formattedAddress!;
        notifyListeners();
      });
    } catch (error) {
      print(error);
    }
    notifyListeners();
  }

  @override
  Future<void> getMarkerIcon({
    required BuildContext context,
    required String? path,
    required int? width,
  }) async {
    var provider = Provider.of<LocationProvider>(context, listen: false);
    markerIcon = await provider.getBitmapDescriptorFromAssetBytes(
      path!,
      width!,
    );
    // notifyListeners();
  }

  @override
  disposeData() {
    positionTO = const LatLng(0, 0);
    hasMarkerTO = false;
    positionFROM = const LatLng(0, 0);
    hasMarkerFROM = false;
    markerBOTH.clear();
    addressDetailsTO = '';
    addressDetailsFROM = '';
    controller.clear();
    markerFROM = null;
    markerTO = null;
    // notifyListeners();
  }

  @override
  Future<List<DelayedTripModel>> getActiveClientTrips(
      {required int? id, required BuildContext context}) async {
    circularDialog(context);
    await _apiProvider.get(
      apiRoute: activeClientTripsURL,
      successResponse: (response) {
        listTrips = response['result']['orders'];

        dismissDialog(context);
        successDialogWithTimer(context);
        notifyListeners();
      },
      errorResponse: (response) {
        _errorModel = ErrorModel.fromJson(response);

        dismissDialog(context);
        errorDialog(context, _errorModel.message);

        notifyListeners();
      },
    );

    // Return the list of all trips
    return listTrips;
  }

  @override
  getFinishClientTrips({required int? id, required BuildContext context}) {
    throw UnimplementedError();
  }

  @override
  Future<ClientActiveOrdersModel> getActiveTripOrder(
      {required int? id, required BuildContext context}) {
    throw UnimplementedError();
  }

  @override
  Future<TripDetailsModel> getTripDetailsById(
      {required int id, required BuildContext context}) async {
    await _apiProvider.get(
      apiRoute: tripDetailsURL,
      queryParameters: {
        'Id': id,
      },
      successResponse: (response) {
        _tripDetailsModel = TripDetailsModel.fromJson(response);
        notifyListeners();
      },
      errorResponse: (errorResponse) {},
    );

    notifyListeners();
    return _tripDetailsModel;
  }
}
