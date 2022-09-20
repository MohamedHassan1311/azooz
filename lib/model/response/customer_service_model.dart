import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'customer_service_model.g.dart';

@immutable
@JsonSerializable(ignoreUnannotated: false)
class CustomerServiceModel extends Equatable {
  @JsonKey(name: 'result')
  final Result? result;
  @JsonKey(name: 'message')
  final String? message;

  const CustomerServiceModel({
    this.result,
    this.message,
  });

  factory CustomerServiceModel.fromJson(Map<String, dynamic> json) =>
      _$CustomerServiceModelFromJson(json);

  Map<String, dynamic> toJson() => _$CustomerServiceModelToJson(this);

  @override
  List<Object?> get props => [result, message];
}

@immutable
@JsonSerializable(ignoreUnannotated: false)
class Result extends Equatable {
  @JsonKey(name: 'chatId')
  final int? chatId;
  @JsonKey(name: 'otherUser')
  final OtherUser? otherUser;

  const Result({
    this.chatId,
    this.otherUser,
  });

  factory Result.fromJson(Map<String, dynamic> json) => _$ResultFromJson(json);

  Map<String, dynamic> toJson() => _$ResultToJson(this);

  @override
  List<Object?> get props => [chatId, otherUser];
}

@immutable
@JsonSerializable(ignoreUnannotated: false)
class OtherUser extends Equatable {
  @JsonKey(name: 'data')
  final Data? data;
  @JsonKey(name: 'phone')
  final String? phone;

  const OtherUser({
    this.data,
    this.phone,
  });

  factory OtherUser.fromJson(Map<String, dynamic> json) =>
      _$OtherUserFromJson(json);

  Map<String, dynamic> toJson() => _$OtherUserToJson(this);

  @override
  List<Object?> get props => [data, phone];
}

@immutable
@JsonSerializable(ignoreUnannotated: false)
class Data extends Equatable {
  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'imageURl')
  final String? imageURl;
  @JsonKey(name: 'rate')
  final double? rate;
  @JsonKey(name: 'rateCount')
  final int? rateCount;

  const Data({
    this.name,
    this.imageURl,
    this.rate,
    this.rateCount,
  });

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);

  @override
  List<Object?> get props => [name, imageURl, rate, rateCount];
}
