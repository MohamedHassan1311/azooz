import 'package:azooz/common/circular_progress.dart';
import 'package:azooz/common/round_numbers.dart';
import 'package:azooz/view/custom_widget/custom_button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../common/style/colors.dart';
import '../../../generated/locale_keys.g.dart';
import '../../../model/request/payment_checkout_model.dart';
import '../../../providers/payment_provider.dart';

class PayWithCashScreen extends StatefulWidget {
  const PayWithCashScreen({
    Key? key,
    required this.paymentCheckoutModel,
  }) : super(key: key);

  final PaymentCheckoutModel paymentCheckoutModel;

  @override
  State<PayWithCashScreen> createState() => _PayWithCashScreenState();
}

class _PayWithCashScreenState extends State<PayWithCashScreen> {
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
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 10.0),
        const CashLogoWidget(),
        const Spacer(),
        _PaymentInfoCardWithPayButton(
          paymentCheckoutModel: paymentCheckoutModel,
        ),
        const SizedBox(height: 20.0),
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
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const SizedBox(
            height: 200,
            child: CustomProgressIndicator(),
          )
        : CustomButton(
            height: 45,
            onPressed: () async {
              print(
                  "I will pay with wallet## ${widget.paymentCheckoutModel.paymentTypeId}");
              context
                  .read<PaymentProvider>()
                  .paymentCash(
                    id: widget.paymentCheckoutModel.orderId,
                    context: context,
                  )
                  .then(
                    (value) => Navigator.of(context).pop(),
                  );
            },
            color: Palette.primaryColor,
            text:
                "دفع مبلغ ${widget.paymentCheckoutModel.amount!.toPrecision(3)} ريال",
          );
  }
}

class CashLogoWidget extends StatelessWidget {
  const CashLogoWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: MediaQuery.of(context).size.width * 0.96,
      height: MediaQuery.of(context).size.width * 0.20,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        // color: const Color.fromARGB(255, 227, 227, 227),
        // gradient: const LinearGradient(
        //   colors: [
        //     Color(0xFFc1dfc4),
        //     Color(0xFFcfd9df),
        //   ],
        //   // begin: Alignment.topCenter,
        //   // end: Alignment.bottomCenter,
        // ),
      ),
      child: const Center(
        child: Icon(
          FluentIcons.money_calculator_24_regular,
          size: 150,
        ),
      ),
    );
  }
}
