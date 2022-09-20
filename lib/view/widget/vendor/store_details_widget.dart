import 'package:azooz/generated/locale_keys.g.dart';
import 'package:azooz/view/custom_widget/custom_loading_widget.dart';
import 'package:azooz/view/widget/vendor/product_item_cart_widget.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../common/config/tools.dart';
import '../../../common/routes/app_router_control.dart';
import '../../../common/routes/app_router_import.gr.dart';
import '../../../model/response/products_model.dart';
import '../../../model/response/store_model.dart';
import '../../../model/screen_argument/make_order_argument.dart';
import '../../../model/screen_argument/store_argument.dart';
import '../../../providers/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/store_provider.dart';
import '../../../utils/easy_loading_functions.dart';
import '../../custom_widget/custom_button.dart';
import '../../custom_widget/custom_cached_image_widget.dart';
import '../../custom_widget/marquee_widget.dart';
import 'store_header_widget.dart';

class StoreDetailsWidget extends StatefulWidget {
  final StoreArgument argument;

  const StoreDetailsWidget({
    Key? key,
    required this.argument,
  }) : super(key: key);

  @override
  State<StoreDetailsWidget> createState() => _StoreDetailsWidgetState();
}

class _StoreDetailsWidgetState extends State<StoreDetailsWidget>
    with TickerProviderStateMixin {
  int page = 1;

  ScrollController scrollController = ScrollController();

  late Future<ProductsModel> futureProducts;

  late final ProductProvider provider;

  late TabController _tabsController;

  int? _selectedCategoryId;

  int? selectedIndex;

  bool isLoading = false;

  getTabsLength() {
    context
        .read<StoreProvider>()
        .getStore(id: widget.argument.storeId, context: context);
    var storeName = Provider.of<StoreProvider>(context, listen: false)
        .storeModel
        .result!
        .store!
        .name;
    print('######### STORE SCREEN $storeName #########');
    List<Categorys>? categories =
        Provider.of<StoreProvider>(context, listen: false)
            .storeModel
            .result!
            .store!
            .categorys;
    print('######### STORE categories $categories #########');
    _tabsController = TabController(
        length: categories!.isNotEmpty ? categories.length : 0, vsync: this);
  }

  @override
  void initState() {
    super.initState();
    mapProduct.clear();
    provider = Provider.of<ProductProvider>(context, listen: false);
    var categories = Provider.of<StoreProvider>(context, listen: false)
        .storeModel
        .result!
        .store!
        .categorys;
    if (categories != null && categories.isNotEmpty) {
      _selectedCategoryId = categories.first.id;
    }

    getTabsLength();

    scrollController.addListener(scrollListener);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    scrollController.removeListener(scrollListener);
    scrollController.dispose();
    provider.endPage = false;
    provider.listProducts.clear();
    _tabsController.dispose();
    super.dispose();
  }

  getMoreData() {
    if (!provider.endPage) {
      if (provider.loadingPagination == false) {
        page++;
        provider.getProducts(
            categoryId: widget.argument.storeId, page: page, context: context);
      }
    }
  }

  scrollListener() => Tools.scrollListener(
        scrollController: scrollController,
        getMoreData: getMoreData,
      );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        StoreHeaderWidget(),
        SizedBox(
          height: 35,
          child: TabBar(
            isScrollable: true,
            padding: const EdgeInsets.symmetric(horizontal: 5),
            onTap: ((int index) {
              context.read<StoreProvider>().setIndex = index;
              setState(() {
                isLoading = true;
              });
              final int selectedCategoryId = index;
              selectedIndex = index;
              _selectedCategoryId =
                  Provider.of<StoreProvider>(context, listen: false)
                      .storeModel
                      .result!
                      .store!
                      .categorys![selectedCategoryId]
                      .id!;

              Future.delayed(const Duration(milliseconds: 750), () {
                setState(() {
                  isLoading = false;
                });
              });
            }),
            controller: _tabsController,
            tabs: Provider.of<StoreProvider>(context, listen: false)
                .storeModel
                .result!
                .store!
                .categorys!
                .map((category) {
              return Tab(
                child: Text(category.name.toString()),
              );
            }).toList(),
          ),
        ),
        const SizedBox(height: 10),
        Expanded(
          child: isLoading
              ? const CustomLoadingWidget()
              : ListView.builder(
                  itemExtent: 100,
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  itemCount: context.read<StoreProvider>().categories!.isEmpty
                      ? 0
                      : context.read<StoreProvider>().products!.length,
                  itemBuilder: ((context, index) {
                    return Container(
                      margin: const EdgeInsets.symmetric(vertical: 5),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey.shade300,
                          width: 1.5,
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Row(
                              // crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: CachedImageCircular(
                                    imageUrl: context
                                        .read<StoreProvider>()
                                        .products![index]
                                        .imageURL,
                                    width: 40,
                                    height: 40,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.51,
                                      child: MarqueeWidget(
                                        child: Text(
                                          context
                                              .read<StoreProvider>()
                                              .products![index]
                                              .name
                                              .toString(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle2,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          textAlign: TextAlign.start,
                                        ),
                                      ),
                                    ),
                                    // SizedBox(height: 5),
                                    SizedBox(
                                      child: Text.rich(
                                        TextSpan(
                                          text: context
                                              .read<StoreProvider>()
                                              .products![index]
                                              .description,
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle2,
                                        ),
                                        maxLines: 10,
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.start,
                                      ),
                                    ),
                                    SizedBox(
                                      child: Text.rich(
                                        TextSpan(
                                          text:
                                              "س.ح ${context.read<StoreProvider>().products![index].calories}",
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle2,
                                        ),
                                        maxLines: 10,
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.start,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          ProductItemCartWidget(
                            product:
                                context.read<StoreProvider>().products![index],
                            index: index,
                          ),
                        ],
                      ),
                    );
                  }),
                ),
        ),
        SizedBox(
          height: 70,
          child: CustomButton(
            width: MediaQuery.of(context).size.width * 0.94,
            text: LocaleKeys.next.tr(),
            onPressed: () {
              provider.productsArgumentList.isEmpty
                  ? showInfo(
                      msg: LocaleKeys.chooseProducts.tr(),
                    )
                  : routerPush(
                      context: context,
                      route: MakeOrderRoute(
                        argument: MakeOrderArgument(
                          id: Provider.of<StoreProvider>(context, listen: false)
                              .storeModel
                              .result!
                              .store!
                              .id,
                          name:
                              Provider.of<StoreProvider>(context, listen: false)
                                  .storeModel
                                  .result!
                                  .store!
                                  .name,
                        ),
                      ),
                    );
            },
          ),
        ),
      ],
    );
  }
}
