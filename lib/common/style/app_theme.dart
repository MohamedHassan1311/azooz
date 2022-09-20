import 'package:flutter/services.dart';

import 'colors.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

enum AppTheme {
  lightTheme,
  darkTheme,
}

enum AppThemeMode {
  light,
  dark,
}

enum AppLanguage {
  arabic,
  english,
}

const textTheme = TextTheme(
  bodyText1: TextStyle(
    color: Palette.kBlack,
    fontSize: 12,
    fontFamily: 'TheSans',
  ),
  bodyText2: TextStyle(
    color: Palette.kBlack,
    fontSize: 14,
    fontFamily: 'TheSans',
  ),
  subtitle1: TextStyle(
    color: Palette.kBlack,
    fontSize: 12,
    fontFamily: 'TheSans',
  ),
  subtitle2: TextStyle(
    color: Color.fromARGB(255, 59, 59, 59),
    fontSize: 12,
    fontFamily: 'TheSans',
  ),
  headline1: TextStyle(
    color: Palette.kBlack,
    fontSize: 16,
    fontWeight: FontWeight.bold,
    fontFamily: 'TheSans',
  ),
  headline2: TextStyle(
    color: Palette.kBlack,
    fontSize: 14,
    fontWeight: FontWeight.bold,
    fontFamily: 'TheSans',
  ),
  headline3: TextStyle(
    color: Palette.kBlack,
    fontSize: 18,
    fontWeight: FontWeight.bold,
    fontFamily: 'TheSans',
  ),
  headline4: TextStyle(
    color: Palette.kBlack,
    fontSize: 12,
    fontWeight: FontWeight.bold,
    fontFamily: 'TheSans',
  ),
);

class AppThemes extends Equatable {
  static Map<AppTheme, ThemeData> appThemeData = {
    AppTheme.lightTheme: ThemeData(
      visualDensity: VisualDensity.adaptivePlatformDensity,
      scaffoldBackgroundColor: Palette.kWhite,
      primaryColor: Palette.primaryColor,
      backgroundColor: Palette.kWhite,
      errorColor: Palette.kErrorRed,
      hintColor: Palette.kGrey,
      primaryColorDark: Palette.kBlack,
      primaryColorLight: Palette.kWhite,
      dialogBackgroundColor: Palette.kWhite,
      // inputDecorationTheme: const InputDecorationTheme(),
      radioTheme: RadioThemeData(
        fillColor: MaterialStateColor.resolveWith(
          (_) => Palette.kBlack,
        ),
      ),

      dialogTheme: const DialogTheme(
        backgroundColor: Palette.kWhite,
      ),

      fontFamily: "TheSans",

      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
        elevation: MaterialStateProperty.all(0.0),
      )),

      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: Colors.black.withOpacity(0),
      ),
      appBarTheme: const AppBarTheme(
        centerTitle: true,
        iconTheme: IconThemeData(
          color: Palette.kBlack,
        ),
        actionsIconTheme: IconThemeData(
          color: Palette.kBlack,
        ),
        titleTextStyle: TextStyle(
          color: Palette.kBlack,
          fontSize: 18,
          fontFamily: 'TheSans',
        ),
        backgroundColor: Colors.white,
        elevation: 0.3,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Color.fromARGB(0, 255, 255, 255),
          // systemNavigationBarColor: Color.fromARGB(255, 255, 255, 255),
          statusBarIconBrightness: Brightness.dark,
          systemNavigationBarIconBrightness: Brightness.dark,
        ),
      ),
      cardColor: Palette.kWhite,
      splashFactory: InkRipple.splashFactory,
      tabBarTheme: TabBarTheme(
        overlayColor:
            MaterialStateProperty.all(const Color.fromARGB(255, 247, 247, 247)),
        labelColor: const Color.fromARGB(255, 255, 255, 255),
        labelStyle: const TextStyle(
          color: Colors.black54,
          fontFamily: 'TheSans',
        ),
        unselectedLabelStyle: const TextStyle(
          color: Colors.black54,
          fontFamily: 'TheSans',
        ),
        unselectedLabelColor: Colors.black,
        splashFactory: InkRipple.splashFactory,
        indicatorSize: TabBarIndicatorSize.tab,
        indicator: const BoxDecoration(
          color: Palette.primaryColor,
          borderRadius: BorderRadius.all(Radius.circular(50)),
        ),
      ),

      // canvasColor: Colors.transparent,
    ),

    // Still working on it
    AppTheme.darkTheme: ThemeData(
      visualDensity: VisualDensity.adaptivePlatformDensity,
      scaffoldBackgroundColor: Palette.kBlack,
      primaryColor: Palette.primaryColor,
      backgroundColor: Palette.kBlack,
      errorColor: Palette.kErrorRed,
      hintColor: Palette.kGrey,
      primaryColorDark: Palette.kBlack,
      primaryColorLight: Palette.kWhite,
      dialogBackgroundColor: Palette.kBlack,
      fontFamily: "TheSans",
      radioTheme: RadioThemeData(
        fillColor: MaterialStateColor.resolveWith(
          (_) => Palette.kWhite,
        ),
      ),
      dialogTheme: const DialogTheme(
        backgroundColor: Palette.kBlack,
      ),

      // textTheme: GoogleFonts.cairoTextTheme(
      //   const TextTheme(
      //     bodyText1: TextStyle(
      //       color: Palette.kWhite,
      //       fontSize: 12,
      //     ),
      //     bodyText2: TextStyle(
      //       color: Palette.kWhite,
      //       fontSize: 14,
      //     ),
      //     subtitle1: TextStyle(
      //       color: Palette.kWhite,
      //       fontSize: 12,
      //     ),
      //     headline1: TextStyle(
      //       color: Palette.kWhite,
      //       fontSize: 16,
      //       fontWeight: FontWeight.bold,
      //     ),
      //     headline2: TextStyle(
      //       color: Palette.kWhite,
      //       fontSize: 14,
      //       fontWeight: FontWeight.bold,
      //     ),
      //     headline3: TextStyle(
      //       color: Palette.kWhite,
      //       fontSize: 18,
      //       fontWeight: FontWeight.bold,
      //     ),
      //     headline4: TextStyle(
      //       color: Palette.kWhite,
      //       fontSize: 12,
      //       fontWeight: FontWeight.bold,
      //     ),
      //   ),
      // ),

      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: Colors.black.withOpacity(0),
      ),
      appBarTheme: const AppBarTheme(
        iconTheme: IconThemeData(
          color: Palette.kWhite,
        ),
        actionsIconTheme: IconThemeData(
          color: Palette.kWhite,
        ),
      ),
      cardColor: Palette.kBlack,
    )
  };

  @override
  List<Object?> get props => [appThemeData];
}

class NoSplashFactory extends InteractiveInkFeatureFactory {
  const NoSplashFactory();
  @override
  InteractiveInkFeature create(
      {required MaterialInkController controller,
      required RenderBox referenceBox,
      required Offset position,
      required Color color,
      required TextDirection textDirection,
      bool containedInkWell = false,
      RectCallback? rectCallback,
      BorderRadius? borderRadius,
      ShapeBorder? customBorder,
      double? radius,
      VoidCallback? onRemoved}) {
    return NoSplash(
        controller: controller,
        referenceBox: referenceBox,
        color: Colors.green);
  }
}

class NoSplash extends InteractiveInkFeature {
  NoSplash({
    required MaterialInkController controller,
    required RenderBox referenceBox,
    required Color color,
  }) : super(controller: controller, referenceBox: referenceBox, color: color);

  @override
  void paintFeature(Canvas canvas, Matrix4 transform) {}
}
