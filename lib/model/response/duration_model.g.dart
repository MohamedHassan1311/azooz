// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'duration_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DurationModel _$DurationModelFromJson(Map<String, dynamic> json) =>
    DurationModel(
      result: json['result'] == null
          ? null
          : Result.fromJson(json['result'] as Map<String, dynamic>),
      message: json['message'] as String?,
    );

Map<String, dynamic> _$DurationModelToJson(DurationModel instance) =>
    <String, dynamic>{
      'result': instance.result,
      'message': instance.message,
    };

Result _$ResultFromJson(Map<String, dynamic> json) => Result(
      durations: (json['durations'] as List<dynamic>?)
          ?.map((e) => Durationi.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ResultToJson(Result instance) => <String, dynamic>{
      'durations': instance.durations,
    };

Durationi _$DurationiFromJson(Map<String, dynamic> json) => Durationi(
      id: json['id'] as int?,
      name: json['name'] as String?,
    );

Map<String, dynamic> _$DurationiToJson(Durationi instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };
