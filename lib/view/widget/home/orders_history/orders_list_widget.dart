import 'package:azooz/common/style/colors.dart';
import 'package:azooz/providers/orders_provider.dart';
import 'package:azooz/view/screen/home/orders_history_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../../../common/config/app_status.dart';
import '../../../../common/routes/app_router_control.dart';
import '../../../../common/routes/app_router_import.gr.dart';
import '../../../../common/style/dimens.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../../../model/response/orders_model.dart';
import '../../../../model/screen_argument/order_confirm_argument.dart';
import '../../../../model/screen_argument/order_details_argument.dart';
import '../../../../providers/chat_provider.dart';
import '../../../custom_widget/custom_loading_widget.dart';
import '../../../custom_widget/marquee_widget.dart';
import '../../../custom_widget/vertical_divider_widget.dart';
import '../../../screen/home/chat_screen.dart';

bool test = false;

class OrdersListWidget extends StatefulWidget {
  final List<Order>? list;
  final double? imageWidth;
  final double imageHeight;
  final BoxFit? boxFit;
  final bool? isQuantity;
  final bool? isLoading;
  final bool? isButton;
  final bool? loadingPagination;
  final Function()? onTapButton;
  final ScrollController scrollController;
  final bool isTripsOrders;

  const OrdersListWidget({
    Key? key,
    required this.list,
    this.imageHeight = 45,
    this.imageWidth = 45,
    this.boxFit = BoxFit.contain,
    this.isQuantity = false,
    this.isLoading = false,
    this.isButton = false,
    this.onTapButton,
    required this.loadingPagination,
    required this.scrollController,
    required this.isTripsOrders,
  }) : super(key: key);

  @override
  State<OrdersListWidget> createState() => _OrdersListWidgetState();
}

class _OrdersListWidgetState extends State<OrdersListWidget> {
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Padding(
      padding: edgeInsetsOnly(top: 20, bottom: 10),
      child: ListView.builder(
        controller: widget.scrollController,
        itemCount: widget.list!.length,
        itemBuilder: (context, index) {
          final String? orderStatus = widget.list![index].status!.name;

          if (index == widget.list!.length) {
            return widget.loadingPagination!
                ? const CustomLoadingPaginationWidget()
                : const SizedBox();
          }
          return GestureDetector(
            onTap: () {
              final orderStatusId = widget.list![index].status!.id;
              final orderStatusName = widget.list![index].status!.name;

              print("Status Id:: $orderStatusId");
              print("Status Name:: $orderStatusName");

              // Orders details below

              if (!widget.isTripsOrders && widget.list != null) {
                if (orderStatusId == AppStatus.orderStatusTypes['Accept']) {
                  routerPush(
                    context: context,
                    route: OrderConfirmRoute(
                      argument: OrderConfirmArgument(
                        storeName: widget.list![index].storeName,
                        orderID: widget.list![index].id,
                      ),
                    ),
                  );
                } else if (orderStatusId ==
                    AppStatus.orderStatusTypes['Active']) {
                  context
                      .read<ChatProvider>()
                      .getChat(
                          orderID: widget.list![index].id, context: context)
                      .then((chatModel) {
                    if (chatModel?.result != null) {
                      routerPush(
                        context: context,
                        route: ChatScreenRoute(
                          orderID: widget.list![index].id,
                          chatID: chatModel?.result!.chat!.id,
                        ),
                      );
                    }
                  });
                } else {
                  routerPush(
                    context: context,
                    route: OrderDetailsRoute(
                      argument: OrderDetailsArgument(
                        withButton: true,
                        isOrderDetails: true,
                        orderID: widget.list![index].id,
                        storeName: widget.list![index].storeName,
                      ),
                    ),
                  );
                }
              }

              // Meshwar details below

              else if (widget.isTripsOrders && widget.list != null) {
                if (orderStatusId == AppStatus.orderStatusTypes['Accept']) {
                  routerPush(
                    context: context,
                    route: OrderConfirmRoute(
                      argument: OrderConfirmArgument(
                        storeName: widget.list![index].storeName,
                        orderID: widget.list![index].id,
                      ),
                    ),
                  );
                } else if (orderStatusId ==
                    AppStatus.orderStatusTypes['Active']) {
                  context
                      .read<ChatProvider>()
                      .getChat(
                          orderID: widget.list![index].id, context: context)
                      .then((chatModel) {
                    if (chatModel?.result != null) {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) {
                            return ChatScreen(
                              orderID: widget.list![index].id,
                              chatID: chatModel?.result!.chat!.id,
                            );
                          },
                        ),
                      );
                    }
                  });
                } else {
                  // Navigator.of(context).push(
                  //   MaterialPageRoute(
                  //     builder: (context) {
                  //       return TripDetailsScreen(

                  //       );
                  //     },
                  //   ),
                  // );
                  routerPush(
                    context: context,
                    route: TripDetailsScreenRoute(
                      argument: TripDetailsArgument(
                        withButton: true,
                        isOrderDetails: true,
                        orderID: widget.list![index].id,
                        storeName: widget.list![index].storeName,
                      ),
                    ),
                  );
                }

                // else if (orderStatusId == AppStatus.orderStatusTypes['New'] ||
                //     orderStatusId == AppStatus.orderStatusTypes['Cancel']) {
                //   routerPush(
                //     context: context,
                //     route: OrderDetailsRoute(
                //       argument: OrderDetailsArgument(
                //         withButton: true,
                //         isOrderDetails: true,
                //         orderID: widget.list![index].id,
                //         storeName: widget.list![index].storeName,
                //       ),
                //     ),
                //   );
                // }
                // context
                //     .read<ClientTripsProvider>()
                //     .getTripDetailsById(
                //         id: widget.list![index].id ?? 0, context: context)
                //     .then((value) {
                //   // context.read<ClientTripsProvider>().getTripDetails;
                // });

                // final int? tripStatusId = widget.list![index].status!.id;

                // print(
                //     "### orders id:# ${context.read<ClientTripsProvider>().getTripDetails.result!.orders!.status!.id}");
                // if (tripStatusId != null &&
                //     tripStatusId == AppStatus.orderStatusTypes['Active']) {
                //   context
                //       .read<ChatProvider>()
                //       .getChat(
                //           orderID: widget.list![index].id, context: context)
                //       .then((chatModel) {
                //     if (chatModel.result != null) {
                //       Navigator.of(context).push(
                //         MaterialPageRoute(
                //           builder: (context) {
                //             return ChatScreen(
                //               orderID: widget.list![index].id,
                //               chatID: chatModel.result!.chat!.id,
                //             );
                //           },
                //         ),
                //       );
                //     }
                //   });
                // } else if (tripStatusId != null &&
                //     tripStatusId == AppStatus.orderStatusTypes['Accept']) {
                //   routerPush(
                //     context: context,
                //     route: OrderConfirmRoute(
                //       argument: OrderConfirmArgument(
                //         storeName: widget.list![index].storeName,
                //         orderID: widget.list![index].id,
                //       ),
                //     ),
                //   );
                // } else {
                //   Navigator.of(context).push(
                //     MaterialPageRoute(
                //       builder: (context) {
                //         return TripDetailsScreen(
                //           argument: TripDetailsArgument(
                //             withButton: true,
                //             isOrderDetails: true,
                //             orderID: widget.list![index].id,
                //             storeName: widget.list![index].storeName,
                //           ),
                //         );
                //       },
                //     ),
                //   );
                // }
              }
            },
            child: Container(
              margin: const EdgeInsets.all(10),
              height: 130,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: kBorderRadius10,
                boxShadow: [
                  BoxShadow(
                    color: Color(0xFFDDDDDD),
                    blurRadius: 12,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Selector<OrdersProvider, OrderHistoryTypes>(
                    selector: (context, orders) {
                      return orders.getCurrentOrderHistoryType;
                    },
                    builder: (context, orderHistoryTypes, child) {
                      if (orderHistoryTypes == OrderHistoryTypes.talabat) {
                        return Row(
                          children: [
                            SizedBox(
                              width: screenSize.width * 0.75,
                              child: Center(
                                child: MarqueeWidget(
                                  child: Text(
                                    widget.list![index].storeName ?? "",
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    style:
                                        Theme.of(context).textTheme.subtitle1,
                                  ),
                                ),
                              ),
                            ),
                            if (widget.list![index].storeType == 71)
                              const SizedBox(
                                width: 20,
                                height: 20,
                                child: Icon(
                                  FluentIcons.star_12_regular,
                                  color: Palette.primaryColor,
                                ),
                              ),
                          ],
                        );
                      } else {
                        return SizedBox(
                          width: screenSize.width * 0.75,
                          child: Center(
                            child: MarqueeWidget(
                              child: Text(
                                "مشوار",
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: Theme.of(context).textTheme.subtitle1,
                              ),
                            ),
                          ),
                        );
                      }
                    },
                  ),
                  SizedBox(
                    width: screenSize.width * 0.75,
                    child: Text(
                      widget.list![index].details ?? "",
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10.0,
                      vertical: 12,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        if (orderStatus!.isNotEmpty)
                          Flexible(
                            fit: FlexFit.loose,
                            flex: 1,
                            child: MarqueeWidget(
                              child: Text(
                                orderStatus,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(
                                      color: orderStatus == "New order"
                                          ? Colors.red
                                          : Colors.green,
                                    ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        if (orderStatus.isNotEmpty)
                          const VerticalDividerWidget(),
                        Flexible(
                          fit: FlexFit.loose,
                          flex: 1,
                          child: MarqueeWidget(
                            child: Text(
                              '${widget.list![index].createdAt}',
                              style: Theme.of(context).textTheme.bodyText1,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                        const VerticalDividerWidget(),
                        Selector<OrdersProvider, OrderHistoryTypes>(
                          selector: (context, orders) =>
                              orders.getCurrentOrderHistoryType,
                          builder: (context, orderHistoryTypes, child) {
                            if (orderHistoryTypes ==
                                OrderHistoryTypes.talabat) {
                              return Flexible(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Flexible(
                                      fit: FlexFit.loose,
                                      flex: 1,
                                      child: MarqueeWidget(
                                        child: Text(
                                          '${widget.list![index].offersCount} ${LocaleKeys.count.tr()}',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ),
                                    const VerticalDividerWidget(),
                                  ],
                                ),
                              );
                            } else {
                              return const SizedBox();
                            }
                          },
                        ),
                        Flexible(
                          fit: FlexFit.loose,
                          flex: 1,
                          child: MarqueeWidget(
                            child: Text(
                              '${LocaleKeys.orderNo.tr()} ${widget.list![index].id}',
                              style: Theme.of(context).textTheme.bodyText1,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class MeshwarOrderDetails extends StatelessWidget {
  const MeshwarOrderDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text("Testtt")),
    );
  }
}
