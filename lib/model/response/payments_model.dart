import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'payments_model.g.dart';

@immutable
@JsonSerializable(ignoreUnannotated: false)
class PaymentsModel extends Equatable {
  @JsonKey(name: 'result')
  final Result? result;
  @JsonKey(name: 'message')
  final String? message;

  const PaymentsModel({
    this.result,
    this.message,
  });

  factory PaymentsModel.fromJson(Map<String, dynamic> json) =>
      _$PaymentsModelFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentsModelToJson(this);

  @override
  List<Object?> get props => [result, message];
}

@immutable
@JsonSerializable(ignoreUnannotated: false)
class Result extends Equatable {
  @JsonKey(name: 'cards')
  final List<CardDetails>? cards;

  const Result({
    this.cards,
  });

  factory Result.fromJson(Map<String, dynamic> json) => _$ResultFromJson(json);

  Map<String, dynamic> toJson() => _$ResultToJson(this);

  @override
  List<Object?> get props => [cards];
}

@immutable
@JsonSerializable(ignoreUnannotated: false)
class CardDetails extends Equatable {
  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'fullName')
  final String fullName;
  @JsonKey(name: 'number')
  final String number;
  @JsonKey(name: 'month')
  final String? month;
  @JsonKey(name: 'year')
  final String? year;
  @JsonKey(name: 'expiredDate')
  final String? expiredDate;

  const CardDetails({
    this.id,
    required this.fullName,
    required this.number,
    this.month,
    this.year,
    this.expiredDate,
  });

  factory CardDetails.fromJson(Map<String, dynamic> json) =>
      _$CardDetailsFromJson(json);

  /// With ID
  Map<String, dynamic> toJsonEdit() => _$CardDetailsToJson(this);

  /// Without ID
  Map<String, dynamic> toJsonCreate() => _$CardDetailsToJson(this);

  @override
  List<Object?> get props => [id, fullName, number, month, year, expiredDate];
}
