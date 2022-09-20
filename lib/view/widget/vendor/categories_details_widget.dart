import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../../common/config/assets.dart';
import '../../../common/style/colors.dart';
import '../../../common/style/dimens.dart';
import '../../../common/style/style.dart';
import '../../../generated/locale_keys.g.dart';
import '../../../model/screen_argument/categories_argument.dart';
import '../../../providers/location_provider.dart';
import '../../../providers/store_provider.dart';
import '../../custom_widget/custom_background_widget.dart';
import '../../custom_widget/custom_list_horizontal_widget.dart';
import '../../custom_widget/custom_search_form_widget.dart';
import 'categories_list_widget.dart';
import 'categories_map_widget.dart';

class CategoriesDetailsWidget extends StatefulWidget {
  final CategoriesArgument argument;

  const CategoriesDetailsWidget({Key? key, required this.argument})
      : super(key: key);

  @override
  State<CategoriesDetailsWidget> createState() =>
      _CategoriesDetailsWidgetState();
}

class _CategoriesDetailsWidgetState extends State<CategoriesDetailsWidget> {
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
    return SingleChildScrollView(
      child: Column(
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
                          var providerStore = Provider.of<StoreProvider>(
                              context,
                              listen: false);
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
                          var providerStore = Provider.of<StoreProvider>(
                              context,
                              listen: false);
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
                                    child:
                                        cases == 1 ? details2SVG : details3SVG,
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
              ? CategoriesListWidget(
                  id: widget.argument.id,
                )
              : const CategoriesMapWidget(),
        ],
      ),
    );
  }
}
