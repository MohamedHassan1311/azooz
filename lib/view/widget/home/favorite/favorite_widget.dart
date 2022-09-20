import '../../../../common/config/tools.dart';
import '../../../../common/style/dimens.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../../../model/response/favorite_model.dart';
import '../../../../providers/favorite_provider.dart';
import '../../../custom_widget/custom_error_widget.dart';
import '../../../custom_widget/custom_list_widget.dart';
import '../../../custom_widget/custom_loading_widget.dart';
import '../../../custom_widget/custom_search_form_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoriteWidget extends StatefulWidget {
  const FavoriteWidget({Key? key}) : super(key: key);

  @override
  State<FavoriteWidget> createState() => _FavoriteWidgetState();
}

class _FavoriteWidgetState extends State<FavoriteWidget> {
  final TextEditingController _typeAheadController = TextEditingController();

  late Future<FavoriteModel> future;

  int page = 1;

  late final FavoriteProvider provider;

  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    Provider.of<FavoriteProvider>(context, listen: false).disposeData();
    provider = Provider.of<FavoriteProvider>(context, listen: false);
    future = provider.getFavorites(page: page, context: context);
    scrollController.addListener(scrollListener);
  }

  getMoreData() {
    if (!provider.endPage) {
      if (provider.loadingPagination == false) {
        page++;
        provider.getFavorites(page: page, context: context);
      }
    }
  }

  scrollListener() => Tools.scrollListener(
        scrollController: scrollController,
        getMoreData: getMoreData,
      );

  @override
  void dispose() {
    _typeAheadController.dispose();
    scrollController.removeListener(scrollListener);
    scrollController.dispose();
    // Provider.of<FavoriteProvider>(context, listen: false).disposeData();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: edgeInsetsOnly(top: 10, bottom: 15),
          child: Row(
            children: [
              Expanded(
                child: CustomSearchFormWidget(
                  suggestionsCallback: (pattern) {
                    return [];
                  },
                  withSuggestion: false,
                  controller: _typeAheadController,
                  validatorText: '',
                  onChanged: (value) =>
                      Provider.of<FavoriteProvider>(context, listen: false)
                          .filterAddress(value),
                  onSubmitted: (value) =>
                      Provider.of<FavoriteProvider>(context, listen: false)
                          .filterAddress(value),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: FutureBuilder<FavoriteModel>(
              future: future,
              builder: (context, snapshot) {
                return snapshot.hasData
                    ? Provider.of<FavoriteProvider>(context)
                            .filteredList!
                            .isEmpty
                        ? CustomErrorWidget(
                            message: LocaleKeys.emptywishlistSubtitle.tr(),
                          )
                        : CustomListWidgetV1(
                            list: Provider.of<FavoriteProvider>(context)
                                .filteredList!,
                            isFavorite: true,
                            boxFit: BoxFit.cover,
                            paginationLoading: provider.loadingPagination,
                            scrollController: scrollController,
                          )
                    : snapshot.hasError
                        ? const CustomErrorWidget()
                        : const CustomLoadingWidget();
              }),
        ),
      ],
    );
  }
}
