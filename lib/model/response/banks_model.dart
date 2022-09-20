import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'banks_model.g.dart';

@immutable
@JsonSerializable(ignoreUnannotated: false)
class BanksModel extends Equatable {
  @JsonKey(name: 'result')
  final Result? result;
  @JsonKey(name: 'msg')
  final String? msg;

  const BanksModel({
    required this.result,
    required this.msg,
  });

  factory BanksModel.fromJson(Map<String, dynamic> json) =>
      _$BanksModelFromJson(json);

  Map<String, dynamic> toJson() => _$BanksModelToJson(this);

  @override
  List<Object?> get props => [result, msg];
}

@immutable
@JsonSerializable(ignoreUnannotated: false)
class Result extends Equatable {
  @JsonKey(name: 'allbanks')
  final List<AllBanks>? allbanks;

  const Result({
    required this.allbanks,
  });

  factory Result.fromJson(Map<String, dynamic> json) => _$ResultFromJson(json);

  Map<String, dynamic> toJson() => _$ResultToJson(this);

  @override
  List<Object?> get props => [allbanks];
}

@JsonSerializable(ignoreUnannotated: false)
class AllBanks extends Equatable {
  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'name')
  final String? name;

  const AllBanks({
    required this.id,
    required this.name,
  });

  factory AllBanks.fromJson(Map<String, dynamic> json) =>
      _$AllBanksFromJson(json);

  Map<String, dynamic> toJson() => _$AllBanksToJson(this);

  @override
  List<Object?> get props => [id, name];
}
