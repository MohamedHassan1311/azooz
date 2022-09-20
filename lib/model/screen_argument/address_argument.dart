import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class AddressArgument extends Equatable {
  final int? id;
  final double? lat;
  final double? lng;
  final String? title;
  final String? details;
  final bool? newAddress;
  final bool? fromOrdersDetails;
  final bool fromAdsScreen;
  final bool isAddressSelector;

  const AddressArgument({
    this.id,
    this.lat,
    this.lng,
    this.title,
    this.details,
    required this.newAddress,
    required this.fromOrdersDetails,
    required this.fromAdsScreen,
    this.isAddressSelector = true,
  });

  @override
  List<Object?> get props => [
        lat,
        lng,
        title,
        details,
        fromAdsScreen,
        isAddressSelector,
      ];
}
