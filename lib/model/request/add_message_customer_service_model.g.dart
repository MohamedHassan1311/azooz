// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_message_customer_service_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddMessageCustomerServiceModel _$AddMessageCustomerServiceModelFromJson(
        Map<String, dynamic> json) =>
    AddMessageCustomerServiceModel(
      textMessage: json['textMessage'] as String?,
      fileMessage: json['fileMessage'] as String?,
      type: json['type'] as int?,
      contactId: json['contactId'] as int?,
    );

Map<String, dynamic> _$AddMessageCustomerServiceModelToJson(
        AddMessageCustomerServiceModel instance) =>
    <String, dynamic>{
      'textMessage': instance.textMessage,
      'fileMessage': instance.fileMessage,
      'type': instance.type,
      'contactId': instance.contactId,
    };
