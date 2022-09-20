// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfileModel _$ProfileModelFromJson(Map<String, dynamic> json) => ProfileModel(
      result: json['result'] == null
          ? null
          : Result.fromJson(json['result'] as Map<String, dynamic>),
      message: json['message'] as String?,
    );

Map<String, dynamic> _$ProfileModelToJson(ProfileModel instance) =>
    <String, dynamic>{
      'result': instance.result,
      'message': instance.message,
    };

Result _$ResultFromJson(Map<String, dynamic> json) => Result(
      user: json['user'] == null
          ? null
          : User.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ResultToJson(Result instance) => <String, dynamic>{
      'user': instance.user,
    };

User _$UserFromJson(Map<String, dynamic> json) => User(
      id: json['id'] as String?,
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      email: json['email'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      birthDate: json['birthDate'] as String?,
      gender: json['gender'] == null
          ? null
          : Gender.fromJson(json['gender'] as Map<String, dynamic>),
      imageURl: json['imageURl'] as String?,
      city: json['city'] == null
          ? null
          : City.fromJson(json['city'] as Map<String, dynamic>),
      region: json['region'] == null
          ? null
          : Region.fromJson(json['region'] as Map<String, dynamic>),
      saudi: json['saudi'] as bool?,
      isDriver: json['isDriver'] as bool?,
      isStore: json['isStore'] as bool?,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'email': instance.email,
      'phoneNumber': instance.phoneNumber,
      'birthDate': instance.birthDate,
      'gender': instance.gender,
      'imageURl': instance.imageURl,
      'city': instance.city,
      'region': instance.region,
      'saudi': instance.saudi,
      'isDriver': instance.isDriver,
      'isStore': instance.isStore,
    };

Gender _$GenderFromJson(Map<String, dynamic> json) => Gender(
      genderID: json['genderID'] as int?,
      name: json['name'] as String?,
    );

Map<String, dynamic> _$GenderToJson(Gender instance) => <String, dynamic>{
      'genderID': instance.genderID,
      'name': instance.name,
    };

City _$CityFromJson(Map<String, dynamic> json) => City(
      cityId: json['cityId'] as int?,
      name: json['name'] as String?,
    );

Map<String, dynamic> _$CityToJson(City instance) => <String, dynamic>{
      'cityId': instance.cityId,
      'name': instance.name,
    };

Region _$RegionFromJson(Map<String, dynamic> json) => Region(
      regionId: json['regionId'] as int?,
      name: json['name'] as String?,
    );

Map<String, dynamic> _$RegionToJson(Region instance) => <String, dynamic>{
      'regionId': instance.regionId,
      'name': instance.name,
    };
