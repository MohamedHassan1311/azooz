import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class OrderConfirmArgument extends Equatable {
  final String? storeName;
  final int? orderID;
  final bool? isFromNotification;

  const OrderConfirmArgument({
    this.storeName,
    this.orderID,
    this.isFromNotification = true,
  });

  @override
  List<Object?> get props => [storeName, orderID, isFromNotification];
}
