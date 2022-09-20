// import 'package:equatable/equatable.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/foundation.dart' show immutable;
// import 'package:json_annotation/json_annotation.dart';

// part 'new_create_order_model.g.dart';

// @immutable
// @JsonSerializable()
// class NewCreateOrderModel extends Equatable {
//   @JsonKey(name: 'details')
//   final String? details;
//   @JsonKey(name: 'durationId')
//   final int? durationId;
//   @JsonKey(name: 'clientLocation')
//   final Map<String, dynamic>? clientLocation;
//   @JsonKey(name: 'products')
//   final Map<String, dynamic>? products;
//   @JsonKey(name: 'couponCode')
//   final String? couponCode;
//   @JsonKey(name: 'storeId')
//   final String? storeId;

//   const NewCreateOrderModel({
//     required this.details,
//     required this.durationId,
//     required this.clientLocation,
//     required this.products,
//     required this.couponCode,
//     required this.storeId,
//   });

//   factory NewCreateOrderModel.fromJson(Map<String, dynamic> json) =>
//       _$NewCreateOrderModelFromJson(json);

//   Map<String, dynamic> toJson() => _$NewCreateOrderModelToJson(this);

//   @override
//   List<Object?> get props => [
//         details,
//         durationId,
//         clientLocation,
//         products,
//         couponCode,
//         storeId,
//       ];
// }
