import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'departments_model.g.dart';

@immutable
@JsonSerializable(ignoreUnannotated: false)
class DepartmentsModel extends Equatable {
  @JsonKey(name: 'result')
  final Result? result;
  @JsonKey(name: 'msg')
  final String? msg;

  const DepartmentsModel({
    required this.result,
    required this.msg,
  });

  factory DepartmentsModel.fromJson(Map<String, dynamic> json) =>
      _$DepartmentsModelFromJson(json);

  Map<String, dynamic> toJson() => _$DepartmentsModelToJson(this);

  @override
  List<Object?> get props => [result, msg];
}

@immutable
@JsonSerializable(ignoreUnannotated: false)
class Result extends Equatable {
  @JsonKey(name: 'alldepartment')
  final List<AllDepartments>? allDepartment;

  const Result({
    required this.allDepartment,
  });

  factory Result.fromJson(Map<String, dynamic> json) => _$ResultFromJson(json);

  Map<String, dynamic> toJson() => _$ResultToJson(this);

  @override
  List<Object?> get props => [allDepartment];
}

@immutable
@JsonSerializable(ignoreUnannotated: false)
class AllDepartments extends Equatable {
  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'name')
  final String? name;

  const AllDepartments({
    required this.id,
    required this.name,
  });

  factory AllDepartments.fromJson(Map<String, dynamic> json) =>
      _$AllDepartmentsFromJson(json);

  Map<String, dynamic> toJson() => _$AllDepartmentsToJson(this);
  @override
  List<Object?> get props => [id, name];
}
