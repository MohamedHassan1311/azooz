import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'app_status_model.g.dart';

@immutable
@JsonSerializable(ignoreUnannotated: false)
class AppStatusModel extends Equatable {
  @JsonKey(name: 'result')
  final Result? result;
  @JsonKey(name: 'msg')
  final String? msg;

  const AppStatusModel({
    this.result,
    this.msg,
  });

  factory AppStatusModel.fromJson(Map<String, dynamic> json) =>
      _$AppStatusModelFromJson(json);

  Map<String, dynamic> toJson() => _$AppStatusModelToJson(this);

  @override
  List<Object?> get props => [result, msg];
}

@immutable
@JsonSerializable(ignoreUnannotated: false)
class Result extends Equatable {
  @JsonKey(name: 'statusCat')
  final List<StatusCat>? statusCat;

  const Result({
    this.statusCat,
  });

  factory Result.fromJson(Map<String, dynamic> json) => _$ResultFromJson(json);

  Map<String, dynamic> toJson() => _$ResultToJson(this);

  @override
  List<Object?> get props => [statusCat];
}

@immutable
@JsonSerializable(ignoreUnannotated: false)
class StatusCat extends Equatable {
  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'status')
  final List<Status>? status;

  const StatusCat({
    this.name,
    this.status,
  });

  factory StatusCat.fromJson(Map<String, dynamic> json) =>
      _$StatusCatFromJson(json);

  Map<String, dynamic> toJson() => _$StatusCatToJson(this);

  @override
  List<Object?> get props => [name, status];
}

@immutable
@JsonSerializable(ignoreUnannotated: false)
class Status extends Equatable {
  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'name')
  final String? name;

  const Status({
    this.id,
    this.name,
  });

  factory Status.fromJson(Map<String, dynamic> json) => _$StatusFromJson(json);

  Map<String, dynamic> toJson() => _$StatusToJson(this);

  @override
  List<Object?> get props => [id, name];
}
