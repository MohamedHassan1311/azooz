import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'vehicle_type_model.g.dart';

@immutable
@JsonSerializable(ignoreUnannotated: false)
class VehicleTypeModel extends Equatable {
  @JsonKey(name: 'result')
  final Result? result;
  @JsonKey(name: 'msg')
  final String? msg;

  const VehicleTypeModel({
    required this.result,
    required this.msg,
  });

  factory VehicleTypeModel.fromJson(Map<String, dynamic> json) =>
      _$VehicleTypeModelFromJson(json);

  Map<String, dynamic> toJson() => _$VehicleTypeModelToJson(this);

  @override
  List<Object?> get props => [result, msg];
}

@immutable
@JsonSerializable(ignoreUnannotated: false)
class Result extends Equatable {
  @JsonKey(name: 'vehicleType')
  final List<VehicleType>? vehicleType;

  const Result({
    required this.vehicleType,
  });

  factory Result.fromJson(Map<String, dynamic> json) => _$ResultFromJson(json);

  Map<String, dynamic> toJson() => _$ResultToJson(this);

  @override
  List<Object?> get props => [vehicleType];
}

@immutable
@JsonSerializable(ignoreUnannotated: false)
class VehicleType extends Equatable {
  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'id')
  final int? id;

  const VehicleType({
    required this.name,
    required this.id,
  });

  factory VehicleType.fromJson(Map<String, dynamic> json) =>
      _$VehicleTypeFromJson(json);

  Map<String, dynamic> toJson() => _$VehicleTypeToJson(this);

  @override
  List<Object?> get props => [name, id];
}
