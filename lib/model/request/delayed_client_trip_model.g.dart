// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delayed_client_trip_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DelayedClientTripModel _$DelayedClientTripModelFromJson(
        Map<String, dynamic> json) =>
    DelayedClientTripModel(
      fromLat: (json['fromlat'] as num).toDouble(),
      fromLng: (json['fromlng'] as num).toDouble(),
      toLng: (json['tolng'] as num).toDouble(),
      toLat: (json['tolat'] as num).toDouble(),
      fromLocationDetails: json['fromLocationDetails'] as String,
      toLocationDetails: json['toLocationDetails'] as String,
      couponCode: json['couponCode'] as String?,
      orderType: json['orderType'] as int?,
      message: json['message'] as String?,
      genderId: json['genderId'] as int?,
      delayedTripDateTime: json['delayedTripDateTime'] as String?,
      carCategoryId: json['carCategoryId'] as int?,
      requestType: json['requestType'] as int?,
      paymentTypeId: json['paymentTypeId'] as int?,
    );

Map<String, dynamic> _$DelayedClientTripModelToJson(
        DelayedClientTripModel instance) =>
    <String, dynamic>{
      'fromlat': instance.fromLat,
      'fromlng': instance.fromLng,
      'tolng': instance.toLng,
      'tolat': instance.toLat,
      'fromLocationDetails': instance.fromLocationDetails,
      'toLocationDetails': instance.toLocationDetails,
      'couponCode': instance.couponCode,
      'orderType': instance.orderType,
      'message': instance.message,
      'genderId': instance.genderId,
      'delayedTripDateTime': instance.delayedTripDateTime,
      'requestType': instance.requestType,
      'carCategoryId': instance.carCategoryId,
      'paymentTypeId': instance.paymentTypeId,
    };
