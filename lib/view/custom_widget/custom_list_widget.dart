import 'dart:developer';

import 'package:azooz/common/routes/app_router_control.dart';
import 'package:azooz/common/routes/app_router_import.gr.dart';

import '../../common/style/colors.dart';
import '../../common/style/dimens.dart';
import '../../common/style/style.dart';
import '../../generated/locale_keys.g.dart';
import '../../model/screen_argument/store_argument.dart';
import '../../providers/favorite_provider.dart';
import '../../providers/store_provider.dart';
import 'custom_loading_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'custom_cached_image_widget.dart';
import 'marquee_widget.dart';

class CustomListWidgetV1 extends StatelessWidget {
  final List list;
  final double? imageWidth;
  final double imageHeight;
  final BoxFit? boxFit;
  final bool? isFavorite;
  final Color? colorFavorite;
  final bool? paginationLoading;
  final ScrollController scrollController;

  const CustomListWidgetV1({
    Key? key,
    required this.list,
    this.imageHeight = 45,
    this.imageWidth = 45,
    this.boxFit = BoxFit.contain,
    this.isFavorite = false,
    this.colorFavorite = Palette.kErrorRed,
    required this.scrollController,
    required this.paginationLoading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("I am custom list v1: $list selected");
    log('messagemessagemessage');
    var screenSize = MediaQuery.of(context).size;
    return ListView.builder(
        controller: scrollController,
        itemCount: list.length,
        itemBuilder: (context, index) {
          if (index == list.length) {
            return paginationLoading!
                ? const CustomLoadingPaginationWidget()
                : const SizedBox();
          }

          return GestureDetector(
            onTap: () {
              // getItRouter.push(StoreRoute(
              //   argument: StoreArgument(
              //     storeId: list[index].id,
              //     name: list[index].name,
              //   ),
              // ));
              routerPush(
                context: context,
                route: StoreScreenRoute(
                  argument: StoreArgument(
                    storeId: list[index].id,
                    name: list[index].name,
                  ),
                ),
              );
            },
            child: Container(
              margin: edgeInsetsAll(8),
              decoration: cardDecoration5(context: context, radius: 12),
              child: Container(
                // padding: const EdgeInsets.only(bottom: 5),
                margin: edgeInsetsOnly(bottom: 10, top: 5),
                // color: Colors.redAccent,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        sizedBox(width: 5),
                        CachedImageCircular(
                          imageUrl: list[index].imageURL,
                          width: 45,
                          height: 55,
                          boxFit: boxFit,
                        ),
                        sizedBox(width: 8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            sizedBox(
                              width: screenSize.width * 0.72,
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 3,
                                    child: MarqueeWidget(
                                      child: Text(
                                        list[index].name,
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle1,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.start,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: edgeInsetsOnly(start: 3.0),
                                      child: isFavorite == false
                                          ? Text(
                                              '${list[index].distance.toString().substring(0, 3)} ${LocaleKeys.km.tr()}',
                                              style: const TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.center,
                                            )
                                          : RawMaterialButton(
                                              shape: const CircleBorder(),
                                              // constraints: const BoxConstraints(
                                              // minWidth: 70,
                                              // ),
                                              onPressed: () {
                                                Provider.of<FavoriteProvider>(
                                                        context,
                                                        listen: false)
                                                    .deleteFavorite(
                                                  storeId: list[index].storeId,
                                                  id: list[index].storeId,
                                                  context: context,
                                                )
                                                    .then((value) {
                                                  Provider.of<FavoriteProvider>(
                                                          context,
                                                          listen: false)
                                                      .paginationListRemove(
                                                          list[index]);
                                                  Provider.of<StoreProvider>(
                                                          context,
                                                          listen: false)
                                                      .changeFavorite(false,
                                                          list[index].storeId!);
                                                  return null;
                                                });
                                              },
                                              child: Icon(
                                                Icons.favorite,
                                                color: colorFavorite,
                                              ),
                                            ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // sizedBox(height: 5),
                            sizedBox(
                              width: screenSize.width * 0.72,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    flex: 3,
                                    child: MarqueeWidget(
                                      child: Text(
                                        list[index].description,
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.start,
                                        style: const TextStyle(
                                          fontSize: 12,
                                          color: Palette.secondaryLight,
                                        ),
                                      ),
                                    ),
                                  ),
                                  isFavorite == false
                                      ? Expanded(
                                          child: Padding(
                                            padding: edgeInsetsOnly(start: 3.0),
                                            child: Text(
                                              '${list[index].time.toString().substring(0, 2)} ${LocaleKeys.minute.tr()}',
                                              style: const TextStyle(
                                                color: Palette.kAccent,
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        )
                                      : Expanded(
                                          child: Padding(
                                            padding:
                                                edgeInsetsOnly(start: 17.0),
                                            child: Row(
                                              children: [
                                                const Icon(
                                                  Icons.star,
                                                  color: Palette.kRating,
                                                  size: 15,
                                                ),
                                                Text(
                                                  '${list[index].rate}',
                                                  style: const TextStyle(
                                                    color: Palette.kRating,
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  textAlign: TextAlign.center,
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                ],
                              ),
                            ),
                            sizedBox(height: 5),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
