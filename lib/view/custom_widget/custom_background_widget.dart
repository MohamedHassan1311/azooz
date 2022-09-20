import 'package:flutter/material.dart';

import '../../common/style/colors.dart';

class CustomBackgroundWidget extends StatelessWidget {
  final double? radius;
  final Widget? child;
  final Color? color;
  final double? padding;
  final double? marginTop;
  final double? marginEnd;
  final double? width;
  final double? height;
  final BoxDecoration? decoration;

  const CustomBackgroundWidget({
    Key? key,
    this.radius = 10,
    this.height,
    required this.child,
    this.color = Palette.kAccentGreyCards,
    this.padding = 5,
    this.marginTop = 5,
    this.marginEnd = 5,
    this.width = 100,
    this.decoration,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: 40,
      margin: EdgeInsetsDirectional.only(top: marginTop!, end: marginEnd!),
      padding: EdgeInsets.all(padding!),
      decoration: decoration ??
          BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(radius!),
          ),
      child: child!,
    );
  }
}
