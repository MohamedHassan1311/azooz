import 'dart:async';

import '../../generated/locale_keys.g.dart';
import '../../providers/advertisement_provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../widget/home/stores/offers_widget.dart';

class LocationOnMapScreen extends StatefulWidget {
  static const String routeName = 'location_on_map';

  const LocationOnMapScreen({Key? key}) : super(key: key);

  @override
  State<LocationOnMapScreen> createState() => _LocationOnMapScreenState();
}

class _LocationOnMapScreenState extends State<LocationOnMapScreen> {
  static const CameraPosition adsGoogleMap = CameraPosition(
    target: LatLng(30.033333, 31.233334),
    zoom: 7,
  );
  final Completer<GoogleMapController> _controller = Completer();

  late final AdvertisementProvider provider;

  LatLng? positionPicked;

  @override
  void initState() {
    super.initState();
    provider = Provider.of<AdvertisementProvider>(context, listen: false);
    provider.getMarkerIcon(
      context: context,
      path: 'assets/images/azooz_drop.png',
      width: 65,
    );
    if (provider.position != null) {
      positionPicked = provider.position;
      provider.addOneMarker(positionPicked!);
    }
    // provider.disposeData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          LocaleKeys.chooseAddress.tr(),
        ),
      ),
      body: Stack(
        children: [
          GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition: adsGoogleMap,
            zoomControlsEnabled: false,
            compassEnabled: false,
            // markers: Provider.of<AdvertisementProvider>(context)
            //                 .hasMarker ==
            //             true &&
            //         Provider.of<AdvertisementProvider>(context)
            //                 .position !=
            //             const LatLng(0, 0) &&
            //         Provider.of<AdvertisementProvider>(context).marker !=
            //             null
            //     ? {Provider.of<AdvertisementProvider>(context).marker!}
            //     : {},
            // onLongPress: (position) {
            //   Provider.of<AdvertisementProvider>(context, listen: false)
            //       .addOneMarker(position);
            //   positionPicked = position;
            // },
            // gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{
            //   Factory<OneSequenceGestureRecognizer>(
            //     () => EagerGestureRecognizer(),
            //   ),
            // },
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
          ),
          const Positioned(
            top: 0,
            left: 0,
            right: 0,
            bottom: 40,
            child: CustomMarkerIcon(),
          ),
        ],
      ),
    );
  }
}
