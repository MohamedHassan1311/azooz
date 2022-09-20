// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationModel _$NotificationModelFromJson(Map<String, dynamic> json) =>
    NotificationModel(
      result: json['result'] == null
          ? null
          : Result.fromJson(json['result'] as Map<String, dynamic>),
      msg: json['msg'] as String?,
    );

Map<String, dynamic> _$NotificationModelToJson(NotificationModel instance) =>
    <String, dynamic>{
      'result': instance.result,
      'msg': instance.msg,
    };

Result _$ResultFromJson(Map<String, dynamic> json) => Result(
      notifications: (json['notifications'] as List<dynamic>?)
          ?.map((e) => NotificationData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ResultToJson(Result instance) => <String, dynamic>{
      'notifications': instance.notifications,
    };

NotificationData _$NotificationDataFromJson(Map<String, dynamic> json) =>
    NotificationData(
      title: json['title'] as String?,
      message: json['message'] as String?,
      messageType: json['messageType'] as int?,
      notificationType: json['notificationType'] as int?,
      orderId: json['orderId'] as int?,
      from: json['from'] == null
          ? null
          : From.fromJson(json['from'] as Map<String, dynamic>),
      createdAt: json['createdAt'] as String?,
      chatId: json['chatId'] as int?,
    );

Map<String, dynamic> _$NotificationDataToJson(NotificationData instance) =>
    <String, dynamic>{
      'title': instance.title,
      'message': instance.message,
      'messageType': instance.messageType,
      'notificationType': instance.notificationType,
      'orderId': instance.orderId,
      'from': instance.from,
      'createdAt': instance.createdAt,
      'chatId': instance.chatId,
    };

From _$FromFromJson(Map<String, dynamic> json) => From(
      url: json['url'] as String?,
    );

Map<String, dynamic> _$FromToJson(From instance) => <String, dynamic>{
      'url': instance.url,
    };
