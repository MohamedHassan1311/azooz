// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';

// enum RequestTypes {
//   tax,
//   personal,
//   goods,
// }

// class MeshwarTripsProvider extends ChangeNotifier {
//   late int selectedIndex = 0;
//   late RequestTypes _requestType;

//   RequestTypes get requestType => _requestType;

//   set setRequestType(RequestTypes value) {
//     _requestType = value;
//     notifyListeners();
//   }

//   RequestTypes generateTripId() {
//     switch (selectedIndex) {
//       case 1:
//         notifyListeners();
//         return RequestTypes.tax;
//       case 2:
//         notifyListeners();
//         return RequestTypes.personal;
//       case 3:
//         notifyListeners();
//         return RequestTypes.goods;
//       default:
//         notifyListeners();
//         return RequestTypes.tax;
//     }
//   }
// }
