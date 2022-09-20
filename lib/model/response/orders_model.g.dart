// // GENERATED CODE - DO NOT MODIFY BY HAND

// part of 'orders_model.dart';

// // **************************************************************************
// // JsonSerializableGenerator
// // **************************************************************************

// OrdersModel _$OrdersModelFromJson(Map<String, dynamic> json) => OrdersModel(
//       result: json['result'] == null
//           ? null
//           : Result.fromJson(json['result'] as Map<String, dynamic>),
//       message: json['message'] as String?,
//     );

// Map<String, dynamic> _$OrdersModelToJson(OrdersModel instance) =>
//     <String, dynamic>{
//       'result': instance.result,
//       'message': instance.message,
//     };

// Result _$ResultFromJson(Map<String, dynamic> json) => Result(
//       orders: (json['orders'] as List<dynamic>?)
//           ?.map((e) => Order.fromJson(e as Map<String, dynamic>))
//           .toList(),
//     );

// Map<String, dynamic> _$ResultToJson(Result instance) => <String, dynamic>{
//       'orders': instance.orders,
//     };

// Order _$OrderFromJson(Map<String, dynamic> json) => Order(
//       storeName: json['storeName'] as String?,
//       details: json['details'] as String?,
//       id: json['id'] as int?,
//       offersCount: json['offersCount'] as int?,
//       createdAt: json['createdAt'] as String?,
//       status: json['status'] == null
//           ? null
//           : Status.fromJson(json['status'] as Map<String, dynamic>),
//     );

// Map<String, dynamic> _$OrderToJson(Order instance) => <String, dynamic>{
//       'storeName': instance.storeName,
//       'details': instance.details,
//       'id': instance.id,
//       'offersCount': instance.offersCount,
//       'createdAt': instance.createdAt,
//       'status': instance.status,
//     };

// Status _$StatusFromJson(Map<String, dynamic> json) => Status(
//       id: json['id'] as int?,
//       name: json['name'] as String?,
//     );

// Map<String, dynamic> _$StatusToJson(Status instance) => <String, dynamic>{
//       'id': instance.id,
//       'name': instance.name,
//     };
