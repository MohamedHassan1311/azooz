import 'package:flutter/material.dart';

import '../../../../common/config/constants.dart';
import '../../../../common/payment_assets.dart';
import '../../../../common/style/colors.dart';

class ApplePayButton extends StatelessWidget {
  ApplePayButton({
    Key? key,
    required this.title,
    required this.icon,
    required this.onPressed,
    // ignore: unused_element
    this.color = Palette.kWhite,
    this.iconColor = Palette.kTitleColor,
    this.isSelected = false,
  }) : super(key: key);

  final String title;
  final IconData icon;
  final Color color;
  final Color iconColor;
  void Function()? onPressed;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        alignment: Alignment.center,
        height: 55,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: color,
          border: isSelected
              ? kActiveBorder
              : Border.all(
                  color: Colors.black,
                  width: 1.5,
                ),
        ),
        child: Center(
          child: Image.asset(
            PaymentAssets.applePayBrand,
            height: 30,
            // color: Colors.red,
          ),
        ),
      ),
    );
  }
}
