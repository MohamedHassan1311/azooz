import 'package:azooz/view/screen/payment/payment_cards/apple_pay_card.dart';
import 'package:azooz/view/screen/payment/payment_cards/mada_pay_card.dart';
import 'package:azooz/view/screen/payment/widgets/mada_pay_button.dart';
import 'package:flutter/material.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:provider/provider.dart';
import 'dart:io' show Platform;
import '../../../common/payment_consts.dart';
import '../../../common/style/colors.dart';
import '../../../providers/payment_provider.dart';
import 'payment_cards/master_pay_card.dart';
import 'payment_cards/stcpay_pay_card.dart';
import 'payment_cards/visa_pay_card.dart';
import 'widgets/apple_pay_button.dart';
import 'widgets/master_pay_button.dart';
import 'widgets/stc_pay_button.dart';
import 'widgets/visa_pay_button.dart';

class RechargeScreen extends StatefulWidget {
  const RechargeScreen({
    Key? key,
    required this.id,
    required this.amount,
  }) : super(key: key);
  final int id;
  final double amount;

  static const routeName = 'RechargeScreen';

  @override
  State<RechargeScreen> createState() => _RechargeScreenState();
}

class _RechargeScreenState extends State<RechargeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<PaymentProvider>().setPaymentMethod =
          PaymentMethodsEnum.NONE;
    });
    print("I am RechargeScreen id:: ${widget.id}");
    print("I am RechargeScreen amount:: ${widget.amount}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Palette.secondaryDark,
      appBar: AppBar(
        title: const Text(
          'شحن المحفظة',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'إختار طريقة الشحن اللي تناسبك',
              style: Theme.of(context)
                  .textTheme
                  .subtitle1!
                  .copyWith(color: Palette.kTitleColor),
            ),
            const SizedBox(height: 20.0),
            _ContentWidget(
              amount: widget.amount,
              id: widget.id,
            ),
          ],
        ),
      ),
    );
  }
}

class _ContentWidget extends StatelessWidget {
  const _ContentWidget({
    Key? key,
    required this.id,
    required this.amount,
  }) : super(key: key);
  final int id;
  final double amount;

  @override
  Widget build(BuildContext context) {
    var provider = context.watch<PaymentProvider>();
    return Column(
      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            // border: Border.all(
            //   color: const Color.fromARGB(255, 233, 233, 233),
            //   width: 2.0,
            // ),
            boxShadow: const [
              BoxShadow(
                color: Color.fromARGB(255, 224, 224, 224),
                offset: Offset(0, 3),
                blurRadius: 10,
              ),
            ],
            color: const Color.fromARGB(255, 255, 255, 255),
          ),
          child: Column(
            children: [
              if (Platform.isIOS) ...[
                const SizedBox(height: 20.0),
                ApplePayButton(
                  title: "Apple Pay",
                  icon: Icons.apple,
                  isSelected: provider.currentPaymentMethod ==
                          PaymentMethodsEnum.APPLEPAY
                      ? true
                      : false,
                  onPressed: () {
                    context.read<PaymentProvider>().setPaymentMethod =
                        PaymentMethodsEnum.APPLEPAY;
                  },
                ),
                const SizedBox(height: 20.0),
              ],
              STCPayButton(
                title: "STC Pay",
                icon: FluentIcons.payment_20_regular,
                isSelected:
                    provider.currentPaymentMethod == PaymentMethodsEnum.STCPAY
                        ? true
                        : false,
                onPressed: () async {
                  context.read<PaymentProvider>().setPaymentMethod =
                      PaymentMethodsEnum.STCPAY;
                },
              ),
              const SizedBox(height: 20.0),
              Row(
                children: [
                  Expanded(
                    child: VisaPayButton(
                      isSelected: provider.currentPaymentMethod ==
                              PaymentMethodsEnum.VISA
                          ? true
                          : false,
                      onPressed: () {
                        context.read<PaymentProvider>().setPaymentMethod =
                            PaymentMethodsEnum.VISA;
                      },
                    ),
                  ),
                  const SizedBox(width: 12.0),
                  Expanded(
                    child: MasterPayButton(
                      isSelected: provider.currentPaymentMethod ==
                              PaymentMethodsEnum.MASTER
                          ? true
                          : false,
                      onPressed: () {
                        context.read<PaymentProvider>().setPaymentMethod =
                            PaymentMethodsEnum.MASTER;
                      },
                    ),
                  ),
                  const SizedBox(width: 12.0),
                  Expanded(
                    child: MadaPayButton(
                      isSelected: provider.currentPaymentMethod ==
                              PaymentMethodsEnum.MADA
                          ? true
                          : false,
                      onPressed: () {
                        context.read<PaymentProvider>().setPaymentMethod =
                            PaymentMethodsEnum.MADA;
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        const SizedBox(height: 20.0),

        // Payment by visa/master/mada view
        _PaymentSelectorWidget(
          id: id,
          amount: amount,
          isRecharge: true,
        ),
      ],
    );
  }
}

class _PaymentSelectorWidget extends StatelessWidget {
  const _PaymentSelectorWidget({
    Key? key,
    required this.id,
    required this.amount,
    required this.isRecharge,
  }) : super(key: key);

  final int id;
  final double amount;
  final bool isRecharge;

  @override
  Widget build(BuildContext context) {
    print("Selector:: - id $id ##");
    print("Selector:: - amount $amount ##");
    switch (context.watch<PaymentProvider>().currentPaymentMethod) {
      case PaymentMethodsEnum.VISA:
        return VisaPayCard(id: id, amount: amount, isRecharge: isRecharge);
      case PaymentMethodsEnum.APPLEPAY:
        return ApplePayPayCard(id: id, amount: amount, isRecharge: isRecharge);
      case PaymentMethodsEnum.MASTER:
        return MasterPayCard(id: id, amount: amount, isRecharge: isRecharge);
      case PaymentMethodsEnum.MADA:
        return MadaPayCard(id: id, amount: amount, isRecharge: isRecharge);
      case PaymentMethodsEnum.STCPAY:
        return STCPayPayCard(id: id, amount: amount, isRecharge: isRecharge);
      default:
        return const SizedBox();
    }
  }
}
