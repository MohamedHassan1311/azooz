// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reviews_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReviewsModel _$ReviewsModelFromJson(Map<String, dynamic> json) => ReviewsModel(
      result: json['result'] == null
          ? null
          : Result.fromJson(json['result'] as Map<String, dynamic>),
      message: json['message'] as String?,
    );

Map<String, dynamic> _$ReviewsModelToJson(ReviewsModel instance) =>
    <String, dynamic>{
      'result': instance.result,
      'message': instance.message,
    };

Result _$ResultFromJson(Map<String, dynamic> json) => Result(
      reviews: (json['reviews'] as List<dynamic>?)
          ?.map((e) => Review.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ResultToJson(Result instance) => <String, dynamic>{
      'reviews': instance.reviews,
    };

Review _$ReviewFromJson(Map<String, dynamic> json) => Review(
      rate: (json['rate'] as num?)?.toDouble(),
      from: json['from'] == null
          ? null
          : From.fromJson(json['from'] as Map<String, dynamic>),
      comment: json['comment'] as String?,
    );

Map<String, dynamic> _$ReviewToJson(Review instance) => <String, dynamic>{
      'rate': instance.rate,
      'from': instance.from,
      'comment': instance.comment,
    };

From _$FromFromJson(Map<String, dynamic> json) => From(
      name: json['name'] as String?,
      imageURl: json['imageURl'] as String?,
      rate: (json['rate'] as num?)?.toDouble(),
      rateCount: json['rateCount'] as int?,
    );

Map<String, dynamic> _$FromToJson(From instance) => <String, dynamic>{
      'name': instance.name,
      'imageURl': instance.imageURl,
      'rate': instance.rate,
      'rateCount': instance.rateCount,
    };
