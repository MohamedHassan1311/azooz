import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../response/advertisement_model.dart';

mixin AdvertisementMixin {
  Future<AdvertisementModel> getAdvertisements({
    required int? page,
    required BuildContext context,
  });

  addOneMarker(LatLng position);

  Future<void> getMarkerIcon({
    required BuildContext context,
    required String? path,
    required int? width,
  });

  Future<void> addAdvertisement({
    required BuildContext context,
    required String? address,
    required String? contactNumber,
    String? whatsappNumber,
    required int? favoriteLocationId,
    required String? details,
    required String? imagePath,
  });

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
  });

  Future<void> deleteAdvertisement({
    required BuildContext context,
    required int? id,
  });

  disposeData();
}
