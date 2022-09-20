import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'chat_message_model.g.dart';

@immutable
@JsonSerializable(ignoreUnannotated: false)
class ChatMessageModel extends Equatable {
  @JsonKey(name: 'result')
  final Result? result;
  @JsonKey(name: 'message')
  final String? message;

  const ChatMessageModel({
    this.result,
    this.message,
  });

  factory ChatMessageModel.fromJson(Map<String, dynamic> json) =>
      _$ChatMessageModelFromJson(json);

  Map<String, dynamic> toJson() => _$ChatMessageModelToJson(this);

  @override
  List<Object?> get props => [result, message];
}

@immutable
@JsonSerializable(ignoreUnannotated: false)
class Result extends Equatable {
  @JsonKey(name: 'messages')
  final List<Message>? messages;

  const Result({this.messages});

  factory Result.fromJson(Map<String, dynamic> json) => _$ResultFromJson(json);

  Map<String, dynamic> toJson() => _$ResultToJson(this);

  @override
  List<Object?> get props => [messages];
}

@immutable
@JsonSerializable(ignoreUnannotated: false)
class Message extends Equatable {
  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'typeId')
  final int? typeId;
  @JsonKey(name: 'message')
  final String? message;
  @JsonKey(name: 'createdAt')
  final String? createdAt;
  @JsonKey(name: 'fromMe')
  final bool? fromMe;
  @JsonKey(name: 'isRead')
  bool? isRead;

  Message({
    this.id,
    this.typeId,
    this.message,
    this.createdAt,
    this.fromMe,
    this.isRead = true,
  });

  factory Message.fromJson(Map<String, dynamic> json) =>
      _$MessageFromJson(json);

  Map<String, dynamic> toJson() => _$MessageToJson(this);

  @override
  List<Object?> get props => [id, typeId, message, createdAt, fromMe];
}
