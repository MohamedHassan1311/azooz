import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'profile_model.g.dart';

@immutable
@JsonSerializable(ignoreUnannotated: false)
class ProfileModel extends Equatable {
  @JsonKey(name: 'result')
  final Result? result;
  @JsonKey(name: 'message')
  final String? message;

  const ProfileModel({
    this.result,
    this.message,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) =>
      _$ProfileModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileModelToJson(this);

  @override
  List<Object?> get props => [message, result];
}

@immutable
@JsonSerializable(ignoreUnannotated: false)
class Result extends Equatable {
  @JsonKey(name: 'user')
  final User? user;

  const Result({
    this.user,
  });

  factory Result.fromJson(Map<String, dynamic> json) => _$ResultFromJson(json);

  Map<String, dynamic> toJson() => _$ResultToJson(this);

  @override
  List<Object?> get props => [user];
}

@immutable
@JsonSerializable(ignoreUnannotated: false)
class User extends Equatable {
  @JsonKey(name: 'id')
  final String? id;
  @JsonKey(name: 'firstName')
  final String? firstName;
  @JsonKey(name: 'lastName')
  final String? lastName;
  @JsonKey(name: 'email')
  final String? email;
  @JsonKey(name: 'phoneNumber')
  final String? phoneNumber;
  @JsonKey(name: 'birthDate')
  final String? birthDate;
  @JsonKey(name: 'gender')
  final Gender? gender;
  @JsonKey(name: 'imageURl')
  final String? imageURl;
  @JsonKey(name: 'city')
  final City? city;
  @JsonKey(name: 'region')
  final Region? region;
  @JsonKey(name: 'saudi')
  final bool? saudi;
  @JsonKey(name: 'isDriver')
  final bool? isDriver;
  @JsonKey(name: 'isStore')
  final bool? isStore;

  const User({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.phoneNumber,
    this.birthDate,
    this.gender,
    this.imageURl,
    this.city,
    this.region,
    this.saudi,
    this.isDriver,
    this.isStore,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);

  @override
  List<Object?> get props => [
        id,
        firstName,
        lastName,
        email,
        phoneNumber,
        birthDate,
        gender,
        imageURl,
        city,
        region,
        saudi,
        isDriver,
        isStore,
      ];
}

@immutable
@JsonSerializable(ignoreUnannotated: false)
class Gender extends Equatable {
  @JsonKey(name: 'genderID')
  final int? genderID;
  @JsonKey(name: 'name')
  final String? name;

  const Gender({this.genderID, this.name});

  factory Gender.fromJson(Map<String, dynamic> json) => _$GenderFromJson(json);

  Map<String, dynamic> toJson() => _$GenderToJson(this);

  @override
  List<Object?> get props => [genderID, name];
}

@immutable
@JsonSerializable(ignoreUnannotated: false)
class City extends Equatable {
  @JsonKey(name: 'cityId')
  final int? cityId;
  @JsonKey(name: 'name')
  final String? name;

  const City({
    this.cityId,
    this.name,
  });

  factory City.fromJson(Map<String, dynamic> json) => _$CityFromJson(json);

  Map<String, dynamic> toJson() => _$CityToJson(this);

  @override
  List<Object?> get props => [cityId, name];
}

@immutable
@JsonSerializable(ignoreUnannotated: false)
class Region extends Equatable {
  @JsonKey(name: 'regionId')
  final int? regionId;
  @JsonKey(name: 'name')
  final String? name;

  const Region({this.regionId, this.name});

  factory Region.fromJson(Map<String, dynamic> json) => _$RegionFromJson(json);

  Map<String, dynamic> toJson() => _$RegionToJson(this);

  @override
  List<Object?> get props => [regionId, name];
}
