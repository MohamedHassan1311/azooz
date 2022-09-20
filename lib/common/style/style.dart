import 'package:flutter/material.dart';

import 'colors.dart';

ButtonStyle activeButton = ButtonStyle(
  elevation: MaterialStateProperty.all(3.0),
  padding: MaterialStateProperty.all(
    const EdgeInsets.symmetric(horizontal: 50),
  ),
  backgroundColor: MaterialStateProperty.all(
    Palette.primaryColor,
  ),
  shape: MaterialStateProperty.all(
    const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(30)),
    ),
  ),
);

ButtonStyle inactiveButton = ButtonStyle(
  elevation: MaterialStateProperty.all(0.0),
  padding: MaterialStateProperty.all(
    const EdgeInsets.symmetric(horizontal: 50),
  ),
  backgroundColor: MaterialStateProperty.all(
    const Color.fromARGB(255, 160, 160, 160),
  ),
  shape: MaterialStateProperty.all(
    const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(30)),
    ),
  ),
);

BoxDecoration cardDecoration(BuildContext context) => BoxDecoration(
      borderRadius: BorderRadius.circular(10.0),
      color: Palette.kLightGreyCards,
      // boxShadow: const [
      //   BoxShadow(
      //     color: kGreyCards,
      //     offset: Offset(0.0, 2),
      //     blurRadius: 4.0,
      //   ),
      // ],
    );

BoxDecoration cardDecoration2(BuildContext context) => BoxDecoration(
      borderRadius: BorderRadius.circular(25.0),
      color: Theme.of(context).primaryColorLight,
      // boxShadow: const [
      //   BoxShadow(
      //     color: kGreyCards,
      //     offset: Offset(0.0, 2),
      //     blurRadius: 4.0,
      //   ),
      // ],
    );

BoxDecoration cardDecoration3(BuildContext context) => BoxDecoration(
      borderRadius: BorderRadius.circular(13.0),
      color: Palette.kLightGreyCards,
      // boxShadow: const [
      //   BoxShadow(
      //     color: kGreyCards,
      //     offset: Offset(0.0, 4),
      //     blurRadius: 4.0,
      //   ),
      // ],
    );

BoxDecoration cardDecoration4(BuildContext context) => BoxDecoration(
      borderRadius: BorderRadius.circular(25.0),
      color: Palette.kAccentBlue2,
      // boxShadow: [
      //   BoxShadow(
      //     color: kPrimary.withOpacity(0.2),
      //     offset: const Offset(0.0, 2),
      //     blurRadius: 2.0,
      //   ),
      // ],
    );

BoxDecoration cardDecoration5({
  required BuildContext context,
  double? radius = 8,
  Color? color = Palette.activeWidgetsColor,
  bool withShadow = true,
}) =>
    BoxDecoration(
      borderRadius: BorderRadius.circular(radius!),
      color: color,
    );

BoxDecoration cardDecoration6({
  required BuildContext context,
  double? radius = 8,
  Color? color = Palette.activeWidgetsColor,
  Color? colorOutline = Palette.activeWidgetsColor,
  bool withShadow = true,
}) =>
    BoxDecoration(
      border: Border.all(
        color: colorOutline!,
        width: 0.8,
      ),
      borderRadius: BorderRadius.circular(radius!),
      color: color,
      // boxShadow: withShadow == true
      //     ? [
      //         BoxShadow(
      //           color: kPrimary.withOpacity(0.2),
      //           offset: const Offset(0, 1.5),
      //           blurRadius: 2.0,
      //         ),
      //       ]
      //     : null,
    );

TextStyle dropDownStyle = const TextStyle(
  color: Colors.black87,
  fontSize: 13,
);

TextStyle headline1 = const TextStyle(
  color: Colors.black87,
  fontSize: 18,
  fontWeight: FontWeight.w900,
);
