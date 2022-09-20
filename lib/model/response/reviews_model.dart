import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'reviews_model.g.dart';

@immutable
@JsonSerializable(ignoreUnannotated: false)
class ReviewsModel extends Equatable {
  @JsonKey(name: 'result')
  final Result? result;
  @JsonKey(name: 'message')
  final String? message;

  const ReviewsModel({
    this.result,
    this.message,
  });

  factory ReviewsModel.fromJson(Map<String, dynamic> json) =>
      _$ReviewsModelFromJson(json);

  Map<String, dynamic> toJson() => _$ReviewsModelToJson(this);

  @override
  List<Object?> get props => [result, message];
}

@immutable
@JsonSerializable(ignoreUnannotated: false)
class Result extends Equatable {
  @JsonKey(name: 'reviews')
  final List<Review>? reviews;

  const Result({
    this.reviews,
  });

  factory Result.fromJson(Map<String, dynamic> json) => _$ResultFromJson(json);

  Map<String, dynamic> toJson() => _$ResultToJson(this);

  @override
  List<Object?> get props => [reviews];
}

@immutable
@JsonSerializable(ignoreUnannotated: false)
class Review extends Equatable {
  @JsonKey(name: 'rate')
  final double? rate;
  @JsonKey(name: 'from')
  final From? from;
  @JsonKey(name: 'comment')
  final String? comment;

  const Review({
    this.rate,
    this.from,
    this.comment,
  });

  factory Review.fromJson(Map<String, dynamic> json) => _$ReviewFromJson(json);

  Map<String, dynamic> toJson() => _$ReviewToJson(this);

  @override
  List<Object?> get props => [rate, from, comment];
}

@immutable
@JsonSerializable(ignoreUnannotated: false)
class From extends Equatable {
  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'imageURl')
  final String? imageURl;
  @JsonKey(name: 'rate')
  final double? rate;
  @JsonKey(name: 'rateCount')
  final int? rateCount;

  const From({
    this.name,
    this.imageURl,
    this.rate,
    this.rateCount,
  });

  factory From.fromJson(Map<String, dynamic> json) => _$FromFromJson(json);

  Map<String, dynamic> toJson() => _$FromToJson(this);

  @override
  List<Object?> get props => [name, imageURl, rate, rateCount];
}
