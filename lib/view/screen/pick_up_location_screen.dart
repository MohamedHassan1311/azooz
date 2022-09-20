import 'dart:async';

import 'package:azooz/providers/client_trips/current_location_provider.dart';
import 'package:azooz/view/custom_widget/custom_loading_widget.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';

import '../../common/circular_progress.dart';
import '../../common/config/keys.dart';
import '../../common/config/map_custom_style.dart';
import '../../common/config/orders_types.dart';
import '../../common/config/tools.dart';
import '../../common/style/colors.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../generated/locale_keys.g.dart';
import '../../model/request/trip_price_calculate_model.dart';
import '../../model/response/orders_types_model.dart';
import '../../providers/client_trips/trip_price_calculator_provider.dart';
import '../../providers/client_trips_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../../providers/orders_provider.dart';
import '../../utils/util_shared.dart';
import '../custom_widget/custom_button.dart';
import '../widget/home/stores/offers_widget.dart';

class PickUpLocationScreen extends StatefulWidget {
  const PickUpLocationScreen({Key? key}) : super(key: key);

  @override
  State<PickUpLocationScreen> createState() => _PickUpLocationScreenState();
}

class _PickUpLocationScreenState extends State<PickUpLocationScreen> {
  final Completer<GoogleMapController> _controller = Completer();

  late ClientTripsProvider clientTripsProvider;

  late Future<LatLng> _futureGetCurrentLatLng;
  bool isLoading = false;

  String currentLang = UtilShared.readStringPreference(key: keyLocale);

  @override
  void initState() {
    super.initState();
    getPloylines();
    print("I am picked up point");
    _futureGetCurrentLatLng =
        context.read<CurrentLocationProvider>().getCurrentLatLng();
    context.read<CurrentLocationProvider>().clear();
  }

  getPloylines() async {
    PolylinePoints polylinePoints = PolylinePoints();

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      mapsApiKey,
      const PointLatLng(
        30.0066,
        31.4416,
      ),
      const PointLatLng(
        29.9754,
        31.2376,
      ),
    );

    if (result.points.isNotEmpty) {
      // ignore: avoid_function_literals_in_foreach_calls
      result.points.forEach((PointLatLng pointi) {
        polylineCoordinates.add(
          LatLng(pointi.latitude, pointi.longitude),
        );
      });
      setState(() {});
    }
  }

  List<LatLng> polylineCoordinates = [];
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          LocaleKeys.pickUpPoint.tr(),
          style: const TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: FutureBuilder<LatLng>(
          future: _futureGetCurrentLatLng,
          builder: (context, snapshot) {
            LatLng? pickUpLocationLatLng =
                context.read<ClientTripsProvider>().positionFROM;
            return snapshot.hasData && snapshot.data != null
                ? Column(
                    children: [
                      Expanded(
                        child: Stack(
                          children: [
                            GoogleMap(
                              polylines: {
                                Polyline(
                                  polylineId: const PolylineId("poly"),
                                  color: Colors.red,
                                  points: polylineCoordinates,
                                ),
                              },
                              mapType: MapType.normal,
                              initialCameraPosition: CameraPosition(
                                target:
                                    (pickUpLocationLatLng != const LatLng(0, 0))
                                        ? pickUpLocationLatLng
                                        : snapshot.data!,
                                zoom: 16.0,
                              ),
                              zoomControlsEnabled: false,
                              myLocationButtonEnabled: false,
                              myLocationEnabled: true,
                              onCameraIdle: () {
                                context
                                    .read<CurrentLocationProvider>()
                                    .getStreetNameOnCameraMovesPickUp();
                              },
                              onCameraMove: (CameraPosition newPosition) {
                                context
                                    .read<CurrentLocationProvider>()
                                    .onCameraMovePickUp(newPosition);
                              },
                              onMapCreated: (GoogleMapController controller) {
                                _controller.complete(controller);

                                _controller.future.then((value) {
                                  value.setMapStyle(mapCustomStyle);
                                });
                              },
                            ),
                            const Positioned(
                              top: 0,
                              left: 0,
                              right: 0,
                              bottom: 35,
                              child: CustomMarkerIcon(),
                            ),

                            Positioned(
                              left: 14,
                              bottom: 35,
                              child: MaterialButton(
                                color: Palette.kWhite,
                                shape: const CircleBorder(),
                                padding: const EdgeInsets.all(14),
                                height: 50,
                                minWidth: 50,
                                onPressed: () async {
                                  await Geolocator.getCurrentPosition(
                                    desiredAccuracy: LocationAccuracy.high,
                                  ).then((position) {
                                    _controller.future.then((value) {
                                      value.animateCamera(
                                        CameraUpdate.newCameraPosition(
                                          CameraPosition(
                                            target: LatLng(position.latitude,
                                                position.longitude),
                                            zoom: 16.0,
                                          ),
                                        ),
                                      );
                                    });
                                    print(
                                        "position.latitude:: ${position.latitude}");
                                    logger.d(
                                        "position.latitude:: ${position.latitude}");
                                  });
                                },
                                child: const Icon(
                                  Icons.my_location,
                                  color: Color(0xFF323639),
                                ),
                              ),
                            ),
                            // currentLang == "ar"
                            //     ? Positioned(
                            //         bottom: 10,
                            //         left: 13,
                            //         child: RawMaterialButton(
                            //           onPressed: () {
                            //             print("### I am now left ###");
                            //             // Move Camera to current location
                            //             _controller.future.then((value) {
                            //               value.animateCamera(
                            //                 CameraUpdate.newCameraPosition(
                            //                   CameraPosition(
                            //                     target: snapshot.data!,
                            //                     zoom: 18.0,
                            //                   ),
                            //                 ),
                            //               );
                            //             });
                            //           },
                            //           fillColor: Colors.white,
                            //           constraints: const BoxConstraints(
                            //             maxHeight: 50,
                            //             maxWidth: 50,
                            //           ),
                            //           shape: const CircleBorder(),
                            //           padding: const EdgeInsets.all(7.0),
                            //           child: const Icon(
                            //             Icons.my_location,
                            //           ),
                            //         ),
                            //       )
                            //     : Positioned(
                            //         bottom: 10,
                            //         right: 13,
                            //         child: RawMaterialButton(
                            //           onPressed: () {
                            //             print("### I am now right ###");
                            //             // Move Camera to current location
                            //             _controller.future.then((value) {
                            //               value.animateCamera(
                            //                 CameraUpdate.newCameraPosition(
                            //                   CameraPosition(
                            //                     target: snapshot.data!,
                            //                     zoom: 18.0,
                            //                   ),
                            //                 ),
                            //               );
                            //             });
                            //           },
                            //           fillColor: Colors.white,
                            //           constraints: const BoxConstraints(
                            //             maxHeight: 50,
                            //             maxWidth: 50,
                            //           ),
                            //           shape: const CircleBorder(),
                            //           padding: const EdgeInsets.all(7.0),
                            //           child: const Icon(
                            //             Icons.my_location,
                            //           ),
                            //         ),
                            //       ),
                          ],
                        ),
                      ),
                      // Address Details & Confirmation Button
                      Container(
                        height: 150,
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          // borderRadius: BorderRadius.vertical(
                          //   top: Radius.circular(20),
                          // ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(
                              height: 50,
                              child: Selector<CurrentLocationProvider, String?>(
                                selector: (_, provider) =>
                                    provider.currentAddressPickUp,
                                builder: (context, text, child) {
                                  if (text != null && text.isNotEmpty) {
                                    return SizedBox(
                                      height: 30,
                                      child: Text(
                                        text,
                                        textAlign: TextAlign.center,
                                      ),
                                    );
                                  } else {
                                    return const CustomProgressIndicator();
                                  }
                                },
                              ),
                            ),
                            SizedBox(
                              height: 50,
                              child: Consumer<ClientTripsProvider>(
                                builder: (context, value, child) {
                                  return isLoading
                                      ? const Center(
                                          child: SizedBox(
                                            width: 25,
                                            height: 25,
                                            child: Center(
                                              child: CircularProgressIndicator(
                                                valueColor:
                                                    AlwaysStoppedAnimation(
                                                        Palette.primaryColor),
                                              ),
                                            ),
                                          ),
                                        )
                                      : CustomButton(
                                          text: LocaleKeys.confirm.tr(),
                                          onPressed: value.showButton == false
                                              ? null
                                              : () {
                                                  isLoading = true;

                                                  var provider = context.read<
                                                      ClientTripsProvider>();

                                                  var currentLocation =
                                                      context.read<
                                                          CurrentLocationProvider>();

                                                  print(
                                                      "======= #Selected Location - PickUp: ${currentLocation.currentLatLngPickUp} =======");

                                                  var fromLatLng = context
                                                      .read<
                                                          ClientTripsProvider>()
                                                      .positionFROM;

                                                  var toLatLng = context
                                                      .read<
                                                          ClientTripsProvider>()
                                                      .positionTO;

                                                  if (currentLocation
                                                              .currentLatLngPickUp !=
                                                          const LatLng(0, 0) &&
                                                      toLatLng !=
                                                          const LatLng(0, 0)) {
                                                    context
                                                        .read<
                                                            ClientTripsProvider>()
                                                        .isDistanceConfirmed(
                                                            context,
                                                            fromLatLng:
                                                                toLatLng,
                                                            toLatLng:
                                                                currentLocation
                                                                    .currentLatLngPickUp!)
                                                        .then((value) {
                                                      setState(() {
                                                        isLoading = false;
                                                      });

                                                      context
                                                          .read<
                                                              TripPriceCalculatorProvider>()
                                                          .setTripLocationDetails(
                                                            context: context,
                                                            tripPriceCalculate:
                                                                TripPriceCalculateModel(
                                                              fromLat: provider
                                                                  .positionFROM
                                                                  .latitude,
                                                              fromLng: provider
                                                                  .positionFROM
                                                                  .longitude,
                                                              toLat: provider
                                                                  .positionTO
                                                                  .latitude,
                                                              toLng: provider
                                                                  .positionTO
                                                                  .longitude,
                                                            ),
                                                          );
                                                      // Save Location Data
                                                      provider.addMarkerFROM(
                                                          currentLocation
                                                              .currentLatLngPickUp!);
                                                      OrdersTypesModel
                                                          currentOrderType =
                                                          context
                                                              .read<
                                                                  OrdersProvider>()
                                                              .getOrderType;
                                                      if (currentOrderType
                                                              .type ==
                                                          ClientOrdersTypes
                                                              .delayedTrip) {
                                                        context
                                                            .read<
                                                                TripPriceCalculatorProvider>()
                                                            .getPrice(
                                                                context:
                                                                    context);
                                                      }
                                                      Navigator.pop(context);
                                                    }).catchError((error) {
                                                      setState(() {
                                                        isLoading = false;
                                                      });
                                                      error;
                                                      showDialog(
                                                          context: context,
                                                          builder: (context) {
                                                            return AlertDialog(
                                                              actions: [
                                                                TextButton(
                                                                  onPressed:
                                                                      () {
                                                                    Navigator.pop(
                                                                        context);
                                                                  },
                                                                  child:
                                                                      const Text(
                                                                          "حسنا"),
                                                                )
                                                              ],
                                                              content: Text(
                                                                error.message[
                                                                        'message']
                                                                    .toString(),
                                                                style:
                                                                    const TextStyle(
                                                                  fontSize: 16,
                                                                ),
                                                              ),
                                                            );
                                                          });
                                                    });
                                                  } else {
                                                    setState(() {
                                                      isLoading = false;
                                                    });

                                                    context
                                                        .read<
                                                            TripPriceCalculatorProvider>()
                                                        .setTripLocationDetails(
                                                          context: context,
                                                          tripPriceCalculate:
                                                              TripPriceCalculateModel(
                                                            fromLat: provider
                                                                .positionFROM
                                                                .latitude,
                                                            fromLng: provider
                                                                .positionFROM
                                                                .longitude,
                                                            toLat: provider
                                                                .positionTO
                                                                .latitude,
                                                            toLng: provider
                                                                .positionTO
                                                                .longitude,
                                                          ),
                                                        );

                                                    // Save Location Data
                                                    provider.addMarkerFROM(
                                                        currentLocation
                                                            .currentLatLngPickUp!);
                                                    OrdersTypesModel
                                                        currentOrderType =
                                                        context
                                                            .read<
                                                                OrdersProvider>()
                                                            .getOrderType;
                                                    if (currentOrderType.type ==
                                                        ClientOrdersTypes
                                                            .delayedTrip) {
                                                      context
                                                          .read<
                                                              TripPriceCalculatorProvider>()
                                                          .getPrice(
                                                              context: context);
                                                    }
                                                    print(
                                                        "fromLatLng:: $fromLatLng");
                                                    print(
                                                        "################## Pick Up Location #################");
                                                    print(
                                                        "toLatLng:: $toLatLng");
                                                    Navigator.pop(context);
                                                  }
                                                },
                                        );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                : const CustomLoadingWidget();
          }),
    );
  }
}

// #################
