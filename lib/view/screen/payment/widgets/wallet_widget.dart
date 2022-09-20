import 'package:azooz/common/style/dimens.dart';
import 'package:flutter/material.dart';

import '../../../../common/config/constants.dart';
import '../../../../common/style/colors.dart';

class WalletPayButton extends StatelessWidget {
  WalletPayButton({
    Key? key,
    required this.title,
    required this.icon,
    required this.onPressed,
    required this.isSelected,
  }) : super(key: key);

  final String title;
  final IconData icon;
  final bool isSelected;
  void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        alignment: Alignment.center,
        height: 55,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        // decoration: BoxDecoration(
        //   borderRadius: BorderRadius.circular(10),
        //   color: Palette.primaryColor,
        // ),
        decoration: BoxDecoration(
          borderRadius: kBorderRadius10,
          color: Palette.kWhite,
          border: isSelected ? kActiveBorder : kDeactiveBorder,
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 24,
                color: Palette.primaryColor,
              ),
              const SizedBox(width: 3),
              Text(
                title,
                style: const TextStyle(
                  color: Palette.primaryColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
