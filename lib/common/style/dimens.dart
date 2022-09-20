import 'package:flutter/material.dart';

const kBorderRadius5 = BorderRadius.all(Radius.circular(5));
const kBorderRadius10 = BorderRadius.all(Radius.circular(10));
const kBorderRadius15 = BorderRadius.all(Radius.circular(15));

EdgeInsetsDirectional edgeInsetsAll(double value) =>
    EdgeInsetsDirectional.all(value);

EdgeInsetsDirectional edgeInsetsOnly({
  double top = 0,
  double bottom = 0,
  double start = 0,
  double end = 0,
}) =>
    EdgeInsetsDirectional.only(
      top: top,
      bottom: bottom,
      start: start,
      end: end,
    );

EdgeInsets edgeInsetsSymmetric({
  double horizontal = 0,
  double vertical = 0,
}) =>
    EdgeInsets.symmetric(
      horizontal: horizontal,
      vertical: vertical,
    );

SizedBox sizedBox({
  double? height,
  double? width,
  Widget? child,
}) =>
    SizedBox(
      height: height,
      width: width,
      child: child,
    );
