import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:json_annotation/json_annotation.dart';

part 'trip_price_calculate_model.g.dart';

@immutable
@JsonSerializable()
class TripPriceCalculateModel extends Equatable {
  @JsonKey(name: 'fromLat')
  final double fromLat;
  @JsonKey(name: 'fromLng')
  final double fromLng;
  @JsonKey(name: 'toLat')
  final double toLat;
  @JsonKey(name: 'toLng')
  final double toLng;

  const TripPriceCalculateModel({
    required this.fromLat,
    required this.fromLng,
    required this.toLat,
    required this.toLng,
  });

  factory TripPriceCalculateModel.fromJson(Map<String, dynamic> json) =>
      _$TripPriceCalculateModelFromJson(json);

  Map<String, dynamic> fromMap() => _$TripPriceCalculateModelToJson(this);

  @override
  List<Object?> get props => [
        fromLat,
        fromLng,
        toLat,
        toLng,
      ];
}
