import 'package:flutter/material.dart';

import '../../common/config/tools.dart';
import 'connectivity.dart';

checkConnectivity(BuildContext contextDialog) {
  print('AppState: Init Mobile Modules ..');
  MyConnectivity.instance.initialise();
  MyConnectivity.instance.myStream.listen((onData) {
    print('App: Internet Issue Change: $onData');
    if (MyConnectivity.instance.isIssue(onData)) {
      if (MyConnectivity.instance.isShow == false) {
        logger.w('No Internet Connection');
        MyConnectivity.instance.isShow = true;
      }
    } else {
      if (MyConnectivity.instance.isShow == true) {
        MyConnectivity.instance.isShow = false;
        logger.i('No Internet Connection');
        print('There is Internet Connection');
      }
    }
  });
  print('AppState: Register Modules .. DONE');
}
