import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'payment_value_model.g.dart';

@immutable
@JsonSerializable(ignoreUnannotated: false)
class PaymentValueModel extends Equatable {
  @JsonKey(name: 'result')
  final Result? result;
  @JsonKey(name: 'message')
  final String? message;

  const PaymentValueModel({
    this.result,
    this.message,
  });

  factory PaymentValueModel.fromJson(Map<String, dynamic> json) =>
      _$PaymentValueModelFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentValueModelToJson(this);

  @override
  List<Object?> get props => [result, message];
}

@immutable
@JsonSerializable(ignoreUnannotated: false)
class Result extends Equatable {
  @JsonKey(name: 'paymentValue')
  final double? paymentValue;

  const Result({
    this.paymentValue,
  });

  factory Result.fromJson(Map<String, dynamic> json) => _$ResultFromJson(json);

  Map<String, dynamic> toJson() => _$ResultToJson(this);

  @override
  List<Object?> get props => [paymentValue];
}
