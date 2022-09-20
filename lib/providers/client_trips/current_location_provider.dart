import 'package:azooz/app.dart';
import 'package:azooz/view/screen/maps/get_location_api.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:provider/provider.dart';

@immutable
class CurrentLocationProvider extends ChangeNotifier {
  LatLng? _initLatLngPickUp;
  LatLng? _initLatLngArrive;
  String? _currentAddressPickUp;
  String? _currentAddressArrive;

  final Set<Marker> _markers = {};
  late BitmapDescriptor _markerIcon;

  BitmapDescriptor get globalMarker => _markerIcon;

  late bool isLoading;

  /// Getters
  LatLng? get currentLatLngPickUp => _initLatLngPickUp;
  LatLng? get currentLatLngArrive => _initLatLngArrive;
  String? get currentAddressPickUp => _currentAddressPickUp;
  String? get currentAddressArrive => _currentAddressArrive;

  Set<Marker> get markers => _markers;

  // void _addMarker(LatLng location, String address) {
  //   _markers.add(
  //     Marker(
  //       markerId: MarkerId(location.toString()),
  //       position: location,
  //     ),
  //   );
  //   notifyListeners();
  // }

  set setCurrentLatLng(LatLng latLng) {
    _initLatLngPickUp = latLng;
    _initLatLngArrive = latLng;
    notifyListeners();
  }

  void onCameraMovePickUp(CameraPosition position) async {
    _initLatLngPickUp = position.target;

    notifyListeners();
  }

  void onCameraMoveArrive(CameraPosition position) async {
    _initLatLngArrive = position.target;
    notifyListeners();
  }

  Future<bool> getStreetNameOnCameraMovesPickUp() async {
    _currentAddressPickUp = "";
    bool isSuccess = false;

    if (_initLatLngPickUp != null) {
      // List<Placemark> placemark = await placemarkFromCoordinates(
      //   _initLatLngPickUp!.latitude,
      //   _initLatLngPickUp!.longitude,
      //   localeIdentifier: "ar_EG",
      // );
      // _currentAddressPickUp = placemark[0].street;

      getItContext!
          .read<MapServicesProvider>()
          .getAddress(
              LatLng(_initLatLngPickUp!.latitude, _initLatLngPickUp!.longitude))
          .then((value) {
        _currentAddressPickUp = value.results![0].formattedAddress;
        notifyListeners();
        isSuccess = true;
      });
    } else {
      isSuccess = false;
    }

    notifyListeners();
    return isSuccess;
  }

  Future getStreetNameOnCameraMovesArrive() async {
    _currentAddressArrive = "";
    try {
      // List<Placemark> placemark = await placemarkFromCoordinates(
      //   _initLatLngArrive!.latitude,
      //   _initLatLngArrive!.longitude,
      //   localeIdentifier: "ar_EG",
      // );
      // _currentAddressArrive = placemark[0].street;

      getItContext!
          .read<MapServicesProvider>()
          .getAddress(
              LatLng(_initLatLngArrive!.latitude, _initLatLngArrive!.longitude))
          .then((value) {
        _currentAddressArrive = value.results![0].formattedAddress;
        notifyListeners();
      });

      notifyListeners();
    } catch (e) {
      notifyListeners();
      print("I am error: $e");
    }
  }

  Future<LatLng> getCurrentLocation() async {
    isLoading = true;
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    // List<Placemark> placemark = await placemarkFromCoordinates(
    //   position.latitude,
    //   position.longitude,
    //   localeIdentifier: "ar_EG",
    // );
    await getItContext!
        .read<MapServicesProvider>()
        .getAddress(LatLng(position.latitude, position.longitude))
        .then((value) {
      _currentAddressPickUp = value.results![0].formattedAddress!;
      _currentAddressArrive = value.results![0].formattedAddress!;
      notifyListeners();
    });

    _initLatLngPickUp = LatLng(position.latitude, position.longitude);
    _initLatLngArrive = LatLng(position.latitude, position.longitude);
    // _currentAddressPickUp = placemark[0].name.toString();
    // _currentAddressArrive = placemark[0].name.toString();

    isLoading = false;
    notifyListeners();
    return LatLng(position.latitude, position.longitude);
  }

  Future<LatLng> getCurrentLatLng() async {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    notifyListeners();
    return LatLng(position.latitude, position.longitude);
  }

  void clear() {
    _currentAddressPickUp = null;
    _currentAddressArrive = null;
  }
}

class ProviderMaps with ChangeNotifier {
  late LatLng _gpsactual;
  LatLng? _initialposition;
  TextEditingController locationController = TextEditingController();
  late GoogleMapController _mapController;
  LatLng get gpsPosition => _gpsactual;
  LatLng? get initialPos => _initialposition;
  GoogleMapController get mapController => _mapController;

  void getStreetNameOnCameraMoves() async {
    if (_initialposition != null) {
      // List<Placemark> placemark = await placemarkFromCoordinates(
      //     _initialposition!.latitude, _initialposition!.longitude,
      //     localeIdentifier: "ar_EG");
      // locationController.text = placemark[0].name!;

      await getItContext!
          .read<MapServicesProvider>()
          .getAddress(
              LatLng(_initialposition!.latitude, _initialposition!.longitude))
          .then((value) {
        notifyListeners();
        locationController.text = value.results![0].formattedAddress!;
      });
    }
  }

  void getUserLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    _initialposition = LatLng(position.latitude, position.longitude);
    // List<Placemark> placemark = await placemarkFromCoordinates(
    //   position.latitude,
    //   position.longitude,
    //   localeIdentifier: "ar_EG",
    // );
    // locationController.text = placemark[0].name!;

    await getItContext!
        .read<MapServicesProvider>()
        .getAddress(LatLng(position.latitude, position.longitude))
        .then((value) {
      notifyListeners();
      locationController.text = value.results![0].formattedAddress!;
    });

    if (_initialposition != null) {
      _mapController.moveCamera(CameraUpdate.newLatLng(_initialposition!));
    }
    notifyListeners();
  }

  void onCreated(GoogleMapController controller) {
    _mapController = controller;
    if (_initialposition != null) {
      _mapController.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(target: _initialposition!, zoom: 15.0),
        ),
      );
    }

    notifyListeners();
  }

  void onCameraMove(CameraPosition position) async {
    print(position.target);
    _initialposition = position.target;
    notifyListeners();
  }
}
