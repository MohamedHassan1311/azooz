import 'package:azooz/service/network/url_constants.dart';
import 'package:azooz/utils/formate_date.dart';
import 'package:azooz/view/screen/payment/payment_screen.dart';
import 'package:azooz/view/widget/image_viewer.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../../../../app.dart';
import '../../../../common/config/tools.dart';
import '../../../../common/style/colors.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../../../model/response/advertisement_model.dart';
import '../../../../providers/advertisement_provider.dart';
import '../../../../providers/payment_provider.dart';
import '../../../custom_widget/custom_cached_image_widget.dart';
import '../../../custom_widget/custom_error_widget.dart';
import '../../../custom_widget/custom_loading_widget.dart';
import '../../../custom_widget/marquee_widget.dart';
import '../../../screen/maps/get_location_api.dart';
import '../../home/stores/offers_widget.dart';

class AdvertsListWidget extends StatefulWidget {
  const AdvertsListWidget({Key? key}) : super(key: key);

  @override
  State<AdvertsListWidget> createState() => _AdvertsListWidgetState();
}

class _AdvertsListWidgetState extends State<AdvertsListWidget> {
  int page = 1;

  late Future<AdvertisementModel> futureGetAllAds;
  late final AdvertisementProvider provider;

  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    provider = Provider.of<AdvertisementProvider>(context, listen: false);
    futureGetAllAds = provider.getAdvertisements(page: page, context: context);
    scrollController.addListener(scrollListener);
  }

  @override
  void dispose() {
    scrollController.removeListener(scrollListener);
    scrollController.dispose();
    super.dispose();
  }

  scrollListener() => Tools.scrollListener(
        scrollController: scrollController,
        getMoreData: getMoreData,
      );

  getMoreData() {
    if (!provider.endPage) {
      if (provider.loadingPagination == false) {
        page++;
        provider.getAdvertisements(page: page, context: context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<AdvertisementModel>(
        future: futureGetAllAds,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Consumer<AdvertisementProvider>(
              builder: (context, provider, child) {
                if (provider.paginationList!.isEmpty) {
                  return Center(
                    child: Text(
                      LocaleKeys.noData.tr(),
                    ),
                  );
                }
                return ListView.builder(
                  padding: const EdgeInsets.only(bottom: 70),
                  controller: scrollController,
                  itemCount: provider.paginationList!.length + 1,
                  itemBuilder: (context, index) {
                    if (index == provider.paginationList!.length) {
                      return provider.loadingPagination
                          ? const CustomLoadingPaginationWidget()
                          : const SizedBox();
                    }
                    return AdsCustomCard(
                      advertisement: provider.paginationList![index],
                      provider: provider,
                    );
                  },
                );
              },
            );
          } else {
            return snapshot.hasError
                ? const CustomErrorWidget()
                : const CustomLoadingWidget();
          }
        });
  }
}

class AdsCustomCard extends StatelessWidget {
  const AdsCustomCard({
    Key? key,
    required this.advertisement,
    required this.provider,
  }) : super(key: key);

  final Advertisement advertisement;
  final AdvertisementProvider provider;

  @override
  Widget build(BuildContext context) {
    print("##advertisement :: ${advertisement.payed}");
    return Container(
      height: 450,
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        color: Palette.secondaryDark,
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ImageViewer(
                          image: baseImageURL + advertisement.image!,
                          isFromInternet: true,
                        ),
                      ),
                    );
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: CachedImageBorderRadius(
                      width: double.infinity,
                      height: 120,
                      boxFit: BoxFit.fitWidth,
                      imageUrl: advertisement.image,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 10),
              // Location & details
              Container(
                height: 50,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.date_range_outlined, size: 17),
                            const SizedBox(width: 3),
                            Text(
                              adsFormatDate(advertisement.from!),
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1!
                                  .copyWith(
                                    fontWeight: FontWeight.normal,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.date_range, size: 17),
                            const SizedBox(width: 3),
                            Text(
                              adsFormatDate(advertisement.to!),
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1!
                                  .copyWith(
                                    fontWeight: FontWeight.normal,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 10),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${LocaleKeys.advertisementAddress.tr()}: ${advertisement.advertiseAddress}',
                    ),
                    const SizedBox(height: 3),
                    Text(
                      '${LocaleKeys.advertisementNumber.tr()}: ${advertisement.id}',
                    ),
                    Text(
                      '${LocaleKeys.advertisementDetails.tr()}: ${advertisement.advertiseDetails}',
                      // maxLines: 1,
                      // overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 3),
                    Text(
                      '${LocaleKeys.contactNumber.tr()}: ${advertisement.contactNumber}',
                      // maxLines: 1,
                      // overflow: TextOverflow.ellipsis,
                    ),
                    Row(
                      children: [
                        RawMaterialButton(
                          fillColor: Colors.white,
                          shape: const CircleBorder(),
                          constraints:
                              const BoxConstraints(maxWidth: 37, maxHeight: 37),
                          padding: const EdgeInsets.all(5),
                          onPressed: () {
                            final favoriteLocation =
                                advertisement.favoriteLocation!;
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (_) {
                                return OpenAddressOnMapScreen(
                                  location: LatLng(
                                    favoriteLocation.lat!,
                                    favoriteLocation.lng!,
                                  ),
                                  adsNumber: advertisement.id.toString(),
                                );
                              }),
                            );
                          },
                          child: const Icon(
                            Icons.place,
                            color: Palette.primaryColor,
                            size: 20,
                          ),
                        ),
                        const SizedBox(width: 10),
                        MarqueeWidget(
                          child: Text(
                            // advertisement.favoriteLocation!.details.toString(),
                            advertisement.favoriteLocation!.title.toString(),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // const Divider(),

              const SizedBox(height: 14),
              // TODO: PAYMENT NEEDED
              if (advertisement.payed == false)
                GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) {
                      return PaymentScreen(
                        id: advertisement.id!,
                        paymentTypeId:
                            context.read<PaymentProvider>().payRechargeId,
                        amount: advertisement.price!,
                      );
                    })).then(
                      (value) => context
                          .read<AdvertisementProvider>()
                          .getAdvertisements(page: 1, context: context),
                    );
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: 50,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Palette.primaryColor,
                    ),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.payment,
                            size: 24,
                            color: Palette.kWhite.withOpacity(0.8),
                          ),
                          const SizedBox(width: 3),
                          Text(
                            "دفع الإعلان",
                            style:
                                Theme.of(context).textTheme.subtitle2!.copyWith(
                                      color: Palette.kWhite,
                                    ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
            ],
          ),
          Positioned(
            top: 0,
            left: 0,
            child: RawMaterialButton(
              fillColor: Palette.kWhite,
              shape: const CircleBorder(),
              constraints: const BoxConstraints(maxWidth: 50, maxHeight: 50),
              padding: const EdgeInsets.all(7),
              onPressed: () {
                context.read<AdvertisementProvider>().deleteAdvertisement(
                      context: context,
                      id: advertisement.id,
                    );
              },
              child: const Icon(
                Icons.delete,
                color: Color.fromARGB(208, 46, 42, 42),
                size: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class OpenAddressOnMapScreen extends StatefulWidget {
  const OpenAddressOnMapScreen({
    Key? key,
    required this.location,
    required this.adsNumber,
  }) : super(key: key);

  final LatLng location;
  final String adsNumber;

  @override
  State<OpenAddressOnMapScreen> createState() => _OpenAddressOnMapScreenState();
}

class _OpenAddressOnMapScreenState extends State<OpenAddressOnMapScreen> {
  String? address;
  _getLocation() async {
    // List<Placemark> placemark = await placemarkFromCoordinates(
    //   widget.location.latitude,
    //   widget.location.longitude,
    //   localeIdentifier: "ar_EG",
    // );
    await getItContext!
        .read<MapServicesProvider>()
        .getAddress(LatLng(widget.location.latitude, widget.location.longitude))
        .then((value) {
      setState(() {
        address = value.results![0].formattedAddress!;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _getLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.adsNumber,
          style: const TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: widget.location,
                    zoom: 17,
                  ),
                  myLocationEnabled: true,
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
              child: Text(
                address ?? "",
                textAlign: TextAlign.center,
                // maxLines: 1,
                style: const TextStyle(
                  color: Colors.black,
                  // overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
