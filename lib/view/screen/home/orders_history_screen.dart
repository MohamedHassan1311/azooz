import 'package:azooz/common/style/colors.dart';
import 'package:azooz/model/response/orders_model.dart';
import 'package:azooz/providers/client_trips/active_trips/get_all_trips_provider.dart';
import 'package:azooz/view/custom_widget/custom_error_widget.dart';
import 'package:azooz/view/custom_widget/custom_loading_widget.dart';
import 'package:azooz/view/widget/home/orders_history/order_meshwar/meshwar_history.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../common/style/dimens.dart';
import '../../../generated/locale_keys.g.dart';
import '../../../model/response/orders_model.dart';
import '../../../providers/orders_provider.dart';
import '../../custom_widget/custom_search_form_widget.dart';
import '../../widget/home/orders_history/orders_history_list_widget.dart';

class OrdersHistoryScreen extends StatefulWidget {
  static const routeName = 'orders_history';

  const OrdersHistoryScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<OrdersHistoryScreen> createState() => _OrdersHistoryScreenState();
}

class _OrdersHistoryScreenState extends State<OrdersHistoryScreen> {
  // bool isCurrentSelected = true;
  // bool isPreviousSelected = false;

  // OrderHistoryTypes? _selectedOrderTypeStatus = OrderHistoryTypes.talabat;

  late TextEditingController _typeAheadController;

  late Future<OrdersModel> _futureOrdersHistory;

  @override
  void initState() {
    super.initState();
    final provider = context.read<OrdersProvider>();
    _futureOrdersHistory = provider.getCurrentOrders(
        context: context, page: 1, isTripsOrders: false);
    if (provider.getCurrentOrderHistoryType == OrderHistoryTypes.meshwar &&
        provider.forceNavigateToMeshwar == true) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        provider.setOrderHistoryType = OrderHistoryTypes.meshwar;
      });
    } else {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        provider.setOrderHistoryType = OrderHistoryTypes.talabat;
      });
    }
    if (provider.isNewOrdersTrips == false) {
      provider.setCurrentOrdersTripsStatus = true;
    }

    selectedButton = ValueNotifier<bool>(true);
    _typeAheadController = TextEditingController();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (mounted) {
        final provider = context.read<OrdersProvider>();
        provider.disposeData();
      }
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<OrdersModel>(
        future: _futureOrdersHistory,
        builder: (context, snapshot) {
          return snapshot.hasData
              ? Consumer<OrdersProvider>(
                  builder: (context, ordersProvider, _) {
                    bool isCurrent = ordersProvider.isNewOrdersTrips;
                    bool isPrevious = ordersProvider.isFinishedOrdersTrips;
                    OrderHistoryTypes orderHistoryTypes =
                        ordersProvider.getCurrentOrderHistoryType;
                    return Padding(
                      padding: edgeInsetsSymmetric(horizontal: 8),
                      child: Column(
                        children: [
                          Padding(
                            padding: edgeInsetsOnly(top: 10, bottom: 3),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 5,
                                  child: CustomSearchFormWidget(
                                    suggestionsCallback: (pattern) {
                                      return [];
                                    },
                                    validatorText: '',
                                    onChanged: (val) {
                                      print("##### onChanged: $val #####");
                                      context
                                          .read<OrdersProvider>()
                                          .filterPreviousOrders(val);
                                      context
                                          .read<GetAllTripProvider>()
                                          .filterPreviousOrders(val);
                                      if (val.isNotEmpty &&
                                          _typeAheadController.text
                                              .trim()
                                              .isNotEmpty) {
                                        if (isCurrent) {
                                          context
                                              .read<OrdersProvider>()
                                              .filterCurrentOrders(val);
                                        } else if (isPrevious) {
                                          context
                                              .read<OrdersProvider>()
                                              .filterPreviousOrders(val);
                                        }
                                      } else {
                                        if (isCurrent &&
                                            orderHistoryTypes ==
                                                OrderHistoryTypes.talabat) {
                                          context
                                              .read<OrdersProvider>()
                                              .getCurrentOrders(
                                                  context: context,
                                                  page: 1,
                                                  isTripsOrders: false);
                                        } else if (isPrevious &&
                                            orderHistoryTypes ==
                                                OrderHistoryTypes.talabat) {
                                          context
                                              .read<OrdersProvider>()
                                              .getPreviousOrders(
                                                context: context,
                                                page: 1,
                                              );
                                        }

                                        if (isCurrent &&
                                            orderHistoryTypes ==
                                                OrderHistoryTypes.meshwar) {
                                          context
                                              .read<GetAllTripProvider>()
                                              .getAllActiveTrips(
                                                page: 1,
                                              );

                                          // context.read<OrdersProvider>().getCurrentOrders(
                                          //     context: context,
                                          //     page: 1,
                                          //     isTripsOrders: true);
                                        } else if (isPrevious &&
                                            orderHistoryTypes ==
                                                OrderHistoryTypes.meshwar) {
                                          context
                                              .read<GetAllTripProvider>()
                                              .getAllFinishTrips(
                                                page: 1,
                                              );
                                        }
                                      }
                                    },
                                    withSuggestion: false,
                                    controller: _typeAheadController,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  flex: 2,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5),
                                    decoration: const BoxDecoration(
                                      color: Palette.activeWidgetsColor,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(30),
                                      ),
                                    ),
                                    child: Theme(
                                      data: ThemeData(
                                        splashColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                      ),
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: DropdownButtonHideUnderline(
                                          child: DropdownButton<
                                                  OrderHistoryTypes>(
                                              dropdownColor:
                                                  Palette.activeWidgetsColor,
                                              value: orderHistoryTypes,
                                              alignment: Alignment.center,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .labelLarge,
                                              borderRadius:
                                                  const BorderRadius.all(
                                                Radius.circular(10),
                                              ),
                                              items: [
                                                DropdownMenuItem<
                                                    OrderHistoryTypes>(
                                                  value: OrderHistoryTypes
                                                      .talabat,
                                                  alignment: Alignment.center,
                                                  child: Text(
                                                    LocaleKeys.talabat.tr(),
                                                    textAlign:
                                                        TextAlign.center,
                                                  ),
                                                ),
                                                DropdownMenuItem<
                                                    OrderHistoryTypes>(
                                                  value: OrderHistoryTypes
                                                      .meshwar,
                                                  alignment: Alignment.center,
                                                  child: Text(
                                                    LocaleKeys.meshwar.tr(),
                                                    textAlign:
                                                        TextAlign.center,
                                                  ),
                                                ),
                                              ],
                                              onChanged: (val) {
                                                print(
                                                    "### Meshwarrr:: $val ###");
                                                if (val != null) {
                                                  if (_typeAheadController
                                                      .text.isNotEmpty) {
                                                    _typeAheadController
                                                        .clear();
                                                  }
                                                  ordersProvider
                                                          .setOrderHistoryType =
                                                      val;
                                                  if (isPrevious) {
                                                    ordersProvider
                                                            .setCurrentOrdersTripsStatus =
                                                        true;
                                                  }

                                                  // if (orderHistoryTypes ==
                                                  //     OrderHistoryTypes
                                                  //         .meshwar) {
                                                  //   context
                                                  //       .read<OrdersProvider>()
                                                  //       .changeSelectedType(
                                                  //           "Meshwar")
                                                  //       .whenComplete(
                                                  //     () {
                                                  //       context
                                                  //           .read<
                                                  //               OrdersProvider>()
                                                  //           .getPreviousOrders(
                                                  //             context: context,
                                                  //             page: 1,
                                                  //           );
                                                  //     },
                                                  //   );
                                                  // }
                                                }
                                              }),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          if (orderHistoryTypes == OrderHistoryTypes.talabat)
                            ValueListenableBuilder(
                              valueListenable: ValueNotifier<bool>(isCurrent),
                              builder: (context, bool isSelected, widget) {
                                print("### value::1 $isSelected ###");
                                return const Expanded(
                                  child: OrdersHistoryListWidget(),
                                );
                              },
                            ),
                          if (orderHistoryTypes == OrderHistoryTypes.meshwar)
                            ValueListenableBuilder(
                              valueListenable: ValueNotifier<bool>(isCurrent),
                              builder: (context, bool isSelected, widget) {
                                print("### value::2 $isSelected ###");
                                return const Expanded(
                                  child: MeshwarHistoryListWidget(),
                                );
                              },
                            ),
                        ],
                      ),
                    );
                  },
                )
              : snapshot.hasError
                  ? const CustomErrorWidget()
                  : const CustomLoadingWidget();
        });
  }
}

enum OrderHistoryTypes {
  talabat,
  meshwar,
}

late ValueNotifier<bool> selectedButton;
