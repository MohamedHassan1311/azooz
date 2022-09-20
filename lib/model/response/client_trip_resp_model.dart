class ClientTripRespModel {
  Result? result;
  String? message;

  ClientTripRespModel({this.result, this.message});

  ClientTripRespModel.fromJson(Map<String, dynamic> json) {
    result = json['result'] != null ? Result.fromJson(json['result']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (result != null) {
      data['result'] = result!.toJson();
    }
    data['message'] = message;
    return data;
  }
}

class Result {
  List<TripOrders>? orders;

  Result({this.orders});

  Result.fromJson(Map<String, dynamic> json) {
    if (json['orders'] != null) {
      orders = <TripOrders>[];
      json['orders'].forEach((v) {
        orders!.add(TripOrders.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (orders != null) {
      data['orders'] = orders!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TripOrders {
  int? id;
  int? orderType;
  String? goodsTransferMessage;
  String? delayedTripDate;
  int? genderId;
  Client? client;
  String? createdAt;
  dynamic details;
  double? price;
  String? rate;
  bool? beenShown;

  TripOrders(
      {this.id,
      this.orderType,
      this.goodsTransferMessage,
      this.delayedTripDate,
      this.genderId,
      this.client,
      this.createdAt,
      this.details,
      this.price,
      this.rate,
      this.beenShown});

  TripOrders.fromJson(Map<String, dynamic> json) {
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
    if (client != null) {
      data['client'] = client!.toJson();
    }
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

  Client({this.details, this.location});

  Client.fromJson(Map<String, dynamic> json) {
    details = Details.fromJson(json['details']);
    location = Location.fromJson(json['location']);
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = <String, dynamic>{};
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

  Details({this.name, this.imageURl, this.rate, this.rateCount, this.phone});

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

  Location(
      {this.fromLat,
      this.fromLng,
      this.toLat,
      this.toLng,
      this.fromLocationDetails,
      this.toLocationDetails});

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
