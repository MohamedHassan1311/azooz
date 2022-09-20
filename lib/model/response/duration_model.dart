import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'duration_model.g.dart';

@immutable
@JsonSerializable(ignoreUnannotated: false)
class DurationModel extends Equatable {
  @JsonKey(name: 'result')
  final Result? result;
  @JsonKey(name: 'message')
  final String? message;

  const DurationModel({
    this.result,
    this.message,
  });

  factory DurationModel.fromJson(Map<String, dynamic> json) =>
      _$DurationModelFromJson(json);

  Map<String, dynamic> toJson() => _$DurationModelToJson(this);

  @override
  List<Object?> get props => [result, message];
}

@immutable
@JsonSerializable(ignoreUnannotated: false)
class Result extends Equatable {
  @JsonKey(name: 'durations')
  final List<Durationi>? durations;

  const Result({
    this.durations,
  });

  factory Result.fromJson(Map<String, dynamic> json) => _$ResultFromJson(json);

  Map<String, dynamic> toJson() => _$ResultToJson(this);

  @override
  List<Object?> get props => [durations];
}

@immutable
@JsonSerializable(ignoreUnannotated: false)
class Durationi extends Equatable {
  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'name')
  final String? name;

  const Durationi({
    this.id,
    this.name,
  });

  factory Durationi.fromJson(Map<String, dynamic> json) =>
      _$DurationiFromJson(json);

  Map<String, dynamic> toJson() => _$DurationiToJson(this);

  @override
  List<Object?> get props => [id, name];
}
