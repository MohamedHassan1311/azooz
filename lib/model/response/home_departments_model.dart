import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'home_departments_model.g.dart';

@immutable
@JsonSerializable(ignoreUnannotated: false)
class HomeDepartmentsModel extends Equatable {
  @JsonKey(name: 'result')
  final Result? result;
  @JsonKey(name: 'message')
  final String? message;

  const HomeDepartmentsModel({
    this.result,
    this.message,
  });

  factory HomeDepartmentsModel.fromJson(Map<String, dynamic> json) =>
      _$HomeDepartmentsModelFromJson(json);

  Map<String, dynamic> toJson() => _$HomeDepartmentsModelToJson(this);

  @override
  List<Object?> get props => [result, message];
}

@immutable
@JsonSerializable(ignoreUnannotated: false)
class Result extends Equatable {
  @JsonKey(name: 'departments')
  final List<DepartmentHome>? departments;

  const Result({
    this.departments,
  });

  factory Result.fromJson(Map<String, dynamic> json) => _$ResultFromJson(json);

  Map<String, dynamic> toJson() => _$ResultToJson(this);

  @override
  List<Object?> get props => [departments];
}

@immutable
@JsonSerializable(ignoreUnannotated: false)
class DepartmentHome extends Equatable {
  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'imageURl')
  final String? imageURL;

  const DepartmentHome({
    this.id,
    this.name,
    this.imageURL,
  });

  factory DepartmentHome.fromJson(Map<String, dynamic> json) =>
      _$DepartmentHomeFromJson(json);

  Map<String, dynamic> toJson() => _$DepartmentHomeToJson(this);

  @override
  List<Object?> get props => [id, name, imageURL];
}
