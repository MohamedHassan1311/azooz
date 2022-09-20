import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'verification_model.g.dart';

@immutable
@JsonSerializable(ignoreUnannotated: false)
class VerificationModel extends Equatable {
  @JsonKey(name: 'result')
  final Result? result;
  @JsonKey(name: 'message')
  final String? message;

  const VerificationModel({this.result, this.message});

  factory VerificationModel.fromJson(Map<String, dynamic> json) =>
      _$VerificationModelFromJson(json);

  Map<String, dynamic> toJson() => _$VerificationModelToJson(this);

  @override
  List<Object?> get props => [result, message];
}

@immutable
@JsonSerializable(ignoreUnannotated: false)
class Result extends Equatable {
  @JsonKey(name: 'authorized')
  final bool? authorized;
  @JsonKey(name: 'authorization')
  final String? authorization;

  const Result({this.authorized, this.authorization});

  factory Result.fromJson(Map<String, dynamic> json) => _$ResultFromJson(json);

  Map<String, dynamic> toJson() => _$ResultToJson(this);

  @override
  List<Object?> get props => [authorized, authorization];
}
