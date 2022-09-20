// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'banks_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BanksModel _$BanksModelFromJson(Map<String, dynamic> json) => BanksModel(
      result: json['result'] == null
          ? null
          : Result.fromJson(json['result'] as Map<String, dynamic>),
      msg: json['msg'] as String?,
    );

Map<String, dynamic> _$BanksModelToJson(BanksModel instance) =>
    <String, dynamic>{
      'result': instance.result,
      'msg': instance.msg,
    };

Result _$ResultFromJson(Map<String, dynamic> json) => Result(
      allbanks: (json['allbanks'] as List<dynamic>?)
          ?.map((e) => AllBanks.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ResultToJson(Result instance) => <String, dynamic>{
      'allbanks': instance.allbanks,
    };

AllBanks _$AllBanksFromJson(Map<String, dynamic> json) => AllBanks(
      id: json['id'] as int?,
      name: json['name'] as String?,
    );

Map<String, dynamic> _$AllBanksToJson(AllBanks instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };
