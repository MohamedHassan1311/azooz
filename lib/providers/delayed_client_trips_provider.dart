import 'package:azooz/model/request/delayed_client_trip_model.dart';

import '../app.dart';
import '../common/config/tools.dart';
import '../generated/locale_keys.g.dart';
import '../model/error_model.dart';
import '../model/mixin/trip_mixin.dart';
import '../utils/dialogs.dart';
import '../view/screen/maps/get_location_api.dart';
import 'location_provider.dart';
import '../service/network/api_provider.dart';
import '../service/network/url_constants.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class DelayedClientTripsProvider extends ChangeNotifier
    with DelayedClientTripsMixin {
  final ApiProvider _apiProvider = ApiProvider.internal();
  late ErrorModel _errorModel;
  late DelayedTripDetailsModel tripDetails;

  double _requiredTotalPrice = 0;

  get requiredTotalPrice => _requiredTotalPrice;

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
  late int orderId;

  final TextEditingController controller = TextEditingController();

  @override
  Future postData({
    required BuildContext context,
    required DelayedClientTripModel delayedClientTripModel,
  }) async {
    print("### Delayed Trip Provider:: $delayedClientTripModel ###");
    orderId = 0;
    // circularDialog(context);
    await _apiProvider.post(
      apiRoute: delayedClientTripURL,
      successResponse: (response) {
        print("### resssspo: $response ###");
        orderId = response['result']['id'];
        _requiredTotalPrice = response['result']['total'];
        tripDetails = DelayedTripDetailsModel(
          rideNumber: orderId,
          fromLocationDetails: delayedClientTripModel.fromLocationDetails,
          toLocationDetails: delayedClientTripModel.toLocationDetails,
          delayedTripDateTime:
              delayedClientTripModel.delayedTripDateTime.toString(),
        );

        notifyListeners();
      },
      errorResponse: (response) {
        _errorModel = ErrorModel.fromJson(response);

        // dismissDialog(context);
        errorDialog(context, _errorModel.message);
        notifyListeners();
      },
      data: delayedClientTripModel.toJson(),
    );

    notifyListeners();
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
    // ).then((value) => addressDetailsTO = value.first.street.toString());
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
    // await placemarkFromCoordinates(
    //   position.latitude,
    //   position.longitude,
    //   localeIdentifier: "ar_EG",
    // ).then((value) => addressDetailsFROM = value.first.street.toString());

    await getItContext!
        .read<MapServicesProvider>()
        .getAddress(LatLng(position.latitude, position.longitude))
        .then((value) {
      addressDetailsFROM = value.results![0].formattedAddress!;
      notifyListeners();
    });

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
    // notifyListeners();
  }

  @override
  Future getActiveClientTrips(
      {required int? id, required BuildContext context}) async {
    circularDialog(context);
    await _apiProvider.get(
      apiRoute: activeClientTripsURL,
      successResponse: (response) {
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
  }

  @override
  getFinishClientTrips({required int? id, required BuildContext context}) {
    throw UnimplementedError();
  }
}
