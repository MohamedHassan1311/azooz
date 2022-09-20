class ClientActiveOrdersModel {
  late Result result;
  late String message;

  ClientActiveOrdersModel({required this.result, required this.message});

  ClientActiveOrdersModel.fromJson(Map<String, dynamic> json) {
    result = Result.fromJson(json['result']);
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['result'] = result.toJson();
    data['message'] = message;
    return data;
  }
}

class Result {
  List<Orders>? orders;

  Result({required this.orders});

  Result.fromJson(Map<String, dynamic> json) {
    if (json['orders'] != null) {
      orders = <Orders>[];
      json['orders'].forEach((v) {
        orders!.add(Orders.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['orders'] = orders!.map((v) => v.toJson()).toList();
    return data;
  }
}

class Orders {
  int? id;
  int? orderType;
  String? goodsTransferMessage;
  String? delayedTripDate;
  int? genderId;
  Client? client;
  String? createdAt;
  String? details;
  double? price;
  String? rate;
  bool? beenShown;

  Orders({
    required this.id,
    required this.orderType,
    required this.goodsTransferMessage,
    required this.delayedTripDate,
    required this.genderId,
    required this.client,
    required this.createdAt,
    required this.details,
    required this.price,
    required this.rate,
    required this.beenShown,
  });

  Orders.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderType = json['orderType'];
    goodsTransferMessage = json['goodsTransferMessage'];
    delayedTripDate = json['delayedTripDate'];
    genderId = json['genderId'];
    client = Client.fromJson(json['client']);
    createdAt = json['createdAt'];
    details = json['details'];
    price = json['price'];
    rate = json['rate'];
    beenShown = json['beenShown'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['orderType'] = orderType;
    data['goodsTransferMessage'] = goodsTransferMessage;
    data['delayedTripDate'] = delayedTripDate;
    data['genderId'] = genderId;
    data['client'] = client!.toJson();
    data['createdAt'] = createdAt;
    data['details'] = details;
    data['price'] = price;
    data['rate'] = rate;
    data['beenShown'] = beenShown;
    return data;
  }
}

class Client {
  Details? details;
  Location? location;

  Client({required this.details, required this.location});

  Client.fromJson(Map<String, dynamic> json) {
    details = Details.fromJson(json['details']);
    location = Location.fromJson(json['location']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['details'] = details!.toJson();
    data['location'] = location!.toJson();
    return data;
  }
}

class Details {
  String? name;
  String? imageURl;
  double? rate;
  int? rateCount;
  String? phone;

  Details({
    required this.name,
    required this.imageURl,
    required this.rate,
    required this.rateCount,
    required this.phone,
  });

  Details.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    imageURl = json['imageURl'];
    rate = json['rate'];
    rateCount = json['rateCount'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['imageURl'] = imageURl;
    data['rate'] = rate;
    data['rateCount'] = rateCount;
    data['phone'] = phone;
    return data;
  }
}

class Location {
  double? fromLat;
  double? fromLng;
  double? toLat;
  double? toLng;
  String? fromLocationDetails;
  String? toLocationDetails;

  Location({
    required this.fromLat,
    required this.fromLng,
    required this.toLat,
    required this.toLng,
    required this.fromLocationDetails,
    required this.toLocationDetails,
  });

  Location.fromJson(Map<String, dynamic> json) {
    fromLat = json['fromLat'];
    fromLng = json['fromLng'];
    toLat = json['toLat'];
    toLng = json['toLng'];
    fromLocationDetails = json['fromLocationDetails'];
    toLocationDetails = json['toLocationDetails'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['fromLat'] = fromLat;
    data['fromLng'] = fromLng;
    data['toLat'] = toLat;
    data['toLng'] = toLng;
    data['fromLocationDetails'] = fromLocationDetails;
    data['toLocationDetails'] = toLocationDetails;
    return data;
  }
}
