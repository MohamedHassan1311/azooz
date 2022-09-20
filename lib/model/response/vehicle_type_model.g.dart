// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vehicle_type_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VehicleTypeModel _$VehicleTypeModelFromJson(Map<String, dynamic> json) =>
    VehicleTypeModel(
      result: json['result'] == null
          ? null
          : Result.fromJson(json['result'] as Map<String, dynamic>),
      msg: json['msg'] as String?,
    );

Map<String, dynamic> _$VehicleTypeModelToJson(VehicleTypeModel instance) =>
    <String, dynamic>{
      'result': instance.result,
      'msg': instance.msg,
    };

Result _$ResultFromJson(Map<String, dynamic> json) => Result(
      vehicleType: (json['vehicleType'] as List<dynamic>?)
          ?.map((e) => VehicleType.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ResultToJson(Result instance) => <String, dynamic>{
      'vehicleType': instance.vehicleType,
    };

VehicleType _$VehicleTypeFromJson(Map<String, dynamic> json) => VehicleType(
      name: json['name'] as String?,
      id: json['id'] as int?,
    );

Map<String, dynamic> _$VehicleTypeToJson(VehicleType instance) =>
    <String, dynamic>{
      'name': instance.name,
      'id': instance.id,
    };
