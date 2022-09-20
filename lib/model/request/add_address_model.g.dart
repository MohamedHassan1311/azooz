// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_address_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddAddressModel _$AddAddressModelFromJson(Map<String, dynamic> json) =>
    AddAddressModel(
      lat: (json['lat'] as num?)?.toDouble(),
      lng: (json['lng'] as num?)?.toDouble(),
      details: json['details'] as String?,
      title: json['title'] as String?,
    );

Map<String, dynamic> _$AddAddressModelToJson(AddAddressModel instance) =>
    <String, dynamic>{
      'lat': instance.lat,
      'lng': instance.lng,
      'details': instance.details,
      'title': instance.title,
    };
