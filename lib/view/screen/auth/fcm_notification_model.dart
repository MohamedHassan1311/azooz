import 'dart:convert';

class FCMNotificationModel {
  String? orderID;
  String? sound;
  Details? details;
  String? media;
  String? notificationType;
  String? priority;
  String? body;
  String? title;
  String? clickAction;
  String? messageType;
  String? chatId;

  FCMNotificationModel({
    this.orderID,
    this.sound,
    this.details,
    this.media,
    this.notificationType,
    this.priority,
    this.body,
    this.title,
    this.clickAction,
    this.messageType,
    this.chatId,
  });

  FCMNotificationModel.fromJson(Map<String, dynamic> json) {
    orderID = json['orderID'];
    sound = json['sound'];
    details = json['details'] != null
        ? Details.fromJson(jsonDecode((json['details'])))
        : null;
    media = json['media'];
    notificationType = json['notificationType'];
    priority = json['priority'];
    body = json['body'];
    title = json['title'];
    clickAction = json['click_action'];
    messageType = json['MessageType'];
    chatId = json['ChatId'];
  }

  FCMNotificationModel.fromPayload(Map<String, dynamic> json) {
    orderID = json['orderID'];
    sound = json['sound'];
    details =
        json['details'] != null ? Details.fromJson((json['details'])) : null;
    media = json['media'];
    notificationType = json['notificationType'];
    priority = json['priority'];
    body = json['body'];
    title = json['title'];
    clickAction = json['click_action'];
    messageType = json['MessageType'];
    chatId = json['ChatId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['orderID'] = orderID;
    data['sound'] = sound;
    if (details != null) {
      data['details'] = details!.toJson();
    }
    data['media'] = media;
    data['notificationType'] = notificationType;
    data['priority'] = priority;
    data['body'] = body;
    data['title'] = title;
    data['click_action'] = clickAction;
    data['MessageType'] = messageType;
    data['ChatId'] = chatId;
    return data;
  }

  String toJsonString() => jsonEncode(toJson());
}

class Details {
  String? orderDetails;
  int? orderType;
  double? price;
  String? createdAt;
  DeliveryAddress? deliveryAddress;
  Client? client;
  Store? store;

  Details(
      {this.orderDetails,
      this.orderType,
      this.price,
      this.createdAt,
      this.deliveryAddress,
      this.client,
      this.store});

  Details.fromJson(Map<String, dynamic> json) {
    orderDetails = json['orderDetails'];
    orderType = json['orderType'];
    price = json['price'];
    createdAt = json['CreatedAt'];
    deliveryAddress = json['DeliveryAddress'] != null
        ? DeliveryAddress.fromJson(json['DeliveryAddress'])
        : null;
    client = json['client'] != null ? Client.fromJson(json['client']) : null;
    store = json['store'] != null ? Store.fromJson(json['store']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['orderDetails'] = orderDetails;
    data['orderType'] = orderType;
    data['price'] = price;
    data['CreatedAt'] = createdAt;
    if (deliveryAddress != null) {
      data['DeliveryAddress'] = deliveryAddress!.toJson();
    }
    if (client != null) {
      data['client'] = client!.toJson();
    }
    if (store != null) {
      data['store'] = store!.toJson();
    }
    return data;
  }
}

class DeliveryAddress {
  String? toDetails;
  double? toLat;
  String? details;
  double? lng;
  double? toLng;
  double? lat;

  DeliveryAddress(
      {this.toDetails,
      this.toLat,
      this.details,
      this.lng,
      this.toLng,
      this.lat});

  DeliveryAddress.fromJson(Map<String, dynamic> json) {
    toDetails = json['toDetails'];
    toLat = json['toLat'];
    details = json['Details'];
    lng = json['Lng'];
    toLng = json['toLng'];
    lat = json['Lat'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['toDetails'] = toDetails;
    data['toLat'] = toLat;
    data['Details'] = details;
    data['Lng'] = lng;
    data['toLng'] = toLng;
    data['Lat'] = lat;
    return data;
  }
}

class Client {
  int? rateCount;
  String? phone;
  double? rate;
  String? imageURl;
  String? name;

  Client({this.rateCount, this.phone, this.rate, this.imageURl, this.name});

  Client.fromJson(Map<String, dynamic> json) {
    rateCount = json['RateCount'];
    phone = json['phone'];
    rate = json['Rate'];
    imageURl = json['ImageURl'];
    name = json['Name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['RateCount'] = rateCount;
    data['phone'] = phone;
    data['Rate'] = rate;
    data['ImageURl'] = imageURl;
    data['Name'] = name;
    return data;
  }
}

class Store {
  String? name;

  Store({this.name});

  Store.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    return data;
  }
}
