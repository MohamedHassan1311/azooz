import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

mixin LocationMixin {
  dynamic handlePermission();

  dynamic getCurrentPosition();

  dynamic getLastKnownPosition();

  dynamic handleLocationAccuracyStatus({LocationAccuracyStatus? status});

  dynamic openAppSettings();

  dynamic openLocationSettings();

  dynamic onDispose();

  dynamic isListening();

  dynamic toggleListening();

  dynamic toggleServiceStatusStream();

  dynamic requestTemporaryFullAccuracy();

  dynamic positionStreamListen();

  dynamic isLocationServiceEnabled();

  Future<Uint8List?> getBytesFromAsset(String path, int width);

  Future<BitmapDescriptor> getBitmapDescriptorFromAssetBytes(
      String path, int width);

  dynamic distanceInMeters({
    required double? startLat,
    required double? startLng,
    required double? endLat,
    required double? endLng,
  });

  dynamic bearing({
    required double? startLat,
    required double? startLng,
    required double? endLat,
    required double? endLng,
  });

  getMarkerIcon({
    required BuildContext context,
    required String? path,
    required int? width,
    required BitmapDescriptor? markerIcon,
  });
}
