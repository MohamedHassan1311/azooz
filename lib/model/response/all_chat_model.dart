import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'all_chat_model.g.dart';

@immutable
@JsonSerializable(ignoreUnannotated: false)
class AllChatModel extends Equatable {
  @JsonKey(name: 'result')
  final Result? result;
  @JsonKey(name: 'message')
  final String? message;

  const AllChatModel({
    this.result,
    this.message,
  });

  factory AllChatModel.fromJson(Map<String, dynamic> json) =>
      _$AllChatModelFromJson(json);

  Map<String, dynamic> toJson() => _$AllChatModelToJson(this);

  @override
  List<Object?> get props => [result, message];
}

@immutable
@JsonSerializable(ignoreUnannotated: false)
class Result extends Equatable {
  @JsonKey(name: 'chats')
  final List<AllChat>? chats;

  const Result({
    this.chats,
  });

  factory Result.fromJson(Map<String, dynamic> json) => _$ResultFromJson(json);

  Map<String, dynamic> toJson() => _$ResultToJson(this);

  @override
  List<Object?> get props => [chats];
}

@immutable
@JsonSerializable(ignoreUnannotated: false)
class AllChat extends Equatable {
  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'orderId')
  final int? orderId;
  @JsonKey(name: 'otherUser')
  final OtherUser? otherUser;
  @JsonKey(name: 'details')
  final String? details;
  @JsonKey(name: 'createAt')
  final String? createAt;

  const AllChat({
    this.id,
    this.orderId,
    this.otherUser,
    this.details,
    this.createAt,
  });

  factory AllChat.fromJson(Map<String, dynamic> json) =>
      _$AllChatFromJson(json);

  Map<String, dynamic> toJson() => _$AllChatToJson(this);

  @override
  List<Object?> get props => [id, orderId, otherUser, details, createAt];
}

@immutable
@JsonSerializable(ignoreUnannotated: false)
class OtherUser extends Equatable {
  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'imageURl')
  final String? imageURl;
  @JsonKey(name: 'rate')
  final double? rate;
  @JsonKey(name: 'rateCount')
  final int? rateCount;

  const OtherUser({
    this.name,
    this.imageURl,
    this.rate,
    this.rateCount,
  });

  factory OtherUser.fromJson(Map<String, dynamic> json) =>
      _$OtherUserFromJson(json);

  Map<String, dynamic> toJson() => _$OtherUserToJson(this);

  @override
  List<Object?> get props => [name, imageURl, rateCount, rate];
}
