import 'package:azooz/providers/orders_provider.dart';
import 'package:flutter/material.dart';

import '../response/create_order_model.dart';
import '../response/order_details_model.dart';
import '../response/orders_model.dart';
import '../response/payment_value_model.dart';
import '../response/orders_types_model.dart';

mixin OrdersMixin {
  Future<OrdersModel> getCurrentOrders({
    required BuildContext context,
    required int page,
    required bool isTripsOrders,
  });

  // Future<DurationModel> getDuration({
  //   required BuildContext context,
  // });

  Future<OrdersTypesModel> getOrdersTypes({
    required BuildContext context,
  });

  Future<OrdersModel> getPreviousOrders({
    required BuildContext context,
    required int? page,
  });

  Future<OrdersModel> getPreviousTrips({
    required BuildContext context,
    required int? page,
  });

  Future<OrderDetailsModel> getOrderDetails({
    required BuildContext context,
    required int? id,
  });

  Future<PaymentValueModel> getPaymentValue({
    required BuildContext context,
    required int? orderId,
  });

  Future<void> cancelOrder({
    required BuildContext context,
    required int? id,
  });

  Future<void> couponCheck({
    required BuildContext context,
    required String? code,
  });

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
  });

  Future refreshOrders({
    required BuildContext context,
    required int? page,
  });

  dynamic filterCurrentOrders(String queryWord);

  dynamic filterPreviousOrders(String queryWord);

  dynamic changeDuration(String name, int id);

  Future<void> changeSelectedType(String newValue);

  void clearFilteredOrders();

  disposeData();

  Future<CancelOrderAlertModel?> cancelConfirmation({
    required BuildContext context,
  });
}
