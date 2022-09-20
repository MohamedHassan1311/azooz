import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart' as easy_localization;
import '../../../../../common/config/tools.dart';
import '../../../../../common/style/colors.dart';
import '../../../../../generated/locale_keys.g.dart';
import '../../../../../model/response/orders_model.dart';
import '../../../../../providers/orders_provider.dart';
import '../../../../custom_widget/custom_error_widget.dart';
import '../../../../custom_widget/custom_loading_widget.dart';
import '../orders_list_widget.dart';

class MeshwarHistoryListWidget extends StatefulWidget {
  const MeshwarHistoryListWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<MeshwarHistoryListWidget> createState() =>
      _MeshwarHistoryListWidgetState();
}

class _MeshwarHistoryListWidgetState extends State<MeshwarHistoryListWidget> {
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
                  ? const PreviousMeshwarWidget()
                  : const ActiveMeshwarWidget(),
            ],
          );
        });
  }
}

class ActiveMeshwarWidget extends StatefulWidget {
  const ActiveMeshwarWidget({Key? key}) : super(key: key);

  @override
  State<ActiveMeshwarWidget> createState() => _ActiveMeshwarWidgetState();
}

class _ActiveMeshwarWidgetState extends State<ActiveMeshwarWidget> {
  late Future<OrdersModel> futureCurrent;
  late Future<OrdersModel> futurePrevious;

  int currentPage = 1;

  late final OrdersProvider provider;

  ScrollController scrollControllerCurrent = ScrollController();

  @override
  void initState() {
    super.initState();

    provider = Provider.of<OrdersProvider>(context, listen: false);
    // provider.filterOrdersPreviousList!.clear();
    // provider.filterOrdersCurrentList!.clear();
    futureCurrent = provider.getCurrentOrders(
      context: context,
      page: currentPage,
      isTripsOrders: true,
    );

    scrollControllerCurrent.addListener(scrollListenerCurrent);
  }

  getMoreDataCurrent() {
    if (!provider.endPageCurrent) {
      if (provider.loadingPagination == false) {
        currentPage++;
        provider.getCurrentOrders(
          context: context,
          page: currentPage,
          isTripsOrders: true,
        );
      }
    }
  }

  scrollListenerCurrent() => Tools.scrollListener(
        scrollController: scrollControllerCurrent,
        getMoreData: getMoreDataCurrent,
      );

  @override
  void dispose() {
    scrollControllerCurrent.removeListener(scrollListenerCurrent);
    scrollControllerCurrent.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FutureBuilder<OrdersModel>(
        future: futureCurrent,
        builder: (context, snapshot) {
          return snapshot.hasData && snapshot.data != null
              ? snapshot.data!.result!.orders!.isEmpty
                  ? CustomErrorWidget(
                      message: LocaleKeys.noOrders.tr(),
                    )
                  : Consumer<OrdersProvider>(
                      builder: (context, provider, child) {
                        return provider.filterOrdersCurrentList!.isEmpty
                            ? CustomErrorWidget(
                                message: LocaleKeys.noOrders.tr(),
                              )
                            : OrdersListWidget(
                                list: provider.filterOrdersCurrentList,
                                boxFit: BoxFit.cover,
                                isLoading: provider.loadingPagination,
                                scrollController: scrollControllerCurrent,
                                loadingPagination: provider.loadingPagination,
                                isTripsOrders: true,
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

class PreviousMeshwarWidget extends StatefulWidget {
  const PreviousMeshwarWidget({Key? key}) : super(key: key);

  @override
  State<PreviousMeshwarWidget> createState() => _PreviousMeshwarWidgetState();
}

class _PreviousMeshwarWidgetState extends State<PreviousMeshwarWidget> {
  // late Future<OrdersModel> futurePrevious;
  late Future<OrdersModel> futurePrevious;

  int previousPage = 1;

  late final OrdersProvider provider;

  ScrollController scrollControllerPrevious = ScrollController();

  @override
  void initState() {
    super.initState();

    provider = Provider.of<OrdersProvider>(context, listen: false);

    futurePrevious = provider.getPreviousTrips(
      context: context,
      page: previousPage,
    );

    print("I am _futurePreviousMeshwarrrr:::");

    scrollControllerPrevious.addListener(scrollListenerPrevious);
  }

  getMoreDataPrevious() {
    if (!provider.endPagePrevious) {
      if (provider.loadingPagination == false) {
        previousPage++;
        provider.getPreviousTrips(
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
        future: futurePrevious,
        builder: (context, snapshot) {
          return snapshot.connectionState == ConnectionState.done &&
                  snapshot.hasData
              ? snapshot.data!.result!.orders!.isEmpty
                  ? CustomErrorWidget(
                      message: LocaleKeys.noOrders.tr(),
                    )
                  : Consumer<OrdersProvider>(
                      builder: (context, provider, child) {
                        return provider.filterOrdersPreviousList.isEmpty
                            ? CustomErrorWidget(
                                message: LocaleKeys.noOrders.tr(),
                              )
                            : OrdersListWidget(
                                list: provider.filterOrdersPreviousList,
                                boxFit: BoxFit.cover,
                                isLoading: provider.loadingPagination,
                                scrollController: scrollControllerPrevious,
                                loadingPagination: provider.loadingPagination,
                                isTripsOrders: true,
                              );
                      },
                    )
              : snapshot.connectionState == ConnectionState.waiting
                  ? const CustomLoadingWidget()
                  : const CustomErrorWidget();
        },
      ),
    );
  }
}
