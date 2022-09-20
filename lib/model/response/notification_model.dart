import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'notification_model.g.dart';

@immutable
@JsonSerializable(ignoreUnannotated: false)
class NotificationModel extends Equatable {
  @JsonKey(name: 'result')
  final Result? result;
  @JsonKey(name: 'msg')
  final String? msg;

  const NotificationModel({
    this.result,
    this.msg,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationModelFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationModelToJson(this);

  @override
  List<Object?> get props => [result, msg];
}

@immutable
@JsonSerializable(ignoreUnannotated: false)
class Result extends Equatable {
  @JsonKey(name: 'notifications')
  final List<NotificationData>? notifications;

  const Result({
    this.notifications,
  });

  factory Result.fromJson(Map<String, dynamic> json) => _$ResultFromJson(json);

  Map<String, dynamic> toJson() => _$ResultToJson(this);

  @override
  List<Object?> get props => [notifications];
}

@immutable
@JsonSerializable(ignoreUnannotated: false)
class NotificationData extends Equatable {
  @JsonKey(name: 'title')
  final String? title;
  @JsonKey(name: 'message')
  final String? message;
  @JsonKey(name: 'messageType')
  final int? messageType;
  @JsonKey(name: 'notificationType')
  final int? notificationType;
  @JsonKey(name: 'orderId')
  final int? orderId;
  @JsonKey(name: 'from')
  final From? from;
  @JsonKey(name: 'createdAt')
  final String? createdAt;
  @JsonKey(name: 'chatId')
  final int? chatId;

  const NotificationData({
    this.title,
    this.message,
    this.messageType,
    this.notificationType,
    this.orderId,
    this.from,
    this.createdAt,
    this.chatId,
  });

  factory NotificationData.fromJson(Map<String, dynamic> json) =>
      _$NotificationDataFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationDataToJson(this);

  @override
  List<Object?> get props =>
      [title, message, messageType, notificationType, orderId, from, createdAt];
}

@immutable
@JsonSerializable(ignoreUnannotated: false)
class From extends Equatable {
  @JsonKey(name: 'url')
  final String? url;

  const From({
    this.url,
  });

  factory From.fromJson(Map<String, dynamic> json) => _$FromFromJson(json);

  Map<String, dynamic> toJson() => _$FromToJson(this);

  @override
  List<Object?> get props => [url];
}

// class AllNotificationModel {
//   Result? result;
//   String? msg;

//   AllNotificationModel({this.result, this.msg});

//   AllNotificationModel.fromJson(Map<String, dynamic> json) {
//     result = json['result'] != null ? Result.fromJson(json['result']) : null;
//     msg = json['msg'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     if (result != null) {
//       data['result'] = result!.toJson();
//     }
//     data['msg'] = msg;
//     return data;
//   }
// }

// class Result {
//   List<NotificationsResultModel>? notifications;

//   Result({this.notifications});

//   Result.fromJson(Map<String, dynamic> json) {
//     if (json['notifications'] != null) {
//       notifications = <NotificationsResultModel>[];
//       json['notifications'].forEach((v) {
//         notifications!.add(NotificationsResultModel.fromJson(v));
//       });
//     }
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     if (notifications != null) {
//       data['notifications'] = notifications!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }

// class NotificationsResultModel {
//   String? title;
//   String? message;
//   int? messageType;
//   int? notificationType;
//   int? orderId;
//   int? chatId;
//   Details? details;
//   From? from;
//   String? createdAt;

//   NotificationsResultModel(
//       {this.title,
//       this.message,
//       this.messageType,
//       this.notificationType,
//       this.orderId,
//       this.chatId,
//       this.details,
//       this.from,
//       this.createdAt});

//   NotificationsResultModel.fromJson(Map<String, dynamic> json) {
//     title = json['title'];
//     message = json['message'];
//     messageType = json['messageType'];
//     notificationType = json['notificationType'];
//     orderId = json['orderId'];
//     chatId = json['chatId'];
//     details =
//         json['details'] != null ? Details.fromJson(json['details']) : null;
//     from = json['from'] != null ? From.fromJson(json['from']) : null;
//     createdAt = json['createdAt'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['title'] = title;
//     data['message'] = message;
//     data['messageType'] = messageType;
//     data['notificationType'] = notificationType;
//     data['orderId'] = orderId;
//     data['chatId'] = chatId;
//     if (details != null) {
//       data['details'] = details!.toJson();
//     }
//     if (from != null) {
//       data['from'] = from!.toJson();
//     }
//     data['createdAt'] = createdAt;
//     return data;
//   }
// }

// class Details {
//   Client? client;
//   String? orderDetails;
//   int? price;
//   DeliveryAddress? deliveryAddress;
//   String? createdAt;
//   int? orderType;

//   Details(
//       {this.client,
//       this.orderDetails,
//       this.price,
//       this.deliveryAddress,
//       this.createdAt,
//       this.orderType});

//   Details.fromJson(Map<String, dynamic> json) {
//     client = json['client'] != null ? Client.fromJson(json['client']) : null;
//     orderDetails = json['orderDetails'];
//     price = json['price'];
//     deliveryAddress = json['deliveryAddress'] != null
//         ? DeliveryAddress.fromJson(json['deliveryAddress'])
//         : null;
//     createdAt = json['createdAt'];
//     orderType = json['orderType'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     if (client != null) {
//       data['client'] = client!.toJson();
//     }
//     data['orderDetails'] = orderDetails;
//     data['price'] = price;
//     if (deliveryAddress != null) {
//       data['deliveryAddress'] = deliveryAddress!.toJson();
//     }
//     data['createdAt'] = createdAt;
//     data['orderType'] = orderType;
//     return data;
//   }
// }

// class Client {
//   String? name;
//   String? imageURl;
//   int? rate;
//   int? rateCount;
//   String? phone;

//   Client({this.name, this.imageURl, this.rate, this.rateCount, this.phone});

//   Client.fromJson(Map<String, dynamic> json) {
//     name = json['name'];
//     imageURl = json['imageURl'];
//     rate = json['rate'];
//     rateCount = json['rateCount'];
//     phone = json['phone'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['name'] = name;
//     data['imageURl'] = imageURl;
//     data['rate'] = rate;
//     data['rateCount'] = rateCount;
//     data['phone'] = phone;
//     return data;
//   }
// }

// class DeliveryAddress {
//   double? lat;
//   double? lng;
//   double? toLat;
//   double? toLng;
//   String? details;
//   String? toDetails;

//   DeliveryAddress(
//       {this.lat,
//       this.lng,
//       this.toLat,
//       this.toLng,
//       this.details,
//       this.toDetails});

//   DeliveryAddress.fromJson(Map<String, dynamic> json) {
//     lat = json['lat'];
//     lng = json['lng'];
//     toLat = json['toLat'];
//     toLng = json['toLng'];
//     details = json['details'];
//     toDetails = json['toDetails'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['lat'] = lat;
//     data['lng'] = lng;
//     data['toLat'] = toLat;
//     data['toLng'] = toLng;
//     data['details'] = details;
//     data['toDetails'] = toDetails;
//     return data;
//   }
// }

// class From {
//   String? url;

//   From({this.url});

//   From.fromJson(Map<String, dynamic> json) {
//     url = json['url'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['url'] = url;
//     return data;
//   }
// }
