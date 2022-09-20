import 'package:azooz/common/circular_progress.dart';
import 'package:azooz/common/round_numbers.dart';
import 'package:azooz/utils/dialogs.dart';
import 'package:azooz/view/custom_widget/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../../../common/custom_waiting_dialog.dart';
import '../../../common/payment_assets.dart';
import '../../../common/payment_consts.dart';
import '../../../common/routes/app_router_control.dart';
import '../../../common/routes/app_router_import.gr.dart';
import '../../../common/style/colors.dart';
import '../../../model/request/payment_checkout_model.dart';
import '../../../model/response/transaction_id_model.dart';
import '../../../providers/payment_provider.dart';

class PayWithMasterScreen extends StatefulWidget {
  const PayWithMasterScreen({
    Key? key,
    required this.paymentCheckoutModel,
  }) : super(key: key);

  final PaymentCheckoutModel paymentCheckoutModel;

  @override
  State<PayWithMasterScreen> createState() => _PayWithMasterScreenState();
}

class _PayWithMasterScreenState extends State<PayWithMasterScreen> {
  @override
  void initState() {
    super.initState();
    print("I am payment id:: ${widget.paymentCheckoutModel.paymentTypeId}");
    print("I am orderId:: ${widget.paymentCheckoutModel.orderId}");
    print("I am amount:: ${widget.paymentCheckoutModel.amount}");
    print("I am methodType:: ${widget.paymentCheckoutModel.methodType}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      resizeToAvoidBottomInset: false,
      // backgroundColor: Palette.secondaryDark,
      appBar: AppBar(
          title: const Text(
        'السداد',
        style: TextStyle(
          color: Colors.black,
        ),
      )),
      body: _ContentWidget(paymentCheckoutModel: widget.paymentCheckoutModel),
    );
  }
}

class _ContentWidget extends StatelessWidget {
  const _ContentWidget({
    Key? key,
    required this.paymentCheckoutModel,
  }) : super(key: key);
  final PaymentCheckoutModel paymentCheckoutModel;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10.0),
        MasterLogoWidget(
          onMasterCardTap: () => context
              .read<PaymentProvider>()
              .setPaymentMethod = PaymentMethodsEnum.MASTER,
        ),
        const SizedBox(height: 5.0),
        Expanded(
          child: _PaymentInfoCardWithPayButton(
            paymentCheckoutModel: paymentCheckoutModel,
          ),
        ),
      ],
    );
  }
}

class _PaymentInfoCardWithPayButton extends StatefulWidget {
  const _PaymentInfoCardWithPayButton({
    Key? key,
    required this.paymentCheckoutModel,
  }) : super(key: key);

  @override
  State<_PaymentInfoCardWithPayButton> createState() =>
      _PaymentInfoCardWithPayButtonState();

  final PaymentCheckoutModel paymentCheckoutModel;
}

class _PaymentInfoCardWithPayButtonState
    extends State<_PaymentInfoCardWithPayButton> {
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
    disposeAll();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const outlineInputBorder = OutlineInputBorder(
      borderSide: BorderSide(
        color: Palette.kTextInputFieldColor,
      ),
    );
    const edgeInsets = EdgeInsets.fromLTRB(10, 7, 10, 7);
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
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color.fromARGB(255, 255, 255, 255),
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        const SizedBox(height: 10.0),
                        TextFormField(
                          controller: _cardNumberController,
                          maxLength: 16,
                          keyboardType: TextInputType.number,
                          validator: (value) => value == null || value.isEmpty
                              ? 'الرجاء إدخال رقم البطاقة'
                              : null,
                          decoration: const InputDecoration(
                            contentPadding: edgeInsets,
                            isDense: true,
                            counterText: "",
                            label: Text(
                              'رقم البطاقة',
                              style: TextStyle(
                                color: Color.fromARGB(255, 67, 63, 63),
                              ),
                            ),
                            labelStyle: TextStyle(fontSize: 14),
                            suffixIcon: _CustomSuffixIcon(),
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
                                validator: (value) =>
                                    value == null || value.isEmpty
                                        ? 'الرجاء إدخال سنة الصلاحية'
                                        : null,
                                decoration: const InputDecoration(
                                  contentPadding: edgeInsets,
                                  isDense: true,
                                  label: Text(
                                    'سنة الإنتهاء',
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 67, 63, 63),
                                    ),
                                  ),
                                  labelStyle: TextStyle(fontSize: 14),
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
                                validator: (value) =>
                                    value == null || value.isEmpty
                                        ? 'الرجاء إدخال شهر الإنتهاء'
                                        : null,
                                decoration: const InputDecoration(
                                  contentPadding: edgeInsets,
                                  isDense: true,
                                  label: Text(
                                    'شهر الإنتهاء',
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 67, 63, 63),
                                    ),
                                  ),
                                  labelStyle: TextStyle(fontSize: 14),
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
                                validator: (value) =>
                                    value == null || value.isEmpty
                                        ? 'الرجاء إدخال رقم التحقق'
                                        : null,
                                decoration: const InputDecoration(
                                  contentPadding: edgeInsets,
                                  isDense: true,
                                  label: Text(
                                    'رمز الحماية',
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 67, 63, 63),
                                    ),
                                  ),
                                  labelStyle: TextStyle(fontSize: 14),
                                  border: outlineInputBorder,
                                  enabledBorder: outlineInputBorder,
                                  focusedBorder: outlineInputBorder,
                                  errorBorder: outlineInputBorder,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          controller: _cardHolderController,
                          textCapitalization: TextCapitalization.words,
                          validator: (value) => value == null || value.isEmpty
                              ? 'الرجاء إدخال إسم حامل البطاقة'
                              : null,
                          decoration: const InputDecoration(
                            contentPadding: edgeInsets,
                            isDense: true,
                            label: Text(
                              'إسم حامل البطاقة',
                              style: TextStyle(
                                color: Color.fromARGB(255, 67, 63, 63),
                              ),
                            ),
                            labelStyle: TextStyle(fontSize: 14),
                            border: outlineInputBorder,
                            enabledBorder: outlineInputBorder,
                            focusedBorder: outlineInputBorder,
                            errorBorder: outlineInputBorder,
                            focusedErrorBorder: outlineInputBorder,
                          ),
                        ),
                        const SizedBox(height: 10.0),
                      ],
                    ),
                  ),
                ),

                // Button
                // const SizedBox(height: 20),
                CustomButton(
                  height: 45,
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      TransactionIdModel checkoutid = await context
                          .read<PaymentProvider>()
                          .getCheckoutId(
                              checkoutModel: widget.paymentCheckoutModel);
                      final CheckOutRequest payRequest = CheckOutRequest(
                        holderName: _cardHolderController.text.trim(),
                        cardNumber: _cardNumberController.text.trim(),
                        month: _cardMonthExpiryController.text.trim(),
                        year: _cardYearExpiryController.text.trim(),
                        cvv: _cardCVVController.text.trim(),
                        brand: widget.paymentCheckoutModel.methodType
                            .toString()
                            .toUpperCase(),
                        checkoutid: checkoutid.result!.transactionId,
                        sTCPAY: "disabled",
                        amount: widget.paymentCheckoutModel.amount,
                      );

                      if (!mounted) return;
                      customWaitingDialog(context);
                      context
                          .read<PaymentProvider>()
                          .payWithMaster(
                              widget.paymentCheckoutModel, payRequest)
                          .then((value) {
                        if (value == true) {
                          dismissDialog(context);
                          clearAll();
                          creditStatusDialog(context).then(
                            (value) => routerPushAndPopUntil(
                              context: context,
                              route: const HomeRoute(),
                            ),
                          );
                        }
                      });
                    }
                  },
                  color: Palette.primaryColor,
                  text:
                      "دفع مبلغ ${widget.paymentCheckoutModel.amount!.toPrecision(3)} ريال",
                ),
              ],
            ),
          );
  }
}

class _CustomSuffixIcon extends StatelessWidget {
  const _CustomSuffixIcon({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(end: 12.0),
      child: SvgPicture.asset(
        PaymentAssets.masterCard,
        width: 10,
      ),
    );
  }
}

class MasterLogoWidget extends StatelessWidget {
  void Function() onMasterCardTap;

  MasterLogoWidget({
    Key? key,
    required this.onMasterCardTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onMasterCardTap,
      child: Container(
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width * 0.96,
        height: MediaQuery.of(context).size.width * 0.20,
        padding: const EdgeInsets.symmetric(horizontal: 40),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          // color: const Color.fromARGB(255, 227, 227, 227),
          gradient: const LinearGradient(
            colors: [
              // Color(0xFFe2ebf0),
              Color(0xFFfdfbfb),
              Color(0xFFebedee),
            ],
            // begin: Alignment.topCenter,
            // end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: SvgPicture.asset(
            PaymentAssets.masterCard,
            // fit: BoxFit.contain,
            height: 40,
          ),
        ),
      ),
    );
  }
}
