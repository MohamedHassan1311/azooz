import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'login_model.g.dart';

@immutable
@JsonSerializable(ignoreUnannotated: false)
class LoginModel extends Equatable {
  @JsonKey(name: 'result')
  final Result? result;
  @JsonKey(name: 'message')
  final String? message;

  const LoginModel({this.result, this.message});

  factory LoginModel.fromJson(Map<String, dynamic> json) =>
      _$LoginModelFromJson(json);

  Map<String, dynamic> toJson() => _$LoginModelToJson(this);

  @override
  List<Object?> get props => [result, message];
}

@immutable
@JsonSerializable(ignoreUnannotated: false)
class Result extends Equatable {
  @JsonKey(name: 'isProvider')
  final bool? isProvider;
  @JsonKey(name: 'securityCode')
  final int? securityCode;
  @JsonKey(name: 'authorization')
  final String? authorization;
  @JsonKey(name: 'phone')
  final String? phone;

  const Result(
      {this.isProvider, this.securityCode, this.authorization, this.phone});

  factory Result.fromJson(Map<String, dynamic> json) => _$ResultFromJson(json);

  Map<String, dynamic> toJson() => _$ResultToJson(this);

  @override
  List<Object?> get props => [isProvider, securityCode, authorization, phone];
}