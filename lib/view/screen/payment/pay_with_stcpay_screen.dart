import 'package:azooz/common/circular_progress.dart';
import 'package:azooz/common/style/colors.dart';
import 'package:azooz/common/style/dimens.dart';
import 'package:azooz/generated/locale_keys.g.dart';
import 'package:azooz/model/request/payment_checkout_model.dart';
import 'package:azooz/view/custom_widget/custom_button.dart';
import 'package:azooz/view/screen/payment/payment_cards/stcpay_pay_card.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../../../common/payment_assets.dart';
import '../../../common/payment_consts.dart';
import '../../../providers/payment_provider.dart';
import '../../../model/request/payment_checkout_model.dart';

class PayWithSTCPayScreen extends StatefulWidget {
  const PayWithSTCPayScreen({
    Key? key,
    required this.paymentCheckoutModel,
  }) : super(key: key);

  final PaymentCheckoutModel paymentCheckoutModel;

  @override
  State<PayWithSTCPayScreen> createState() => _PayWithSTCPayScreenState();
}

class _PayWithSTCPayScreenState extends State<PayWithSTCPayScreen> {
  @override
  void initState() {
    super.initState();
    print(
        "I am PayWithSTCPayScreen id:: ${widget.paymentCheckoutModel.paymentTypeId}");
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
        STCPayLogoWidget(
          onSTCPayTap: () => context.read<PaymentProvider>().setPaymentMethod =
              PaymentMethodsEnum.STCPAY,
        ),
        const SizedBox(height: 5.0),
        // const Expanded(
        //   child: STCPayPaymentCardWithButton(),
        // ),

        Expanded(
          child: STCPayPayCard(
            id: paymentCheckoutModel.orderId!,
            amount: paymentCheckoutModel.amount!,
            isRecharge: false,
          ),
        ),
      ],
    );
  }
}

class STCPayPaymentCardWithButton extends StatefulWidget {
  const STCPayPaymentCardWithButton({
    Key? key,
  }) : super(key: key);

  @override
  State<STCPayPaymentCardWithButton> createState() =>
      _STCPayPaymentCardWithButtonState();
}

class _STCPayPaymentCardWithButtonState
    extends State<STCPayPaymentCardWithButton> with TickerProviderStateMixin {
  bool isLoading = true;

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
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
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const SizedBox(
            height: 200,
            child: CustomProgressIndicator(),
          )
        : Column(
            children: [
              const SizedBox(height: 10),
              AnimatedContainer(
                duration: const Duration(seconds: 2),
                height: 40,
                // padding: const EdgeInsets.symmetric(horizontal: 10),
                margin: const EdgeInsets.symmetric(horizontal: 10),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: kBorderRadius10,
                ),
                child: TabBar(
                  indicator: const BoxDecoration(
                    color: Palette.primaryColor,
                    borderRadius: kBorderRadius10,
                  ),

                  controller: _tabController,
                  tabs: [
                    Text(LocaleKeys.phoneNumber.tr()),
                    Text(LocaleKeys.phoneNumber.tr()),
                  ],
                  // child: Padding(
                  //   padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  //   child: Column(children: [
                  //     SmartInputTextField(
                  //       label: "",
                  //       hintText: LocaleKeys.phone.tr(),
                  //       fillColor: Colors.white,
                  //     ),
                  //     // TextFormField(),
                  //   ]),
                  // ),
                ),
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.all(10.0),
                  decoration: const BoxDecoration(
                    borderRadius: kBorderRadius10,
                    color: Color.fromARGB(255, 255, 255, 255),
                  ),
                  child: TabBarView(
                    controller: _tabController,
                    children: const [
                      Text("data1"),
                      Center(child: Text("data2")),
                    ],
                  ),
                ),
              ),
              CustomButton(height: 45, text: "text", onPressed: () {}),
              const SizedBox(height: 10),
            ],
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
        PaymentAssets.stcPay,
        width: 10,
      ),
    );
  }
}

class STCPayLogoWidget extends StatelessWidget {
  void Function() onSTCPayTap;

  STCPayLogoWidget({
    Key? key,
    required this.onSTCPayTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onSTCPayTap,
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
              Color(0xFFe6e9f0),
              Color(0xFFfdfbfb),
            ],
            // begin: Alignment.topCenter,
            // end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: SvgPicture.asset(
            PaymentAssets.stcPay,
            // fit: BoxFit.contain,
            height: 17,
          ),
        ),
      ),
    );
  }
}
