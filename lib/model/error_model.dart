import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'error_model.g.dart';

@immutable
@JsonSerializable(ignoreUnannotated: false)
class ErrorModel extends Equatable {
  @JsonKey(name: 'code')
  final int? code;
  @JsonKey(name: 'message')
  final String? message;
  @JsonKey(name: 'details')
  final List<Detail>? details;

  const ErrorModel({this.code, this.message, this.details});

  factory ErrorModel.fromJson(Map<String, dynamic> json) =>
      _$ErrorModelFromJson(json);

  Map<String, dynamic> toJson() => _$ErrorModelToJson(this);

  @override
  List<Object?> get props => [code, message, details];
}

@immutable
@JsonSerializable(ignoreUnannotated: false)
class Detail extends Equatable {
  @JsonKey(name: 'key')
  final String? key;
  @JsonKey(name: 'value')
  final String? value;

  const Detail({this.key, this.value});

  factory Detail.fromJson(Map<String, dynamic> json) => _$DetailFromJson(json);

  Map<String, dynamic> toJson() => _$DetailToJson(this);

  @override
  List<Object?> get props => [key, value];
}