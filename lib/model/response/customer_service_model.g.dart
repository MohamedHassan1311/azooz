// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer_service_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CustomerServiceModel _$CustomerServiceModelFromJson(
        Map<String, dynamic> json) =>
    CustomerServiceModel(
      result: json['result'] == null
          ? null
          : Result.fromJson(json['result'] as Map<String, dynamic>),
      message: json['message'] as String?,
    );

Map<String, dynamic> _$CustomerServiceModelToJson(
        CustomerServiceModel instance) =>
    <String, dynamic>{
      'result': instance.result,
      'message': instance.message,
    };

Result _$ResultFromJson(Map<String, dynamic> json) => Result(
      chatId: json['chatId'] as int?,
      otherUser: json['otherUser'] == null
          ? null
          : OtherUser.fromJson(json['otherUser'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ResultToJson(Result instance) => <String, dynamic>{
      'chatId': instance.chatId,
      'otherUser': instance.otherUser,
    };

OtherUser _$OtherUserFromJson(Map<String, dynamic> json) => OtherUser(
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
      phone: json['phone'] as String?,
    );

Map<String, dynamic> _$OtherUserToJson(OtherUser instance) => <String, dynamic>{
      'data': instance.data,
      'phone': instance.phone,
    };

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      name: json['name'] as String?,
      imageURl: json['imageURl'] as String?,
      rate: (json['rate'] as num?)?.toDouble(),
      rateCount: json['rateCount'] as int?,
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'name': instance.name,
      'imageURl': instance.imageURl,
      'rate': instance.rate,
      'rateCount': instance.rateCount,
    };
