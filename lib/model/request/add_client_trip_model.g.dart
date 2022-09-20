// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_client_trip_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClientTripModel _$ClientTripModelFromJson(Map<String, dynamic> json) =>
    ClientTripModel(
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
      carCategoryId: json['carCategoryId'] as int?,
      requestType: json['requestType'] as int?,
      paymentTypeId: json['paymentTypeId'] as int?,
    );

Map<String, dynamic> _$ClientTripModelToJson(ClientTripModel instance) =>
    <String, dynamic>{
      'fromlat': instance.fromLat,
      'fromlng': instance.fromLng,
      'tolng': instance.toLng,
      'tolat': instance.toLat,
      'driverIds': instance.driverIds,
      'isFav': instance.isFav,
      'fromLocationDetails': instance.fromLocationDetails,
      'toLocationDetails': instance.toLocationDetails,
      'couponCode': instance.couponCode,
      'orderType': instance.orderType,
      'message': instance.message,
      'genderId': instance.genderId,
      'carCategoryId': instance.carCategoryId,
      'requestType': instance.requestType,
      'paymentTypeId': instance.paymentTypeId,
    };
