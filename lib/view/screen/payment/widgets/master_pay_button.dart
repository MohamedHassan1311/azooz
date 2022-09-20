import 'package:flutter_svg/svg.dart';

import '../../../../common/config/constants.dart';
import '../../../../common/payment_assets.dart';
import 'package:flutter/material.dart';

import '../../../../common/style/colors.dart';

class MasterPayButton extends StatelessWidget {
  const MasterPayButton({
    Key? key,
    required this.onPressed,
    this.isSelected = false,
  }) : super(key: key);

  final GestureTapCallback? onPressed;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        alignment: Alignment.center,
        height: 55,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Palette.kWhite,
          border: isSelected ? kActiveBorder : kDeactiveBorder,
        ),
        child: Center(
          child: SvgPicture.asset(
            PaymentAssets.masterCard,
            // height: 30,
          ),
        ),
      ),
    );
  }
}
