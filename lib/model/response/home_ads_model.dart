import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'home_ads_model.g.dart';

@immutable
@JsonSerializable(ignoreUnannotated: false)
class HomeAdsModel extends Equatable {
  @JsonKey(name: 'result')
  final Result? result;
  @JsonKey(name: 'message')
  final String? message;

  const HomeAdsModel({
    this.result,
    this.message,
  });

  factory HomeAdsModel.fromJson(Map<String, dynamic> json) =>
      _$HomeAdsModelFromJson(json);

  Map<String, dynamic> toJson() => _$HomeAdsModelToJson(this);

  @override
  List<Object?> get props => [result, message];
}

@immutable
@JsonSerializable(ignoreUnannotated: false)
class Result extends Equatable {
  @JsonKey(name: 'adds')
  final List<AdHome>? adds;

  const Result({
    this.adds,
  });

  factory Result.fromJson(Map<String, dynamic> json) => _$ResultFromJson(json);

  Map<String, dynamic> toJson() => _$ResultToJson(this);

  @override
  List<Object?> get props => [adds];
}

@immutable
@JsonSerializable(ignoreUnannotated: false)
class AdHome extends Equatable {
  @JsonKey(name: 'imageURl')
  final String? imageURL;

  const AdHome({
    this.imageURL,
  });

  factory AdHome.fromJson(Map<String, dynamic> json) => _$AdHomeFromJson(json);

  Map<String, dynamic> toJson() => _$AdHomeToJson(this);

  @override
  List<Object?> get props => [imageURL];
}
