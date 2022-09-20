import 'dart:developer';
import 'dart:io';

import 'package:azooz/common/payment_consts.dart';
import 'package:azooz/view/screen/payment/pay_with_visa_screen.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../../common/style/colors.dart';
import '../../../../common/style/dimens.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../../../model/request/payment_checkout_model.dart';
import '../../../../model/response/chat_model.dart';
import '../../../../providers/chat_provider.dart';
import '../../../../providers/payment_provider.dart';
import '../../../../utils/util_url_launcher.dart';
import '../../../custom_widget/custom_button.dart';
import '../../../custom_widget/custom_error_widget.dart';
import '../../../custom_widget/custom_loading_widget.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../../custom_widget/marquee_widget.dart';
import '../../../screen/payment/pay_with_apple_screen.dart';
import '../../../screen/payment/pay_with_cash_screen.dart';
import '../../../screen/payment/pay_with_mada_screen.dart';
import '../../../screen/payment/pay_with_master_screen.dart';
import '../../../screen/payment/pay_with_stcpay_screen.dart';
import '../../../screen/payment/pay_with_walett_screen.dart';

class DriverDetailsChatHudWidget extends StatefulWidget {
  final int? orderID;

  const DriverDetailsChatHudWidget({Key? key, required this.orderID})
      : super(key: key);

  @override
  State<DriverDetailsChatHudWidget> createState() =>
      _DriverDetailsChatHudWidgetState();
}

class _DriverDetailsChatHudWidgetState
    extends State<DriverDetailsChatHudWidget> {
  late Future<ChatModel?> futureDriverHud;

  late final PaymentProvider providerPayment;
  bool isFavClicked = false;
  @override
  void initState() {
    super.initState();
    providerPayment = Provider.of<PaymentProvider>(context, listen: false);
    isFavClicked = false;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<PaymentProvider>().setPayRechargeId =
          PayRechargeIds.payTripOrderId;

      print("I am from DriverDetailsChatHudWidget");
      print(
          "I am from DriverDetailsChatHudWidget :: ${context.read<PaymentProvider>().payRechargeId}");
    });
    futureDriverHud = Provider.of<ChatProvider>(context, listen: false)
        .getChat(orderID: widget.orderID, context: context);
  }

  @override
  Widget build(BuildContext context) {
    var tabInd = context.watch<ChatProvider>().tabInd;
    log('tabInd: $tabInd');
    return FutureBuilder<ChatModel?>(
        future: futureDriverHud,
        builder: (context, snapshot) {
          return snapshot.hasData && snapshot.data != null
              ? Consumer<ChatProvider>(builder: (context, provider, widget) {
                  return Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 20,
                      ),
                      decoration: const BoxDecoration(
                        color: Palette.kWhite,
                        borderRadius: BorderRadius.vertical(
                          bottom: Radius.circular(15),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 20,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: MarqueeWidget(
                                  child: Consumer<ChatProvider>(
                                    builder: (context, provider, child) {
                                      return Text(
                                        '${LocaleKeys.speakingTo.tr()} ${provider.chatModel?.result?.chat?.otherUser?.data?.name}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle2,
                                      );
                                    },
                                  ),
                                ),
                              ),
                              Column(
                                children: [
                                  IconButton(
                                    splashRadius: 20,
                                    icon: isFavClicked == true
                                        ? const Icon(
                                            Icons.favorite_rounded,
                                            color: Palette.primaryColor,
                                          )
                                        : const Icon(
                                            Icons.favorite_border,
                                            color: Palette.primaryColor,
                                          ),
                                    onPressed: () {
                                      setState(() {
                                        isFavClicked = true;
                                      });

                                      context.read<ChatProvider>().addFavDriver(
                                          context,
                                          '${provider.chatModel?.result?.chat?.orderId}');
                                      // ///////////////////////////////
                                      // provider.favorite![storeData.id!] == true
                                      //     ? Provider.of<FavoriteProvider>(context,
                                      //             listen: false)
                                      //         .deleteFavorite(
                                      //             storeId: storeData.id, context: context)
                                      //         .then(
                                      //           (value) => provider.changeFavorite(
                                      //               false, storeData.id!),
                                      //         )
                                      //     : Provider.of<FavoriteProvider>(context,
                                      //             listen: false)
                                      //         .addFavorite(
                                      //             id: storeData.id, context: context)
                                      //         .then(
                                      //           (value) => provider.changeFavorite(
                                      //               true, storeData.id!),
                                      //         );
                                    },
                                  ),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.star,
                                        color: Palette.kRating,
                                        size: 15,
                                      ),
                                      sizedBox(width: 3),
                                      Consumer<ChatProvider>(
                                        builder: (context, provider, child) {
                                          return Text(
                                            '${provider.chatModel?.result?.chat?.otherUser?.data?.rate}',
                                            style: Theme.of(context)
                                                .textTheme
                                                .subtitle2,
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                flex: 2,
                                child: Consumer<ChatProvider>(
                                  builder: (context, provider, child) {
                                    return Text(
                                      '${provider.chatModel?.result?.chat?.otherUser?.phone}',
                                      style:
                                          Theme.of(context).textTheme.subtitle2,
                                    );
                                  },
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Consumer<ChatProvider>(
                                  builder: (context, provider, child) {
                                    return CustomButton(
                                      height: 35,
                                      text: LocaleKeys.call.tr(),
                                      color:
                                          Palette.primaryColor.withOpacity(0.3),
                                      textColor:
                                          Theme.of(context).primaryColorDark,
                                      onPressed: () =>
                                          UtilURLLauncher.makePhoneCall(
                                        provider.chatModel!.result!.chat!
                                            .otherUser!.phone!,
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          if (tabInd == 3) ...[
                            CustomButton(
                              width: MediaQuery.of(context).size.width,
                              height: 35,
                              text:
                                  "${LocaleKeys.pay.tr()} مبلغ ${snapshot.data!.result!.chat?.amountToPay}",
                              textColor: Colors.white,
                              onPressed: () {
                                context
                                        .read<PaymentProvider>()
                                        .setPayRechargeId =
                                    PayRechargeIds.payTripOrderId;
                                final data =
                                    context.read<ChatProvider>().chatModel;
                                final orderPaymentTypeId =
                                    data?.result!.chat!.orderpaymentTypeId;

                                final amountToPay =
                                    data?.result!.chat!.amountToPay;
                                print(
                                    '### ##methodType $orderPaymentTypeId ##');
                                print(
                                    "Selected payment type id $orderPaymentTypeId ##");
                                final int? orderId =
                                    data?.result!.chat!.orderId;
                                String methodType = paymentMethodTypes
                                    .where((element) =>
                                        element["id"].toString().trim() ==
                                        orderPaymentTypeId.toString().trim())
                                    .first["name"];
                                PaymentCheckoutModel paymentCheckoutData =
                                    PaymentCheckoutModel(
                                  amount: amountToPay,
                                  paymentTypeId: PayRechargeIds.payTripOrderId,
                                  mode: "",
                                  mobile: "",
                                  methodType: methodType,
                                  orderId: orderId,
                                );
                                payOrderMeshwar(paymentCheckoutData);
                              },
                              color: Palette.kGreen,
                              borderColor: Theme.of(context).primaryColorDark,
                            ),
                          ],
                        ],
                      ),
                    ),
                  );
                })
              : snapshot.hasError
                  ? const CustomErrorWidget()
                  : const CustomLoadingWidget(size: 35);
        });
  }

  void payOrderMeshwar(PaymentCheckoutModel paymentCheckoutModel) async {
    print("## Current Payment method:: ${paymentCheckoutModel.methodType} ##");
    switch (paymentCheckoutModel.methodType!.toUpperCase()) {
      case "VISA":
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PayWithVisaScreen(
              paymentCheckoutModel: paymentCheckoutModel,
            ),
          ),
        );
        break;
      case "MASTER":
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PayWithMasterScreen(
              paymentCheckoutModel: paymentCheckoutModel,
            ),
          ),
        );
        break;

      case "STCPAY":
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PayWithSTCPayScreen(
              paymentCheckoutModel: paymentCheckoutModel,
            ),
          ),
        );
        break;

      case "APPLEPAY":
        if (Platform.isIOS) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PayWithApplePayScreen(
                paymentCheckoutModel: paymentCheckoutModel,
              ),
            ),
          );
        }
        break;

      case "MADA":
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PayWithMadaScreen(
              paymentCheckoutModel: paymentCheckoutModel,
            ),
          ),
        );
        break;
      case "WALLET":
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PayWithWalletScreen(
              paymentCheckoutModel: paymentCheckoutModel,
            ),
          ),
        );
        break;

      case "CASH":
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PayWithCashScreen(
              paymentCheckoutModel: paymentCheckoutModel,
            ),
          ),
        );
    }
  }
}
