// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delayed_trip_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DelayedTripModel _$DelayedTripModelFromJson(Map<String, dynamic> json) =>
    DelayedTripModel(
      fromlat: json['fromlat'] as String?,
      fromlng: json['fromlng'] as String?,
      tolng: json['tolng'] as String?,
      tolat: json['tolat'] as String?,
      price: json['price'] as String?,
      couponCode: json['couponCode'] as String?,
      fromLocationDetails: json['fromLocationDetails'] as String?,
      toLocationDetails: json['toLocationDetails'] as String?,
      durationId: json['durationId'] as String?,
      vehicletypeId: json['vehicletypeId'] as String?,
      tripType: json['tripType'] as String?,
      message: json['message'] as String?,
      genderId: json['genderId'] as String?,
      delayedTripDateTime: json['delayedTripDateTime'] as String?,
    );

Map<String, dynamic> _$DelayedTripModelToJson(DelayedTripModel instance) =>
    <String, dynamic>{
      'fromlat': instance.fromlat,
      'fromlng': instance.fromlng,
      'tolng': instance.tolng,
      'tolat': instance.tolat,
      'price': instance.price,
      'couponCode': instance.couponCode,
      'fromLocationDetails': instance.fromLocationDetails,
      'toLocationDetails': instance.toLocationDetails,
      'durationId': instance.durationId,
      'vehicletypeId': instance.vehicletypeId,
      'tripType': instance.tripType,
      'message': instance.message,
      'genderId': instance.genderId,
      'delayedTripDateTime': instance.delayedTripDateTime,
    };
