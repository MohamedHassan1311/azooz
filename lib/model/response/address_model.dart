import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'address_model.g.dart';

@immutable
@JsonSerializable(ignoreUnannotated: false)
class AddressModel extends Equatable {
  @JsonKey(name: 'result')
  final Result? result;
  @JsonKey(name: 'message')
  final String? message;

  const AddressModel({
    this.result,
    this.message,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) =>
      _$AddressModelFromJson(json);

  Map<String, dynamic> toJson() => _$AddressModelToJson(this);

  @override
  List<Object?> get props => [result, message];
}

@immutable
@JsonSerializable(ignoreUnannotated: false)
class Result extends Equatable {
  @JsonKey(name: 'favoriteLocations')
  final List<FavoriteLocation>? favoriteLocations;

  const Result({
    this.favoriteLocations,
  });

  factory Result.fromJson(Map<String, dynamic> json) => _$ResultFromJson(json);

  Map<String, dynamic> toJson() => _$ResultToJson(this);

  @override
  List<Object?> get props => [favoriteLocations];
}

@immutable
@JsonSerializable(ignoreUnannotated: false)
class FavoriteLocation extends Equatable {
  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'title')
  final String? title;
  @JsonKey(name: 'details')
  final String? details;
  @JsonKey(name: 'lat')
  final double? lat;
  @JsonKey(name: 'lng')
  final double? lng;

  const FavoriteLocation({
    this.id,
    this.title,
    this.details,
    this.lat,
    this.lng,
  });

  factory FavoriteLocation.fromJson(Map<String, dynamic> json) =>
      _$FavoriteLocationFromJson(json);

  Map<String, dynamic> toJson() => _$FavoriteLocationToJson(this);

  @override
  List<Object?> get props => [id, title, details, lat, lng];
}
