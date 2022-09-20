// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_review_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddReviewModel _$AddReviewModelFromJson(Map<String, dynamic> json) =>
    AddReviewModel(
      orderId: json['orderId'] as int?,
      rate: json['rate'] as int?,
      comment: json['comment'] as String?,
    );

Map<String, dynamic> _$AddReviewModelToJson(AddReviewModel instance) =>
    <String, dynamic>{
      'orderId': instance.orderId,
      'rate': instance.rate,
      'comment': instance.comment,
    };
