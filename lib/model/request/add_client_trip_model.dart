import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'add_client_trip_model.g.dart';

@immutable
@JsonSerializable(ignoreUnannotated: false)
class ClientTripModel extends Equatable {
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
  @JsonKey(name: 'carCategoryId')
  final int? carCategoryId;
  @JsonKey(name: 'requestType')
  final int? requestType;
  @JsonKey(name: 'paymentTypeId')
  final int? paymentTypeId;

  factory ClientTripModel.fromJson(Map<String, dynamic> json) =>
      _$ClientTripModelFromJson(json);

  const ClientTripModel({
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
    required this.carCategoryId,
    required this.requestType,
    required this.paymentTypeId,
  });

  Map<String, dynamic> toJson() => _$ClientTripModelToJson(this);

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
        driverIds,
        isFav,
        orderType,
        carCategoryId,
        paymentTypeId,
      ];
}
