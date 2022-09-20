// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'city_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CityModel _$CityModelFromJson(Map<String, dynamic> json) => CityModel(
      result: json['result'] == null
          ? null
          : Result.fromJson(json['result'] as Map<String, dynamic>),
      msg: json['msg'] as String?,
    );

Map<String, dynamic> _$CityModelToJson(CityModel instance) => <String, dynamic>{
      'result': instance.result,
      'msg': instance.msg,
    };

Result _$ResultFromJson(Map<String, dynamic> json) => Result(
      cities: (json['cities'] as List<dynamic>?)
          ?.map((e) => Cities.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ResultToJson(Result instance) => <String, dynamic>{
      'cities': instance.cities,
    };

Cities _$CitiesFromJson(Map<String, dynamic> json) => Cities(
      id: json['id'] as int?,
      name: json['name'] as String?,
    );

Map<String, dynamic> _$CitiesToJson(Cities instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };
