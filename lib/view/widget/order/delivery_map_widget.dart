import 'dart:async';

import '../../../common/style/colors.dart';
import 'package:flutter/material.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'delivery_bottom_widget.dart';

class DeliveryMapWidget extends StatefulWidget {
  const DeliveryMapWidget({Key? key}) : super(key: key);

  @override
  State<DeliveryMapWidget> createState() => _DeliveryMapWidgetState();
}

class _DeliveryMapWidgetState extends State<DeliveryMapWidget> {
  final Completer<GoogleMapController> _controller = Completer();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(30.033333, 31.233334),
    zoom: 7,
  );

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: 0.89,
          width: 1,
          child: GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition: _kGooglePlex,
            zoomControlsEnabled: false,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
          ),
        ),
        Positioned(
          bottom: 0,
          child: Container(
            width: 1,
            padding: const EdgeInsets.only(bottom: 10),
            decoration: const BoxDecoration(
              color: Palette.kWhite,
              borderRadius: BorderRadiusDirectional.only(
                topEnd: Radius.circular(20),
                topStart: Radius.circular(20),
              ),
            ),
            child: const DeliveryBottomWidget(),
          ),
        ),
      ],
    );
  }
}
