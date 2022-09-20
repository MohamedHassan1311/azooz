import 'package:azooz/common/circular_progress.dart';
import 'package:azooz/common/round_numbers.dart';
import 'package:azooz/view/custom_widget/custom_button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../common/payment_assets.dart';
import '../../../common/payment_consts.dart';
import '../../../common/style/colors.dart';
import '../../../generated/locale_keys.g.dart';
import '../../../model/request/payment_checkout_model.dart';
import '../../../model/response/transaction_id_model.dart';
import '../../../providers/payment_provider.dart';

class PayWithMadaScreen extends StatefulWidget {
  const PayWithMadaScreen({
    Key? key,
    required this.paymentCheckoutModel,
  }) : super(key: key);

  final PaymentCheckoutModel paymentCheckoutModel;

  @override
  State<PayWithMadaScreen> createState() => _PayWithMadaScreenState();
}

class _PayWithMadaScreenState extends State<PayWithMadaScreen> {
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
          title: Text(
        LocaleKeys.checkout.tr(),
        style: const TextStyle(
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
        MadaLogoWidget(
          onMadaTap: () => context.read<PaymentProvider>().setPaymentMethod =
              PaymentMethodsEnum.MADA,
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
                        const SizedBox(height: 10.0),
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
                      context
                          .read<PaymentProvider>()
                          .payWithMada(widget.paymentCheckoutModel, payRequest)
                          .then((value) {
                        clearAll();
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
      child: Image.asset(
        PaymentAssets.madaPay,
        width: 10,
      ),
    );
  }
}

class MadaLogoWidget extends StatelessWidget {
  void Function() onMadaTap;

  MadaLogoWidget({
    Key? key,
    required this.onMadaTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onMadaTap,
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
              Color(0xFFc1dfc4),
              Color(0xFFcfd9df),
            ],
            // begin: Alignment.topCenter,
            // end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Image.asset(
            PaymentAssets.madaPay,
            // fit: BoxFit.contain,
            height: 17,
          ),
        ),
      ),
    );
  }
}
