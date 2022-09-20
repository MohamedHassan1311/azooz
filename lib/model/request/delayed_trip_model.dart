import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:flutter/foundation.dart' show immutable;
part 'delayed_trip_model.g.dart';

@immutable
@JsonSerializable()
class DelayedTripModel extends Equatable {
  const DelayedTripModel({
    required this.fromlat,
    required this.fromlng,
    required this.tolng,
    required this.tolat,
    required this.price,
    this.couponCode,
    required this.fromLocationDetails,
    required this.toLocationDetails,
    required this.durationId,
    required this.vehicletypeId,
    required this.tripType,
    this.message,
    required this.genderId,
    required this.delayedTripDateTime,
  });

  @JsonKey(name: 'fromlat')
  final String? fromlat;
  @JsonKey(name: 'fromlng')
  final String? fromlng;
  @JsonKey(name: 'tolng')
  final String? tolng;
  @JsonKey(name: 'tolat')
  final String? tolat;
  @JsonKey(name: 'price')
  final String? price;
  @JsonKey(name: 'couponCode')
  final String? couponCode;
  @JsonKey(name: 'fromLocationDetails')
  final String? fromLocationDetails;
  @JsonKey(name: 'toLocationDetails')
  final String? toLocationDetails;
  @JsonKey(name: 'durationId')
  final String? durationId;
  @JsonKey(name: 'vehicletypeId')
  final String? vehicletypeId;
  @JsonKey(name: 'tripType')
  final String? tripType;
  @JsonKey(name: 'message')
  final String? message;
  @JsonKey(name: 'genderId')
  final String? genderId;
  @JsonKey(name: 'delayedTripDateTime')
  final String? delayedTripDateTime;

  factory DelayedTripModel.fromJson(Map<String, dynamic> json) =>
      _$DelayedTripModelFromJson(json);
  Map<String, dynamic> toJson() => _$DelayedTripModelToJson(this);

  @override
  List<Object?> get props => [
        fromlat,
        fromlng,
        tolng,
        tolat,
        price,
        couponCode,
        fromLocationDetails,
        toLocationDetails,
        durationId,
        vehicletypeId,
        tripType,
        message,
        genderId,
        delayedTripDateTime,
      ];
}
