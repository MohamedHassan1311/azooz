import 'package:azooz/common/custom_waiting_dialog.dart';
import 'package:azooz/common/routes/app_router_control.dart';
import 'package:azooz/common/routes/app_router_import.gr.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../common/circular_progress.dart';
import '../../../../common/payment_consts.dart';
import '../../../../common/style/dimens.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../../../model/request/payment_checkout_model.dart';
import '../../../../model/response/transaction_id_model.dart';
import '../../../../providers/payment_provider.dart';
import '../../../../utils/smart_text_inputs.dart';
import '../../../custom_widget/custom_button.dart';

class STCPayPayCard extends StatefulWidget {
  const STCPayPayCard({
    Key? key,
    required this.id,
    required this.amount,
    required this.isRecharge,
  }) : super(key: key);

  final int id;
  final double amount;
  final bool isRecharge;

  @override
  State<STCPayPayCard> createState() => _STCPayPayCardState();
}

class _STCPayPayCardState extends State<STCPayPayCard> {
  bool isLoading = true;
  @override
  void initState() {
    super.initState();

    context.read<PaymentProvider>().setStcPayMobileNumber = TextEditingController();

    Future.delayed(const Duration(milliseconds: 350), () {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    });
  }

  @override
  void dispose() {
    // context.read<PaymentProvider>().stcPayMobileNumber.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return
      isLoading
        ? const SizedBox(
            height: 200,
            child: CustomProgressIndicator(),
          )
        :
    AnimatedContainer(
            duration: const Duration(seconds: 2),
            // height: 200,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 255, 255, 255).withOpacity(0.3),
              borderRadius: kBorderRadius10,
            ),
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(children: [
                SmartInputTextField(
                  label: "",
                  hasLabel: false,
                  controller: context.read<PaymentProvider>().stcPayMobileNumber,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "الرجاء إدخال رقم الجوال";
                    }
                    return null;
                  },
                  textInputType: TextInputType.number,
                  maxLength: 103456547,
                  hintText: LocaleKeys.phone.tr(),
                  fillColor: const Color.fromARGB(255, 235, 235, 235),
                ),
                const SizedBox(height: 20),
                CustomButton(
                    height: 45,
                    text: widget.isRecharge
                        ? "إشحن ${widget.amount.toString()}"
                        : "إدفع ${widget.amount.toString()}",
                    onPressed: () async {
                      final mobileVal = context.read<PaymentProvider>().stcPayMobileNumber.text;
                      if (mobileVal.isEmpty ) {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              content: const Text("يجب إدخال رقم الجوال"),
                              actions: [
                                TextButton(
                                  child: const Text("حسنا"),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      } else {
                        // showDialog(
                        //   context: context,
                        //   builder: (context) => const CustomProgressIndicator(),
                        // );

                        final stcPayMobile = context.read<PaymentProvider>().stcPayMobileNumber.text.trim();
                        final paymentTypeId = context.read<PaymentProvider>().payRechargeId;
                        print("## Payment type id:: $paymentTypeId ##");
                        final PaymentCheckoutModel checkoutRequest = PaymentCheckoutModel(
                          amount: widget.amount,
                          methodType: PaymentMethodsEnum.STCPAY.name,
                          mobile: stcPayMobile,
                          mode: CheckoutMode.mobile.name,
                          orderId: widget.id,
                          paymentTypeId: paymentTypeId,
                        );
                        
                        print("I am check properies:: $checkoutRequest ##");
                        final TransactionIdModel checkoutid = await context.read<PaymentProvider>().getCheckoutId(checkoutModel: checkoutRequest);

                        final CheckOutRequest payRequest = CheckOutRequest(
                          checkoutid: checkoutid.result!.transactionId,
                          brand: PaymentMethodsEnum.STCPAY.name,
                          cardNumber: "",
                          holderName: "",
                          month: "",
                          year: "",
                          cvv: "",
                          sTCPAY: "enabled",
                          amount: widget.amount,
                        );
                        if (!mounted) return;
                        //customWaitingDialog(context);
                        context.read<PaymentProvider>().stcPayPayment(payRequest).then((value) {
                          // final status = context.read<PaymentProvider>().creditStatusResult;
                          Navigator.of(context).pop();

                          creditStatusDialog(context).then(
                            (value) {
                              if (mounted) {
                                routerPushAndPopUntil(
                                  context: context,
                                  route: const HomeRoute(),
                                );
                              }
                            },
                          );
                        });
                      }
                    }),
                const SizedBox(height: 20),
              ]),
            ),
          );
  }
}
