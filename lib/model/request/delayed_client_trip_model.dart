import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'delayed_client_trip_model.g.dart';

@immutable
@JsonSerializable(ignoreUnannotated: false)
class DelayedClientTripModel extends Equatable {
  @JsonKey(name: 'fromlat')
  final double fromLat;
  @JsonKey(name: 'fromlng')
  final double fromLng;
  @JsonKey(name: 'tolng')
  final double toLng;
  @JsonKey(name: 'tolat')
  final double toLat;
  @JsonKey(name: 'fromLocationDetails')
  final String fromLocationDetails;
  @JsonKey(name: 'toLocationDetails')
  final String toLocationDetails;
  @JsonKey(name: 'couponCode')
  final String? couponCode;
  @JsonKey(name: 'orderType')
  final int? orderType;
  @JsonKey(name: 'message')
  final String? message;
  @JsonKey(name: 'isFav')
  final bool? isFav;
  @JsonKey(name: 'driverIds')
  final List<String>? driverIds;

  @JsonKey(name: 'genderId')
  final int? genderId;
  @JsonKey(name: 'delayedTripDateTime')
  final String? delayedTripDateTime;
  @JsonKey(name: 'requestType')
  final int? requestType;

  @JsonKey(name: 'carCategoryId')
  final int? carCategoryId;

  @JsonKey(name: 'paymentTypeId')
  final int? paymentTypeId;

  factory DelayedClientTripModel.fromJson(Map<String, dynamic> json) =>
      _$DelayedClientTripModelFromJson(json);

  const DelayedClientTripModel({
    required this.fromLat,
    required this.fromLng,
    required this.toLng,
    required this.toLat,
    required this.fromLocationDetails,
    required this.toLocationDetails,
    this.couponCode,
    required this.orderType,
    this.message,
    this.isFav,
    this.driverIds,
    required this.genderId,
    required this.delayedTripDateTime,
    required this.carCategoryId,
    required this.requestType,
    required this.paymentTypeId,
  });

  Map<String, dynamic> toJson() => _$DelayedClientTripModelToJson(this);

  @override
  List<Object?> get props => [
        fromLat,
        fromLng,
        toLng,
        toLat,
        toLocationDetails,
        fromLocationDetails,
        couponCode,
        genderId,
        isFav,
         driverIds,
        orderType,
        delayedTripDateTime,
        carCategoryId,
      ];
}

class DelayedTripDetailsModel {
  final int rideNumber;
  final String fromLocationDetails;
  final String toLocationDetails;
  final String delayedTripDateTime;

  DelayedTripDetailsModel({
    required this.rideNumber,
    required this.fromLocationDetails,
    required this.toLocationDetails,
    required this.delayedTripDateTime,
  });
}
