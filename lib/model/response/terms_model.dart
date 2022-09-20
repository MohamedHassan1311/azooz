import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'terms_model.g.dart';

@immutable
@JsonSerializable(ignoreUnannotated: false)
class TermsModel extends Equatable {
  @JsonKey(name: 'result')
  final Result? result;
  @JsonKey(name: 'msg')
  final String? msg;

  const TermsModel({
    this.result,
    this.msg,
  });

  factory TermsModel.fromJson(Map<String, dynamic> json) =>
      _$TermsModelFromJson(json);

  Map<String, dynamic> toJson() => _$TermsModelToJson(this);

  @override
  List<Object?> get props => [result, msg];
}

@immutable
@JsonSerializable(ignoreUnannotated: false)
class Result extends Equatable {
  @JsonKey(name: 'termsAndPolicies')
  final TermsAndPolicies? termsAndPolicies;

  const Result({
    this.termsAndPolicies,
  });

  factory Result.fromJson(Map<String, dynamic> json) => _$ResultFromJson(json);

  Map<String, dynamic> toJson() => _$ResultToJson(this);

  @override
  List<Object?> get props => [termsAndPolicies];
}

@immutable
@JsonSerializable(ignoreUnannotated: false)
class TermsAndPolicies extends Equatable {
  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'policy')
  final String? policy;
  @JsonKey(name: 'terms')
  final String? terms;
  @JsonKey(name: 'cTerms')
  final String? cTerms;
  @JsonKey(name: 'aboutUs')
  final String? aboutUs;

  const TermsAndPolicies({
    this.id,
    this.policy,
    this.terms,
    this.cTerms,
    this.aboutUs,
  });

  factory TermsAndPolicies.fromJson(Map<String, dynamic> json) =>
      _$TermsAndPoliciesFromJson(json);

  Map<String, dynamic> toJson() => _$TermsAndPoliciesToJson(this);

  @override
  List<Object?> get props => [id, policy, terms, cTerms,aboutUs];
}