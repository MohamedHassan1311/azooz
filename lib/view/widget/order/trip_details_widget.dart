import 'package:azooz/common/custom_waiting_dialog.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:provider/provider.dart';

import '../../../app.dart';
import '../../../common/config/orders_types.dart';
import '../../../common/style/colors.dart';
import '../../../common/style/dimens.dart';
import '../../../generated/locale_keys.g.dart';
import '../../../model/response/trip_details_model.dart';
import '../../../model/screen_argument/order_details_argument.dart';
import '../../../providers/address_provider.dart';
import '../../../providers/client_trips_provider.dart';
import '../../../providers/orders_provider.dart';
import '../../../providers/payment_provider.dart';
import '../../../providers/product_provider.dart';
import '../../../utils/easy_loading_functions.dart';
import '../../custom_widget/custom_button.dart';
import '../../custom_widget/custom_error_widget.dart';
import '../../custom_widget/custom_loading_widget.dart';
import '../../custom_widget/marquee_widget.dart';
import '../../screen/maps/get_location_api.dart';
import 'address_details_widget.dart';
import 'store_details_order_widget.dart';

class TripDetailsWidget extends StatefulWidget {
  final TripDetailsArgument argument;

  const TripDetailsWidget({Key? key, required this.argument}) : super(key: key);

  @override
  State<TripDetailsWidget> createState() => TripDetailsWidgetState();
}

class TripDetailsWidgetState extends State<TripDetailsWidget> {
  late Future<TripDetailsModel> future;

  @override
  void initState() {
    super.initState();
    if (widget.argument.isOrderDetails == true) {
      future = Provider.of<ClientTripsProvider>(context, listen: false)
          .getTripDetailsById(
        context: context,
        id: widget.argument.orderID!,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.argument.isOrderDetails == true
        ? FutureBuilder<TripDetailsModel>(
            future: future,
            builder: (context, snapshot) {
              return snapshot.hasData && snapshot.data != null
                  ? Consumer<ClientTripsProvider>(
                      builder: (context, provider, child) {
                        ClientTripDetails? data =
                            provider.getTripDetails.result!.orders;
                        return Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "رقم الرحلة",
                                    style:
                                        Theme.of(context).textTheme.bodySmall,
                                  ),
                                  sizedBox(height: 10),
                                  Align(
                                    alignment: AlignmentDirectional.centerStart,
                                    child: MarqueeWidget(
                                      child: Text(
                                        data!.id.toString(),
                                      ),
                                    ),
                                  ),
                                  sizedBox(height: 10),
                                  Text(
                                    "من",
                                    style:
                                        Theme.of(context).textTheme.subtitle1,
                                  ),
                                  sizedBox(height: 10),
                                  Align(
                                    alignment: AlignmentDirectional.centerStart,
                                    child: MarqueeWidget(
                                      child: Text(
                                        data.deliveryAddress!.details!
                                            .toString(),
                                      ),
                                    ),
                                  ),
                                  sizedBox(height: 10),
                                  Text(
                                    "إلى",
                                    style:
                                        Theme.of(context).textTheme.subtitle1,
                                  ),
                                  sizedBox(height: 10),
                                  Align(
                                    alignment: AlignmentDirectional.centerStart,
                                    child: MarqueeWidget(
                                      child: Text(
                                        data.deliveryAddress?.toDetails ?? "",
                                      ),
                                    ),
                                  ),
                                  sizedBox(height: 15),
                                  // Text(
                                  //   LocaleKeys.deliveryTime.tr(),
                                  //   style: Theme.of(context).textTheme.subtitle1,
                                  // ),
                                  // sizedBox(height: 10),
                                  // Align(
                                  //   alignment: AlignmentDirectional.centerStart,
                                  //   child: MarqueeWidget(
                                  //     child: Text(
                                  //       data.duration!,
                                  //     ),
                                  //   ),
                                  // ),
                                  sizedBox(height: 15),
                                  Text(
                                    LocaleKeys.orderTime.tr(),
                                    style:
                                        Theme.of(context).textTheme.subtitle1,
                                  ),
                                  sizedBox(height: 10),
                                  Align(
                                    alignment: AlignmentDirectional.centerStart,
                                    child: MarqueeWidget(
                                      child: Text(
                                        data.createdAt!,
                                      ),
                                    ),
                                  ),
                                  sizedBox(height: 15),
                                  Text(
                                    LocaleKeys.orderStatus.tr(),
                                    style:
                                        Theme.of(context).textTheme.subtitle1,
                                  ),
                                  sizedBox(height: 10),
                                  Align(
                                    alignment: AlignmentDirectional.centerStart,
                                    child: MarqueeWidget(
                                      child: Text(
                                        data.status!.name!,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Spacer(),

                            /// Cancel trip button
                            if (data.orderType !=
                                ClientOrdersTypes.delayedTrip) ...[
                              const SizedBox(height: 20),
                              CustomButton(
                                width: MediaQuery.of(context).size.width * 0.94,
                                text: "إلغاء المشوار",
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
                                              title:
                                                  LocaleKeys.cancelOrder.tr(),
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
                                                      id: widget
                                                          .argument.orderID,
                                                    )
                                                    .whenComplete(() {
                                                  Navigator.of(context).pop();
                                                });
                                              },
                                              cancelPress: () {
                                                // getItRouter.pop();
                                                // Navigator.of(context).pop();
                                                Navigator.of(context).pop();
                                              },
                                              confirmText:
                                                  "تأكيد إلغاء المشوار",
                                              cancelText: "التراجع",
                                            );
                                          });
                                    }
                                  });
                                },
                              ),
                              const SizedBox(height: 20),
                            ],
                          ],
                        );
                      },
                    )
                  : snapshot.hasError
                      ? const CustomErrorWidget()
                      : const CustomLoadingWidget();
            })
        : ListView(
            shrinkWrap: true,
            children: [
              StoreDetailsOrderWidget(
                storeName: widget.argument.storeName ?? '',
                orderNumber: '',
              ),
              // sizedBox(height: 15),
              // const PaymentWayOrderWidget(),
              sizedBox(height: 15),
              const AddressDetailsWidget(),
              Column(
                children: [
                  sizedBox(
                      height: widget.argument.withButton == false ? 0.3 : 0.18),
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
                  if (widget.argument.withButton == true) ...[
                    Padding(
                      padding: edgeInsetsOnly(top: 10),
                      child: CustomButton(
                        width: MediaQuery.of(context).size.width * 0.94,
                        text: LocaleKeys.confirmOrder.tr(),
                        textColor: Theme.of(context).primaryColorLight,
                        onPressed: () async {
                          List<Map<String, dynamic>> listProducts = [];
                          for (var element in Provider.of<ProductProvider>(
                                  context,
                                  listen: false)
                              .productsArgumentList) {
                            listProducts.add(
                              // ProductReq(
                              //   id: element.id,
                              //   count: element.quantity,
                              // ),
                              {
                                'id': element.id,
                                'count': element.quantity,
                              },
                            );
                          }
                          final provider = Provider.of<OrdersProvider>(context,
                              listen: false);
                          final providerAddress = Provider.of<AddressProvider>(
                              context,
                              listen: false);

                          if (providerAddress.selectedName.isNotEmpty) {
                            await getItContext!
                                .read<MapServicesProvider>()
                                .getAddress(LatLng(providerAddress.selectedLat,
                                    providerAddress.selectedLng))
                                .then(
                              (value) {
                                provider.createOrder(
                                  context: context,
                                  details: widget.argument.details!.isNotEmpty
                                      ? widget.argument.details
                                      : '',
                                  durationID: provider.durationID,
                                  storeID: widget.argument.storeID ?? 0,
                                  products: listProducts,
                                  clientLocationLat:
                                      providerAddress.selectedLat,
                                  clientLocationLng:
                                      providerAddress.selectedLng,
                                  paymentTypeId: context
                                      .read<PaymentProvider>()
                                      .payRechargeId,
                                  clientLocationDetails: value
                                      .results![0].formattedAddress
                                      .toString(),
                                );
                                return Future.value(value);
                              },
                            );
                          } else {
                            showInfo(msg: LocaleKeys.chooseAddress.tr());
                          }
                        },
                      ),
                    ),
                  ]
                ],
              )
            ],
          );
  }
}
