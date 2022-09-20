// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'terms_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TermsModel _$TermsModelFromJson(Map<String, dynamic> json) => TermsModel(
      result: json['result'] == null
          ? null
          : Result.fromJson(json['result'] as Map<String, dynamic>),
      msg: json['msg'] as String?,
    );

Map<String, dynamic> _$TermsModelToJson(TermsModel instance) =>
    <String, dynamic>{
      'result': instance.result,
      'msg': instance.msg,
    };

Result _$ResultFromJson(Map<String, dynamic> json) => Result(
      termsAndPolicies: json['termsAndPolicies'] == null
          ? null
          : TermsAndPolicies.fromJson(
              json['termsAndPolicies'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ResultToJson(Result instance) => <String, dynamic>{
      'termsAndPolicies': instance.termsAndPolicies,
    };

TermsAndPolicies _$TermsAndPoliciesFromJson(Map<String, dynamic> json) =>
    TermsAndPolicies(
      id: json['id'] as int?,
      policy: json['policy'] as String?,
      terms: json['terms'] as String?,
      cTerms: json['cTerms'] as String?,
      aboutUs: json['aboutUs'] as String?,
    );

Map<String, dynamic> _$TermsAndPoliciesToJson(TermsAndPolicies instance) =>
    <String, dynamic>{
      'id': instance.id,
      'policy': instance.policy,
      'terms': instance.terms,
      'cTerms': instance.cTerms,
      'aboutUs': instance.aboutUs,
    };
