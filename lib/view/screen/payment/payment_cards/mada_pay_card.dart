import 'package:azooz/common/payment_consts.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../common/circular_progress.dart';
import '../../../../common/custom_waiting_dialog.dart';
import '../../../../common/payment_assets.dart';
import '../../../../common/routes/app_router_control.dart';
import '../../../../common/routes/app_router_import.gr.dart';
import '../../../../common/style/colors.dart';
import '../../../../common/style/dimens.dart';
import '../../../../model/request/payment_checkout_model.dart';
import '../../../../model/response/transaction_id_model.dart';
import '../../../../providers/payment_provider.dart';
import '../../../custom_widget/custom_button.dart';

class MadaPayCard extends StatefulWidget {
  const MadaPayCard({
    Key? key,
    required this.id,
    required this.amount,
    required this.isRecharge,
  }) : super(key: key);

  @override
  State<MadaPayCard> createState() => MadaPayCardState();

  final int id;
  final double amount;
  final bool isRecharge;
}

class MadaPayCardState extends State<MadaPayCard> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TextEditingController _cardHolderController,
      _cardNumberController,
      _cardYearExpiryController,
      _cardMonthExpiryController,
      _cardCVVController;

  bool isLoading = true;

  disposeAll() {
    _cardHolderController.dispose();
    _cardNumberController.dispose();
    _cardYearExpiryController.dispose();
    _cardMonthExpiryController.dispose();
    _cardCVVController.dispose();
  }

  initAll() {
    _cardHolderController = TextEditingController();
    _cardNumberController = TextEditingController();
    _cardYearExpiryController = TextEditingController();
    _cardMonthExpiryController = TextEditingController();
    _cardCVVController = TextEditingController();
  }

  clearAll() {
    _cardHolderController.clear();
    _cardNumberController.clear();
    _cardYearExpiryController.clear();
    _cardMonthExpiryController.clear();
    _cardCVVController.clear();
  }

  @override
  void initState() {
    super.initState();
    initAll();
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
    clearAll();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var outlineInputBorder = const OutlineInputBorder(
      borderSide: BorderSide(
        color: Palette.kTextInputFieldColor,
      ),
      borderRadius: kBorderRadius10,
    );
    return isLoading
        ? const SizedBox(
            height: 200,
            child: CustomProgressIndicator(),
          )
        : AnimatedContainer(
            duration: const Duration(seconds: 2),
            // height: 200,
            padding: const EdgeInsets.all(10.0),
            decoration: const BoxDecoration(
              color: Palette.kWhite,
              // border: Border.all(
              //   color: const Color.fromARGB(255, 44, 42, 42),
              //   width: 1,
              // ),
              borderRadius: kBorderRadius10,
            ),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(height: 20.0),
                  TextFormField(
                    controller: _cardNumberController,
                    keyboardType: TextInputType.number,
                    maxLength: 16,
                    validator: (value) => value == null || value.isEmpty
                        ? '???????????? ?????????? ?????? ??????????????'
                        : null,
                    decoration: InputDecoration(
                      isDense: true,
                      counterText: "",

                      label: const Text(
                        '?????? ??????????????',
                        style: TextStyle(
                          color: Color.fromARGB(255, 67, 63, 63),
                        ),
                      ),
                      labelStyle: const TextStyle(fontSize: 14),
                      suffixIcon: const _MadaSuffixIcon(),
                      // prefix: IconButton(
                      //   // constraints: const BoxConstraints(
                      //   //   maxWidth: 100,
                      //   //   maxHeight: 100,
                      //   // ),
                      //   onPressed: () {},
                      //   icon: const Icon(
                      //     Icons.camera_alt,
                      //   ),
                      // ),
                      border: outlineInputBorder,
                      enabledBorder: outlineInputBorder,
                      focusedBorder: outlineInputBorder,
                      errorBorder: outlineInputBorder,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _cardYearExpiryController,
                          keyboardType: TextInputType.number,
                          textAlignVertical: TextAlignVertical.center,
                          validator: (value) => value == null || value.isEmpty
                              ? '???????????? ?????????? ?????? ????????????????'
                              : null,
                          decoration: InputDecoration(
                            isDense: true,
                            label: const Text(
                              '?????? ????????????????',
                              style: TextStyle(
                                color: Color.fromARGB(255, 67, 63, 63),
                              ),
                            ),
                            labelStyle: const TextStyle(fontSize: 14),
                            border: outlineInputBorder,
                            enabledBorder: outlineInputBorder,
                            focusedBorder: outlineInputBorder,
                            errorBorder: outlineInputBorder,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: TextFormField(
                          controller: _cardMonthExpiryController,
                          textAlignVertical: TextAlignVertical.center,
                          keyboardType: TextInputType.number,
                          validator: (value) => value == null || value.isEmpty
                              ? '???????????? ?????????? ?????? ????????????????'
                              : null,
                          decoration: InputDecoration(
                            isDense: true,
                            label: const Text(
                              '?????? ????????????????',
                              style: TextStyle(
                                color: Color.fromARGB(255, 67, 63, 63),
                              ),
                            ),
                            labelStyle: const TextStyle(fontSize: 14),
                            border: outlineInputBorder,
                            enabledBorder: outlineInputBorder,
                            focusedBorder: outlineInputBorder,
                            errorBorder: outlineInputBorder,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: TextFormField(
                          controller: _cardCVVController,
                          textAlignVertical: TextAlignVertical.center,
                          keyboardType: TextInputType.number,
                          validator: (value) => value == null || value.isEmpty
                              ? '???????????? ?????????? ?????? ????????????'
                              : null,
                          decoration: InputDecoration(
                            isDense: true,
                            label: const Text(
                              '?????? ??????????????',
                              style: TextStyle(
                                color: Color.fromARGB(255, 67, 63, 63),
                              ),
                            ),
                            labelStyle: const TextStyle(fontSize: 14),
                            border: outlineInputBorder,
                            enabledBorder: outlineInputBorder,
                            focusedBorder: outlineInputBorder,
                            errorBorder: outlineInputBorder,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20.0),
                  TextFormField(
                    controller: _cardHolderController,
                    validator: (value) => value == null || value.isEmpty
                        ? '???????????? ?????????? ?????? ???????? ??????????????'
                        : null,
                    textCapitalization: TextCapitalization.words,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
                      isDense: true,
                      label: const Text(
                        '?????? ???????? ??????????????',
                        style: TextStyle(
                          color: Color.fromARGB(255, 67, 63, 63),
                        ),
                      ),
                      labelStyle: const TextStyle(fontSize: 14),
                      border: outlineInputBorder,
                      enabledBorder: outlineInputBorder,
                      focusedBorder: outlineInputBorder,
                      errorBorder: outlineInputBorder,
                    ),
                  ),
                  const SizedBox(height: 20),
                  CustomButton(
                      height: 45,
                      text: widget.isRecharge
                          ? "???????? ${widget.amount.toString()}"
                          : "???????? ${widget.amount.toString()}",
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          customWaitingDialog(context);
                          final orderPaymentType =
                              context.read<PaymentProvider>().orderPaymentType;

                          final PaymentCheckoutModel checkoutRequest =
                              PaymentCheckoutModel(
                            amount: widget.amount,
                            methodType: PaymentMethodsEnum.MADA.name,
                            // Below is pay from what? Ads / Order / Trip
                            paymentTypeId:
                                context.read<PaymentProvider>().payRechargeId,
                            mobile: "",
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
                            brand: PaymentMethodsEnum.MADA.name,
                            cardNumber: _cardNumberController.text.trim(),
                            holderName: _cardHolderController.text.trim(),
                            month: _cardMonthExpiryController.text.trim(),
                            year: _cardYearExpiryController.text.trim(),
                            cvv: _cardCVVController.text.trim(),
                            sTCPAY: "disabled",
                            amount: widget.amount,
                          );

                          if (!mounted) return;
                          context
                              .read<PaymentProvider>()
                              .payWithMada(checkoutRequest, payRequest)
                              .then(
                            (value) {
                              final status = context
                                  .read<PaymentProvider>()
                                  .creditStatusResult;
                              context.read<PaymentProvider>().clear();
                              clearAll();
                              Navigator.of(context).pop();

                              creditStatusDialog(context).then(
                                (value) => routerPushAndPopUntil(
                                  context: context,
                                  route: const HomeRoute(),
                                ),
                              );
                            },
                          );
                        }
                      }),
                ],
              ),
            ),
          );
  }
}

class _MadaSuffixIcon extends StatelessWidget {
  const _MadaSuffixIcon({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(end: 12.0),
      child: Image.asset(
        PaymentAssets.madaPay,
        width: 20,
      ),
    );
  }
}
