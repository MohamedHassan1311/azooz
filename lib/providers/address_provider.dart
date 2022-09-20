import 'dart:collection';

import 'package:azooz/app.dart';
import 'package:azooz/utils/dialogs.dart';
import 'package:azooz/view/screen/maps/get_location_api.dart';
import 'package:flutter/material.dart';

import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../common/config/tools.dart';
import '../model/error_model.dart';
import '../model/mixin/address_mixin.dart';
import '../model/request/add_address_model.dart';
import '../model/request/delete_address_model.dart';
import '../model/request/edit_address_model.dart';
import '../model/response/address_model.dart';
import '../service/network/api_provider.dart';
import '../service/network/url_constants.dart';
import 'location_provider.dart';

class AddressProvider extends ChangeNotifier with AddressMixin {
  final ApiProvider _apiProvider = ApiProvider.internal();
  late ErrorModel _errorModel;
  late AddressModel _addressModel;
  Marker? marker;
  LatLng? position;
  bool? hasMarker = false;
  bool? loading = false;
  List<FavoriteLocation>? _filteredList = [];
  List<FavoriteLocation>? _paginationList = [];
  // LatLng _initialposition = const LatLng(29.9602, 31.2569);
  late LatLng _initialPosition;
  // LatLng _initLatLng = const LatLng(29.9602, 31.2569);
  late LatLng _savedLatLng;

  LatLng get currentLatLng => _savedLatLng;

  LatLng get initialPos => _initialPosition;
  TextEditingController locationController = TextEditingController();
  late GoogleMapController _mapController;

  BitmapDescriptor? markerIcon;

  double selectedLat = 0;
  double selectedLng = 0;
  String selectedName = '';

  bool loadingPagination = false;
  bool endPage = false;

  Future<LatLng> getUserLocation() async {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    // List<Placemark> placemark = await placemarkFromCoordinates(
    //   position.latitude,
    //   position.longitude,
    //   localeIdentifier: "ar_EG",
    // );
    _initialPosition = LatLng(position.latitude, position.longitude);
    await getItContext!
        .read<MapServicesProvider>()
        .getAddress(LatLng(position.latitude, position.longitude))
        .then((value) {
      locationController.text = value.results![0].formattedAddress!;
      selectedName = value.results![0].formattedAddress!;
      notifyListeners();
    });

    notifyListeners();
    return _initialPosition;
  }

  Future getStreetNameOnCameraMoves() async {
    if (position != null && position != const LatLng(0, 0)) {
      // List<Placemark> placemark = await placemarkFromCoordinates(
      //   position!.latitude,
      //   position!.longitude,
      //   localeIdentifier: "ar_EG",
      // );
      // selectedName = placemark[0].street!;

      await getItContext!
          .read<MapServicesProvider>()
          .getAddress(LatLng(position!.latitude, position!.longitude))
          .then((value) {
        selectedName = value.results![0].formattedAddress!;
        notifyListeners();
      });

      notifyListeners();
    }
  }

  Future<String> getStreetName() async {
    // List<Placemark> placemark = await placemarkFromCoordinates(
    //   position!.latitude,
    //   position!.longitude,
    //   localeIdentifier: "ar_EG",
    // );
    // notifyListeners();
    // return placemark[0].street!;
    late String StreetName;
    await getItContext!
        .read<MapServicesProvider>()
        .getAddress(LatLng(position!.latitude, position!.longitude))
        .then((value) {
      StreetName = value.results![0].formattedAddress!;
      notifyListeners();
    });
    notifyListeners();
    return StreetName;
  }

  void onCameraMove(CameraPosition position) async {
    _savedLatLng = position.target;
    notifyListeners();
  }

  void onCreated(GoogleMapController controller) {
    _mapController = controller;
    _mapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: _initialPosition, zoom: 15.0),
      ),
    );

    _mapController.moveCamera(CameraUpdate.newLatLng(_initialPosition));
    notifyListeners();
  }

  @override
  Future<AddressModel> getAddress({
    required int? page,
    required BuildContext context,
  }) async {
    if (page != 1) {
      loadingPagination = true;
      notifyListeners();
    }
    // dialogAlert(context);
    await _apiProvider.get(
      apiRoute: getAddressURL,
      queryParameters: {
        'Page': page,
      },
      successResponse: (response) {
        _addressModel = AddressModel.fromJson(response);
        if (_addressModel.result!.favoriteLocations!.isNotEmpty) {
          _filteredList!.addAll(
            LinkedHashSet<FavoriteLocation>.from(
                    _addressModel.result!.favoriteLocations!)
                .toList(),
          );
          _paginationList!.addAll(
            LinkedHashSet<FavoriteLocation>.from(
                    _addressModel.result!.favoriteLocations!)
                .toList(),
          );

          final Map<String, FavoriteLocation> mapFilter = {};
          final Map<String, FavoriteLocation> mapPagination = {};
          for (var item in _filteredList!) {
            mapFilter[item.id.toString()] = item;
          }
          for (var item in _paginationList!) {
            mapPagination[item.id.toString()] = item;
          }

          _filteredList = mapFilter.values.toList();
          _paginationList = mapPagination.values.toList();
          // dismissDialog(getItContext);
          notifyListeners();
        } else {
          endPage = true;
          notifyListeners();
        }
        loadingPagination = false;
        notifyListeners();
      },
      errorResponse: (response) {
        _errorModel = ErrorModel.fromJson(response);
        loadingPagination = false;
        errorDialog(context, _errorModel.message.toString());
        notifyListeners();
      },
    );
    // notifyListeners();

    return _addressModel;
  }

  @override
  Future<void> addAddress({
    required AddAddressModel addAddressModel,
    required BuildContext context,
  }) async {
    circularDialog(context);
    await _apiProvider.post(
      apiRoute: addAddressURL,
      successResponse: (response) {
        getAddress(page: 1, context: context);
        dismissDialog(getItContext);
        dismissDialog(getItContext);
        notifyListeners();
      },
      errorResponse: (response) {
        _errorModel = ErrorModel.fromJson(response);
        dismissDialog(getItContext);
        errorDialog(context, _errorModel.message.toString());
        notifyListeners();
      },
      data: addAddressModel.toJson(),
    );
    // notifyListeners();
  }

  @override
  Future<void> deleteAddress({
    required DeleteAddressModel deleteAddressModel,
    required BuildContext context,
  }) async {
    circularDialog(context);
    await _apiProvider.delete(
      apiRoute: deleteAddressURL,
      successResponse: (response) {
        _filteredList!
            .removeWhere((element) => element.id == deleteAddressModel.id);
        _paginationList!
            .removeWhere((element) => element.id == deleteAddressModel.id);
        dismissDialog(getItContext);
        successDialogWithTimer(context);
        notifyListeners();
      },
      errorResponse: (response) {
        _errorModel = ErrorModel.fromJson(response);
        dismissDialog(getItContext);

        errorDialog(context, _errorModel.message.toString());
        notifyListeners();
      },
      data: deleteAddressModel.toJson(),
    );
    notifyListeners();
  }

  @override
  Future<void> editAddress({
    required EditAddressModel editAddressModel,
    required BuildContext context,
  }) async {
    circularDialog(context);
    await _apiProvider.put(
      apiRoute: editAddressURL,
      successResponse: (response) {
        dismissDialog(getItContext);
        getAddress(page: 1, context: context);
        successDialogWithTimer(context)
            .then((value) => dismissDialog(getItContext));
        notifyListeners();
      },
      errorResponse: (response) {
        _errorModel = ErrorModel.fromJson(response);
        dismissDialog(getItContext);
        errorDialog(context, _errorModel.message.toString());
        notifyListeners();
      },
      data: editAddressModel.toJson(),
    );
    notifyListeners();
  }

  @override
  addOneMarker(LatLng position) {
    this.position = position;
    hasMarker = true;
    _savedLatLng = position;
    logger.d(
        'Position Detected: Lat => ${this.position!.latitude} - Lng => ${this.position!.longitude}');
    marker = Marker(
      // markerId: MarkerId(UniqueKey().toString()),
      markerId: const MarkerId("singleMarker"),
      position: LatLng(this.position!.latitude, this.position!.longitude),
      icon: markerIcon!,
      infoWindow: const InfoWindow(title: 'موقع العنوان'),
    );
    notifyListeners();
  }

  @override
  void disposeData() {
    position = const LatLng(0, 0);
    hasMarker = false;
    // _filteredList!.clear();
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
    notifyListeners();
  }

  @override
  bool? isLoading(bool? loading) {
    this.loading = loading;
    notifyListeners();
    return null;
  }

  @override
  List<FavoriteLocation>? filterAddress(String queryWord) {
    Iterable<FavoriteLocation> result = [];
    if (queryWord.trim().isNotEmpty) {
      result = _paginationList!.where(
        (element) => element.title!.toLowerCase().contains(
              queryWord.toLowerCase().trim(),
            ),
      );
      notifyListeners();
    } else {
      result = _paginationList!;
      notifyListeners();
    }
    _filteredList = result.toSet().toList();
    notifyListeners();
    return _filteredList;
  }

  @override
  Future selectedLocation({
    required double lat,
    required double lng,
    required String name,
  }) async {
    selectedLat = lat;
    selectedLng = lng;
    selectedName = name;
    notifyListeners();
  }

  List<FavoriteLocation>? get filteredList => _filteredList;
  late FavoriteLocation _selectedAdsLocation;
  FavoriteLocation get getSelectedAdsLocation => _selectedAdsLocation;

  AddressModel get addressModel => _addressModel;
}
