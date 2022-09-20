import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'delete_address_model.g.dart';

@immutable
@JsonSerializable(ignoreUnannotated: false)
class DeleteAddressModel extends Equatable {
  @JsonKey(name: 'id')
  final int? id;

  const DeleteAddressModel({
    required this.id,
  });

  factory DeleteAddressModel.fromJson(Map<String, dynamic> json) =>
      _$DeleteAddressModelFromJson(json);

  Map<String, dynamic> toJson() => _$DeleteAddressModelToJson(this);

  @override
  List<Object?> get props => [id];
}
