// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_status_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppStatusModel _$AppStatusModelFromJson(Map<String, dynamic> json) =>
    AppStatusModel(
      result: json['result'] == null
          ? null
          : Result.fromJson(json['result'] as Map<String, dynamic>),
      msg: json['msg'] as String?,
    );

Map<String, dynamic> _$AppStatusModelToJson(AppStatusModel instance) =>
    <String, dynamic>{
      'result': instance.result,
      'msg': instance.msg,
    };

Result _$ResultFromJson(Map<String, dynamic> json) => Result(
      statusCat: (json['statusCat'] as List<dynamic>?)
          ?.map((e) => StatusCat.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ResultToJson(Result instance) => <String, dynamic>{
      'statusCat': instance.statusCat,
    };

StatusCat _$StatusCatFromJson(Map<String, dynamic> json) => StatusCat(
      name: json['name'] as String?,
      status: (json['status'] as List<dynamic>?)
          ?.map((e) => Status.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$StatusCatToJson(StatusCat instance) => <String, dynamic>{
      'name': instance.name,
      'status': instance.status,
    };

Status _$StatusFromJson(Map<String, dynamic> json) => Status(
      id: json['id'] as int?,
      name: json['name'] as String?,
    );

Map<String, dynamic> _$StatusToJson(Status instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };
