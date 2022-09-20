import 'dart:developer';

import 'package:azooz/service/network/url_constants.dart';
import 'package:azooz/view/custom_widget/custom_loading_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:provider/provider.dart';

import '../../../../common/routes/app_router_import.gr.dart';
import '../../../../common/routes/app_router_control.dart';
import '../../../../common/style/colors.dart';
import '../../../../common/style/dimens.dart';
import '../../../../model/response/home_model.dart';
import 'package:flutter/material.dart';

import '../../../../model/screen_argument/store_argument.dart';
import '../../../../providers/favorite_provider.dart';
import '../../../../providers/store_provider.dart';

class OpenStoreWidget extends StatelessWidget {
  final List<SmartDepartments>? list;
  final Axis scrollDirection;
  final ScrollController? controller;
  final bool? isHomeScreen;

  const OpenStoreWidget({
    Key? key,
    required this.list,
    this.scrollDirection = Axis.horizontal,
    this.controller,
    this.isHomeScreen = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // SmartDepartment item = list![index];
    var screenHeight = MediaQuery.of(context).size.height;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          list![0].name.toString(),
          style: Theme.of(context).textTheme.subtitle1,
        ),
        SizedBox(
          height: isHomeScreen == true ? screenHeight * 0.30 : screenHeight,
          child: ListView.separated(
            separatorBuilder: (context, index) {
              return const SizedBox(width: 20);
            },
            addAutomaticKeepAlives: false,
            addRepaintBoundaries: false,
            scrollDirection: scrollDirection,
            physics: const BouncingScrollPhysics(),
            itemCount: list![0].stores!.length,
            itemBuilder: (context, index) {
              Stores storeData = list![0].stores![index];
              final List<dynamic>? images = storeData.imageURls;
              final String storeImageOut = images == null || images.isEmpty
                  ? ""
                  : baseImageURL + images.first;
              return OpenStoreCard(
                storeData: storeData,
                image: storeImageOut,
              );
            },
          ),
        ),
      ],
    );
  }
}

class OpenStoreCard extends StatelessWidget {
  const OpenStoreCard({
    Key? key,
    required this.storeData,
    required this.image,
  }) : super(key: key);

  final Stores storeData;
  final String image;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      child: Card(
        shape: const RoundedRectangleBorder(
          borderRadius: kBorderRadius5,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // Stack(
            //   children: [
            //     Container(
            //       height: 130,
            //       width: 300,
            //       decoration: const BoxDecoration(
            //         color: Color.fromARGB(255, 67, 224, 217),
            //         borderRadius: BorderRadius.all(
            //           Radius.circular(5),
            //         ),
            //       ),
            //       child: GestureDetector(
            //         onTap: () {
            //           routerPush(
            //             context: context,
            //             route: StoreRoute(
            //               argument: StoreArgument(
            //                 storeId: storeData.id,
            //                 name: "storeData.name",
            //               ),
            //             ),
            //           );
            //         },
            //         child: ClipRRect(
            //           borderRadius: const BorderRadius.vertical(
            //             top: Radius.circular(5),
            //           ),
            //           child: CachedNetworkImage(
            //             fit: BoxFit.cover,
            //             imageUrl: image,
            //             errorWidget: (context, url, error) {
            //               return Image.asset(
            //                 "assets/images/azooz_logo.png",
            //                 fit: BoxFit.cover,
            //               );
            //             },
            //             placeholder: (context, url) =>
            //                 const CustomLoadingWidget(),
            //           ),
            //         ),
            //       ),
            //     ),
            //     PositionedDirectional(
            //       bottom: 30,
            //       end: 20,
            //       child: Container(
            //         padding: const EdgeInsets.all(2),
            //         decoration: const BoxDecoration(
            //           borderRadius: BorderRadius.all(
            //             Radius.circular(5),
            //           ),
            //           color: Colors.black54,
            //         ),
            //         constraints: BoxConstraints(
            //           minWidth: 70,
            //           minHeight: 25,
            //         ),
            //         child: Center(
            //           child: Row(
            //             children: [
            //               Text(
            //                 storeData.rate.toString(),
            //                 textAlign: TextAlign.center,
            //                 style: const TextStyle(
            //                   color: Palette.kWhite,
            //                   fontSize: 14,
            //                 ),
            //               ),
            //               SizedBox(width: 5),
            //               const Icon(
            //                 Icons.star_border,
            //                 color: Palette.kWhite,
            //                 size: 15,
            //               ),
            //             ],
            //           ),
            //         ),
            //       ),
            //     ),
            //     PositionedDirectional(
            //       bottom: 30,
            //       start: 20,
            //       child: Container(
            //         padding: const EdgeInsets.all(2),
            //         decoration: const BoxDecoration(
            //           borderRadius: BorderRadius.all(
            //             Radius.circular(5),
            //           ),
            //           color: Colors.black54,
            //         ),
            //         constraints: BoxConstraints(
            //           minWidth: 70,
            //           minHeight: 25,
            //         ),
            //         child: Center(
            //           child: Text(
            //             "${getMinuteString(storeData.time!)} min",
            //             textAlign: TextAlign.center,
            //             style: const TextStyle(
            //               color: Colors.white,
            //               fontSize: 14,
            //             ),
            //           ),
            //         ),
            //       ),
            //     ),
            //   ],
            // ),
            Container(
              height: 130,
              width: 300,
              padding: const EdgeInsets.all(5),
              margin: const EdgeInsets.all(5),
              decoration: const BoxDecoration(
                // color: Color.fromARGB(255, 67, 224, 217),
                borderRadius: BorderRadius.all(
                  Radius.circular(5),
                ),
              ),
              child: GestureDetector(
                onTap: () {
                  routerPush(
                    context: context,
                    route: StoreScreenRoute(
                      argument: StoreArgument(
                        storeId: storeData.id,
                        name: storeData.name,
                      ),
                    ),
                  );
                },
                child: ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(5),
                  ),
                  child: CachedNetworkImage(
                    fit: BoxFit.cover,
                    imageUrl: image,
                    errorWidget: (context, url, error) {
                      return Image.asset(
                        "assets/images/azooz_logo.png",
                        fit: BoxFit.cover,
                      );
                    },
                    placeholder: (context, url) => const CustomLoadingWidget(),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 5),
            Container(
              height: 40,
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      storeData.name.toString(),
                      style: Theme.of(context).textTheme.subtitle1,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),

                  Consumer<StoreProvider>(
                    builder: (context, provider, child) {
                      log('storeData.id!: ${storeData.id!}');
                      log('provider.favorite![storeData.id!]: ${provider.favorite![storeData.id!]}');
                      return IconButton(
                        splashRadius: 20,
                        icon: provider.favorite![storeData.id!] == true
                            ? const Icon(
                                Icons.favorite_rounded,
                                color: Palette.primaryColor,
                              )
                            : const Icon(
                                Icons.favorite_border,
                                color: Palette.primaryColor,
                              ),
                        onPressed: () {
                          provider.favorite![storeData.id!] == true
                              ? Provider.of<FavoriteProvider>(context,
                                      listen: false)
                                  .deleteFavorite(
                                      storeId: storeData.id, context: context)
                                  .then(
                                    (value) => provider.changeFavorite(
                                        false, storeData.id!),
                                  )
                              : Provider.of<FavoriteProvider>(context,
                                      listen: false)
                                  .addFavorite(
                                      id: storeData.id, context: context)
                                  .then(
                                    (value) => provider.changeFavorite(
                                        true, storeData.id!),
                                  );
                        },
                      );
                    },
                  ),

                  // IconButton(
                  //   splashRadius: 20,
                  //   icon: const Icon(
                  //     Icons.favorite_rounded,
                  //     color: Palette.primaryColor,
                  //   ),
                  //   onPressed: () {
                  //

                  // },
                  // ),

                  // Row(
                  //   children: [
                  //     SizedBox(
                  //       height: 15,
                  //       width: 15,
                  //       child: distanceSVG,
                  //     ),
                  //     const SizedBox(width: 10),
                  //     Text(
                  //       '${storeData.distance.toString().substring(0, 7)} ${LocaleKeys.km.tr()}',
                  //     ),
                  //   ],
                  // ),
                ],
              ),
            ),
            Container(
              height: 40,
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
              ),
              child: Row(children: const [
                // Rate widget
                _CustomBorderButton(
                  title: Text("4.9"),
                  icon: Icon(
                    Icons.star_rate_rounded,
                    color: Palette.primaryColor,
                    size: 18,
                  ),
                ),
                SizedBox(width: 5),
                // Rate widget
                _CustomBorderButton(
                  title: Text("30-25 min"),
                  icon: Icon(
                    Icons.access_time_rounded,
                    color: Color(0xFFB9C1CB),
                    size: 18,
                  ),
                ),
                SizedBox(width: 5),
                // Rate widget
                _CustomBorderButton(
                  title: Text("1.3 km"),
                  icon: Icon(
                    Icons.near_me_outlined,
                    color: Color(0xFFB9C1CB),
                    size: 18,
                  ),
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}

class _CustomBorderButton extends StatelessWidget {
  const _CustomBorderButton({
    Key? key,
    required this.title,
    required this.icon,
  }) : super(key: key);

  final Widget title;
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: 100,
      height: 30,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(5),
        ),
        border: Border.all(
          width: 1.0,
          color: const Color(
            0xFFEDEEF2,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          icon,
          const SizedBox(width: 3),
          title,
        ],
      ),
    );
  }
}
