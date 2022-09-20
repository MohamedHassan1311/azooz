import 'dart:async';
import 'dart:developer';

import 'package:azooz/common/custom_waiting_dialog.dart';
import 'package:azooz/providers/client_trips/current_location_provider.dart';
import 'package:azooz/view/custom_widget/custom_button.dart';
import 'package:azooz/view/custom_widget/custom_loading_widget.dart';

import '../../common/circular_progress.dart';
import '../../common/config/keys.dart';
import '../../common/config/map_custom_style.dart';
import '../../common/config/orders_types.dart';
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
import '../widget/home/stores/offers_widget.dart';

class ArriveLocationScreen extends StatefulWidget {
  const ArriveLocationScreen({Key? key}) : super(key: key);

  @override
  State<ArriveLocationScreen> createState() => _ArriveLocationScreenState();
}

class _ArriveLocationScreenState extends State<ArriveLocationScreen> {
  final Completer<GoogleMapController> _controller = Completer();

  late ClientTripsProvider clientTripsProvider;

  late Future<LatLng> _futureGetCurrentLatLng;

  bool isLoading = false;
  String currentLang = UtilShared.readStringPreference(key: keyLocale);

  @override
  void initState() {
    super.initState();
    _futureGetCurrentLatLng =
        context.read<CurrentLocationProvider>().getCurrentLatLng();
    context.read<CurrentLocationProvider>().clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          LocaleKeys.arrivePoint.tr(),
          style: const TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: FutureBuilder<LatLng>(
          future: _futureGetCurrentLatLng,
          builder: (context, snapshot) {
            LatLng? arriveLocationLatLng =
                context.read<ClientTripsProvider>().positionTO;
            return snapshot.hasData && snapshot.data != null
                ? Column(
                    children: [
                      Expanded(
                        child: Stack(
                          children: [
                            GoogleMap(
                              mapType: MapType.normal,
                              initialCameraPosition: CameraPosition(
                                target:
                                    (arriveLocationLatLng != const LatLng(0, 0))
                                        ? arriveLocationLatLng
                                        : snapshot.data!,
                                zoom: 16.0,
                              ),
                              zoomControlsEnabled: false,
                              compassEnabled: false,
                              onCameraIdle: () {
                                context
                                    .read<CurrentLocationProvider>()
                                    .getStreetNameOnCameraMovesArrive();
                              },
                              onCameraMove: (CameraPosition newPosition) {
                                context
                                    .read<CurrentLocationProvider>()
                                    .onCameraMoveArrive(newPosition);
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
                              bottom: 40,
                              child: CustomMarkerIcon(),
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
                            Selector<CurrentLocationProvider, String?>(
                              selector: (_, provider) =>
                                  provider.currentAddressArrive,
                              builder: (context, text, child) {
                                if (text != null) {
                                  return SizedBox(
                                    height: 30,
                                    child: Text(
                                      text,
                                      textAlign: TextAlign.center,
                                    ),
                                  );
                                } else {
                                  return const Text("");
                                }
                              },
                            ),
                            SizedBox(
                              height: 50,
                              child: Consumer<ClientTripsProvider>(
                                builder: (context, value, child) {
                                  return isLoading
                                      ? const CustomProgressIndicator()
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
                                                      "======= #Selected Location - Arrive: ${currentLocation.currentLatLngArrive} =======");

                                                  var fromLatLng = context
                                                      .read<
                                                          ClientTripsProvider>()
                                                      .positionFROM;

                                                  var toLatLng = context
                                                      .read<
                                                          ClientTripsProvider>()
                                                      .positionTO;

                                                  if (currentLocation
                                                              .currentLatLngArrive !=
                                                          const LatLng(0, 0) &&
                                                      fromLatLng !=
                                                          const LatLng(0, 0)) {
                                                    context
                                                        .read<
                                                            ClientTripsProvider>()
                                                        .isDistanceConfirmed(
                                                            context,
                                                            fromLatLng:
                                                                fromLatLng,
                                                            toLatLng:
                                                                currentLocation
                                                                    .currentLatLngArrive!)
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
                                                      provider.addMarkerTO(
                                                          currentLocation
                                                              .currentLatLngArrive!);
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
                                                            log('SmartSingleAlertDialog');
                                                            return SmartSingleAlertDialog(
                                                              description: error
                                                                  .message[
                                                                      'message']
                                                                  .toString(),
                                                              cancelPress: () {
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                              cancelText:
                                                                  "حسنا",
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
                                                    provider.addMarkerTO(
                                                        currentLocation
                                                            .currentLatLngArrive!);
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
                                                        "################## Arrive Location #################");
                                                    print(
                                                        "toLatLng:: $toLatLng");
                                                    Navigator.pop(context);
                                                  }
                                                },
                                        );
                                },
                              ),
                            ),

                            // RawMaterialButton(
                            //   padding:
                            //       const EdgeInsets.symmetric(horizontal: 70),
                            //   constraints: const BoxConstraints(
                            //       minWidth: 100, minHeight: 35),
                            //   elevation: 0.0,
                            //   highlightElevation: 0.0,
                            //   fillColor: Palette.primaryColor,
                            //   onPressed: () {
                            //     var provider =
                            //         context.read<ClientTripsProvider>();
                            //     var currentLocation =
                            //         context.read<CurrentLocationProvider>();
                            //     // Save Location Data
                            //     provider.addMarkerTO(
                            //         currentLocation.currentLatLngArrive!);
                            //     OrdersTypesModel currentOrderType =
                            //         context.read<OrdersProvider>().getOrderType;
                            //     if (currentOrderType.type ==
                            //         OrdersTypes.delayedTrip) {
                            //       context
                            //           .read<TripPriceCalculatorProvider>()
                            //           .getPrice(context: context);
                            //     }

                            //     // context
                            //     //     .read<CalculateDistanceProvider>()
                            //     //     .getDistance(
                            //     //       context,
                            //     //     );

                            //     Navigator.pop(context);
                            //   },
                            //   shape: const RoundedRectangleBorder(
                            //     borderRadius: BorderRadius.all(
                            //       Radius.circular(7),
                            //     ),
                            //   ),
                            //   child: Text(
                            //     LocaleKeys.confirm.tr(),
                            //     style: const TextStyle(
                            //       color: Colors.white,
                            //     ),
                            //   ),
                            // ),
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
