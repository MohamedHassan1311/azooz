// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginModel _$LoginModelFromJson(Map<String, dynamic> json) => LoginModel(
      result: json['result'] == null
          ? null
          : Result.fromJson(json['result'] as Map<String, dynamic>),
      message: json['message'] as String?,
    );

Map<String, dynamic> _$LoginModelToJson(LoginModel instance) =>
    <String, dynamic>{
      'result': instance.result,
      'message': instance.message,
    };

Result _$ResultFromJson(Map<String, dynamic> json) => Result(
      isProvider: json['isProvider'] as bool?,
      securityCode: json['securityCode'] as int?,
      authorization: json['authorization'] as String?,
      phone: json['phone'] as String?,
    );

Map<String, dynamic> _$ResultToJson(Result instance) => <String, dynamic>{
      'isProvider': instance.isProvider,
      'securityCode': instance.securityCode,
      'authorization': instance.authorization,
      'phone': instance.phone,
    };
