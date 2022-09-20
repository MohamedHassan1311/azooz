// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_smart_departments_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HomeSmartDepartmentsModel _$HomeSmartDepartmentsModelFromJson(
        Map<String, dynamic> json) =>
    HomeSmartDepartmentsModel(
      result: json['result'] == null
          ? null
          : Result.fromJson(json['result'] as Map<String, dynamic>),
      message: json['message'] as String?,
    );

Map<String, dynamic> _$HomeSmartDepartmentsModelToJson(
        HomeSmartDepartmentsModel instance) =>
    <String, dynamic>{
      'result': instance.result,
      'message': instance.message,
    };

Result _$ResultFromJson(Map<String, dynamic> json) => Result(
      smartDepartments: (json['smartDepartments'] as List<dynamic>?)
          ?.map((e) => SmartDepartmentHome.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ResultToJson(Result instance) => <String, dynamic>{
      'smartDepartments': instance.smartDepartments,
    };

SmartDepartmentHome _$SmartDepartmentHomeFromJson(Map<String, dynamic> json) =>
    SmartDepartmentHome(
      id: json['id'] as int?,
      name: json['name'] as String?,
      stores: (json['stores'] as List<dynamic>?)
          ?.map((e) => Store.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SmartDepartmentHomeToJson(
        SmartDepartmentHome instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'stores': instance.stores,
    };

Store _$StoreFromJson(Map<String, dynamic> json) => Store(
      id: json['id'] as int?,
      name: json['name'] as String?,
      distance: json['distance'] as String?,
      time: json['time'] as String?,
      rate: (json['rate'] as num?)?.toDouble(),
      imageURL: json['imageURl'] as String?,
      freeDelivery: json['freeDelivery'] as bool?,
      storeCategory: (json['storeCatogory'] as List<dynamic>?)
          ?.map((e) => StoreCategory.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$StoreToJson(Store instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'distance': instance.distance,
      'time': instance.time,
      'rate': instance.rate,
      'imageURl': instance.imageURL,
      'freeDelivery': instance.freeDelivery,
      'storeCatogory': instance.storeCategory,
    };

StoreCategory _$StoreCategoryFromJson(Map<String, dynamic> json) =>
    StoreCategory(
      name: json['name'] as String?,
    );

Map<String, dynamic> _$StoreCategoryToJson(StoreCategory instance) =>
    <String, dynamic>{
      'name': instance.name,
    };
