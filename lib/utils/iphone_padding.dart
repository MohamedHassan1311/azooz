import 'dart:io';

import 'package:flutter/widgets.dart';


bool isIPhoneX(BuildContext context) {
  if (Platform.isIOS) {
    var size = MediaQuery.of(context).size;
    if (size.height > 812.0 || size.width > 812.0) {
      return true;
    }
  }
  return false;
}