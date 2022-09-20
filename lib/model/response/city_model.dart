import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'city_model.g.dart';

@immutable
@JsonSerializable(ignoreUnannotated: false)
class CityModel extends Equatable {
  @JsonKey(name: 'result')
  final Result? result;
  @JsonKey(name: 'msg')
  final String? msg;

  const CityModel({this.result, this.msg});

  factory CityModel.fromJson(Map<String, dynamic> json) =>
      _$CityModelFromJson(json);

  Map<String, dynamic> toJson() => _$CityModelToJson(this);

  @override
  List<Object?> get props => [result, msg];
}

@immutable
@JsonSerializable(ignoreUnannotated: false)
class Result extends Equatable {
  @JsonKey(name: 'cities')
  final List<Cities>? cities;

  const Result({this.cities});

  factory Result.fromJson(Map<String, dynamic> json) => _$ResultFromJson(json);

  Map<String, dynamic> toJson() => _$ResultToJson(this);

  @override
  List<Object?> get props => [cities];
}

@immutable
@JsonSerializable(ignoreUnannotated: false)
class Cities extends Equatable {
  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'name')
  final String? name;

  const Cities({this.id, this.name});

  factory Cities.fromJson(Map<String, dynamic> json) => _$CitiesFromJson(json);

  Map<String, dynamic> toJson() => _$CitiesToJson(this);

  @override
  List<Object?> get props => [id, name];
}
