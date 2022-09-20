import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'home_smart_departments_model.g.dart';

@immutable
@JsonSerializable(ignoreUnannotated: false)
class HomeSmartDepartmentsModel extends Equatable {
  @JsonKey(name: 'result')
  final Result? result;
  @JsonKey(name: 'message')
  final String? message;

  const HomeSmartDepartmentsModel({
    this.result,
    this.message,
  });

  factory HomeSmartDepartmentsModel.fromJson(Map<String, dynamic> json) =>
      _$HomeSmartDepartmentsModelFromJson(json);

  Map<String, dynamic> toJson() => _$HomeSmartDepartmentsModelToJson(this);

  @override
  List<Object?> get props => [result, message];
}

@immutable
@JsonSerializable(ignoreUnannotated: false)
class Result extends Equatable {
  @JsonKey(name: 'smartDepartments')
  final List<SmartDepartmentHome>? smartDepartments;

  const Result({
    this.smartDepartments,
  });

  factory Result.fromJson(Map<String, dynamic> json) => _$ResultFromJson(json);

  Map<String, dynamic> toJson() => _$ResultToJson(this);

  @override
  List<Object?> get props => [smartDepartments];
}

@immutable
@JsonSerializable(ignoreUnannotated: false)
class SmartDepartmentHome extends Equatable {
  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'stores')
  final List<Store>? stores;

  const SmartDepartmentHome({
    this.id,
    this.name,
    this.stores,
  });

  factory SmartDepartmentHome.fromJson(Map<String, dynamic> json) =>
      _$SmartDepartmentHomeFromJson(json);

  Map<String, dynamic> toJson() => _$SmartDepartmentHomeToJson(this);

  @override
  List<Object?> get props => [id, name, stores];
}

@immutable
@JsonSerializable(ignoreUnannotated: false)
class Store extends Equatable {
  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'distance')
  final String? distance;
  @JsonKey(name: 'time')
  final String? time;
  @JsonKey(name: 'rate')
  final double? rate;
  @JsonKey(name: 'imageURl')
  final String? imageURL;
  @JsonKey(name: 'freeDelivery')
  final bool? freeDelivery;
  @JsonKey(name: 'storeCatogory')
  final List<StoreCategory>? storeCategory;

  const Store({
    this.id,
    this.name,
    this.distance,
    this.time,
    this.rate,
    this.imageURL,
    this.freeDelivery,
    this.storeCategory,
  });

  factory Store.fromJson(Map<String, dynamic> json) => _$StoreFromJson(json);

  Map<String, dynamic> toJson() => _$StoreToJson(this);

  @override
  List<Object?> get props =>
      [id, name, distance, time, rate, imageURL, freeDelivery, storeCategory];
}

@immutable
@JsonSerializable(ignoreUnannotated: false)
class StoreCategory extends Equatable {
  @JsonKey(name: 'name')
  final String? name;

  const StoreCategory({
    this.name,
  });

  factory StoreCategory.fromJson(Map<String, dynamic> json) =>
      _$StoreCategoryFromJson(json);

  Map<String, dynamic> toJson() => _$StoreCategoryToJson(this);

  @override
  List<Object?> get props => [name];
}
