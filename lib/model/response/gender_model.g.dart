// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gender_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GenderModel _$GenderModelFromJson(Map<String, dynamic> json) => GenderModel(
      result: json['result'] == null
          ? null
          : Result.fromJson(json['result'] as Map<String, dynamic>),
      msg: json['msg'] as String?,
    );

Map<String, dynamic> _$GenderModelToJson(GenderModel instance) =>
    <String, dynamic>{
      'result': instance.result,
      'msg': instance.msg,
    };

Result _$ResultFromJson(Map<String, dynamic> json) => Result(
      genders: (json['genders'] as List<dynamic>?)
          ?.map((e) => UserGender.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ResultToJson(Result instance) => <String, dynamic>{
      'genders': instance.genders,
    };

UserGender _$UserGenderFromJson(Map<String, dynamic> json) => UserGender(
      id: json['id'] as int?,
      name: json['name'] as String?,
    );

Map<String, dynamic> _$UserGenderToJson(UserGender instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };
