import 'package:azooz/common/config/app_status.dart';
import 'package:geolocator/geolocator.dart';

import '../../../../common/config/assets.dart';

import '../../../../common/style/colors.dart';
import '../../../../common/style/dimens.dart';
import '../../../../common/style/style.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../../../providers/home_provider.dart';
import '../../../custom_widget/custom_background_widget.dart';
import '../../../custom_widget/custom_search_form_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import '../../../custom_widget/custom_list_horizontal_widget.dart';
import '../../../custom_widget/custom_loading_widget.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../../common/config/tools.dart';
import '../../../../model/response/stores_model.dart';
import '../../../../model/screen_argument/categories_argument.dart';
import '../../../../providers/location_provider.dart';
import '../../../../providers/store_provider.dart';
import '../../../custom_widget/custom_error_widget.dart';
import '../../../custom_widget/custom_list_widget.dart';

class StoresAppBar extends StatefulWidget {
  const StoresAppBar({
    Key? key,
  }) : super(key: key);

  @override
  State<StoresAppBar> createState() => _StoresAppBarState();
}

class _StoresAppBarState extends State<StoresAppBar> {
  final TextEditingController _typeAheadController = TextEditingController();

  List types = [
    'متاجر اجم',
    'مرسول اجم',
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _typeAheadController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 7,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const HomeScreenSearch(),
                    ),
                  );
                },

                child: Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.92,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    height: 45,
                    decoration: const BoxDecoration(
                      color: Palette.activeWidgetsColor,
                      borderRadius: BorderRadius.all(Radius.circular(14)),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.search),
                        const SizedBox(width: 20),
                        Text(LocaleKeys.search.tr()),
                      ],
                    ),
                  ),
                ),
                // child: CustomSearchFormWidget(
                //   suggestionsCallback: (pattern) {
                //     print(pattern);
                //     return [];
                //   },
                //   controller: _typeAheadController,
                //   validatorText: '',
                //   onSaved: (value) {},
                //   onChanged: (vl) {
                //     print(vl);

                //     // setState(() {

                //     // });
                //   },
                // ),
              ),
            ),
            Consumer<HomeProvider>(
              builder: (context, homeProvider, child) {
                final int currentStoreType = homeProvider.getStoreType;
                return Expanded(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsetsDirectional.only(start: 5),
                    child: CustomBackgroundWidget(
                      radius: 18,
                      padding: 0,
                      color: Palette.activeWidgetsColor,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              context.read<HomeProvider>().setStoreType =
                                  AppStatus.defaultStoreType;
                              context
                                  .read<HomeProvider>()
                                  .getHomeDetails(context: context);
                            },
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 350),
                              decoration: cardDecoration5(
                                context: context,
                                radius: 15,
                                color: currentStoreType ==
                                        AppStatus.defaultStoreType
                                    ? Palette.secondaryLight
                                    : Palette.activeWidgetsColor,
                                withShadow: currentStoreType ==
                                        AppStatus.defaultStoreType
                                    ? true
                                    : false,
                              ),
                              padding: edgeInsetsSymmetric(
                                  horizontal: 10, vertical: 6),
                              child: const SizedBox(
                                height: 25,
                                width: 25,
                                child: Icon(Icons.home),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              context.read<HomeProvider>().setStoreType =
                                  AppStatus.mapStoreType;
                              context
                                  .read<HomeProvider>()
                                  .getHomeDetails(context: context);
                            },
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 350),
                              decoration: cardDecoration5(
                                context: context,
                                radius: 15,
                                color:
                                    currentStoreType == AppStatus.mapStoreType
                                        ? Palette.secondaryLight
                                        : Palette.activeWidgetsColor,
                                withShadow:
                                    currentStoreType == AppStatus.mapStoreType
                                        ? true
                                        : false,
                              ),
                              padding: edgeInsetsSymmetric(
                                  horizontal: 10, vertical: 6),
                              child: const SizedBox(
                                height: 25,
                                width: 25,
                                child: Icon(Icons.location_on),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ],
    );
  }
}

class HomeScreenSearch extends StatelessWidget {
  const HomeScreenSearch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          LocaleKeys.search.tr(),
          style: Theme.of(context).textTheme.headline5,
        ),
      ),
      body: const CategoryDetailsWidget(
        argument: CategoriesArgument(
          name: "",
          id: 2,
        ),
      ),
    );
  }
}

class CategoryDetailsWidget extends StatefulWidget {
  final CategoriesArgument argument;

  const CategoryDetailsWidget({Key? key, required this.argument})
      : super(key: key);

  @override
  State<CategoryDetailsWidget> createState() => _CategoryDetailsWidgetState();
}

class _CategoryDetailsWidgetState extends State<CategoryDetailsWidget> {
  final TextEditingController _typeAheadController = TextEditingController();
  int cases = 1;
  int? indexFilter;
  bool isMapSelected = false;

  List<String> listName = [
    LocaleKeys.price.tr(),
    LocaleKeys.distance.tr(),
    LocaleKeys.rate.tr(),
    LocaleKeys.time.tr(),
  ];
  List<Widget> listIMG = [
    priceTag4SVG,
    distance2SVG,
    rateSVG,
    time2SVG,
  ];

  @override
  void initState() {
    super.initState();

    /// To Fix Reset indexFilter Value
    Provider.of<StoreProvider>(context, listen: false).indexFilter = -1;
    Provider.of<StoreProvider>(context, listen: false).searchWord = '';

    Provider.of<StoreProvider>(context, listen: false).getMarkerIcon(
      context: context,
      path: 'assets/images/azooz_drop.png',
      width: 65,
    );
  }

  @override
  void dispose() {
    _typeAheadController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: edgeInsetsSymmetric(horizontal: 10),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 2,
                    child: CustomSearchFormWidget(
                      suggestionsCallback: (pattern) {
                        return [];
                      },
                      withSuggestion: false,
                      controller: _typeAheadController,
                      validatorText: '',
                      onChanged: (value) {
                        var providerStore =
                            Provider.of<StoreProvider>(context, listen: false);
                        var providerLocation = Provider.of<LocationProvider>(
                            context,
                            listen: false);

                        providerStore.changeSearchWord(searchWord: value);
                        if (value.isEmpty) {
                          providerStore.isLoading(loading: true);
                          providerStore
                              .searchStore(
                                searchWord: '',
                                id: widget.argument.id,
                                page: 1,
                                lat: providerLocation
                                        .currentPosition?.latitude ??
                                    0,
                                lng: providerLocation
                                        .currentPosition?.longitude ??
                                    0,
                                context: context,
                                searchIsEmpty: false,
                              )
                              .whenComplete(
                                () => providerStore.isLoading(loading: false),
                              );
                        } else {
                          providerStore.isLoading(loading: true);
                          providerStore
                              .searchStore(
                                searchWord: providerStore.searchWord!.isEmpty
                                    ? ''
                                    : providerStore.searchWord,
                                id: widget.argument.id,
                                page: 1,
                                lat: providerLocation
                                        .currentPosition?.latitude ??
                                    0,
                                lng: providerLocation
                                        .currentPosition?.longitude ??
                                    0,
                                context: context,
                                searchIsEmpty: false,
                              )
                              .whenComplete(
                                () => providerStore.isLoading(loading: false),
                              );
                        }
                      },
                      onSubmitted: (value) {
                        var providerStore =
                            Provider.of<StoreProvider>(context, listen: false);
                        var providerLocation = Provider.of<LocationProvider>(
                            context,
                            listen: false);
                        providerStore.isLoading(loading: true);
                        providerStore
                            .searchStore(
                              searchWord: providerStore.searchWord!.isEmpty
                                  ? ''
                                  : providerStore.searchWord,
                              id: widget.argument.id,
                              page: 1,
                              lat: providerLocation.currentPosition?.latitude ??
                                  0,
                              lng:
                                  providerLocation.currentPosition?.longitude ??
                                      0,
                              context: context,
                              searchIsEmpty: false,
                            )
                            .whenComplete(
                              () => providerStore.isLoading(loading: false),
                            );
                      },
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: edgeInsetsOnly(start: 5),
                      child: CustomBackgroundWidget(
                        radius: 18,
                        padding: 0,
                        color: Palette.activeWidgetsColor,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              decoration: cardDecoration5(
                                context: context,
                                radius: 15,
                                color: cases == 1
                                    ? Palette.secondaryLight
                                    : Palette.activeWidgetsColor,
                                withShadow: cases == 1 ? true : false,
                              ),
                              padding: edgeInsetsSymmetric(
                                  horizontal: 10, vertical: 6),
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    cases = 1;
                                  });
                                },
                                child: SizedBox(
                                  height: 25,
                                  width: 25,
                                  child: cases == 1 ? details2SVG : details3SVG,
                                ),
                              ),
                            ),
                            Container(
                              decoration: cardDecoration5(
                                context: context,
                                radius: 15,
                                color: cases == 2
                                    ? Palette.secondaryLight
                                    : Palette.activeWidgetsColor,
                                withShadow: cases == 2 ? true : false,
                              ),
                              padding: edgeInsetsSymmetric(
                                  horizontal: 10, vertical: 6),
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    cases = 2;
                                  });
                                },
                                child: SizedBox(
                                  height: 25,
                                  width: 25,
                                  child: cases == 2
                                      ? locationMarker2SVG
                                      : locationMarker3SVG,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              if (cases == 1)
                Padding(
                  padding: edgeInsetsOnly(top: 10, bottom: 5),
                  child: CustomListWidget(
                    onTapWithIndex: (index) => {
                      indexFilter =
                          Provider.of<StoreProvider>(context, listen: false)
                              .selectFilter(index: index),
                      Provider.of<StoreProvider>(context, listen: false)
                          .filterStores(index),
                    },
                    indexFilter:
                        Provider.of<StoreProvider>(context).indexFilter,
                    list: listName,
                    listIMG: listIMG,
                    withListIMG: true,
                    radius: 12,
                    height: 40,
                    withShadow: false,
                  ),
                ),
            ],
          ),
        ),
        cases == 1
            ? CategoryListWidget(
                id: widget.argument.id,
              )
            : CategoryMapWidget(
                id: widget.argument.id,
              ),
      ],
    );
  }
}

class CategoryListWidget extends StatefulWidget {
  final int? id;

  const CategoryListWidget({
    Key? key,
    this.id,
  }) : super(key: key);

  @override
  State<CategoryListWidget> createState() => _CategoryListWidgetState();
}

class _CategoryListWidgetState extends State<CategoryListWidget> {
  late Future<StoresModel> future;
  int page = 1;

  late final StoreProvider provider;

  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    provider = Provider.of<StoreProvider>(context, listen: false);
    future = provider.getStores(
      id: widget.id,
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
          id: widget.id,
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
    return Expanded(
      child: FutureBuilder<StoresModel>(
          future: future,
          builder: (context, snapshot) {
            return snapshot.hasData
                ? Consumer<StoreProvider>(
                    builder: (context, provider, child) {
                      return provider.loading == true
                          ? const CustomLoadingWidget()
                          : provider.filteredList.isEmpty
                              ? CustomErrorWidget(
                                  message: LocaleKeys.noSearchResults.tr(),
                                )
                              : CustomListWidgetV1(
                                  list: provider.filteredList,
                                  boxFit: BoxFit.cover,
                                  paginationLoading: provider.loadingPagination,
                                  scrollController: scrollController,
                                  // categoryId: 1,
                                  // withNoOutlined: true,
                                );
                    },
                  )
                : snapshot.hasError
                    ? const CustomErrorWidget()
                    : const CustomLoadingWidget();
          }),
    );
  }
}

class CategoryMapWidget extends StatefulWidget {
  const CategoryMapWidget({
    Key? key,
    required this.id,
  }) : super(key: key);

  final int id;

  @override
  State<CategoryMapWidget> createState() => _CategoryMapWidgetState();
}

class _CategoryMapWidgetState extends State<CategoryMapWidget> {
  late Future<StoresModel> future;
  int page = 1;

  late final StoreProvider provider;

  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    print("Stores in Google Map & Stores in List");
    provider = Provider.of<StoreProvider>(context, listen: false);
    future = provider.getStores(
      id: widget.id,
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
          id: widget.id,
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
    return FutureBuilder<StoresModel>(
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
        });
  }
}

class _AllStoresInMaps extends StatefulWidget {
  const _AllStoresInMaps({Key? key, required this.stores}) : super(key: key);

  final List<Stores> stores;

  @override
  State<_AllStoresInMaps> createState() => _AllStoresInMapsState();
}

class _AllStoresInMapsState extends State<_AllStoresInMaps> {
  late GoogleMapController controller;

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
    _bitmapFromAssets = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(), "assets/images/azooz_drop.png");
    setState(() {
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
        _markers[store.name!] = marker;
      }
    });
  }

  late LatLng _futureGetCurrentLatLng;

  getLatLng() async {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    _futureGetCurrentLatLng = LatLng(position.latitude, position.longitude);
  }

  @override
  void initState() {
    super.initState();
    rootBundle.loadString('assets/map_style/map_style.txt').then((fileText) {
      mapStyle = fileText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GoogleMap(
        padding: const EdgeInsets.only(
          bottom: 30,
          right: 10,
        ),
        initialCameraPosition: CameraPosition(
          target: _futureGetCurrentLatLng,
          zoom: 13.5,
        ),
        onCameraMove: (position) {
          controller.animateCamera(
            CameraUpdate.newCameraPosition(
              CameraPosition(
                target: position.target,
                zoom: 13.5,
              ),
            ),
          );
        },
        buildingsEnabled: true,
        myLocationButtonEnabled: false,
        markers: _markers.values.toSet(),
        zoomControlsEnabled: false,
        onMapCreated: _onMapCreated,
      ),
    );
  }
}

// Go to my location
// Positioned(
//   bottom: 30,
//
//   left: 10,
//
//   // right: 10,
//   child: RawMaterialButton(
//     materialTapTargetSize: MaterialTapTargetSize.padded,
//     fillColor: Colors.white,
//     constraints: const BoxConstraints(maxWidth: 50, maxHeight: 50),
//     shape: const CircleBorder(),
//     padding: const EdgeInsets.all(5),
//     onPressed: () {
//       controller.animateCamera(
//         CameraUpdate.newCameraPosition(
//           CameraPosition(
//             target: LatLng(
//               widget.stores.first.location!.lat!,
//               widget.stores.first.location!.lng!,
//             ),
//             zoom: 13.5,
//           ),
//         ),
//       );
//     },
//     child: const Icon(
//       Icons.my_location,
//       color: Color.fromARGB(255, 119, 121, 123),
//     ),
//   ),
// ),

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
