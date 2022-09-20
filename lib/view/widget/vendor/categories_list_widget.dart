import '../../../common/config/tools.dart';
import '../../../common/style/dimens.dart';
import '../../../generated/locale_keys.g.dart';
import '../../../model/response/stores_model.dart';
import '../../../providers/location_provider.dart';
import '../../../providers/store_provider.dart';
import '../../custom_widget/custom_error_widget.dart';
import '../../custom_widget/custom_list_widget.dart';
import '../../custom_widget/custom_loading_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoriesListWidget extends StatefulWidget {
  final int? id;

  const CategoriesListWidget({
    Key? key,
    this.id,
  }) : super(key: key);

  @override
  State<CategoriesListWidget> createState() => _CategoriesListWidgetState();
}

class _CategoriesListWidgetState extends State<CategoriesListWidget> {
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
    var screenHeight = MediaQuery.of(context).size.height;
    return sizedBox(
      height: screenHeight * 0.71,
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
