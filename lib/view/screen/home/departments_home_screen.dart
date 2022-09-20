import '../../../common/style/dimens.dart';
import '../../../providers/home_provider.dart';
import '../../custom_widget/custom_loading_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../../common/config/assets.dart';
import '../../../common/config/tools.dart';
import '../../../common/routes/app_router_control.dart';
import '../../../common/routes/app_router_import.gr.dart';
import '../../../common/style/colors.dart';
import '../../../common/style/style.dart';
import '../../../generated/locale_keys.g.dart';
import '../../../model/screen_argument/store_argument.dart';
import '../../custom_widget/custom_cached_image_widget.dart';
import '../../custom_widget/custom_error_widget.dart';

class DepartmentsHomeScreen extends StatefulWidget {
  static const routeName = 'departments_home';

  const DepartmentsHomeScreen({Key? key}) : super(key: key);

  @override
  State<DepartmentsHomeScreen> createState() => _DepartmentsHomeScreenState();
}

class _DepartmentsHomeScreenState extends State<DepartmentsHomeScreen> {
  late Future future;

  ScrollController scrollController = ScrollController();

  int page = 1;

  @override
  void initState() {
    super.initState();
    Provider.of<HomeProvider>(context, listen: false).disposeData();
    future =
        Provider.of<HomeProvider>(context, listen: false).getAllDepartments(
      context: context,
      page: page,
    );
  }

  getMoreData() {
    final provider = Provider.of<HomeProvider>(context, listen: false);
    if (!provider.endPage) {
      page++;
      provider.getAllDepartments(context: context, page: page);
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
    return Scaffold(
      appBar: AppBar(title: Text(LocaleKeys.stores.tr())),
      body: FutureBuilder(
        future: future,
        builder: (context, snapshot) {
          return snapshot.hasData
              ? Consumer<HomeProvider>(
                  builder: (context, provider, child) {
                    return Padding(
                      padding: edgeInsetsSymmetric(horizontal: 8),
                      child: ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: provider.listDepartments.length,
                        controller: scrollController,
                        padding: EdgeInsets.zero,
                        itemBuilder: (context, index) {
                          var item = provider.listDepartments[index];
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    item.name.toString(),
                                    style:
                                        Theme.of(context).textTheme.subtitle1,
                                  ),
                                ],
                              ),
                              ListView.builder(
                                shrinkWrap: true,
                                padding: EdgeInsets.zero,
                                addAutomaticKeepAlives: false,
                                addRepaintBoundaries: false,
                                // physics: const BouncingScrollPhysics(),
                                itemCount: item.stores?.length,
                                itemBuilder: (context, index) {
                                  var item2 = item.stores![index];
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Stack(
                                        children: [
                                          Container(
                                            height: 130,
                                            width: 300,
                                            padding: edgeInsetsSymmetric(
                                                horizontal: 10),
                                            child: CachedImageBorderRadius(
                                              imageUrl:
                                                  item2.imageURL.toString(),
                                              onTap: () => routerPush(
                                                context: context,
                                                route: StoreScreenRoute(
                                                  argument: StoreArgument(
                                                    storeId: item2.id,
                                                    name: item2.name,
                                                  ),
                                                ),
                                              ),
                                              borderRadius: 15,
                                            ),
                                          ),
                                          PositionedDirectional(
                                            bottom: 30,
                                            end: 20,
                                            child: Container(
                                              padding: edgeInsetsAll(5),
                                              decoration: cardDecoration5(
                                                context: context,
                                                radius: 8,
                                              ),
                                              constraints: const BoxConstraints(
                                                minWidth: 35,
                                                minHeight: 30,
                                              ),
                                              child: Center(
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      item2.rate.toString(),
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                    const SizedBox(width: 5),
                                                    const Icon(
                                                      Icons.star_border,
                                                      color: Palette
                                                          .secondaryLight,
                                                      size: 15,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          PositionedDirectional(
                                            bottom: 30,
                                            start: 20,
                                            child: Container(
                                              padding: edgeInsetsAll(5),
                                              decoration: cardDecoration5(
                                                context: context,
                                                radius: 8,
                                              ),
                                              constraints: const BoxConstraints(
                                                minWidth: 35,
                                                minHeight: 30,
                                              ),
                                              child: Center(
                                                child: Text(
                                                  item2.time.toString(),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: edgeInsetsOnly(
                                          end: 8,
                                          top: 5,
                                          bottom: 5,
                                        ),
                                        child: Text(
                                          item2.name.toString(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle1,
                                        ),
                                      ),
                                      Padding(
                                        padding: edgeInsetsSymmetric(
                                          vertical: 5,
                                          horizontal: 5,
                                        ),
                                        child: Row(
                                          children: [
                                            Row(
                                              children: [
                                                SizedBox(
                                                  height: 20,
                                                  width: 20,
                                                  child: distanceSVG,
                                                ),
                                                const SizedBox(width: 5),
                                                Text(
                                                  '${item2.distance.toString()} ${LocaleKeys.km.tr()}',
                                                ),
                                              ],
                                            ),
                                            if (item2.freeDelivery == true) ...[
                                              const SizedBox(width: 8),
                                              Row(
                                                children: [
                                                  SizedBox(
                                                    height: 20,
                                                    width: 20,
                                                    child: truckSVG,
                                                  ),
                                                  const SizedBox(width: 10),
                                                  Text(LocaleKeys.freeDelivery
                                                      .tr()),
                                                ],
                                              ),
                                              const SizedBox(width: 10),
                                            ],
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 25,
                                        width: 300,
                                        child: Align(
                                          alignment:
                                              AlignmentDirectional.centerStart,
                                          child: ListView.builder(
                                              scrollDirection: Axis.horizontal,
                                              shrinkWrap: true,
                                              itemCount:
                                                  item2.storeCategory?.length,
                                              itemBuilder: (context, index) {
                                                var item3 =
                                                    item2.storeCategory![index];
                                                return Container(
                                                  width: 45,
                                                  margin:
                                                      edgeInsetsOnly(end: 10),
                                                  decoration: cardDecoration5(
                                                    context: context,
                                                    radius: 8,
                                                    color: Palette.primaryColor,
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      item3.name.toString(),
                                                      style: const TextStyle(
                                                        color: Palette.kWhite,
                                                      ),
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                );
                                              }),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ],
                          );
                        },
                      ),
                    );
                  },
                )
              : snapshot.hasError
                  ? const CustomErrorWidget()
                  : const CustomLoadingWidget();
        },
      ),
    );
  }
}
