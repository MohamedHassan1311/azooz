// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'edit_address_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EditAddressModel _$EditAddressModelFromJson(Map<String, dynamic> json) =>
    EditAddressModel(
      lat: (json['lat'] as num?)?.toDouble(),
      lng: (json['lng'] as num?)?.toDouble(),
      details: json['details'] as String?,
      id: json['id'] as int?,
      title: json['title'] as String?,
    );

Map<String, dynamic> _$EditAddressModelToJson(EditAddressModel instance) =>
    <String, dynamic>{
      'lat': instance.lat,
      'lng': instance.lng,
      'details': instance.details,
      'id': instance.id,
      'title': instance.title,
    };
