// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fcm_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FcmModel _$FcmModelFromJson(Map<String, dynamic> json) => FcmModel(
      fcm: json['fcm'] as String?,
      mobileType: json['mobileType'] as String?,
      mobileID: json['mobileID'] as String?,
      userRule: json['userRule'] as int?,
    );

Map<String, dynamic> _$FcmModelToJson(FcmModel instance) => <String, dynamic>{
      'fcm': instance.fcm,
      'mobileType': instance.mobileType,
      'mobileID': instance.mobileID,
      'userRule': instance.userRule,
    };
