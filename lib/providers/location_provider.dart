import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import '../common/config/tools.dart';
import '../model/mixin/location_mixin.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:ui' as ui;

import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationProvider extends ChangeNotifier with LocationMixin {
  final GeolocatorPlatform _geoLocatorPlatform = GeolocatorPlatform.instance;
  StreamSubscription<Position>? _positionStreamSubscription;
  StreamSubscription<ServiceStatus>? _serviceStatusStreamSubscription;
  bool positionStreamStarted = false;
  Position? currentPosition;
  Position? lastKnownPosition;
  LocationSettings? locationSettings;

  StreamSubscription<Position>? positionStream;

  @override
  Future<bool> isLocationServiceEnabled() async =>
      await Geolocator.isLocationServiceEnabled();

  @override
  Future<void> getCurrentPosition() async {
    final hasPermission = await handlePermission();

    if (!hasPermission) {
      notifyListeners();
      return;
    }

    currentPosition = await _geoLocatorPlatform.getCurrentPosition();

    logger.d('Current Position: Lat => ${currentPosition!.latitude} - Lng => ${currentPosition!.longitude}');

    notifyListeners();
  }

  @override
  getLastKnownPosition() async {
    lastKnownPosition = await _geoLocatorPlatform.getLastKnownPosition();
    if (lastKnownPosition != null) {
      logger.d(
          'Last Known Position: Lat => ${lastKnownPosition!.latitude} - Lng => ${lastKnownPosition!.longitude}');
      notifyListeners();
    } else {
      logger.w('No Last known position available');
      notifyListeners();
    }
    notifyListeners();
  }

  @override
  handleLocationAccuracyStatus({LocationAccuracyStatus? status}) {
    String locationAccuracyStatusValue;
    if (status == LocationAccuracyStatus.precise) {
      locationAccuracyStatusValue = 'Precise';
      logger.i('$locationAccuracyStatusValue Location Accuracy Granted');
      notifyListeners();
    } else if (status == LocationAccuracyStatus.reduced) {
      locationAccuracyStatusValue = 'Reduced';
      logger.w('$locationAccuracyStatusValue Location Accuracy Granted');
      notifyListeners();
    } else {
      locationAccuracyStatusValue = 'Unknown';
      logger.e('$locationAccuracyStatusValue Location Accuracy Granted');
      notifyListeners();
    }

    notifyListeners();
  }

  @override
  openAppSettings() async {
    final opened = await _geoLocatorPlatform.openAppSettings();

    if (opened) {
      logger.i('Opened Application Settings');
      notifyListeners();
    } else {
      logger.e('Error opening Application Settings');
      notifyListeners();
    }
    notifyListeners();
  }

  @override
  Future<bool> handlePermission() async {
    bool serviceEnabled;
    LocationPermission permission;
    // Test if location services are enabled.
    serviceEnabled = await _geoLocatorPlatform.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      logger.w('Location services are disabled');

      notifyListeners();

      return false;
    }

    permission = await _geoLocatorPlatform.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await _geoLocatorPlatform.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        logger.e('Location Permission Denied');

        notifyListeners();

        return false;
      }
      notifyListeners();
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      logger.e('Location Permission Denied Forever');

      notifyListeners();

      return false;
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.

    logger.i('Location Permission Granted');

    notifyListeners();

    return true;
  }

  @override
  onDispose() {
    if (_positionStreamSubscription != null) {
      _positionStreamSubscription!.cancel();
      _positionStreamSubscription = null;
      notifyListeners();
    }
  }

  @override
  Future<void> openLocationSettings() async {
    final opened = await _geoLocatorPlatform.openLocationSettings();

    if (opened) {
      logger.i('Opened Location Settings');
      notifyListeners();
    } else {
      logger.e('Error Opening Location Settings');
      notifyListeners();
    }

    notifyListeners();
  }

  @override
  bool isListening() {
    notifyListeners();
    return !(_positionStreamSubscription == null ||
        _positionStreamSubscription!.isPaused);
  }

  @override
  requestTemporaryFullAccuracy() async {
    final status = await _geoLocatorPlatform.requestTemporaryFullAccuracy(
      purposeKey: "TemporaryPreciseAccuracy",
    );
    handleLocationAccuracyStatus(status: status);
    notifyListeners();
  }

  @override
  toggleListening() {
    if (_positionStreamSubscription == null) {
      final positionStream = _geoLocatorPlatform.getPositionStream();
      _positionStreamSubscription = positionStream.handleError((error) {
        _positionStreamSubscription?.cancel();
        _positionStreamSubscription = null;
      }).listen(
        (position) => logger.d(
            'Toggle Listening: Lat => ${position.latitude} - Lng => ${position.longitude}'),
      );
      _positionStreamSubscription?.pause();
      notifyListeners();
    }
  }

  @override
  positionStreamListen() {
    if (Platform.isAndroid) {
      locationSettings = AndroidSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 100,
        forceLocationManager: true,
        intervalDuration: const Duration(seconds: 2),
      );
      notifyListeners();
    } else if (Platform.isIOS) {
      locationSettings = AppleSettings(
        accuracy: LocationAccuracy.high,
        activityType: ActivityType.fitness,
        distanceFilter: 100,
        pauseLocationUpdatesAutomatically: true,
      );
      notifyListeners();
    } else {
      locationSettings = const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 100,
      );
      notifyListeners();
    }
    positionStream =
        Geolocator.getPositionStream(locationSettings: locationSettings).listen(
      (Position? position) {
        position == null
            ? logger.e('Position Stream Listen Unknown')
            : logger.d(
                'Position Stream Listen: Lat => ${position.latitude} - Lng => ${position.longitude}');

        notifyListeners();
      },
    );
    notifyListeners();
  }

  @override
  double bearing({
    required double? startLat,
    required double? startLng,
    required double? endLat,
    required double? endLng,
  }) {
    logger.d(
        'Bearing: Start Lat => $startLat - Start Lng => $startLng - End Lat => $endLat - End Lng => $endLng');
    notifyListeners();
    return _geoLocatorPlatform.bearingBetween(
      startLat!,
      startLng!,
      endLat!,
      endLng!,
    );
  }

  @override
  double distanceInMeters({
    required double? startLat,
    required double? startLng,
    required double? endLat,
    required double? endLng,
  }) {
    logger.d(
        'Distance: Start Lat => $startLat - Start Lng => $startLng - End Lat => $endLat - End Lng => $endLng');
    notifyListeners();
    return _geoLocatorPlatform.distanceBetween(
      startLat!,
      startLng!,
      endLat!,
      endLng!,
    );
  }

  @override
  toggleServiceStatusStream() {
    if (_serviceStatusStreamSubscription == null) {
      final serviceStatusStream = _geoLocatorPlatform.getServiceStatusStream();
      _serviceStatusStreamSubscription =
          serviceStatusStream.handleError((error) {
        _serviceStatusStreamSubscription?.cancel();
        _serviceStatusStreamSubscription = null;
      }).listen((serviceStatus) {
        if (serviceStatus == ServiceStatus.enabled) {
          if (positionStreamStarted) {
            toggleListening();
          }
          logger.i('Location Service has been Enabled');
          notifyListeners();
        } else {
          if (_positionStreamSubscription != null) {
            _positionStreamSubscription?.cancel();
            _positionStreamSubscription = null;
            logger.e('Position Stream has been Canceled');
            notifyListeners();
          }
          logger.e('Location Service has been Disabled');
          notifyListeners();
        }
      });
      notifyListeners();
    }
    notifyListeners();
  }

  @override
  Future<BitmapDescriptor> getBitmapDescriptorFromAssetBytes(
      String path, int width) async {
    final result =
        BitmapDescriptor.fromAssetImage(const ImageConfiguration(), path);
    // notifyListeners();
    return result;
  }

  @override
  Future<Uint8List?> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    final result = (await fi.image.toByteData(format: ui.ImageByteFormat.png))
        ?.buffer
        .asUint8List();
    notifyListeners();
    return result;
  }

  @override
  Future<void> getMarkerIcon({
    required BuildContext context,
    required String? path,
    required int? width,
    required BitmapDescriptor? markerIcon,
  }) async {
    markerIcon = await getBitmapDescriptorFromAssetBytes(
      path!,
      width!,
    );
    notifyListeners();
  }
}
