import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../common/config/tools.dart';
import '../../../common/style/dimens.dart';
import '../../../generated/locale_keys.g.dart';
import '../../../model/response/stores_model.dart';
import '../../../providers/location_provider.dart';
import '../../../providers/store_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../custom_widget/custom_error_widget.dart';
import '../../custom_widget/custom_loading_widget.dart';

class CategoriesMapWidget extends StatefulWidget {
  const CategoriesMapWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<CategoriesMapWidget> createState() => _CategoriesMapWidgetState();
}

class _CategoriesMapWidgetState extends State<CategoriesMapWidget> {
  late Future<StoresModel> future;
  int page = 1;

  late final StoreProvider provider;

  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    provider = Provider.of<StoreProvider>(context, listen: false);
    future = provider.getStores(
      id: 1,
      searchWord: provider.searchWord!.isEmpty ? '' : provider.searchWord,
      page: page,
      lat: Provider.of<LocationProvider>(context, listen: false)
              .currentPosition
              ?.latitude ??
          0,
      lng: Provider.of<LocationProvider>(context, listen: false)
              .currentPosition
              ?.longitude ??
          0,
      context: context,
    );

    scrollController.addListener(scrollListener);
  }

  getMoreData() {
    if (!provider.endPage) {
      if (provider.loadingPagination == false) {
        page++;
        provider.getStores(
          id: 1,
          searchWord: provider.searchWord!.isEmpty ? '' : provider.searchWord,
          page: page,
          lat: Provider.of<LocationProvider>(context, listen: false)
                  .currentPosition
                  ?.latitude ??
              0,
          lng: Provider.of<LocationProvider>(context, listen: false)
                  .currentPosition
                  ?.longitude ??
              0,
          context: context,
        );
      }
    }
  }

  scrollListener() => Tools.scrollListener(
        scrollController: scrollController,
        getMoreData: getMoreData,
      );

  @override
  void dispose() {
    scrollController.removeListener(scrollListener);
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return sizedBox(
      height: screenHeight * 0.71,
      child: FutureBuilder<StoresModel>(
          future: future,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Consumer<StoreProvider>(
                builder: (context, provider, child) {
                  if (provider.loading == true) {
                    return const CustomLoadingWidget();
                  } else {
                    if (provider.filteredList.isEmpty) {
                      return CustomErrorWidget(
                        message: LocaleKeys.noSearchResults.tr(),
                      );
                    } else {
                      return _AllStoresInMaps(stores: provider.filteredList);
                    }
                  }
                },
              );
            } else {
              return snapshot.hasError
                  ? const CustomErrorWidget()
                  : const CustomLoadingWidget();
            }
          }),
    );
  }
}

class _AllStoresInMaps extends StatefulWidget {
  const _AllStoresInMaps({Key? key, required this.stores}) : super(key: key);

  final List<Stores> stores;

  @override
  State<_AllStoresInMaps> createState() => _AllStoresInMapsState();
}

class _AllStoresInMapsState extends State<_AllStoresInMaps> {
  late GoogleMapController _mapController;

  String? mapStyle;

  late BitmapDescriptor _bitmapFromAssets;

  Future<void> _showBottomDetails(Stores store) {
    return showModalBottomSheet(
        isScrollControlled: true,
        useRootNavigator: false,
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height / 2,
        ),
        context: context,
        builder: (BuildContext context) {
          return _BottomStoreDetails(selectedStore: store);
        });
  }

  final Map<String, Marker> _markers = {};
  Future<void> _onMapCreated(GoogleMapController controller) async {
    _mapController = controller;
    _bitmapFromAssets = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(), "assets/images/azooz_drop.png");

    _markers.clear();
    for (final store in widget.stores) {
      final marker = Marker(
        onTap: () {
          _showBottomDetails(store);
        },
        markerId: MarkerId(store.name!),
        position: LatLng(store.location!.lat!, store.location!.lng!),
        icon: _bitmapFromAssets,
        infoWindow: InfoWindow(
          title: store.name,
        ),
      );
      // _markers[store.name!] = marker;
      _markers.addAll({store.name!: marker});
    }

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    print("III am all stors in map:: ${widget.stores}");
    rootBundle.loadString('assets/map_style/map_style.txt').then((fileText) {
      mapStyle = fileText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      padding: const EdgeInsets.only(
        bottom: 30,
        right: 10,
      ),
      initialCameraPosition: CameraPosition(
        target: LatLng(
          widget.stores.first.location!.lat!,
          widget.stores.first.location!.lng!,
        ),
        zoom: 13,
      ),
      buildingsEnabled: true,
      myLocationButtonEnabled: false,
      markers: _markers.values.toSet(),
      zoomControlsEnabled: false,
      onMapCreated: _onMapCreated,
      onCameraMove: (position) {
        _mapController.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              target: LatLng(
                position.target.latitude,
                position.target.longitude,
              ),
              zoom: 13,
            ),
          ),
        );
      },
    );
    // return FutureBuilder<Position>(
    //   future: _futureLocationLatLng,
    //   builder: (context, snapshot) {
    //     return !snapshot.hasData
    //         ? const CustomLoadingWidget()
    //         : GoogleMap(
    //             padding: const EdgeInsets.only(
    //               bottom: 30,
    //               right: 10,
    //             ),
    //             initialCameraPosition: CameraPosition(
    //               target: LatLng(
    //                 snapshot.data!.latitude,
    //                 snapshot.data!.longitude,
    //               ),
    //               zoom: 13,
    //             ),
    //             buildingsEnabled: true,
    //             myLocationButtonEnabled: false,
    //             markers: _markers.values.toSet(),
    //             zoomControlsEnabled: false,
    //             onMapCreated: _onMapCreated,
    //           );
    //   },
    // );
  }
}

class _BottomStoreDetails extends StatelessWidget {
  const _BottomStoreDetails({
    Key? key,
    required this.selectedStore,
  }) : super(key: key);

  final Stores selectedStore;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 248, 236, 228),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          height: 200,
          child: Column(
            children: [
              const SizedBox(height: 14),
              Container(
                alignment: Alignment.center,
                width: 42,
                height: 3.5,
                decoration: const BoxDecoration(
                  color: Color.fromARGB(166, 158, 158, 158),
                  borderRadius: BorderRadius.all(
                    Radius.circular(50),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Text(selectedStore.name!),
            ],
          ),
        ),
        Positioned(
          top: 5,
          left: -5,
          child: RawMaterialButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            // constraints: const BoxConstraints(minWidth: 50),
            fillColor: const Color.fromARGB(255, 226, 226, 226),
            elevation: 0.0,
            highlightElevation: 0.0,

            shape: const CircleBorder(),
            child: const Icon(
              Icons.close,
              // size: 20,
              color: Color.fromARGB(255, 82, 82, 82),
            ),
          ),
        ),
      ],
    );
  }
}
