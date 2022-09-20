import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:provider/provider.dart';

import '../../../app.dart';
import '../../../common/config/assets.dart';
import '../../../common/custom_waiting_dialog.dart';
import '../../../common/style/colors.dart';
import '../../../common/style/dimens.dart';
import '../../../generated/locale_keys.g.dart';
import '../../../model/response/order_details_model.dart';
import '../../../model/screen_argument/order_details_argument.dart';
import '../../../providers/address_provider.dart';
import '../../../providers/orders_provider.dart';
import '../../../providers/payment_provider.dart';
import '../../../providers/product_provider.dart';
import '../../../service/network/url_constants.dart';
import '../../../utils/easy_loading_functions.dart';
import '../../../utils/dialogs.dart';
import '../../custom_widget/custom_button.dart';
import '../../custom_widget/custom_error_widget.dart';
import '../../custom_widget/custom_loading_widget.dart';
import '../../custom_widget/marquee_widget.dart';
import '../../screen/maps/get_location_api.dart';
import 'address_details_widget.dart';
import 'store_details_order_widget.dart';

////*********** */

class OrderDetailsWidget extends StatefulWidget {
  final OrderDetailsArgument argument;

  const OrderDetailsWidget({Key? key, required this.argument})
      : super(key: key);

  @override
  State<OrderDetailsWidget> createState() => _OrderDetailsWidgetState();
}

class _OrderDetailsWidgetState extends State<OrderDetailsWidget> {
  late Future<OrderDetailsModel> futureOrderDetails;

  @override
  void initState() {
    super.initState();
    if (widget.argument.isOrderDetails == true) {
      futureOrderDetails =
          Provider.of<OrdersProvider>(context, listen: false).getOrderDetails(
        context: context,
        id: widget.argument.orderID,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<OrderDetailsModel>(
        future: futureOrderDetails,
        builder: (context, snapshot) {
          return snapshot.hasData &&
                  snapshot.connectionState == ConnectionState.done
              ? Consumer<OrdersProvider>(
                  builder: (context, provider, child) {
                    var data = provider.orderDetailsModel.result!.orders;
                    return Column(
                      children: [
                        Expanded(
                          child: SingleChildScrollView(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 10,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.all(12),
                                  decoration: const BoxDecoration(
                                    color: Palette.activeWidgetsColor,
                                    borderRadius: kBorderRadius10,
                                  ),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Text(LocaleKeys.orderNumber.tr()),
                                          const SizedBox(width: 12),
                                          Text(provider.orderDetailsModel
                                              .result!.orders!.id
                                              .toString()),
                                        ],
                                      ),
                                      const SizedBox(height: 12),
                                      Row(
                                        children: [
                                          Text(LocaleKeys.orderStatus.tr()),
                                          const SizedBox(width: 12),
                                          Text(data!.status!.name!),
                                        ],
                                      ),
                                      const SizedBox(height: 12),
                                      Row(
                                        children: [
                                          Text(LocaleKeys.orderTime.tr()),
                                          const SizedBox(width: 12),
                                          Text(data.createdAt!.toString()),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 12),
                                Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.all(12),
                                  decoration: const BoxDecoration(
                                    color: Palette.activeWidgetsColor,
                                    borderRadius: kBorderRadius10,
                                  ),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Text(LocaleKeys.storeName.tr()),
                                          const SizedBox(width: 12),
                                          Text(data.store!.details!.name
                                              .toString()),
                                        ],
                                      ),
                                      const SizedBox(height: 12),
                                      Row(
                                        children: [
                                          Text(LocaleKeys.storeRate.tr()),
                                          const SizedBox(width: 12),
                                          Align(
                                            alignment: AlignmentDirectional
                                                .centerStart,
                                            child: Row(
                                              children: [
                                                const Icon(
                                                  Icons.star,
                                                  size: 20,
                                                  color: Palette.kRating,
                                                ),
                                                sizedBox(width: 5),
                                                MarqueeWidget(
                                                  child: Text(
                                                    data.store!.details!.rate
                                                        .toString(),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 12),
                                Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.all(12),
                                  decoration: const BoxDecoration(
                                    color: Palette.activeWidgetsColor,
                                    borderRadius: kBorderRadius10,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        LocaleKeys.deliveryAddress.tr(),
                                      ),
                                      sizedBox(height: 10),
                                      Row(
                                        children: [
                                          Row(
                                            children: [
                                              sizedBox(
                                                height: 20,
                                                width: 20,
                                                child: homeSVG,
                                              ),
                                              sizedBox(width: 20),
                                            ],
                                          ),
                                          Expanded(
                                            child: Text(
                                              data.deliveryAddress!.details ??
                                                  LocaleKeys.address.tr(),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.all(12),
                                  decoration: const BoxDecoration(
                                    color: Palette.activeWidgetsColor,
                                    borderRadius: kBorderRadius10,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(LocaleKeys.note.tr()),
                                      sizedBox(height: 15),
                                      Text(
                                        data.details ?? "",
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle1,
                                      ),
                                    ],
                                  ),
                                ),

                                const SizedBox(height: 10),
                                // Products
                                _ProductsCard(
                                  products: data.products!,
                                ),
                              ],
                            ),
                          ),
                        ),
                        if (data.status!.id != 84) ...[
                          const SizedBox(height: 10),
                          CustomButton(
                            width: MediaQuery.of(context).size.width * 0.94,
                            text: LocaleKeys.cancelOrder.tr(),
                            textColor: Theme.of(context).primaryColorLight,
                            onPressed: () {
                              context
                                  .read<OrdersProvider>()
                                  .cancelConfirmation(context: context)
                                  .then((response) {
                                if (response != null) {
                                  final message = response.message;
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return SmartAlertDialog(
                                          isCancelable: false,
                                          title: LocaleKeys.cancelOrder.tr(),
                                          description: message.toString(),
                                          confirmPress: () {
                                            // Cancel order and pop back
                                            Navigator.of(context).pop();
                                            print(
                                                "Order id - from provider:: ${data.id}");
                                            print(
                                                "Order id:: ${widget.argument.orderID}");
                                            context
                                                .read<OrdersProvider>()
                                                .cancelOrder(
                                                  context: context,
                                                  id: widget.argument.orderID,
                                                )
                                                .then((value) {
                                              Navigator.of(context).pop();
                                            });
                                          },
                                          cancelPress: () {
                                            // getItRouter.pop();
                                            // Navigator.of(context).pop();
                                            Navigator.of(context).pop();
                                          },
                                          confirmText: "تأكيد إلغاء الطلب",
                                          cancelText: "التراجع",
                                        );
                                      });
                                }
                              });

                              // showDialog(
                              //     context: context,
                              //     builder: (context) {
                              //       return AlertDialog(
                              //         content: Text(
                              //           LocaleKeys.cancelOrderConfirm
                              //               .tr(),
                              //         ),
                              //         actions: [
                              //           TextButton(
                              //             child: Text(
                              //               LocaleKeys.cancel.tr(),
                              //             ),
                              //             onPressed: () {
                              //               Navigator.of(context).pop();
                              //             },
                              //           ),
                              //           TextButton(
                              //             child: Text(
                              //               LocaleKeys.confirm.tr(),
                              //             ),
                              //             onPressed: () {
                              //               if (mounted) {
                              //                 Navigator.of(context)
                              //                     .pop();
                              //               }
                              //               provider
                              //                   .cancelOrder(
                              //                 context: context,
                              //                 id: data.id,
                              //               )
                              //                   .then((value) {
                              //                 if (mounted) {
                              //                   // Navigator.of(context)
                              //                   //     .pop();
                              //                 }
                              //               });
                              //             },
                              //           ),
                              //         ],
                              //       );
                              //     });
                            },
                          ),
                          const SizedBox(height: 20),
                        ]
                      ],
                    );
                  },
                )
              : snapshot.hasError
                  ? const CustomErrorWidget()
                  : const CustomLoadingWidget();
        });
  }
}

class _ProductsCard extends StatelessWidget {
  const _ProductsCard({
    Key? key,
    required this.products,
  }) : super(key: key);

  final List<Products>? products;

  @override
  Widget build(BuildContext context) {
    if (products == null || products!.isEmpty) {
      return const SizedBox();
    }
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: const BoxDecoration(
        color: Palette.activeWidgetsColor,
        borderRadius: kBorderRadius10,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("قائمة المنتجات"),
          const SizedBox(height: 10),
          Column(
            children: products!.map(
              (e) {
                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  height: 80,
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
                      SizedBox(
                        width: 30,
                        height: 30,
                        child: ClipOval(
                          child: CachedNetworkImage(
                            imageUrl: baseImageURL + e.imageURl.toString(),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Row(
                          // crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Expanded(
                            //   child: CachedImageCircular(
                            //     imageUrl: context
                            //         .read<StoreProvider>()
                            //         .products![index]
                            //         .imageURL,
                            //     width: 40,
                            //     height: 40,
                            //   ),
                            // ),
                            const SizedBox(width: 8),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.51,
                                  child: MarqueeWidget(
                                    child: Text(
                                      'fasdf sadfdd',
                                      style:
                                          Theme.of(context).textTheme.subtitle2,
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
                                      text: "fasdf",
                                      style:
                                          Theme.of(context).textTheme.subtitle2,
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
                      Text(
                        "${LocaleKeys.count.tr()} ${e.count.toString()}",
                      ),
                      const SizedBox(width: 5),
                    ],
                  ),
                );

                // return Card(
                //   child: ListTile(
                //     trailing: Text(
                //       "${LocaleKeys.count.tr()} ${e.count.toString()}",
                //     ),
                //     title: SizedBox(
                //       width: 30,
                //       height: 30,
                //       child: ClipOval(
                //         child: CachedNetworkImage(
                //           imageUrl: "http://api.azoooz.com${e.imageURl}",
                //           fit: BoxFit.cover,
                //         ),
                //       ),
                //     ),
                //   ),
                // );
              },
            ).toList(),
          ),
        ],
      ),
    );
  }
}

class ConfirmationDetails extends StatelessWidget {
  const ConfirmationDetails({
    Key? key,
    required this.argument,
  }) : super(key: key);

  final OrderConfirmationArgument argument;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                StoreDetailsOrderWidget(
                  storeName: argument.storeName ?? '',
                  orderNumber: '',
                ),
                const SizedBox(height: 15),
                const AddressDetailsWidget(),
                Column(
                  children: [
                    const Divider(
                      thickness: 1,
                      endIndent: 15,
                      indent: 15,
                      color: Palette.secondaryLight,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          LocaleKeys.total.tr(),
                          style: Theme.of(context).textTheme.subtitle1,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.start,
                        ),
                        sizedBox(width: 15),
                        Consumer<ProductProvider>(
                          builder: (context, provider, child) {
                            return Text(
                              provider.totalProductsPrice.toString(),
                              style: Theme.of(context).textTheme.subtitle1,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.start,
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 10),
        CustomButton(
          width: MediaQuery.of(context).size.width * 0.94,
          text: LocaleKeys.confirmOrder.tr(),
          textColor: Theme.of(context).primaryColorLight,
          onPressed: () async {

            List<Map<String, dynamic>> listProducts = [];
            for (var element
                in Provider.of<ProductProvider>(context, listen: false)
                    .productsArgumentList) {
              listProducts.add(
                {
                  'id': element.id,
                  'count': element.quantity,
                },
              );
            }
            final provider =
                Provider.of<OrdersProvider>(context, listen: false);
            final providerAddress =
                Provider.of<AddressProvider>(context, listen: false);
            final int? selectedPaymentId =
                context.read<PaymentProvider>().orderPaymentType!.id;

            if (providerAddress.selectedName.isNotEmpty &&
                selectedPaymentId != null) {
              circularDialog(context);
              await getItContext!
                  .read<MapServicesProvider>()
                  .getAddress(LatLng(
                      providerAddress.selectedLat, providerAddress.selectedLng))
                  .then(
                (value) {
                  provider
                      .createOrder(
                    context: context,
                    details:
                        argument.details!.isNotEmpty ? argument.details : '',
                    durationID: provider.durationID,
                    storeID: argument.storeID ?? 0,
                    products: listProducts,
                    clientLocationLat: providerAddress.selectedLat,
                    clientLocationLng: providerAddress.selectedLng,
                    paymentTypeId: selectedPaymentId,
                    clientLocationDetails:
                        value.results![0].formattedAddress.toString(),
                  )
                      .then((value) {
                    context.read<AddressProvider>().disposeData();
                    context.read<ProductProvider>().clearCart();
                    Navigator.of(context, rootNavigator: true).pop();
                  });
                  return Future.value(value);
                },
              ).catchError((error) {
                print("I am error:: $error");
                Navigator.of(context, rootNavigator: true).pop();
              });
            } else {
              Navigator.of(context, rootNavigator: true).pop();
              showInfo(msg: LocaleKeys.chooseAddress.tr());
            }
          },
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
