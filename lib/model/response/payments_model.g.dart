// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payments_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentsModel _$PaymentsModelFromJson(Map<String, dynamic> json) =>
    PaymentsModel(
      result: json['result'] == null
          ? null
          : Result.fromJson(json['result'] as Map<String, dynamic>),
      message: json['message'] as String?,
    );

Map<String, dynamic> _$PaymentsModelToJson(PaymentsModel instance) =>
    <String, dynamic>{
      'result': instance.result,
      'message': instance.message,
    };

Result _$ResultFromJson(Map<String, dynamic> json) => Result(
      cards: (json['cards'] as List<dynamic>?)
          ?.map((e) => CardDetails.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ResultToJson(Result instance) => <String, dynamic>{
      'cards': instance.cards,
    };

CardDetails _$CardDetailsFromJson(Map<String, dynamic> json) => CardDetails(
      id: json['id'] as int?,
      fullName: json['fullName'] as String,
      number: json['number'] as String,
      month: json['month'] as String?,
      year: json['year'] as String?,
      expiredDate: json['expiredDate'] as String?,
    );

Map<String, dynamic> _$CardDetailsToJson(CardDetails instance) =>
    <String, dynamic>{
      'id': instance.id,
      'fullName': instance.fullName,
      'number': instance.number,
      'month': instance.month,
      'year': instance.year,
      'expiredDate': instance.expiredDate,
    };
