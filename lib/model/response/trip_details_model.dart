import 'package:equatable/equatable.dart';

class TripDetailsModel extends Equatable {
  String? message;
  Result? result;

  TripDetailsModel({
    required this.result,
    required this.message,
  });

  TripDetailsModel.fromJson(Map<String, dynamic> json) {
    result = Result.fromJson(json['result']);
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['result'] = result!.toJson();
    data['message'] = message;
    return data;
  }

  @override
  List<Object?> get props => [
        result,
        message,
      ];
}

class Result {
  ClientTripDetails? orders;

  Result({required this.orders});

  Result.fromJson(Map<String, dynamic> json) {
    orders = ClientTripDetails.fromJson(json['orders']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['orders'] = orders!.toJson();
    return data;
  }
}

class ClientTripDetails {
  int? id;
  int? orderType;
  Status? status;
  Store? store;
  DeliveryAddress? deliveryAddress;
  String? createdAt;
  String? duration;
  String? details;
  List<dynamic>? products;
  String? goodsTransferMessage;
  String? delayedTripDate;

  ClientTripDetails({
    required this.id,
    required this.orderType,
    required this.status,
    required this.store,
    required this.deliveryAddress,
    required this.createdAt,
    required this.duration,
    required this.details,
    required this.products,
    required this.goodsTransferMessage,
    required this.delayedTripDate,
  });

  ClientTripDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderType = json['orderType'];
    status = Status.fromJson(json['status']);
    store = Store.fromJson(json['store']);
    deliveryAddress = DeliveryAddress.fromJson(json['deliveryAddress']);
    createdAt = json['createdAt'];
    duration = json['duration'];
    details = json['details'];
    if (json['products'] != null) {
      products = <Null>[];
      json['products'].forEach((v) {
        products!.add(v);
      });
    }
    goodsTransferMessage = json['goodsTransferMessage'];
    delayedTripDate = json['delayedTripDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['orderType'] = orderType;
    data['status'] = status!.toJson();
    data['store'] = store!.toJson();
    data['deliveryAddress'] = deliveryAddress!.toJson();
    data['createdAt'] = createdAt;
    data['duration'] = duration;
    data['details'] = details;
    data['products'] = products!.map((v) => v.toJson()).toList();
    data['goodsTransferMessage'] = goodsTransferMessage;
    data['delayedTripDate'] = delayedTripDate;
    return data;
  }
}

class Status {
  int? id;
  String? name;

  Status({required this.id, required this.name});

  Status.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}

class Store {
  Details? details;
  Details? location;

  Store({required this.details, required this.location});

  Store.fromJson(Map<String, dynamic> json) {
    details =
        json['details'] != null ? Details.fromJson(json['details']) : null;
    location =
        json['location'] != null ? Details.fromJson(json['location']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['details'] = details!.toJson();
    data['location'] = location!.toJson();
    return data;
  }
}

class Details {
  Details();

  Details.fromJson(Map<String, dynamic> json);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    return data;
  }
}

class DeliveryAddress {
  double? lat;
  double? lng;
  double? toLat;
  double? toLng;
  String? details;
  String? toDetails;

  DeliveryAddress(
      {this.lat,
      this.lng,
      this.toLat,
      this.toLng,
      this.details,
      this.toDetails});

  DeliveryAddress.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    lng = json['lng'];
    toLat = json['toLat'];
    toLng = json['toLng'];
    details = json['details'];
    toDetails = json['toDetails'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['lat'] = lat;
    data['lng'] = lng;
    data['toLat'] = toLat;
    data['toLng'] = toLng;
    data['details'] = details;
    data['toDetails'] = toDetails;
    return data;
  }
}
