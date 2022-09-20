import 'package:azooz/app.dart';
import 'package:azooz/common/style/dimens.dart';
import 'package:azooz/service/network/url_constants.dart';
import 'package:azooz/view/screen/maps/get_location_api.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../../../../common/style/colors.dart';
import '../../../../model/response/home_model.dart';
import '../../../custom_widget/marquee_widget.dart';
import '../../../screen/maps/google_map_address.dart';

class OffersWidget extends StatefulWidget {
  final List<Advertisement>? list;

  const OffersWidget({Key? key, required this.list}) : super(key: key);

  @override
  State<OffersWidget> createState() => _OffersWidgetState();
}

class _OffersWidgetState extends State<OffersWidget> {
  final int _current = 0;
  late CarouselController _controller;

  @override
  void initState() {
    super.initState();
    _controller = CarouselController();
  }

  @override
  void dispose() {
    _controller.stopAutoPlay();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.list != null && widget.list!.isEmpty
        ? const SizedBox()
        : SizedBox(
            // color: Colors.blue,
            width: MediaQuery.of(context).size.width,
            height: 130,
            child: CarouselSlider.builder(
              options: CarouselOptions(
                viewportFraction: 0.90,
                aspectRatio: 16 / 9,
                pauseAutoPlayOnTouch: true,
                autoPlay: true,
              ),
              itemBuilder: (context, index, index2) {
                return _OffersSliderCard(
                  adsItem: widget.list![index],
                );
              },
              itemCount: widget.list!.length,
              carouselController: _controller,
              // items: widget.list!.map((e) => const Text("ABC")).toList(),
            ),
          );
  }
}

class _OffersSliderCard extends StatelessWidget {
  const _OffersSliderCard({
    Key? key,
    required this.adsItem,
  }) : super(key: key);

  final Advertisement adsItem;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: Stack(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) {
                  return _AdsGoogleMap(
                    addsTilte: adsItem.advertiseAddress!,
                    latLng: LatLng(
                      adsItem.lat!,
                      adsItem.lng!,
                    ),
                  );
                }),
              );
            },
            child: ClipRRect(
              borderRadius: kBorderRadius5,
              child: CachedNetworkImage(
                imageUrl: baseImageURL + adsItem.url!,
                fit: BoxFit.cover,
                width: MediaQuery.of(context).size.width,
              ),
            ),
          ),
          Positioned(
            // right: 10,
            bottom: 0,
            child: Center(
              child: Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width * 0.90,
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      adsItem.advertiseAddress.toString(),
                      style: Theme.of(context).textTheme.subtitle1!.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    MarqueeWidget(
                      child: Text(
                        adsItem.advertiseDetails.toString(),
                        style: Theme.of(context).textTheme.subtitle1!.copyWith(
                              color: Colors.white,
                            ),
                      ),
                    ),
                    const SizedBox(height: 5),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _AdsGoogleMap extends StatelessWidget {
  const _AdsGoogleMap({
    Key? key,
    required this.latLng,
    required this.addsTilte,
  }) : super(key: key);

  final LatLng latLng;
  final String addsTilte;

  Future<String?> getCurrentAddress() async {
    // List<Placemark> placemark = await placemarkFromCoordinates(
    //   latLng.latitude,
    //   latLng.longitude,
    //   localeIdentifier: "ar_EG",
    // );

    MapLocationModel getLocation = await getItContext!
        .read<MapServicesProvider>()
        .getAddress(LatLng(latLng.latitude, latLng.longitude));

    return getLocation.results![0].formattedAddress;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
        addsTilte,
        style: const TextStyle(
          color: Colors.black,
        ),
      )),
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: latLng,
                    zoom: 10,
                  ),
                  myLocationEnabled: true,
                  onMapCreated: (controller) {
                    controller.animateCamera(
                      CameraUpdate.newLatLngZoom(
                        latLng,
                        14,
                      ),
                    );
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
            height: 100,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            alignment: Alignment.center,
            color: Palette.kWhite,
            child: Center(
              child: FutureBuilder<String?>(
                  future: getCurrentAddress(),
                  builder: (context, snapshot) {
                    return Text(
                      snapshot.data ?? "",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                    );
                  }),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomMarkerIcon extends StatelessWidget {
  const CustomMarkerIcon({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Image.asset(
        'assets/images/azooz_drop.png',
        width: 45,
      ),
    );
  }
}
