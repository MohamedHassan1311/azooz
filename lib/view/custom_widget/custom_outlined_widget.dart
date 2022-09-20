import '../../common/style/colors.dart';
import 'package:flutter/material.dart';

class CustomOutlinedWidget extends StatelessWidget {
  final Widget? child;
  final double? paddingAll;
  final double? marginVertical;
  final Color? color;

  const CustomOutlinedWidget({
    Key? key,
    required this.child,
    this.paddingAll = 15,
    this.marginVertical = 5,
    this.color = Palette.kAccentGreyCards,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: marginVertical!),
      padding: EdgeInsets.all(paddingAll!),
      decoration: BoxDecoration(
        border: Border.all(
          color: color!,
          width: 1.5,
        ),
        borderRadius: BorderRadius.circular(15),
      ),
      child: child,
    );
  }
}
