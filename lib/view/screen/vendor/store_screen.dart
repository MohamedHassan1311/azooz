// import '../home/chat_screen.dart';

// import '../../../common/style/colors.dart';
// import '../../../common/style/dimens.dart';
// import '../../../model/response/store_model.dart';
// import '../../../model/screen_argument/store_argument.dart';
// import '../../../providers/favorite_provider.dart';
// import '../../../providers/product_provider.dart';
// import '../../../providers/store_provider.dart';
// import '../../custom_widget/custom_error_widget.dart';
// import '../../custom_widget/custom_loading_widget.dart';
// import '../../widget/vendor/product_item_cart_widget.dart';
// import '../../widget/vendor/store_details_widget.dart';
// import '../../widget/vendor/vendor_app_bar_widget.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// class StoreScreen extends StatefulWidget {
//   static const routeName = 'store';
//   final StoreArgument? argument;

//   const StoreScreen({
//     Key? key,
//     this.argument,
//   }) : super(key: key);

//   @override
//   State<StoreScreen> createState() => _StoreScreenState();
// }

// class _StoreScreenState extends State<StoreScreen> {
//   late Future<StoreModel> future;

//   @override
//   void initState() {
//     super.initState();
//     future = Provider.of<StoreProvider>(context, listen: false)
//         .getStore(id: widget.argument!.storeId, context: context);
//     Provider.of<ProductProvider>(context, listen: false)
//         .productsArgumentList
//         .clear();
//     mapProduct.clear();
//   }

//   @override
//   Widget build(BuildContext context) {
//     future.then((store) {
//       print("##### Store Name: ${store.result} #####");
//     });
//     print("##### Store Screen - argument: ${widget.argument} #####");
//     return FutureBuilder<StoreModel>(
//         future: future,
//         builder: (context, snapshot) {
//           return snapshot.hasData
//               ? Scaffold(
//                   resizeToAvoidBottomInset: false,
//                   floatingActionButton: FloatingActionButton(
//                     backgroundColor: Palette.chatIconColor,
//                     onPressed: () {
//
//                       Navigator.of(context).push(MaterialPageRoute(
//                         builder: (_) => const ChatScreen(
//                           chatID: 58,
//                           orderID: 20,
//                         ),
//                       ));
//                     },
//                     child: const Icon(
//                       Icons.chat,
//                     ),
//                   ),
//                   body: Column(
//                     children: [
//                       Consumer<StoreProvider>(
//                         builder: (context, provider, child) {
//                           return VendorAppBarWidget(
//                               isFavorite: true,
//                               title: widget.argument!.name,
//                               inFavorites: provider.favorite,
//                               onPressedFavorite: () {
//                                 provider.favorite == true
//                                     ? Provider.of<FavoriteProvider>(context,
//                                             listen: false)
//                                         .deleteFavorite(
//                                             storeId: widget.argument!.storeId,
//                                             context: context)
//                                         .then(
//                                           (value) =>
//                                               provider.changeFavorite(false),
//                                         )
//                                     : Provider.of<FavoriteProvider>(context,
//                                             listen: false)
//                                         .addFavorite(
//                                             id: widget.argument!.storeId,
//                                             context: context)
//                                         .then(
//                                           (value) =>
//                                               provider.changeFavorite(true),
//                                         );
//                               });
//                         },
//                       ),

//
//                       Expanded(
//                         child: Padding(
//                           padding: edgeInsetsSymmetric(horizontal: 10),
//                           child: StoreDetailsWidget(
//                             argument: widget.argument!,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 )
//               : snapshot.hasError
//                   ? const CustomErrorWidget()
//                   : const CustomLoadingWidget();
//         });
//   }
// }

import 'dart:developer';

import 'package:azooz/common/style/colors.dart';

import '../../../model/response/store_model.dart';
import '../../../model/screen_argument/store_argument.dart';
import '../../../providers/favorite_provider.dart';
import '../../../providers/product_provider.dart';
import '../../../providers/store_provider.dart';
import '../../custom_widget/custom_error_widget.dart';
import '../../custom_widget/custom_loading_widget.dart';
import '../../widget/vendor/store_details_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StoreScreen extends StatefulWidget {
  static const routeName = 'store';
  final StoreArgument? argument;

  const StoreScreen({
    Key? key,
    this.argument,
  }) : super(key: key);

  @override
  State<StoreScreen> createState() => _StoreScreenState();
}

class _StoreScreenState extends State<StoreScreen> {
  late Future<StoreModel> _futureGetStore;

  @override
  void initState() {
    super.initState();
    print("##!!::name ${widget.argument!.name}");
    print("##!!:: ${widget.argument!.storeId}");
    Provider.of<ProductProvider>(context, listen: false).clearCart();
    _futureGetStore = Provider.of<StoreProvider>(context, listen: false)
        .getStore(id: widget.argument!.storeId, context: context);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<StoreModel>(
        future: _futureGetStore,
        builder: (context, snapshot) {
          return snapshot.hasData && snapshot.data != null
              ? Scaffold(
                  appBar: AppBar(
                    title: Text(widget.argument!.name.toString()),
                    actions: [
                      Consumer<StoreProvider>(
                        builder: (context, provider, child) {
                          return IconButton(
                            onPressed: () {
                              log('addaaaaaaaaaaaaaaaaaaaaaa');
                              log('paginationList: ${Provider.of<FavoriteProvider>(context, listen: false).paginationList.toString()}');
                              provider.favorite![widget.argument!.storeId!] ==
                                      true
                                  ? Provider.of<FavoriteProvider>(context,
                                          listen: false)
                                      .deleteFavorite(
                                          storeId: widget.argument!.storeId,
                                          context: context)
                                      .then(
                                        (value) => provider.changeFavorite(
                                            false, widget.argument!.storeId!),
                                      )
                                  : Provider.of<FavoriteProvider>(context,
                                          listen: false)
                                      .addFavorite(
                                          id: widget.argument!.storeId,
                                          context: context)
                                      .then(
                                        (value) => provider.changeFavorite(
                                            true, widget.argument!.storeId!),
                                      );
                            },
                            icon:
                                provider.favorite![widget.argument!.storeId!] ==
                                        true
                                    ? const Icon(
                                        Icons.favorite,
                                        color: Palette.primaryColor,
                                      )
                                    : const Icon(
                                        Icons.favorite_outline_outlined,
                                        color: Palette.primaryColor,
                                      ),
                          );
                        },
                      ),
                    ],
                  ),
                  resizeToAvoidBottomInset: false,
                  body: StoreDetailsWidget(
                    argument: widget.argument!,
                  ),
                )
              : snapshot.hasError
                  ? const CustomErrorWidget()
                  : const CustomLoadingWidget();
        });
  }
}
