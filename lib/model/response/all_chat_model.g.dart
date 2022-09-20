// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'all_chat_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AllChatModel _$AllChatModelFromJson(Map<String, dynamic> json) => AllChatModel(
      result: json['result'] == null
          ? null
          : Result.fromJson(json['result'] as Map<String, dynamic>),
      message: json['message'] as String?,
    );

Map<String, dynamic> _$AllChatModelToJson(AllChatModel instance) =>
    <String, dynamic>{
      'result': instance.result,
      'message': instance.message,
    };

Result _$ResultFromJson(Map<String, dynamic> json) => Result(
      chats: (json['chats'] as List<dynamic>?)
          ?.map((e) => AllChat.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ResultToJson(Result instance) => <String, dynamic>{
      'chats': instance.chats,
    };

AllChat _$AllChatFromJson(Map<String, dynamic> json) => AllChat(
      id: json['id'] as int?,
      orderId: json['orderId'] as int?,
      otherUser: json['otherUser'] == null
          ? null
          : OtherUser.fromJson(json['otherUser'] as Map<String, dynamic>),
      details: json['details'] as String?,
      createAt: json['createAt'] as String?,
    );

Map<String, dynamic> _$AllChatToJson(AllChat instance) => <String, dynamic>{
      'id': instance.id,
      'orderId': instance.orderId,
      'otherUser': instance.otherUser,
      'details': instance.details,
      'createAt': instance.createAt,
    };

OtherUser _$OtherUserFromJson(Map<String, dynamic> json) => OtherUser(
      name: json['name'] as String?,
      imageURl: json['imageURl'] as String?,
      rate: (json['rate'] as num?)?.toDouble(),
      rateCount: json['rateCount'] as int?,
    );

Map<String, dynamic> _$OtherUserToJson(OtherUser instance) => <String, dynamic>{
      'name': instance.name,
      'imageURl': instance.imageURl,
      'rate': instance.rate,
      'rateCount': instance.rateCount,
    };
