// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddressModel _$AddressModelFromJson(Map<String, dynamic> json) => AddressModel(
      result: json['result'] == null
          ? null
          : Result.fromJson(json['result'] as Map<String, dynamic>),
      message: json['message'] as String?,
    );

Map<String, dynamic> _$AddressModelToJson(AddressModel instance) =>
    <String, dynamic>{
      'result': instance.result,
      'message': instance.message,
    };

Result _$ResultFromJson(Map<String, dynamic> json) => Result(
      favoriteLocations: (json['favoriteLocations'] as List<dynamic>?)
          ?.map((e) => FavoriteLocation.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ResultToJson(Result instance) => <String, dynamic>{
      'favoriteLocations': instance.favoriteLocations,
    };

FavoriteLocation _$FavoriteLocationFromJson(Map<String, dynamic> json) =>
    FavoriteLocation(
      id: json['id'] as int?,
      title: json['title'] as String?,
      details: json['details'] as String?,
      lat: (json['lat'] as num?)?.toDouble(),
      lng: (json['lng'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$FavoriteLocationToJson(FavoriteLocation instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'details': instance.details,
      'lat': instance.lat,
      'lng': instance.lng,
    };
