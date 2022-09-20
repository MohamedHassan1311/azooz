// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trip_price_calculate_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TripPriceCalculateModel _$TripPriceCalculateModelFromJson(
        Map<String, dynamic> json) =>
    TripPriceCalculateModel(
      fromLat: (json['fromLat'] as num).toDouble(),
      fromLng: (json['fromLng'] as num).toDouble(),
      toLat: (json['toLat'] as num).toDouble(),
      toLng: (json['toLng'] as num).toDouble(),
    );

Map<String, dynamic> _$TripPriceCalculateModelToJson(
        TripPriceCalculateModel instance) =>
    <String, dynamic>{
      'fromLat': instance.fromLat,
      'fromLng': instance.fromLng,
      'toLat': instance.toLat,
      'toLng': instance.toLng,
    };
