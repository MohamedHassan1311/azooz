// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'departments_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DepartmentsModel _$DepartmentsModelFromJson(Map<String, dynamic> json) =>
    DepartmentsModel(
      result: json['result'] == null
          ? null
          : Result.fromJson(json['result'] as Map<String, dynamic>),
      msg: json['msg'] as String?,
    );

Map<String, dynamic> _$DepartmentsModelToJson(DepartmentsModel instance) =>
    <String, dynamic>{
      'result': instance.result,
      'msg': instance.msg,
    };

Result _$ResultFromJson(Map<String, dynamic> json) => Result(
      allDepartment: (json['alldepartment'] as List<dynamic>?)
          ?.map((e) => AllDepartments.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ResultToJson(Result instance) => <String, dynamic>{
      'alldepartment': instance.allDepartment,
    };

AllDepartments _$AllDepartmentsFromJson(Map<String, dynamic> json) =>
    AllDepartments(
      id: json['id'] as int?,
      name: json['name'] as String?,
    );

Map<String, dynamic> _$AllDepartmentsToJson(AllDepartments instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };
