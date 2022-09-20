import 'package:easy_localization/easy_localization.dart';

import '../../../generated/locale_keys.g.dart';
import '../../../model/response/home_model.dart';
import '../../../providers/home_provider.dart';
import '../../../providers/location_provider.dart';
import '../../custom_widget/custom_error_widget.dart';
import '../../custom_widget/custom_loading_widget.dart';
import '../../widget/home/stores/categories_home_widget.dart';
import '../../widget/home/stores/stores_app_bar.dart';
import '../../widget/home/stores/offers_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../widget/home/stores/stores_widget.dart';

class StoresScreen extends StatefulWidget {
  static const routeName = 'stores';

  const StoresScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<StoresScreen> createState() => _StoresScreenState();
}

class _StoresScreenState extends State<StoresScreen> {
  late Future<HomeModel> futureHomeDetails;

  @override
  void initState() {
    super.initState();
    Provider.of<HomeProvider>(context, listen: false).disposeData();
    futureHomeDetails = Provider.of<HomeProvider>(context, listen: false)
        .getHomeDetails(context: context);
    Provider.of<LocationProvider>(context, listen: false).getCurrentPosition();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<HomeModel>(
        future: futureHomeDetails,
        builder: (context, snapshot) {
          return snapshot.hasData
              ? Consumer<HomeProvider>(builder: (context, provider, child) {
                  return CustomScrollView(
                    physics: const BouncingScrollPhysics(),
                    slivers: [
                      const SliverToBoxAdapter(
                        child: StoresAppBar(),
                      ),
                      // const SliverPadding(
                      //   padding: EdgeInsets.symmetric(vertical: 10),
                      // ),
                      SliverPadding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        sliver: SliverToBoxAdapter(
                          child: OffersWidget(
                            list: provider.homeModel.result?.advertisement,
                          ),
                        ),
                      ),
                      // const SliverPadding(
                      //   padding: EdgeInsets.symmetric(vertical: 14),
                      // ),
                      if (provider.homeModel.result!.smartDepartments!.first
                              .stores!.isNotEmpty &&
                          provider
                              .homeModel.result!.smartDepartments!.isNotEmpty)
                        SliverToBoxAdapter(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: OpenStoreWidget(
                              list: provider.homeModel.result?.smartDepartments,
                            ),
                          ),
                        ),
                      SliverPadding(
                        padding: const EdgeInsets.only(
                          // bottom: 20,
                          left: 8,
                          right: 8,
                        ),
                        sliver: SliverToBoxAdapter(
                          child: Align(
                            alignment: AlignmentDirectional.centerStart,
                            child: Text(
                              LocaleKeys.categories.tr(),
                              textAlign: TextAlign.right,
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                          ),
                        ),
                      ),
                      SliverPadding(
                        padding: const EdgeInsets.only(
                          bottom: 45,
                          left: 8,
                          right: 8,
                          top: 2,
                        ),
                        sliver: CategoriesHomeWidget(
                          list: provider.homeModel.result?.departments,
                        ),
                      ),
                      // const SliverPadding(
                      //   padding: EdgeInsets.symmetric(vertical: 20),
                      // ),
                    ],
                  );
                })
              : snapshot.hasError
                  ? const CustomErrorWidget()
                  : const CustomLoadingWidget();
        });
  }
}



// import '../../../common/style/dimens.dart';
// import '../../../model/response/home_model.dart';
// import '../../../providers/home_provider.dart';
// import '../../../providers/location_provider.dart';
// import '../../custom_widget/custom_error_widget.dart';
// import '../../custom_widget/custom_loading_widget.dart';
// import '../../widget/home/stores/categories_home_widget.dart';
// import '../../widget/home/stores/stores_widget.dart';
// import '../../widget/home/stores/stores_app_bar.dart';
// import '../../widget/home/stores/offers_widget.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// class StoresScreen extends StatefulWidget {
//   static const routeName = 'stores';

//   const StoresScreen({
//     Key? key,
//   }) : super(key: key);

//   @override
//   State<StoresScreen> createState() => _StoresScreenState();
// }

// class _StoresScreenState extends State<StoresScreen> {
//   late Future<HomeModel> future;

//   @override
//   void initState() {
//     super.initState();
//     Provider.of<HomeProvider>(context, listen: false).disposeData();
//     future = Provider.of<HomeProvider>(context, listen: false)
//         .getHomeDetails(context: context);
//     Provider.of<LocationProvider>(context, listen: false).getCurrentPosition();
//   }

//   @override
//   void dispose() {
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 8),
//       child: Column(
//         children: [
//           const StoresAppBar(),
//           const SizedBox(height: 10),
//           Expanded(
//             // height: 0.69,
//             child: FutureBuilder<HomeModel>(
//               future: future,
//               builder: (context, snapshot) {
//                 return snapshot.hasData
//                     ? Consumer<HomeProvider>(
//                         builder: (context, provider, child) {
//                           print(
//                               "I am list of smarttts:: ${provider.homeModel.result?.smartDepartments!.first.stores!.first.imagesURLs} ##");
//                           return ListView(
//                             shrinkWrap: true,
//                             children: [
//                               OffersWidget(
//                                 list: provider.homeModel.result?.ads,
//                               ),

//                               if (provider.homeModel.result!.smartDepartments!
//                                       .first.stores!.isNotEmpty &&
//                                   provider.homeModel.result!.smartDepartments!
//                                       .isNotEmpty)
//                                 Padding(
//                                   padding: edgeInsetsSymmetric(vertical: 8.0),
//                                   child: OpenStoreWidget(
//                                     list: provider
//                                         .homeModel.result?.smartDepartments,
//                                   ),
//                                 ),
//                               // sizedBox(height: 15),
//                               CategoriesHomeWidget(
//                                 list: provider.homeModel.result?.departments,
//                               ),
//                             ],
//                           );
//                         },
//                       )
//                     : snapshot.hasError
//                         ? const CustomErrorWidget()
//                         : const CustomLoadingWidget();
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
