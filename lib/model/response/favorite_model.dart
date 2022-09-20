import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'favorite_model.g.dart';

@immutable
@JsonSerializable(ignoreUnannotated: false)
class FavoriteModel extends Equatable {
  @JsonKey(name: 'result')
  final Result? result;
  @JsonKey(name: 'message')
  final String? message;

  const FavoriteModel({this.result, this.message});

  factory FavoriteModel.fromJson(Map<String, dynamic> json) =>
      _$FavoriteModelFromJson(json);

  Map<String, dynamic> toJson() => _$FavoriteModelToJson(this);

  @override
  List<Object?> get props => [result, message];
}

@immutable
@JsonSerializable(ignoreUnannotated: false)
class Result extends Equatable {
  @JsonKey(name: 'stors')
  final List<Stores>? stores;

  const Result({this.stores});

  factory Result.fromJson(Map<String, dynamic> json) => _$ResultFromJson(json);

  Map<String, dynamic> toJson() => _$ResultToJson(this);

  @override
  List<Object?> get props => [stores];
}

@immutable
@JsonSerializable(ignoreUnannotated: false)
class Stores extends Equatable {
  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'storeId')
  final int? storeId;
  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'description')
  final String? description;
  @JsonKey(name: 'imageURl')
  final String? imageURL;
  @JsonKey(name: 'rate')
  final double? rate;

  const Stores(
      {this.id,
      this.name,
      this.description,
      this.imageURL,
      this.rate,
      this.storeId});

  factory Stores.fromJson(Map<String, dynamic> json) => _$StoresFromJson(json);

  Map<String, dynamic> toJson() => _$StoresToJson(this);

  @override
  List<Object?> get props => [id, name, description, imageURL, rate];
}
