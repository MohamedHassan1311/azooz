// // GENERATED CODE - DO NOT MODIFY BY HAND

// part of 'order_details_model.dart';

// // **************************************************************************
// // JsonSerializableGenerator
// // **************************************************************************

// OrderDetailsModel _$OrderDetailsModelFromJson(Map<String, dynamic> json) =>
//     OrderDetailsModel(
//       result: json['result'] == null
//           ? null
//           : Result.fromJson(json['result'] as Map<String, dynamic>),
//       message: json['message'] as String?,
//     );

// Map<String, dynamic> _$OrderDetailsModelToJson(OrderDetailsModel instance) =>
//     <String, dynamic>{
//       'result': instance.result,
//       'message': instance.message,
//     };

// Result _$ResultFromJson(Map<String, dynamic> json) => Result(
//       orders: json['orders'] == null
//           ? null
//           : Orders.fromJson(json['orders'] as Map<String, dynamic>),
//     );

// Map<String, dynamic> _$ResultToJson(Result instance) => <String, dynamic>{
//       'orders': instance.orders,
//     };

// Orders _$OrdersFromJson(Map<String, dynamic> json) => Orders(
//       id: json['id'] as int?,
//       status: json['status'] == null
//           ? null
//           : Status.fromJson(json['status'] as Map<String, dynamic>),
//       store: json['store'] == null
//           ? null
//           : Store.fromJson(json['store'] as Map<String, dynamic>),
//       deliveryAddress: json['deliveryAddress'] == null
//           ? null
//           : DeliveryAddress.fromJson(
//               json['deliveryAddress'] as Map<String, dynamic>),
//       createdAt: json['createdAt'] as String?,
//       duration: json['duration'] as String?,
//       details: json['details'] as String?,
//     );

// Map<String, dynamic> _$OrdersToJson(Orders instance) => <String, dynamic>{
//       'id': instance.id,
//       'status': instance.status,
//       'store': instance.store,
//       'deliveryAddress': instance.deliveryAddress,
//       'createdAt': instance.createdAt,
//       'duration': instance.duration,
//       'details': instance.details,
//     };

// Status _$StatusFromJson(Map<String, dynamic> json) => Status(
//       id: json['id'] as int?,
//       name: json['name'] as String?,
//     );

// Map<String, dynamic> _$StatusToJson(Status instance) => <String, dynamic>{
//       'id': instance.id,
//       'name': instance.name,
//     };

// Store _$StoreFromJson(Map<String, dynamic> json) => Store(
//       details: json['details'] == null
//           ? null
//           : Details.fromJson(json['details'] as Map<String, dynamic>),
//       location: json['location'] == null
//           ? null
//           : Location.fromJson(json['location'] as Map<String, dynamic>),
//     );

// Map<String, dynamic> _$StoreToJson(Store instance) => <String, dynamic>{
//       'details': instance.details,
//       'location': instance.location,
//     };

// Details _$DetailsFromJson(Map<String, dynamic> json) => Details(
//       name: json['name'] as String?,
//       imageURL: json['imageURl'] as String?,
//       rate: (json['rate'] as num?)?.toDouble(),
//       rateCount: json['rateCount'] as int?,
//     );

// Map<String, dynamic> _$DetailsToJson(Details instance) => <String, dynamic>{
//       'name': instance.name,
//       'imageURl': instance.imageURL,
//       'rate': instance.rate,
//       'rateCount': instance.rateCount,
//     };

// Location _$LocationFromJson(Map<String, dynamic> json) => Location(
//       lat: (json['lat'] as num?)?.toDouble(),
//       lng: (json['lng'] as num?)?.toDouble(),
//     );

// Map<String, dynamic> _$LocationToJson(Location instance) => <String, dynamic>{
//       'lat': instance.lat,
//       'lng': instance.lng,
//     };

// DeliveryAddress _$DeliveryAddressFromJson(Map<String, dynamic> json) =>
//     DeliveryAddress(
//       lat: (json['lat'] as num?)?.toDouble(),
//       lng: (json['lng'] as num?)?.toDouble(),
//       details: json['details'] as String?,
//     );

// Map<String, dynamic> _$DeliveryAddressToJson(DeliveryAddress instance) =>
//     <String, dynamic>{
//       'lat': instance.lat,
//       'lng': instance.lng,
//       'details': instance.details,
//     };
