import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'add_review_model.g.dart';

@immutable
@JsonSerializable(ignoreUnannotated: false)
class AddReviewModel extends Equatable {
  @JsonKey(name: 'orderId')
  final int? orderId;
  @JsonKey(name: 'rate')
  final int? rate;
  @JsonKey(name: 'comment')
  final String? comment;

  const AddReviewModel({
    required this.orderId,
    required this.rate,
    required this.comment,
  });

  Map<String, dynamic> toJson() => _$AddReviewModelToJson(this);

  @override
  List<Object?> get props => [orderId, rate, comment];
}
