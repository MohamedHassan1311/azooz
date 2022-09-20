import 'dart:async';

import '../../../../common/config/map_custom_style.dart';
import '../../../../model/screen_argument/address_argument.dart';
import '../../../../providers/address_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../../../custom_widget/custom_loading_widget.dart';
import '../../home/stores/offers_widget.dart';
import 'add_address_bottom_widget.dart';

class AddAddressWidget extends StatefulWidget {
  final AddressArgument? argument;

  const AddAddressWidget({Key? key, required this.argument}) : super(key: key);

  @override
  State<AddAddressWidget> createState() => _AddAddressWidgetState();
}

class _AddAddressWidgetState extends State<AddAddressWidget> {
  final Completer<GoogleMapController> _controller = Completer();

  late Future<LatLng> _futureGetCurrentLocation;

  @override
  void initState() {
    super.initState();

    _futureGetCurrentLocation =
        context.read<AddressProvider>().getUserLocation();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<LatLng>(
        future: _futureGetCurrentLocation,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            LatLng initLatLng =
                Provider.of<AddressProvider>(context, listen: false).initialPos;
            return Column(
              children: [
                Expanded(
                  child: Stack(
                    children: [
                      GoogleMap(
                        mapType: MapType.normal,
                        initialCameraPosition: initLatLng != const LatLng(0, 0)
                            ? CameraPosition(
                                target: initLatLng,
                                zoom: 16.5,
                              )
                            : CameraPosition(
                                target: context
                                    .read<AddressProvider>()
                                    .currentLatLng,
                                zoom: 16.5,
                              ),
                        zoomControlsEnabled: false,
                        compassEnabled: false,
                        onCameraIdle: () {
                          context
                              .read<AddressProvider>()
                              .getStreetNameOnCameraMoves();
                        },
                        onCameraMove: (CameraPosition newPosition) {
                          context
                              .read<AddressProvider>()
                              .onCameraMove(newPosition);
                          Provider.of<AddressProvider>(context, listen: false)
                              .addOneMarker(
                            LatLng(newPosition.target.latitude,
                                newPosition.target.longitude),
                          );
                        },
                        // onMapCreated: (GoogleMapController controller) {
                        //   _controller.complete(controller);
                        //   controller.animateCamera(
                        //     CameraUpdate.newCameraPosition(
                        //       CameraPosition(
                        //         target: context.read<AddressProvider>().position!,
                        //         zoom: 16.5,
                        //       ),
                        //     ),
                        //   );
                        // },

                        onMapCreated: (GoogleMapController controller) {
                          _controller.complete(controller);
                          _controller.future.then((value) {
                            value.setMapStyle(mapCustomStyle);
                          });
                          // controller.animateCamera(
                          //   CameraUpdate.newCameraPosition(
                          //     CameraPosition(
                          //       target: context.read<AddressProvider>().currentLatLng,
                          //       zoom: 16.5,
                          //     ),
                          //   ),
                          // );
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
                ),
                AddAddressBottomWidget(argument: widget.argument),
              ],
            );
          } else {
            return const CustomLoadingWidget();
          }
        });
  }
}

// Stack(
//               children: [
//                 GoogleMap(
//                   mapType: MapType.normal,
//                   initialCameraPosition: _kGooglePlex,
//                   zoomControlsEnabled: false,
//                   compassEnabled: false,
//                   onCameraIdle: () {
//                     context.read<CurrentLocationProvider>().getStreetNameOnCameraMoves();
//                   },
//                   onCameraMove: (CameraPosition newPosition) {
//                     context
//                         .read<CurrentLocationProvider>()
//                         .onCameraMove(newPosition);
//                   },
//                   onMapCreated: (GoogleMapController controller) {
//                     _controller.complete(controller);
//                     controller.animateCamera(
//                       CameraUpdate.newCameraPosition(
//                         CameraPosition(
//                           target: context
//                               .read<CurrentLocationProvider>()
//                               .currentLatLng,
//                           zoom: 16.5,
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//                 Positioned(
//                   top: 0,
//                   left: 0,
//                   right: 0,
//                   bottom: 0,
//                   child: Align(
//                     alignment: Alignment.center,
//                     child: Image.asset(
//                       'assets/images/azooz_drop.png',
//                       width: 50,
//                     ),
//                   ),
//                 ),
//               ],
//             )
