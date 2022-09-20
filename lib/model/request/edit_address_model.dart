import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'edit_address_model.g.dart';

@immutable
@JsonSerializable(ignoreUnannotated: false)
class EditAddressModel extends Equatable {
  @JsonKey(name: 'lat')
  final double? lat;
  @JsonKey(name: 'lng')
  final double? lng;
  @JsonKey(name: 'details')
  final String? details;
  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'title')
  final String? title;

  const EditAddressModel({
    required this.lat,
    required this.lng,
    required this.details,
    required this.id,
    required this.title,
  });

  factory EditAddressModel.fromJson(Map<String, dynamic> json) =>
      _$EditAddressModelFromJson(json);

  Map<String, dynamic> toJson() => _$EditAddressModelToJson(this);

  @override
  List<Object?> get props => [lat, lng, details, id, title];
}
