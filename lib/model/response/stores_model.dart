import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'stores_model.g.dart';

@immutable
@JsonSerializable(ignoreUnannotated: false)
class StoresModel extends Equatable {
  @JsonKey(name: 'result')
  final Result? result;
  @JsonKey(name: 'message')
  final String? message;

  const StoresModel({
    this.result,
    this.message,
  });

  factory StoresModel.fromJson(Map<String, dynamic> json) =>
      _$StoresModelFromJson(json);

  Map<String, dynamic> toJson() => _$StoresModelToJson(this);

  @override
  List<Object?> get props => [result, message];
}

@immutable
@JsonSerializable(ignoreUnannotated: false)
class Result extends Equatable {
  @JsonKey(name: 'stors')
  final List<Stores>? stores;

  const Result({
    this.stores,
  });

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
  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'description')
  final String? description;
  @JsonKey(name: 'imageURl')
  final String? imageURL;
  @JsonKey(name: 'time')
  final double? time;
  @JsonKey(name: 'rate')
  final double? rate;
  @JsonKey(name: 'distance')
  final double? distance;
  @JsonKey(name: 'lowestPrice')
  final double? lowestPrice;
  @JsonKey(name: 'location')
  final Location? location;

  const Stores({
    this.id,
    this.name,
    this.description,
    this.imageURL,
    this.time,
    this.rate,
    this.distance,
    this.lowestPrice,
    this.location,
  });

  factory Stores.fromJson(Map<String, dynamic> json) => _$StoresFromJson(json);

  Map<String, dynamic> toJson() => _$StoresToJson(this);

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        imageURL,
        time,
        distance,
        rate,
        lowestPrice,
        location
      ];
}

@immutable
@JsonSerializable(ignoreUnannotated: false)
class Location extends Equatable {
  @JsonKey(name: 'lat')
  final double? lat;
  @JsonKey(name: 'lng')
  final double? lng;

  const Location({
    this.lat,
    this.lng,
  });

  factory Location.fromJson(Map<String, dynamic> json) =>
      _$LocationFromJson(json);

  Map<String, dynamic> toJson() => _$LocationToJson(this);

  @override
  List<Object?> get props => [lat, lng];
}
