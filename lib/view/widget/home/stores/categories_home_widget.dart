import 'package:cached_network_image/cached_network_image.dart';

import '../../../../common/routes/app_router_control.dart';
import '../../../../common/routes/app_router_import.gr.dart';
import '../../../../common/style/colors.dart';
import '../../../../common/style/dimens.dart';
import '../../../../model/response/home_model.dart';
import '../../../../model/screen_argument/categories_argument.dart';
import '../../../../providers/home_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../common/config/tools.dart';
import '../../../../model/response/home_departments_model.dart';
import '../../../../service/network/url_constants.dart';

class CategoriesHomeWidget extends StatefulWidget {
  final List<Departments>? list;

  const CategoriesHomeWidget({Key? key, required this.list}) : super(key: key);

  @override
  State<CategoriesHomeWidget> createState() => _CategoriesHomeWidgetState();
}

class _CategoriesHomeWidgetState extends State<CategoriesHomeWidget> {
  late Future<List<DepartmentHome>> future;

  ScrollController scrollController = ScrollController();

  int page = 1;

  @override
  void initState() {
    super.initState();
    future = Provider.of<HomeProvider>(context, listen: false)
        .getAllCategories(context: context, page: page);
    scrollController.addListener(scrollListener);
  }

  getMoreData() {
    final provider = Provider.of<HomeProvider>(context, listen: false);
    if (!provider.endPage) {
      page++;
      provider.getAllCategories(context: context, page: page);
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
    var screenSize = MediaQuery.of(context).size;
    return SliverGrid(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 20,
        crossAxisSpacing: 20,
      ),
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return GestureDetector(
            onTap: () {
              routerPush(
                context: context,
                route: CategoriesRoute(
                  argument: CategoriesArgument(
                    name: widget.list![index].name,
                    id: widget.list![index].id!,
                  ),
                ),
              );
            },
            child: Stack(
              // alignment: Alignment.bottomCenter,
              children: [
                Container(
                  // height: 135.0,
                  decoration: const BoxDecoration(
                    color: Palette.primaryColor,
                    borderRadius: kBorderRadius10,
                  ),
                  child: ClipRRect(
                    borderRadius: kBorderRadius10,
                    child: CachedNetworkImage(
                      imageUrl: baseImageURL + widget.list![index].imageURl!,
                      errorWidget: (context, url, error) => const SizedBox(),
                      fit: BoxFit.fitHeight,
                      height: 300,
                    ),
                  ),
                ),
                Positioned.fill(
                  // top: 0,
                  bottom: 0,
                  child: Container(
                    width: 170,
                    height: 150 / 3.0,
                    decoration: const BoxDecoration(
                      borderRadius: kBorderRadius5,
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromARGB(25, 0, 0, 0),
                          blurRadius: 10,
                          spreadRadius: 5,
                          offset: Offset(0.0, 0.0),
                        )
                      ],
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color.fromARGB(1, 149, 149, 149),
                          Color.fromARGB(55, 18, 18, 18),
                        ],
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(right: 10.0, bottom: 10.0),
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: Text(
                          widget.list![index].name.toString(),
                          maxLines: 1,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
        childCount: widget.list == null ? 0 : widget.list!.length,
      ),
    );

    // return Column(
    //   mainAxisAlignment: MainAxisAlignment.center,
    //   // crossAxisAlignment: CrossAxisAlignment.end,
    //   children: [
    //     Align(
    //       alignment: AlignmentDirectional.centerStart,
    //       child: Text(
    //         LocaleKeys.categories.tr(),
    //         textAlign: TextAlign.right,
    //         style: Theme.of(context).textTheme.subtitle1,
    //       ),
    //     ),
    //     const SizedBox(height: 10),
    //     SizedBox(
    //       width: MediaQuery.of(context).size.width,
    //       height: MediaQuery.of(context).size.height,
    //       child: Center(
    //         child: GridView.builder(
    //           itemCount: widget.list == null ? 0 : widget.list!.length,
    //           physics: const NeverScrollableScrollPhysics(),
    //           gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
    //             crossAxisCount: 2,
    //             childAspectRatio: 1.5,

    //             // Spaces between each child widget.
    //             crossAxisSpacing: 14,
    //             mainAxisSpacing: 14,
    //           ),
    //           itemBuilder: (context, index) {
    //             return GestureDetector(
    //               onTap: () {
    //                 routerPush(
    //                   context: context,
    //                   route: CategoriesRoute(
    //                     argument: CategoriesArgument(
    //                       name: widget.list![index].name,
    //                       id: widget.list![index].id!,
    //                     ),
    //                   ),
    //                 );
    //               },
    //               child: Stack(
    //                 alignment: Alignment.center,
    //                 children: [
    //                   Container(
    //                     width: 170,
    //                     height: 130,
    //                     decoration: BoxDecoration(
    //                       color: const Color(0xFF8BCADC),
    //                       borderRadius: BorderRadius.circular(10),
    //                     ),
    //                     child: ClipRRect(
    //                       borderRadius: const BorderRadius.all(
    //                         Radius.circular(10),
    //                       ),
    //                       child: CachedNetworkImage(
    //                         imageUrl:
    //                             baseImageURL + widget.list![index].imageURL!,
    //                         errorWidget: (context, url, error) =>
    //                             const SizedBox(),
    //                         fit: BoxFit.cover,
    //                       ),
    //                     ),
    //                   ),
    //                   Positioned(
    //                     bottom: 0,
    //                     child: Container(
    //                       height: 150 / 2.7,
    //                       width: 170,
    //                       decoration: BoxDecoration(
    //                         boxShadow: [
    //                           BoxShadow(
    //                             color: Colors.black.withOpacity(0.1),
    //                             blurRadius: 10,
    //                             spreadRadius: 5,
    //                             offset: const Offset(0.0, 0.0),
    //                           )
    //                         ],
    //                         borderRadius: BorderRadius.circular(10),
    //                         gradient: const LinearGradient(
    //                           begin: Alignment.topCenter,
    //                           end: Alignment.bottomCenter,
    //                           colors: [
    //                             Color.fromARGB(1, 149, 149, 149),
    //                             Color.fromARGB(55, 18, 18, 18),
    //                           ],
    //                         ),
    //                       ),
    //                       child: Padding(
    //                         padding:
    //                             const EdgeInsets.only(right: 10.0, bottom: 5),
    //                         child: Align(
    //                           alignment: Alignment.bottomRight,
    //                           child: Text(
    //                             widget.list![index].name.toString(),
    //                             maxLines: 1,
    //                             style: const TextStyle(
    //                               color: Colors.white,
    //                               fontWeight: FontWeight.bold,
    //                               overflow: TextOverflow.ellipsis,
    //                             ),
    //                           ),
    //                         ),
    //                       ),
    //                     ),
    //                   ),
    //                 ],
    //               ),
    //             );
    //           },
    //         ),
    //       ),

    //       // child: SingleChildScrollView(
    //       //   physics: const NeverScrollableScrollPhysics(),
    //       //   child: Column(
    //       //       children: List.generate(3, (index) {
    //       //     return Container(
    //       //       color: Colors.white,
    //       //       height: 150,
    //       //       margin: const EdgeInsets.only(bottom: 20),
    //       //       child: Row(
    //       //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //       //         children: [
    //       //           Stack(
    //       //             children: [
    //       //               Container(
    //       //                 width: 170,
    //       //                 height: 130,
    //       //                 decoration: BoxDecoration(
    //       //                   color: const Color.fromARGB(255, 126, 211, 152),
    //       //                   borderRadius: BorderRadius.circular(10),
    //       //                 ),
    //       //               ),
    //       //               Positioned(
    //       //                 bottom: 0,
    //       //                 child: Container(
    //       //                   height: 150 / 2.5,
    //       //                   width: 170,
    //       //                   decoration: BoxDecoration(
    //       //                     boxShadow: [
    //       //                       BoxShadow(
    //       //                         color: Colors.black.withOpacity(0.1),
    //       //                         blurRadius: 10,
    //       //                         spreadRadius: 5,
    //       //                         offset: const Offset(0.0, 0.0),
    //       //                       )
    //       //                     ],
    //       //                     borderRadius: BorderRadius.circular(10),
    //       //                     gradient: const LinearGradient(
    //       //                       begin: Alignment.topCenter,
    //       //                       end: Alignment.bottomCenter,
    //       //                       colors: [
    //       //                         Color.fromARGB(1, 149, 149, 149),
    //       //                         Color.fromARGB(55, 18, 18, 18),
    //       //                       ],
    //       //                     ),
    //       //                   ),
    //       //                   child: Center(
    //       //                     child: Text(
    //       //                       "${widget.list![index].name}",
    //       //                       style: const TextStyle(
    //       //                         color: Colors.white,
    //       //                       ),
    //       //                     ),
    //       //                   ),
    //       //                 ),
    //       //               ),
    //       //             ],
    //       //           ),
    //       //           Stack(
    //       //             children: [
    //       //               Container(
    //       //                 width: 170,
    //       //                 height: 130,
    //       //                 decoration: BoxDecoration(
    //       //                   color: const Color(0xFF8BCADC),
    //       //                   borderRadius: BorderRadius.circular(10),
    //       //                 ),
    //       //               ),
    //       //               Positioned(
    //       //                 bottom: 0,
    //       //                 child: Container(
    //       //                   height: 150 / 2.5,
    //       //                   width: 170,
    //       //                   decoration: BoxDecoration(
    //       //                     boxShadow: [
    //       //                       BoxShadow(
    //       //                         color: Colors.black.withOpacity(0.1),
    //       //                         blurRadius: 10,
    //       //                         spreadRadius: 5,
    //       //                         offset: const Offset(0.0, 0.0),
    //       //                       )
    //       //                     ],
    //       //                     borderRadius: BorderRadius.circular(10),
    //       //                     gradient: const LinearGradient(
    //       //                       begin: Alignment.topCenter,
    //       //                       end: Alignment.bottomCenter,
    //       //                       colors: [
    //       //                         Color.fromARGB(1, 149, 149, 149),
    //       //                         Color.fromARGB(55, 18, 18, 18),
    //       //                       ],
    //       //                     ),
    //       //                   ),
    //       //                   child: const Center(
    //       //                     child: Text(
    //       //                       "شس يبشسي ب",
    //       //                       style: TextStyle(
    //       //                         color: Colors.white,
    //       //                       ),
    //       //                     ),
    //       //                   ),
    //       //                 ),
    //       //               ),
    //       //             ],
    //       //           ),
    //       //         ],
    //       //       ),
    //       //     );
    //       //   })),
    //       // ),
    //     ),
    //   ],
    // );
  }
}
