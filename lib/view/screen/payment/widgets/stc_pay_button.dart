import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../common/config/constants.dart';
import '../../../../common/payment_assets.dart';
import '../../../../common/style/colors.dart';

class STCPayButton extends StatelessWidget {
  STCPayButton({
    Key? key,
    required this.title,
    required this.icon,
    required this.onPressed,
    this.isSelected = false,
  }) : super(key: key);

  final String title;
  final IconData icon;
  void Function()? onPressed;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        alignment: Alignment.center,
        height: 55,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Palette.kWhite,
          border: isSelected ? kActiveBorder : kDeactiveBorder,
        ),
        child: Center(
          child: SvgPicture.asset(
            PaymentAssets.stcPay,
            height: 24,
            width: 24,
          ),
        ),
      ),
    );
  }
}
