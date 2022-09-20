import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'add_message_customer_service_model.g.dart';

@immutable
@JsonSerializable(ignoreUnannotated: false)
class AddMessageCustomerServiceModel extends Equatable {
  @JsonKey(name: 'textMessage')
  final String? textMessage;
  @JsonKey(name: 'fileMessage')
  final String? fileMessage;
  @JsonKey(name: 'type')
  final int? type;
  @JsonKey(name: 'contactId')
  final int? contactId;

  const AddMessageCustomerServiceModel({
    this.textMessage,
    this.fileMessage,
    this.type,
    this.contactId,
  });

  factory AddMessageCustomerServiceModel.fromJson(Map<String, dynamic> json) =>
      _$AddMessageCustomerServiceModelFromJson(json);

  Map<String, dynamic> toJson() => _$AddMessageCustomerServiceModelToJson(this);

  @override
  List<Object?> get props => [textMessage, fileMessage, type, contactId];
}
