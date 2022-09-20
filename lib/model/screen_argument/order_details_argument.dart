import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class OrderConfirmationArgument extends Equatable {
  final String? details;
  final String? coupon;
  final String? storeName;
  final int? storeID;
  final int? orderID;
  final bool? isRefreshPage;

  const OrderConfirmationArgument({
    this.details,
    this.coupon,
    this.storeName,
    this.storeID,
    this.orderID,
    this.isRefreshPage,
  });

  @override
  List<Object?> get props =>
      [details, coupon, storeName, storeID, orderID, isRefreshPage];
}

@immutable
class OrderDetailsArgument extends Equatable {
  final bool? withButton;
  final bool? isOrderDetails;
  final String? details;
  final String? coupon;
  final String? storeName;
  final int? storeID;
  final int? orderID;
  final bool? isRefreshPage;

  const OrderDetailsArgument({
    required this.withButton,
    required this.isOrderDetails,
    this.details,
    this.coupon,
    this.storeName,
    this.storeID,
    this.orderID,
    this.isRefreshPage,
  });

  @override
  List<Object?> get props => [
        withButton,
        details,
        coupon,
        storeName,
        storeID,
        orderID,
        isOrderDetails,
        isRefreshPage
      ];
}

@immutable
class TripDetailsArgument extends Equatable {
  final bool? withButton;
  final bool? isOrderDetails;
  final String? details;
  final String? coupon;
  final String? storeName;
  final int? storeID;
  final int? orderID;

  const TripDetailsArgument({
    required this.withButton,
    required this.isOrderDetails,
    this.details,
    this.coupon,
    this.storeName,
    this.storeID,
    this.orderID,
  });

  @override
  List<Object?> get props => [
        withButton,
        details,
        coupon,
        storeName,
        storeID,
        orderID,
        isOrderDetails
      ];
}
