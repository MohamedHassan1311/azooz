import 'dart:collection';

import 'package:azooz/common/config/convert_farsi_numbers.dart';
import 'package:azooz/providers/payment_provider.dart';
import 'package:azooz/utils/dialogs.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../app.dart';
import '../common/config/tools.dart';
import '../common/routes/app_router_control.dart';
import '../common/routes/app_router_import.gr.dart';
import '../model/error_model.dart';
import '../model/mixin/advertisement_mixin.dart';
import '../model/response/advertisement_model.dart';
import '../service/network/api_provider.dart';
import '../service/network/url_constants.dart';
import '../view/screen/maps/get_location_api.dart';
import 'location_provider.dart';

class AdvertisementProvider extends ChangeNotifier with AdvertisementMixin {
  final ApiProvider _apiProvider = ApiProvider.internal();
  late ErrorModel _errorModel;
  late AdvertisementModel _advertisementModel;

  AdvertisementModel get advertisementModel => _advertisementModel;

  bool loadingPagination = false;
  bool endPage = false;

  List<Advertisement>? _paginationList = [];

  Marker? marker;
  LatLng? position;
  bool? hasMarker = false;
  bool? loading = false;
  BitmapDescriptor? markerIcon;

  FormData? _body;

  int locationId = 0;
  String selectedAdsName = '';
  String selectedAdsDetails = '';
  String selectedAdsPlace = '';

  String? fromDate;
  String? toDate;

  String setFrom(String val) {
    notifyListeners();
    return fromDate = val;
  }

  String setTo(String val) {
    notifyListeners();
    return toDate = val;
  }

  Future selectedAdsLocation({
    required int favoriteLocationId,
    required String name,
    required String details,
    required LatLng latLng,
  }) async {
    // List<Placemark> placemark = await placemarkFromCoordinates(
    //   latLng.latitude,
    //   latLng.longitude,
    //   localeIdentifier: "ar_EG",
    // );
    // selectedAdsPlace = placemark[0].street ?? "";

    await getItContext!
        .read<MapServicesProvider>()
        .getAddress(latLng)
        .then((value) {
      selectedAdsPlace = value.results![0].formattedAddress!;
      notifyListeners();
    });

    locationId = favoriteLocationId;
    selectedAdsName = name;
    selectedAdsDetails = details;
    notifyListeners();
  }

  @override
  Future<AdvertisementModel> getAdvertisements({
    required int? page,
    required BuildContext context,
  }) async {
    if (page != 1) {
      loadingPagination = true;
      notifyListeners();
    }

    await _apiProvider.get(
      apiRoute: getAdvertisementURL,
      queryParameters: {
        'Page': page,
      },
      successResponse: (response) {
        _advertisementModel = AdvertisementModel.fromJson(response);
        if (_advertisementModel.result!.advertisement!.isNotEmpty) {
          _paginationList!.addAll(
            LinkedHashSet<Advertisement>.from(
                    _advertisementModel.result!.advertisement!)
                .toList(),
          );
          final Map<String, Advertisement> mapPagination = {};

          for (var item in _paginationList!) {
            mapPagination[item.id.toString()] = item;
          }
          _paginationList = mapPagination.values.toList();
        } else {
          endPage = true;
          // notifyListeners();
        }
        loadingPagination = false;

        // notifyListeners();
      },
      errorResponse: (response) {
        _errorModel = ErrorModel.fromJson(response);
        errorDialog(context, _errorModel.message.toString());
        loadingPagination = false;
        // notifyListeners();
      },
    );
    notifyListeners();

    return _advertisementModel;
  }

  @override
  Future<void> addAdvertisement({
    required BuildContext context,
    required String? address,
    required String? contactNumber,
    String? whatsappNumber,
    required int? favoriteLocationId,
    required String? details,
    required String? imagePath,
  }) async {
    circularDialog(context);
    print('@@@@@ ${_body?.fields}');
    imagePath != null && imagePath != ''
        ? _body = FormData.fromMap({
            "AdvertiseAddress": address,
            "ContactNumber": contactNumber,
            "WhatsappNumber": "",
            "ContactBy": 1,
            "favoriteLocationId": favoriteLocationId,
            "From": convertArabicToEng(fromDate),
            "To": convertArabicToEng(toDate),
            "AdvertiseDetails": details,
            "Image": await MultipartFile.fromFile(imagePath),
          })
        : _body = FormData.fromMap({
            "AdvertiseAddress": address,
            "ContactNumber": contactNumber,
            "WhatsappNumber": "",
            "ContactBy": 1,
            "favoriteLocationId": favoriteLocationId,
            "From": convertArabicToEng(fromDate),
            "To": convertArabicToEng(toDate),
            "AdvertiseDetails": details,
            "Image": null,
          });

    await _apiProvider.post(
      apiRoute: addAdvertisementURL,
      successResponse: (response) {
        AdsResult adsResult = AdsResult.fromJson(response);
        print("#### adsResult::: ${adsResult.result}");
        dismissDialog(context);
        successDialogWithTimer(context);
        routerReplace(
            context: context,
            route: PaymentScreenRoute(
              amount: 0.0,
              id: adsResult.result!.id!,
              paymentTypeId: context.read<PaymentProvider>().payRechargeId,
            ));
        getAdvertisements(context: context, page: 1);
        disposeData();
        notifyListeners();
      },
      errorResponse: (response) {
        _errorModel = ErrorModel.fromJson(response);

        dismissDialog(context);

        errorDialog(context, _errorModel.message);
        notifyListeners();
      },
      data: _body,
    );
    notifyListeners();
  }

  @override
  Future<void> editAdvertisement({
    required String? address,
    required String? contactNumber,
    required String? details,
    required double? price,
    required BuildContext context,
    required double? lat,
    required double? lng,
    required String? imagePath,
    required int? id,
  }) async {
    circularDialog(context);

    imagePath != null && imagePath != ''
        ? _body = FormData.fromMap({
            "id": id,
            "AdvertiseAddress": address,
            "ContactNumber": contactNumber,
            "Price": price,
            "ContactBy": 0,
            "Lat": lat,
            "Lng": lng,
            "AdvertiseDetails": details,
            "Image": await MultipartFile.fromFile(imagePath),
          })
        : _body = FormData.fromMap({
            "id": id,
            "AdvertiseAddress": address,
            "ContactNumber": contactNumber,
            "Price": price,
            "ContactBy": 0,
            "Lat": lat,
            "Lng": lng,
            "AdvertiseDetails": details,
          });

    await _apiProvider.put(
      apiRoute: editAdvertisementURL,
      successResponse: (response) {
        getAdvertisements(page: 1, context: context);
        dismissDialog(context);
        successDialogWithTimer(context);
        getAdvertisements(context: context, page: 1);
        notifyListeners();
      },
      errorResponse: (response) {
        _errorModel = ErrorModel.fromJson(response);

        dismissDialog(context);
        errorDialog(context, _errorModel.message);
        notifyListeners();
      },
      data: _body,
    );
    notifyListeners();
  }

  @override
  Future<void> deleteAdvertisement({
    required BuildContext context,
    required int? id,
  }) async {
    circularDialog(context);
    await _apiProvider.delete(
      apiRoute: deleteAdvertisementURL,
      successResponse: (response) {
        dismissDialog(context);
        successDialogWithTimer(context);

        _paginationList!.removeWhere((element) => element.id == id);
        notifyListeners();
      },
      errorResponse: (response) {
        _errorModel = ErrorModel.fromJson(response);
        dismissDialog(context);
        errorDialog(context, _errorModel.message);
        notifyListeners();
      },
      data: {
        "id": id,
      },
    );
    notifyListeners();
  }

  @override
  addOneMarker(LatLng position) {
    this.position = position;
    hasMarker = true;
    logger.d(
        'Position Detected: Lat => ${this.position!.latitude} - Lng => ${this.position!.longitude}');
    marker = Marker(
      markerId: MarkerId(UniqueKey().toString()),
      position: LatLng(this.position!.latitude, this.position!.longitude),
      icon: markerIcon!,
      infoWindow: const InfoWindow(title: 'موقع العنوان '),
    );
    notifyListeners();
  }

  @override
  Future<void> getMarkerIcon({
    required BuildContext context,
    required String? path,
    int? width,
  }) async {
    var provider = Provider.of<LocationProvider>(context, listen: false);
    markerIcon = await provider.getBitmapDescriptorFromAssetBytes(
      path!,
      width!,
    );
    notifyListeners();
  }

  @override
  disposeData() {
    hasMarker = false;
    paginationList!.clear();
    locationId = 0;
    selectedAdsName = '';
    selectedAdsDetails = '';
    selectedAdsPlace = '';
    fromDate = null;
    toDate = null;
  }

  List<Advertisement>? get paginationList => _paginationList;
}

class AdsResult {
  Result? result;
  String? msg;

  AdsResult({this.result, this.msg});

  AdsResult.fromJson(Map<String, dynamic> json) {
    result = json['result'] != null ? Result.fromJson(json['result']) : null;
    msg = json['msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (result != null) {
      data['result'] = result!.toJson();
    }
    data['msg'] = msg;
    return data;
  }
}

class Result {
  int? id;

  Result({this.id});

  Result.fromJson(Map<String, dynamic> json) {
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    return data;
  }
}
