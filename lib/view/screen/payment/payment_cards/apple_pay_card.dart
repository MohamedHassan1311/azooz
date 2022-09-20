import 'package:azooz/common/payment_consts.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../common/circular_progress.dart';
import '../../../../common/custom_waiting_dialog.dart';
import '../../../../common/style/dimens.dart';
import '../../../../model/request/payment_checkout_model.dart';
import '../../../../model/response/transaction_id_model.dart';
import '../../../../providers/payment_provider.dart';
import '../../../custom_widget/custom_button.dart';

class ApplePayPayCard extends StatefulWidget {
  const ApplePayPayCard({
    Key? key,
    required this.id,
    required this.amount,
    required this.isRecharge,
  }) : super(key: key);

  final int id;
  final double amount;
  final bool isRecharge;

  @override
  State<ApplePayPayCard> createState() => _ApplePayPayCardState();
}

class _ApplePayPayCardState extends State<ApplePayPayCard> {
  bool isLoading = true;

  final bool _isSelected = true;

  @override
  void initState() {
    super.initState();

    context.read<PaymentProvider>().setStcPayMobileNumber =
        TextEditingController();

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
    return isLoading
        ? const SizedBox(
            height: 200,
            child: CustomProgressIndicator(),
          )
        : AnimatedContainer(
            duration: const Duration(seconds: 2),
            // height: 200,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 255, 255, 255).withOpacity(0.3),
              borderRadius: kBorderRadius10,
            ),
            child: Column(children: [
              CustomButton(
                  height: 45,
                  text: widget.isRecharge
                      ? "إشحن ${widget.amount.toString()}"
                      : "إدفع ${widget.amount.toString()}",
                  onPressed: () async {
                    final mobileVal =
                        context.read<PaymentProvider>().stcPayMobileNumber.text;
                    // if (mobileVal.isEmpty) {
                    //   showDialog(
                    //     context: context,
                    //     builder: (context) => const AlertDialog(
                    //       content: Text("يجب إدخال رقم الجوال"),
                    //     ),
                    //   );
                    // }

                    final orderPaymentType =
                        context.read<PaymentProvider>().orderPaymentType;

                    final PaymentCheckoutModel checkoutRequest =
                        PaymentCheckoutModel(
                      amount: widget.amount,
                      methodType: PaymentMethodsEnum.APPLEPAY.name,
                      // Below is pay from what? Ads / Order / Trip
                      paymentTypeId:
                          context.read<PaymentProvider>().payRechargeId,
                      mobile: context
                          .read<PaymentProvider>()
                          .stcPayMobileNumber
                          .text
                          .trim(),
                      mode: "",
                      orderId: widget.id,
                    );
                    final TransactionIdModel checkoutid = await context
                        .read<PaymentProvider>()
                        .getCheckoutId(checkoutModel: checkoutRequest);

                    final CheckOutRequest payRequest = CheckOutRequest(
                      type: "CustomUI",
                      checkoutid: checkoutid.result!.transactionId,
                      mode: "LIVE",
                      brand: "APPLEPAY",
                      cardNumber: "",
                      holderName: "",
                      month: "",
                      year: "",
                      cvv: "",
                      sTCPAY: "disabled",
                      amount: widget.amount,
                    );

                    if (!mounted) return;
                    customWaitingDialog(context);
                    context
                        .read<PaymentProvider>()
                        .applePayPayment(checkoutRequest, payRequest)
                        .then((value) {
                      if (value == true) {
                        final status =
                            context.read<PaymentProvider>().creditStatusResult;
                        Navigator.of(context).pop();
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text("تأكيد الدفع"),
                                content: Text(status),
                                actions: [
                                  TextButton(
                                    child: const Text("حسنا"),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            });
                      } else {
                        Navigator.of(context).pop();
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text("تأكيد الدفع"),
                                content: const Text("لم يتم الدفع"),
                                actions: [
                                  TextButton(
                                    child: const Text("حسنا"),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            });
                      }
                    });
                  }),
              const SizedBox(height: 20),
            ]),
          );
  }
}
