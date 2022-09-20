import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'fcm_model.g.dart';

@immutable
@JsonSerializable(ignoreUnannotated: false)
class FcmModel extends Equatable {
  @JsonKey(name: 'fcm')
  final String? fcm;
  @JsonKey(name: 'mobileType')
  final String? mobileType;
  @JsonKey(name: 'mobileID')
  final String? mobileID;
  @JsonKey(name: 'userRule')
  final int? userRule;

  const FcmModel({
    required this.fcm,
    required this.mobileType,
    required this.mobileID,
    required this.userRule,
  });

  Map<String, dynamic> toJson() => _$FcmModelToJson(this);

  @override
  List<Object?> get props => [fcm, mobileID, mobileType, userRule];
}
