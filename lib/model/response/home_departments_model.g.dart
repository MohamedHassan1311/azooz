// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_departments_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HomeDepartmentsModel _$HomeDepartmentsModelFromJson(
        Map<String, dynamic> json) =>
    HomeDepartmentsModel(
      result: json['result'] == null
          ? null
          : Result.fromJson(json['result'] as Map<String, dynamic>),
      message: json['message'] as String?,
    );

Map<String, dynamic> _$HomeDepartmentsModelToJson(
        HomeDepartmentsModel instance) =>
    <String, dynamic>{
      'result': instance.result,
      'message': instance.message,
    };

Result _$ResultFromJson(Map<String, dynamic> json) => Result(
      departments: (json['departments'] as List<dynamic>?)
          ?.map((e) => DepartmentHome.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ResultToJson(Result instance) => <String, dynamic>{
      'departments': instance.departments,
    };

DepartmentHome _$DepartmentHomeFromJson(Map<String, dynamic> json) =>
    DepartmentHome(
      id: json['id'] as int?,
      name: json['name'] as String?,
      imageURL: json['imageURl'] as String?,
    );

Map<String, dynamic> _$DepartmentHomeToJson(DepartmentHome instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'imageURl': instance.imageURL,
    };
