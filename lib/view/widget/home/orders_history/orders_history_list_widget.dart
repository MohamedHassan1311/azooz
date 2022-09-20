import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../common/config/tools.dart';
import '../../../../common/style/colors.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../../../model/response/orders_model.dart';
import '../../../../providers/orders_provider.dart';
import '../../../custom_widget/custom_error_widget.dart';
import '../../../custom_widget/custom_loading_widget.dart';
import 'orders_list_widget.dart';

class OrdersHistoryListWidget extends StatefulWidget {
  const OrdersHistoryListWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<OrdersHistoryListWidget> createState() =>
      _OrdersHistoryListWidgetState();
}

class _OrdersHistoryListWidgetState extends State<OrdersHistoryListWidget> {
  @override
  void initState() {
    super.initState();

    context.read<OrdersProvider>().clearFilteredOrders();
  }

  bool isCurrentSelected = true;
  bool isPreviousSelected = false;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: ValueNotifier<bool>(isCurrentSelected),
      builder: (context, value, child) {
        return Column(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.80,
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        var currentRoute =
                            ModalRoute.of(context)?.settings.arguments;

                        print(
                            "## -- Current route from on screen :: $currentRoute -- ##");

                        setState(() {
                          isCurrentSelected = true;
                          isPreviousSelected = false;
                        });
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 350),
                        height: 37,
                        decoration: BoxDecoration(
                          color: isCurrentSelected
                              ? Palette.primaryColor
                              : Colors.grey.shade200,
                          borderRadius: const BorderRadius.all(
                            Radius.circular(30),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            LocaleKeys.current.tr(),
                            style: TextStyle(
                              color: isCurrentSelected
                                  ? Colors.white
                                  : Colors.black87,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          isCurrentSelected = false;
                          isPreviousSelected = true;
                        });
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 350),
                        height: 37,
                        decoration: BoxDecoration(
                          color: isPreviousSelected
                              ? Palette.primaryColor
                              : Colors.grey.shade200,
                          borderRadius: const BorderRadius.all(
                            Radius.circular(30),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            LocaleKeys.previous.tr(),
                            style: TextStyle(
                              color: isPreviousSelected
                                  ? Colors.white
                                  : Colors.black87,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            value == false
                ? const PreviousOrdersWidget()
                : const ActiveOrdersWidget(),
          ],
        );
      },
    );
  }
}

class ActiveOrdersWidget extends StatefulWidget {
  const ActiveOrdersWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<ActiveOrdersWidget> createState() => _ActiveOrdersWidgetState();
}

class _ActiveOrdersWidgetState extends State<ActiveOrdersWidget> {
  late Future<OrdersModel> _futureCurrent;
  late ScrollController _scrollControllerCurrent;

  int currentPage = 1;

  getMoreDataCurrent() {
    final provider = context.read<OrdersProvider>();
    if (!provider.endPageCurrent) {
      if (provider.loadingPagination == false) {
        currentPage++;
        provider.getCurrentOrders(
          context: context,
          page: currentPage,
          isTripsOrders: false,
        );
      }
    }
  }

  scrollListenerCurrent() => Tools.scrollListener(
        scrollController: _scrollControllerCurrent,
        getMoreData: getMoreDataCurrent,
      );

  @override
  void initState() {
    super.initState();
    _futureCurrent = context.read<OrdersProvider>().getCurrentOrders(
          context: context,
          page: currentPage,
          isTripsOrders: false,
        );

    _scrollControllerCurrent = ScrollController();
    _scrollControllerCurrent.addListener(scrollListenerCurrent);
  }

  @override
  void dispose() {
    _scrollControllerCurrent.removeListener(scrollListenerCurrent);
    _scrollControllerCurrent.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FutureBuilder<OrdersModel>(
        future: _futureCurrent,
        builder: (context, snapshot) {
          return snapshot.hasData && snapshot.data != null
              ? Consumer<OrdersProvider>(
                  builder: (context, provider, child) {
                    if (provider.filterOrdersCurrentList == null ||
                        provider.filterOrdersCurrentList!.isEmpty) {
                      return CustomErrorWidget(
                          message: LocaleKeys.noOrders.tr());
                    }
                    return OrdersListWidget(
                      list: provider.filterOrdersCurrentList,
                      boxFit: BoxFit.cover,
                      isLoading: provider.loadingPagination,
                      scrollController: _scrollControllerCurrent,
                      loadingPagination: provider.loadingPagination,
                      isTripsOrders: false,
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

class PreviousOrdersWidget extends StatefulWidget {
  const PreviousOrdersWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<PreviousOrdersWidget> createState() => _PreviousOrdersWidgetState();
}

class _PreviousOrdersWidgetState extends State<PreviousOrdersWidget> {
  late Future<OrdersModel> _futurePreviousOrders;

  int previousPage = 1;

  ScrollController scrollControllerPrevious = ScrollController();

  @override
  void initState() {
    super.initState();

    _futurePreviousOrders = context.read<OrdersProvider>().getPreviousOrders(
          context: context,
          page: 1,
        );
    print("I am _futurePreviousOrders::# $_futurePreviousOrders ##");

    scrollControllerPrevious.addListener(scrollListenerPrevious);
  }

  getMoreDataPrevious() {
    final provider = context.read<OrdersProvider>();
    if (!provider.endPagePrevious) {
      if (provider.loadingPagination == false) {
        previousPage++;
        provider.getPreviousOrders(
          context: context,
          page: previousPage,
        );
      }
    }
  }

  scrollListenerPrevious() => Tools.scrollListener(
        scrollController: scrollControllerPrevious,
        getMoreData: getMoreDataPrevious,
      );

  @override
  void dispose() {
    scrollControllerPrevious.removeListener(scrollListenerPrevious);
    scrollControllerPrevious.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FutureBuilder<OrdersModel>(
        future: _futurePreviousOrders,
        builder: (context, snapshot) {
          return snapshot.hasData
              ? snapshot.data!.result!.orders!.isEmpty
                  ? CustomErrorWidget(
                      message: LocaleKeys.noOrders.tr(),
                    )
                  : Consumer<OrdersProvider>(
                      builder: (context, provider, child) {
                        return OrdersListWidget(
                          list: provider.filterOrdersPreviousList,
                          boxFit: BoxFit.cover,
                          isLoading: provider.loadingPagination,
                          scrollController: scrollControllerPrevious,
                          loadingPagination: provider.loadingPagination,
                          isTripsOrders: false,
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
