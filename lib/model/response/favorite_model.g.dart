// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorite_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FavoriteModel _$FavoriteModelFromJson(Map<String, dynamic> json) =>
    FavoriteModel(
      result: json['result'] == null
          ? null
          : Result.fromJson(json['result'] as Map<String, dynamic>),
      message: json['message'] as String?,
    );

Map<String, dynamic> _$FavoriteModelToJson(FavoriteModel instance) =>
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
      rate: (json['rate'] as num?)?.toDouble(),
      storeId: json['storeId'] as int?,
    );

Map<String, dynamic> _$StoresToJson(Stores instance) => <String, dynamic>{
      'id': instance.id,
      'storeId': instance.storeId,
      'name': instance.name,
      'description': instance.description,
      'imageURl': instance.imageURL,
      'rate': instance.rate,
    };
