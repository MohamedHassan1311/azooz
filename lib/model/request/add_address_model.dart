import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'add_address_model.g.dart';

@immutable
@JsonSerializable(ignoreUnannotated: false)
class AddAddressModel extends Equatable {
  @JsonKey(name: 'lat')
  final double? lat;
  @JsonKey(name: 'lng')
  final double? lng;
  @JsonKey(name: 'details')
  final String? details;
  @JsonKey(name: 'title')
  final String? title;

  const AddAddressModel({
    required this.lat,
    required this.lng,
    required this.details,
    required this.title,
  });

  factory AddAddressModel.fromJson(Map<String, dynamic> json) =>
      _$AddAddressModelFromJson(json);

  Map<String, dynamic> toJson() => _$AddAddressModelToJson(this);

  @override
  List<Object?> get props => [lat, lng, details, title];
}
