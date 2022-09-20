import '../../../../common/config/tools.dart';
import '../../../../common/style/colors.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../../../model/response/payments_model.dart';
import '../../../../model/screen_argument/add_payment_ways_argument.dart';
import '../../../../providers/payment_provider.dart';
import '../../../custom_widget/custom_error_widget.dart';
import '../../../custom_widget/custom_loading_widget.dart';
import '../../../screen/drawer/payment/edit_card_data_screen.dart';
import 'payment_item_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class PaymentWaysListWidget extends StatefulWidget {
  const PaymentWaysListWidget({Key? key}) : super(key: key);

  @override
  State<PaymentWaysListWidget> createState() => _PaymentWaysListWidgetState();
}

class _PaymentWaysListWidgetState extends State<PaymentWaysListWidget> {
  late Future<PaymentsModel> future;
  int page = 1;

  late final PaymentProvider provider;

  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    provider = Provider.of<PaymentProvider>(context, listen: false);
    future = provider.getData(page: page, context: context);
    scrollController.addListener(scrollListener);
  }

  getMoreData() {
    if (!provider.endPage) {
      if (provider.loadingPagination == false) {
        page++;
        provider.getData(page: page, context: context);
      }
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            LocaleKeys.paymentDetails.tr(),
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: Palette.kBlue,
            ),
          ),
          Expanded(
            child: Consumer<PaymentProvider>(
              builder: (context, provider, child) {
                List<CardDetails>? data = provider.listPayment!;
                print('### ALL DATA: $data end ###');
                return provider.listPayment!.isEmpty
                    ? CustomErrorWidget(
                        message: LocaleKeys.noPaymentMethods.tr(),
                      )
                    : ListView.builder(
                        shrinkWrap: true,
                        controller: scrollController,
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          if (index == data.length) {
                            return provider.loadingPagination
                                ? const CustomLoadingPaginationWidget()
                                : const SizedBox();
                          }
                          return PaymentItemWidget(
                            title: data[index].fullName,
                            subtitle: data[index].number,
                            onPressedDelete: () async {
                              await provider.deleteData(
                                id: data[index].id,
                                context: context,
                              );
                            },
                            onPressedEdit: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) {
                                  return EditCardDataScreen(
                                    argument: AddPaymentWaysArgument(
                                      isNew: false,
                                      id: data[index].id,
                                      fullName: data[index].fullName,
                                      number: data[index].number,
                                      year: data[index].year,
                                      month: data[index].month,
                                      expiredDate: data[index].expiredDate,
                                    ),
                                  );
                                }),
                              );
                              // return routerPush(
                              //   context: context,
                              //   route: AddPaymentWayRoute(
                              //     argument: AddPaymentWaysArgument(
                              //       isNew: false,
                              //       id: data[index].id,
                              //       fullName: data[index].fullName,
                              //       number: data[index].number,
                              //       year: data[index].year,
                              //       month: data[index].month,
                              //       expiredDate:
                              //           data[index].expiredDate,
                              //     ),
                              //   ),
                              // );
                            },
                          );
                        },
                      );
              },
            ),
          ),
        ],
      ),
    );
  }
}
