// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stores_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StoresModel _$StoresModelFromJson(Map<String, dynamic> json) => StoresModel(
      result: json['result'] == null
          ? null
          : Result.fromJson(json['result'] as Map<String, dynamic>),
      message: json['message'] as String?,
    );

Map<String, dynamic> _$StoresModelToJson(StoresModel instance) =>
    <String, dynamic>{
      'result': instance.result,
      'message': instance.message,
    };

Result _$ResultFromJson(Map<String, dynamic> json) => Result(
      stores: (json['stors'] as List<dynamic>?)
          ?.map((e) => Stores.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ResultToJson(Result instance) => <String, dynamic>{
      'stors': instance.stores,
    };

Stores _$StoresFromJson(Map<String, dynamic> json) => Stores(
      id: json['id'] as int?,
      name: json['name'] as String?,
      description: json['description'] as String?,
      imageURL: json['imageURl'] as String?,
      time: (json['time'] as num?)?.toDouble(),
      rate: (json['rate'] as num?)?.toDouble(),
      distance: (json['distance'] as num?)?.toDouble(),
      lowestPrice: (json['lowestPrice'] as num?)?.toDouble(),
      location: json['location'] == null
          ? null
          : Location.fromJson(json['location'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$StoresToJson(Stores instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'imageURl': instance.imageURL,
      'time': instance.time,
      'rate': instance.rate,
      'distance': instance.distance,
      'lowestPrice': instance.lowestPrice,
      'location': instance.location,
    };

Location _$LocationFromJson(Map<String, dynamic> json) => Location(
      lat: (json['lat'] as num?)?.toDouble(),
      lng: (json['lng'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$LocationToJson(Location instance) => <String, dynamic>{
      'lat': instance.lat,
      'lng': instance.lng,
    };
