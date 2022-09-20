import 'dart:collection';
import 'dart:developer';

import 'package:azooz/app.dart';
import 'package:azooz/model/response/orders_types_model.dart';
import 'package:azooz/utils/dialogs.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

import '../common/config/orders_types.dart';
import '../common/config/tools.dart';
import '../common/routes/app_router_control.dart';
import '../common/routes/app_router_import.gr.dart';
import '../model/error_model.dart';
import '../model/mixin/orders_mixin.dart';
import '../model/response/coupon_model.dart';
import '../model/response/create_order_model.dart';
import '../model/response/duration_model.dart';
import '../model/response/order_details_model.dart';
import '../model/response/orders_model.dart';
import '../model/response/payment_value_model.dart';
import '../service/network/api_provider.dart';
import '../service/network/url_constants.dart';
import '../utils/easy_loading_functions.dart';
import '../view/custom_widget/animated_switcher_widget.dart';
import 'package:flutter/material.dart';

import '../view/screen/home/orders_history_screen.dart';
import 'address_provider.dart';

class OrdersProvider extends ChangeNotifier with OrdersMixin {
  final ApiProvider _apiProvider = ApiProvider.internal();
  late ErrorModel _errorModel;
  late OrdersModel _ordersCurrentModel;
  late OrdersModel _ordersPreviousModel;
  late DurationModel _durationModel;
  OrdersTypesModel? _ordersTypes;
  late CreateOrderModel _createOrderModel;
  late PaymentValueModel _paymentValueModel;
  List<Order> _filterOrdersCurrentList = [];
  List<Order> _paginationOrdersCurrentList = [];
  List<Order> _filterOrdersPreviousList = [];
  List<Order> _paginationOrdersPreviousList = [];
  late OrderDetailsModel _orderDetailsModel;
  late CouponModel _couponModel;
  bool? _forceNavigateToMeshwar;
  CancelOrderAlertModel? _cancelOrderAlertModel;

  bool get forceNavigateToMeshwar => _forceNavigateToMeshwar ?? false;
  set setForceToNavigateToMeshwar(bool value) {
    _forceNavigateToMeshwar = value;
    notifyListeners();
  }

  OrderHistoryTypes _currentOrderHistoryType = OrderHistoryTypes.talabat;

  OrderHistoryTypes get getCurrentOrderHistoryType => _currentOrderHistoryType;

  bool _isNewOrdersTrips = true;
  bool _isFinishedOrdersTrips = false;

  bool get isNewOrdersTrips => _isNewOrdersTrips;
  bool get isFinishedOrdersTrips => _isFinishedOrdersTrips;

  set setOrderHistoryType(OrderHistoryTypes value) {
    _currentOrderHistoryType = value;
    notifyListeners();
  }

  set setCurrentOrdersTripsStatus(bool isNewOrdersTrips) {
    if (isNewOrdersTrips) {
      _isNewOrdersTrips = true;
      _isFinishedOrdersTrips = false;
    } else {
      _isNewOrdersTrips = false;
      _isFinishedOrdersTrips = true;
    }
    notifyListeners();
  }

  String durationName = '';
  int durationID = 0;

  double coupon = 0;

  bool loadingPagination = false;
  bool endPagePrevious = false;
  bool endPageCurrent = false;

  // Test orders types
  setOrdersTypes(OrdersTypesModel ordersTypesModel) {
    if (ordersTypesModel.name != null) {
      _ordersTypes = ordersTypesModel;
      notifyListeners();
    }
  }

  OrdersTypesModel get getOrderType =>
      _ordersTypes ??
      OrdersTypesModel(name: 'trip', type: ClientOrdersTypes.trip);

  @override
  void clearFilteredOrders() {
    _paginationOrdersCurrentList.clear();
    _paginationOrdersPreviousList.clear();
    _filterOrdersCurrentList.clear();
    _filterOrdersPreviousList.clear();
  }

  @override
  Future<void> cancelOrder({
    required BuildContext context,
    required int? id,
  }) async {
    circularDialog(context);
    await _apiProvider
        .delete(
          apiRoute: orderCancelURL,
          queryParameters: {
            'Id': id,
          },
          successResponse: (response) {
            dismissDialog(getItContext);
            if (_filterOrdersCurrentList.isNotEmpty) {
              _filterOrdersCurrentList
                  .removeWhere((element) => element.id == id);
            }
            successDialog(getItContext!, 'تم إلغاء الطلب بنجاح');

            getCurrentOrders(
              context: context,
              page: 1,
              isTripsOrders: false,
            );
            notifyListeners();
          },
          errorResponse: (response) {
            _errorModel = ErrorModel.fromJson(response);
            errorDialog(context, _errorModel.message.toString());
            notifyListeners();
          },
          data: null,
        )
        .then((value) => notifyListeners());
  }

  @override
  Future<CreateOrderModel> createOrder({
    required BuildContext context,
    required String? details,
    required int? durationID,
    required int? storeID,
    required List<Map<String, dynamic>> products,
    String? couponCode,
    required String? clientLocationDetails,
    required double? clientLocationLat,
    required double? clientLocationLng,
    required int paymentTypeId,
    String? imagePath,
  }) async {
    // circularDialog(context);
    print("### paymentTypeId:: $paymentTypeId");
    await _apiProvider.post(
      apiRoute: createOrderURL,
      successResponse: (response) {
        _createOrderModel = CreateOrderModel.fromJson(response);

        // dismissLoading().whenComplete(
        //   () => delayMilliseconds(
        //     250,
        //     () => showSuccess(
        //       durationMilliseconds: 850,
        //     ).whenComplete(
        //       () {
        routerPushAndPopUntil(
          context: context,
          route: const OrderSuccessfulRoute(),
        );
        context.read<AddressProvider>().disposeData();
        // },
        //     ),
        //   ),
        // );
        notifyListeners();
      },
      errorResponse: (response) {
        _errorModel = ErrorModel.fromJson(response);
        // dismissLoading().whenComplete(
        //   () => delayMilliseconds(
        //     250,
        //     () => errorDialog(context,  _errorModel.message),
        //   ),
        // );
        notifyListeners();
      },
      data: {
        'details': details,
        'products': products,
        'durationId': durationID,
        'couponCode': couponCode,
        'clientLocation': {
          "lat": clientLocationLat,
          "lng": clientLocationLng,
          "details": clientLocationDetails
        },
        'paymentTypeId': paymentTypeId,
        'storeId': storeID
      },
    );
    notifyListeners();
    return _createOrderModel;
  }

  // @override
  // Future<DurationModel> getDuration({
  //   required BuildContext context,
  // }) async {
  //   await _apiProvider.get(
  //     apiRoute: durationURL,
  //     successResponse: (response) {
  //       print("I am in success ##: $response ##");
  //       _durationModel = DurationModel.fromJson(response);
  //       durationID = _durationModel.result!.durations!.first.id!;
  //       durationName = _durationModel.result!.durations!.first.name!;
  //       notifyListeners();
  //     },
  //     errorResponse: (response) {
  //       print("I am in error ##: $response ##");
  //       _errorModel = ErrorModel.fromJson(response);
  //       errorDialog(context,  _errorModel.message);

  //       notifyListeners();
  //     },
  //   );
  //   notifyListeners();

  //   return _durationModel;
  // }

  @override
  Future<OrdersTypesModel> getOrdersTypes(
      {required BuildContext context}) async {
    circularDialog(context);
    await _apiProvider.get(
      apiRoute: ordersTypesURL,
      successResponse: (response) {
        _ordersTypes = OrdersTypesModel.fromJson(response);

        dismissLoading();
        notifyListeners();
      },
      errorResponse: (response) {
        _errorModel = ErrorModel.fromJson(response);
        dismissLoading();
        errorDialog(context, _errorModel.message);
        notifyListeners();
      },
    );
    return _ordersTypes!;
  }

  @override
  Future<PaymentValueModel> getPaymentValue({
    required BuildContext context,
    required int? orderId,
  }) async {
    circularDialog(context);
    await _apiProvider.get(
      apiRoute: paymentValueURL,
      queryParameters: {
        'OrderId': orderId,
      },
      successResponse: (response) {
        _paymentValueModel = PaymentValueModel.fromJson(response);
        dismissLoading();
        notifyListeners();
      },
      errorResponse: (response) {
        _errorModel = ErrorModel.fromJson(response);
        dismissLoading().whenComplete(
          () => errorDialog(context, _errorModel.message),
        );
        notifyListeners();
      },
    );
    notifyListeners();

    return _paymentValueModel;
  }

  @override
  Future<void> couponCheck({
    required BuildContext context,
    required String? code,
  }) async {
    circularDialog(context);
    Map body = {
      'code': code,
    };
    await _apiProvider.post(
      apiRoute: couponCheckURL,
      successResponse: (response) {
        _couponModel = CouponModel.fromJson(response);
        dismissDialog(context);
        successDialogWithTimer(context);
        // dismissLoading().whenComplete(
        //   () => delayMilliseconds(
        //     250,
        //     () => showSuccess(
        //       durationMilliseconds: 850,
        //     ),
        //   ),
        // );
        coupon = _couponModel.result!.value!;
        notifyListeners();
      },
      errorResponse: (response) {
        _errorModel = ErrorModel.fromJson(response);
        errorDialog(context, _errorModel.message);
        notifyListeners();
      },
      data: body,
    );
    notifyListeners();
  }

  @override
  Future<OrdersModel> getCurrentOrders({
    required BuildContext context,
    required int page,
    required bool isTripsOrders,
  }) async {
    if (page != 1) {
      loadingPagination = true;
      // notifyListeners();
    }
    await _apiProvider.get(
      apiRoute: isTripsOrders ? activeClientTripsURL : ordersCurrentURL,
      queryParameters: {
        'Page': page,
      },
      successResponse: (response) {
        _ordersCurrentModel = OrdersModel.fromJson(response);

        if (_ordersCurrentModel.result!.orders != null &&
            _ordersCurrentModel.result!.orders!.isNotEmpty) {
          _filterOrdersCurrentList = [];
          _paginationOrdersCurrentList = [];
          log('notifyListeners');
          _filterOrdersCurrentList.addAll(
            LinkedHashSet<Order>.from(_ordersCurrentModel.result!.orders!)
                .toList(),
          );
          _paginationOrdersCurrentList.addAll(
            LinkedHashSet<Order>.from(_ordersCurrentModel.result!.orders!)
                .toList(),
          );

          _filterOrdersCurrentList =
              Tools.removeDuplicates(_filterOrdersCurrentList);
          _paginationOrdersCurrentList =
              Tools.removeDuplicates(_paginationOrdersCurrentList);
        } else {
          endPageCurrent = true;
          // notifyListeners();
        }
        loadingPagination = false;
        // notifyListeners();
      },
      errorResponse: (response) {
        _errorModel = ErrorModel.fromJson(response);
        if (_errorModel.code != 102) {
          errorDialog(context, _errorModel.message);
        }
        loadingPagination = false;
      },
    );
    notifyListeners();
    return _ordersCurrentModel;
  }

  @override
  Future<OrdersModel> getPreviousOrders({
    required BuildContext context,
    required int? page,
  }) async {
    if (page != 1) {
      loadingPagination = true;
      notifyListeners();
    }

    await _apiProvider.get(
      apiRoute: ordersPreviousURL,
      queryParameters: {
        'Page': page,
      },
      successResponse: (response) {
        _ordersPreviousModel = OrdersModel.fromJson(response);
        if (_ordersPreviousModel.result!.orders!.isNotEmpty) {
          _filterOrdersPreviousList.addAll(
            LinkedHashSet<Order>.from(_ordersPreviousModel.result!.orders!)
                .toList(),
          );
          _paginationOrdersPreviousList.addAll(
            LinkedHashSet<Order>.from(_ordersPreviousModel.result!.orders!)
                .toList(),
          );

          final Map<String, Order> filterPreviousMap = {};
          for (var item in _filterOrdersPreviousList) {
            filterPreviousMap[item.id.toString()] = item;
          }

          final Map<String, Order> paginationOrdersPreviousMap = {};
          for (var item in _paginationOrdersPreviousList) {
            paginationOrdersPreviousMap[item.id.toString()] = item;
          }

          _filterOrdersPreviousList = filterPreviousMap.values.toSet().toList();

          _paginationOrdersPreviousList =
              paginationOrdersPreviousMap.values.toSet().toList();

          _filterOrdersPreviousList =
              Tools.removeDuplicates(_filterOrdersPreviousList);
          _paginationOrdersPreviousList =
              Tools.removeDuplicates(_filterOrdersPreviousList);
        } else {
          endPagePrevious == true;
          notifyListeners();
        }

        loadingPagination = false;
        notifyListeners();
      },
      errorResponse: (response) {
        _errorModel = ErrorModel.fromJson(response);
        loadingPagination = false;
        errorDialog(context, _errorModel.message);
      },
    );

    notifyListeners();
    return _ordersPreviousModel;
  }

  @override
  Future<OrdersModel> getPreviousTrips({
    required BuildContext context,
    required int? page,
  }) async {
    if (page != 1) {
      loadingPagination = true;
      notifyListeners();
    }

    await _apiProvider.get(
      apiRoute: finishClientTripsURL,
      queryParameters: {
        'Page': page,
      },
      successResponse: (response) {
        _ordersPreviousModel = OrdersModel.fromJson(response);
        if (_ordersPreviousModel.result!.orders!.isNotEmpty) {
          _filterOrdersPreviousList.addAll(
            LinkedHashSet<Order>.from(_ordersPreviousModel.result!.orders!)
                .toList(),
          );
          _paginationOrdersPreviousList.addAll(
            LinkedHashSet<Order>.from(_ordersPreviousModel.result!.orders!)
                .toList(),
          );

          final Map<String, Order> filterPreviousMap = {};
          for (var item in _filterOrdersPreviousList) {
            filterPreviousMap[item.id.toString()] = item;
          }

          final Map<String, Order> paginationOrdersPreviousMap = {};
          for (var item in _paginationOrdersPreviousList) {
            paginationOrdersPreviousMap[item.id.toString()] = item;
          }

          _filterOrdersPreviousList = filterPreviousMap.values.toSet().toList();

          _paginationOrdersPreviousList =
              paginationOrdersPreviousMap.values.toSet().toList();

          _filterOrdersPreviousList =
              Tools.removeDuplicates(_filterOrdersPreviousList);
          _paginationOrdersPreviousList =
              Tools.removeDuplicates(_filterOrdersPreviousList);
        } else {
          endPagePrevious == true;
          notifyListeners();
        }

        loadingPagination = false;
        notifyListeners();
      },
      errorResponse: (response) {
        _errorModel = ErrorModel.fromJson(response);
        loadingPagination = false;
        errorDialog(context, _errorModel.message);
      },
    );

    notifyListeners();
    return _ordersPreviousModel;
  }

  @override
  Future<OrderDetailsModel> getOrderDetails({
    required BuildContext context,
    required int? id,
  }) async {
    await _apiProvider.get(
      apiRoute: orderDetailsURL,
      queryParameters: {
        'Id': id,
      },
      successResponse: (response) {
        print("I am reppppppo:: $response");
        _orderDetailsModel = OrderDetailsModel.fromJson(response);
      },
      errorResponse: (response) {
        _errorModel = ErrorModel.fromJson(response);
        errorDialog(context, _errorModel.message);
      },
    );
    notifyListeners();
    return _orderDetailsModel;
  }

  @override
  List<Order>? filterCurrentOrders(String queryWord) {
    if (_currentOrderHistoryType == OrderHistoryTypes.talabat &&
        isNewOrdersTrips) {
      Iterable<Order> result = [];
      print('@@@ $queryWord - $_paginationOrdersCurrentList');
      if (queryWord.trim().isNotEmpty) {
        result = _paginationOrdersCurrentList.where(
          (element) {
            if (element.storeName == null) {
              print("#####': ${element.id}");
            }
            return element.storeName!
                    .toLowerCase()
                    .contains(queryWord.toLowerCase().trim()) ||
                element.createdAt!
                    .toLowerCase()
                    .contains(queryWord.toLowerCase().trim()) ||
                element.details.toString().contains(queryWord.trim()) ||
                element.id.toString().contains(queryWord.trim());
          },
        );
        print('Result Filter: $result');

        final Logger loggesr = Logger(printer: PrettyPrinter(lineLength: 500));
        loggesr.d("##### looong list: $_paginationOrdersCurrentList #####");
        notifyListeners();
      } else {
        result = _paginationOrdersCurrentList;
        notifyListeners();
      }
      _filterOrdersCurrentList = result.toSet().toList();
      _filterOrdersCurrentList.sort(
        (a, b) => b.id!.compareTo(a.id!),
      );
      final Map<String, Order> map = {};
      for (var item in _filterOrdersCurrentList) {
        map[item.id.toString()] = item;
      }
      _filterOrdersCurrentList = map.values.toList();
      notifyListeners();

      return _filterOrdersCurrentList;
    } else if (_currentOrderHistoryType == OrderHistoryTypes.meshwar &&
        isNewOrdersTrips) {
      Iterable<Order> result = [];
      print('@@@ $queryWord - $_paginationOrdersCurrentList');
      if (queryWord.trim().isNotEmpty) {
        result = _paginationOrdersCurrentList.where(
          (element) {
            return element.createdAt!
                    .toLowerCase()
                    .contains(queryWord.toLowerCase().trim()) ||
                element.details.toString().contains(queryWord.trim()) ||
                element.id.toString().contains(queryWord.trim()) ||
                element.createdAt!
                    .toLowerCase()
                    .contains(queryWord.toLowerCase().trim());
          },
        );
        print('Result Filter: $result');

        final Logger loggesr = Logger(printer: PrettyPrinter(lineLength: 500));
        loggesr.d("##### looong list: $_paginationOrdersCurrentList #####");
        notifyListeners();
      } else {
        result = _paginationOrdersCurrentList;
        notifyListeners();
      }
      _filterOrdersCurrentList = result.toSet().toList();
      _filterOrdersCurrentList.sort(
        (a, b) => b.id!.compareTo(a.id!),
      );
      final Map<String, Order> map = {};
      for (var item in _filterOrdersCurrentList) {
        map[item.id.toString()] = item;
      }
      _filterOrdersCurrentList = map.values.toList();
      notifyListeners();

      return _filterOrdersCurrentList;
    }
    return null;
  }

  @override
  List<Order>? filterPreviousOrders(String queryWord) {
    if (_currentOrderHistoryType == OrderHistoryTypes.talabat &&
        isFinishedOrdersTrips) {
      Iterable<Order> result = [];
      print('@@@ $queryWord - $_paginationOrdersPreviousList');
      if (queryWord.trim().isNotEmpty) {
        result = _paginationOrdersPreviousList.where(
          (element) {
            return element.storeName!
                    .toLowerCase()
                    .contains(queryWord.toLowerCase().trim()) ||
                element.createdAt!
                    .toLowerCase()
                    .contains(queryWord.toLowerCase().trim()) ||
                element.details.toString().contains(queryWord.trim()) ||
                element.id.toString().contains(queryWord.trim());
          },
        );
        print('Result Filter: $result');

        final Logger loggesr = Logger(printer: PrettyPrinter(lineLength: 500));
        loggesr.d("##### looong list: $_paginationOrdersPreviousList #####");
        notifyListeners();
      } else {
        result = _paginationOrdersPreviousList;
        notifyListeners();
      }
      _filterOrdersPreviousList = result.toSet().toList();
      _filterOrdersPreviousList.sort(
        (a, b) => b.id!.compareTo(a.id!),
      );
      final Map<String, Order> map = {};
      for (var item in _filterOrdersPreviousList) {
        map[item.id.toString()] = item;
      }
      _filterOrdersPreviousList = map.values.toList();
      notifyListeners();

      return _filterOrdersPreviousList;
    } else if (_currentOrderHistoryType == OrderHistoryTypes.meshwar &&
        isFinishedOrdersTrips) {
      Iterable<Order> result = [];
      print('@@@ $queryWord - $_paginationOrdersPreviousList');
      if (queryWord.trim().isNotEmpty) {
        result = _paginationOrdersPreviousList.where(
          (element) {
            return element.createdAt!
                    .toLowerCase()
                    .contains(queryWord.toLowerCase().trim()) ||
                element.details.toString().contains(queryWord.trim()) ||
                element.id.toString().contains(queryWord.trim());
          },
        );
        print('Result Filter: $result');

        final Logger loggesr = Logger(printer: PrettyPrinter(lineLength: 500));
        loggesr.d("##### looong list: $_paginationOrdersPreviousList #####");
        notifyListeners();
      } else {
        result = _paginationOrdersPreviousList;
        notifyListeners();
      }
      _filterOrdersPreviousList = result.toSet().toList();
      _filterOrdersPreviousList.sort(
        (a, b) => b.id!.compareTo(a.id!),
      );
      final Map<String, Order> map = {};
      for (var item in _filterOrdersPreviousList) {
        map[item.id.toString()] = item;
      }
      _filterOrdersPreviousList = map.values.toList();
      notifyListeners();

      return _filterOrdersPreviousList;
    }
    return null;
    // Iterable<Order> result = [];
    // if (queryWord.trim().isNotEmpty) {
    //   result = _paginationOrdersPreviousList!.where(
    //     (element) {
    //       return element.storeName!
    //               .toLowerCase()
    //               .contains(queryWord.toLowerCase().trim()) ||
    //           element.createdAt!
    //               .toLowerCase()
    //               .contains(queryWord.toLowerCase().trim()) ||
    //           element.details.toString().contains(queryWord.trim()) ||
    //           element.id.toString().contains(queryWord.trim());
    //     },
    //   );
    //   result.toList().sort(
    //         (a, b) => b.id!.compareTo(a.id!),
    //       );
    //   notifyListeners();
    // } else {
    //   result = _paginationOrdersPreviousList!;
    //   notifyListeners();
    // }

    // final Map<String, Order> map = {};
    // for (var item in _filterOrdersPreviousList!) {
    //   map[item.id.toString()] = item;
    // }
    // _filterOrdersPreviousList = map.values.toList();

    // notifyListeners();

    // return _filterOrdersPreviousList;
  }

  @override
  Future<void> changeSelectedType(String newValue) async {
    selectedType = newValue;
    notifyListeners();
  }

  @override
  changeDuration(String name, int id) {
    durationName = name;
    durationID = id;
    notifyListeners();
  }

  @override
  disposeData() {
    loadingPagination = false;
    endPagePrevious = false;
    endPageCurrent = false;
    _filterOrdersCurrentList.clear();
    _filterOrdersPreviousList.clear();
  }

  OrdersModel get ordersCurrentModel => _ordersCurrentModel;

  OrdersModel get ordersPreviousModel => _ordersPreviousModel;

  OrderDetailsModel get orderDetailsModel => _orderDetailsModel;

  List<Order> get filterOrdersPreviousList => _filterOrdersPreviousList;

  List<Order>? get filterOrdersCurrentList => _filterOrdersCurrentList;

  DurationModel get durationModel => _durationModel;

  CreateOrderModel? get createOrderModel => _createOrderModel;

  PaymentValueModel get paymentValueModel => _paymentValueModel;

  @override
  Future refreshOrders(
      {required BuildContext context, required int? page}) async {
    _ordersCurrentModel = OrdersModel();
    _filterOrdersCurrentList = [];
    _paginationOrdersCurrentList = [];
    Future.delayed(const Duration(milliseconds: 300), () {
      getCurrentOrders(context: context, page: 1, isTripsOrders: false);
    });
  }

  @override
  Future<CancelOrderAlertModel?> cancelConfirmation(
      {required BuildContext context}) async {
    await _apiProvider.post(
      apiRoute: cancelOrderConfirmURL,
      data: {},
      successResponse: (response) {
        CancelOrderAlertModel alertModel =
            CancelOrderAlertModel.fromJson(response);
        _cancelOrderAlertModel = alertModel;
        Navigator.pop(context);
        notifyListeners();
        print("Alert message:: ${alertModel.message}");
      },
      errorResponse: (errorResponse) {
        print('errorResponse: $errorResponse');
        errorDialog(context, errorResponse.message);
      },
    );
    notifyListeners();
    return _cancelOrderAlertModel;
  }
}

class CancelOrderAlertModel {
  String? message;

  CancelOrderAlertModel({this.message});

  CancelOrderAlertModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    return data;
  }
}
