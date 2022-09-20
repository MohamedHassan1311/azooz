import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../../../../../common/circular_progress.dart';
import '../../../../../common/config/map_custom_style.dart';
import '../../../../../common/style/colors.dart';
import '../../../../../generated/locale_keys.g.dart';
import '../../../../../providers/be_partner_provider.dart';
import '../../../../custom_widget/custom_button.dart';
import '../../../../custom_widget/custom_loading_widget.dart';
import '../../../home/stores/offers_widget.dart';

class CustomGoogleMap extends StatefulWidget {
  const CustomGoogleMap({Key? key}) : super(key: key);

  @override
  State<CustomGoogleMap> createState() => _CustomGoogleMapState();
}

class _CustomGoogleMapState extends State<CustomGoogleMap> {
  final Completer<GoogleMapController> _controller = Completer();

  late Future<LatLng> _futureGetCurrentStoreLocation;

  @override
  void initState() {
    super.initState();
    context.read<BePartnerProvider>().disposeData();
    _futureGetCurrentStoreLocation =
        context.read<BePartnerProvider>().getStoreLocation();
  }

  @override
  void dispose() {
    context.read<BePartnerProvider>().disposeData();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "مكان المتجر على الخريطة",
          style: TextStyle(
            color: Colors.black,
            fontSize: 17,
          ),
        ),
      ),
      body: FutureBuilder<LatLng>(
          future: _futureGetCurrentStoreLocation,
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data != null) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Stack(
                      children: [
                        GoogleMap(
                          mapType: MapType.normal,
                          initialCameraPosition: CameraPosition(
                            target: snapshot.data!,
                            zoom: 16.5,
                          ),
                          zoomControlsEnabled: false,
                          compassEnabled: false,
                          onCameraIdle: () {
                            context
                                .read<BePartnerProvider>()
                                .getStreetNameOnCameraMoves();
                          },
                          onCameraMove: (CameraPosition newPosition) {
                            context
                                .read<BePartnerProvider>()
                                .onCameraMoves(newPosition);
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
                      ],
                    ),
                  ),
                  Container(
                    height: 200,
                    decoration: const BoxDecoration(
                      color: Palette.kWhite,
                      borderRadius: BorderRadiusDirectional.only(
                        topEnd: Radius.circular(20),
                        topStart: Radius.circular(20),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Selector<BePartnerProvider, String>(
                          selector: (p0, p1) => p1.selectedAddressName,
                          builder: (context, val, child) {
                            if (val.isEmpty) {
                              return const SizedBox(
                                height: 100,
                                child: CustomProgressIndicator(),
                              );
                            }
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: SizedBox(
                                height: 100,
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.place,
                                      color: Palette.primaryColor,
                                    ),
                                    const SizedBox(width: 5),
                                    Expanded(
                                      child: Text(
                                        val.toString(),
                                        maxLines: 2,
                                        style: TextStyle(
                                          color: Palette.primaryColor
                                              .withOpacity(0.7),
                                          fontWeight: FontWeight.bold,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                        Center(
                          child: CustomButton(
                            text: LocaleKeys.save.tr(),
                            onPressed: () {
                              context
                                  .read<BePartnerProvider>()
                                  .saveSelectedAddress()
                                  .then((value) {
                                if (value == true) {
                                  Navigator.pop(context);
                                }
                              });
                            },
                            width: MediaQuery.of(context).size.width * 0.90,
                            height: 45,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            } else {
              return const CustomLoadingWidget();
            }
          }),
    );
  }
}
