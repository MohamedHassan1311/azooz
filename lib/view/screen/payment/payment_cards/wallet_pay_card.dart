import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../common/circular_progress.dart';
import '../../../../common/style/colors.dart';
import '../../../../common/style/dimens.dart';
import '../../../../providers/payment_provider.dart';
import '../../../custom_widget/custom_button.dart';

class WalletPayCard extends StatefulWidget {
  const WalletPayCard({
    Key? key,
    required this.id,
  }) : super(key: key);

  final int id;
  @override
  State<WalletPayCard> createState() => WalletPayCardState();
}

class WalletPayCardState extends State<WalletPayCard> {
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
  Widget build(BuildContext context) {
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
            child: Column(
              children: [
                CustomButton(
                    height: 45,
                    text: "أدفع الأن",
                    onPressed: () async {
                      context.read<PaymentProvider>().paymentWallet(
                            id: widget.id,
                            paymentTypeId:
                                context.read<PaymentProvider>().payRechargeId,
                            context: context,
                          );
                    }),
              ],
            ),
          );
  }
}
