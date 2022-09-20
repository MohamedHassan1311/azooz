import 'package:azooz/common/config/keys.dart';
import 'package:azooz/view/screen/maps/google_map_address.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../service/network/api_provider.dart';

class MapServicesProvider extends ChangeNotifier {
  final ApiProvider apiProvider = ApiProvider.internal();
  late MapLocationModel address;
  Future<MapLocationModel> getAddress(
    LatLng latLng,
  ) async {
    await apiProvider.get(
      apiRoute: "https://maps.googleapis.com/maps/api/geocode/json?",
      queryParameters: {
        "latlng": "${latLng.latitude},${latLng.longitude}",
        "key": mapsApiKey,
        "language": "ar",
      },
      successResponse: (response) {
        address = MapLocationModel.fromJson(response);
        print("I am aaadddd ${address.results![2].formattedAddress}");
        notifyListeners();
      },
      errorResponse: (response) {},
    );
    notifyListeners();

    return address;
  }
}
