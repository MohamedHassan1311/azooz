import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'gender_model.g.dart';

@immutable
@JsonSerializable(ignoreUnannotated: false)
class GenderModel extends Equatable {
  @JsonKey(name: 'result')
  final Result? result;
  @JsonKey(name: 'msg')
  final String? msg;

  const GenderModel({this.result, this.msg});

  factory GenderModel.fromJson(Map<String, dynamic> json) =>
      _$GenderModelFromJson(json);

  Map<String, dynamic> toJson() => _$GenderModelToJson(this);

  @override
  List<Object?> get props => [result, msg];
}

@immutable
@JsonSerializable(ignoreUnannotated: false)
class Result extends Equatable {
  @JsonKey(name: 'genders')
  final List<UserGender>? genders;

  const Result({this.genders});

  factory Result.fromJson(Map<String, dynamic> json) => _$ResultFromJson(json);

  Map<String, dynamic> toJson() => _$ResultToJson(this);

  @override
  List<Object?> get props => [genders];
}

@immutable
@JsonSerializable(ignoreUnannotated: false)
class UserGender extends Equatable {
  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'name')
  final String? name;

  const UserGender({this.id, this.name});

  factory UserGender.fromJson(Map<String, dynamic> json) =>
      _$UserGenderFromJson(json);

  Map<String, dynamic> toJson() => _$UserGenderToJson(this);

  @override
  bool operator ==(Object other) => other is UserGender && other.name == name;

  @override
  int get hashCode => name.hashCode;

  @override
  List<Object?> get props => [id, name];
}
