// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_ads_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HomeAdsModel _$HomeAdsModelFromJson(Map<String, dynamic> json) => HomeAdsModel(
      result: json['result'] == null
          ? null
          : Result.fromJson(json['result'] as Map<String, dynamic>),
      message: json['message'] as String?,
    );

Map<String, dynamic> _$HomeAdsModelToJson(HomeAdsModel instance) =>
    <String, dynamic>{
      'result': instance.result,
      'message': instance.message,
    };

Result _$ResultFromJson(Map<String, dynamic> json) => Result(
      adds: (json['adds'] as List<dynamic>?)
          ?.map((e) => AdHome.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ResultToJson(Result instance) => <String, dynamic>{
      'adds': instance.adds,
    };

AdHome _$AdHomeFromJson(Map<String, dynamic> json) => AdHome(
      imageURL: json['imageURl'] as String?,
    );

Map<String, dynamic> _$AdHomeToJson(AdHome instance) => <String, dynamic>{
      'imageURl': instance.imageURL,
    };
