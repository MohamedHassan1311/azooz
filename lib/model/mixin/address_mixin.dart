import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../request/add_address_model.dart';
import '../request/delete_address_model.dart';
import '../request/edit_address_model.dart';

mixin AddressMixin {
  dynamic getAddress({
    required int? page,
    required BuildContext context,
  });

  dynamic addAddress({
    required AddAddressModel addAddressModel,
    required BuildContext context,
  });

  dynamic editAddress({
    required EditAddressModel editAddressModel,
    required BuildContext context,
  });

  dynamic deleteAddress({
    required DeleteAddressModel deleteAddressModel,
    required BuildContext context,
  });

  dynamic addOneMarker(LatLng position) {}

  dynamic disposeData() {}

  dynamic getMarkerIcon({
    required BuildContext context,
    required String? path,
    required int? width,
  }) {}

  bool? isLoading(bool? loading) {
    return null;
  }

  dynamic filterAddress(String queryWord) {}

  Future selectedLocation(
      {required double lat, required double lng, required String name});
}
