// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_value_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentValueModel _$PaymentValueModelFromJson(Map<String, dynamic> json) =>
    PaymentValueModel(
      result: json['result'] == null
          ? null
          : Result.fromJson(json['result'] as Map<String, dynamic>),
      message: json['message'] as String?,
    );

Map<String, dynamic> _$PaymentValueModelToJson(PaymentValueModel instance) =>
    <String, dynamic>{
      'result': instance.result,
      'message': instance.message,
    };

Result _$ResultFromJson(Map<String, dynamic> json) => Result(
      paymentValue: (json['paymentValue'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$ResultToJson(Result instance) => <String, dynamic>{
      'paymentValue': instance.paymentValue,
    };
