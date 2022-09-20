class ChatModel {
  Result? result;
  String? message;

  ChatModel({this.result, this.message});

  ChatModel.fromJson(Map<String, dynamic> json) {
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
  Chat? chat;

  Result({this.chat});

  Result.fromJson(Map<String, dynamic> json) {
    chat = json['chat'] != null ? Chat.fromJson(json['chat']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (chat != null) {
      data['chat'] = chat!.toJson();
    }
    return data;
  }
}

class Chat {
  int? id;
  int? orderId;
  OtherUser? otherUser;
  int? tabsInd;
  bool? clientCanPay;
  bool? driverCanRecive;
  int? orderType;
  WorkLocation? workLocation;
  WorkLocation? driverlocation;
  String? carNumber;
  String? carModel;
  double? offerPrice;
  bool? marsol;
  double? amount;
  double? amountToPay;
  int? orderpaymentTypeId;

  Chat(
      {this.id,
      this.orderId,
      this.otherUser,
      this.tabsInd,
      this.clientCanPay,
      this.driverCanRecive,
      this.orderType,
      this.workLocation,
      this.driverlocation,
      this.carNumber,
      this.carModel,
      this.offerPrice,
      this.marsol,
      this.amount,
      this.amountToPay,
      this.orderpaymentTypeId});

  Chat.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderId = json['orderId'];
    otherUser = json['otherUser'] != null
        ? OtherUser.fromJson(json['otherUser'])
        : null;
    tabsInd = json['tabsInd'];
    clientCanPay = json['clientCanPay'];
    driverCanRecive = json['driverCanRecive'];
    orderType = json['orderType'];
    workLocation = json['workLocation'] != null
        ? WorkLocation.fromJson(json['workLocation'])
        : null;
    driverlocation = json['driverlocation'] != null
        ? WorkLocation.fromJson(json['driverlocation'])
        : null;
    carNumber = json['carNumber'];
    carModel = json['carModel'];
    offerPrice = json['offerPrice'];
    marsol = json['marsol'];
    amount = json['amount'];
    amountToPay = json['amountToPay'];
    orderpaymentTypeId = json['orderpaymentTypeId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['orderId'] = orderId;
    if (otherUser != null) {
      data['otherUser'] = otherUser!.toJson();
    }
    data['tabsInd'] = tabsInd;
    data['clientCanPay'] = clientCanPay;
    data['driverCanRecive'] = driverCanRecive;
    data['orderType'] = orderType;
    if (workLocation != null) {
      data['workLocation'] = workLocation!.toJson();
    }
    if (driverlocation != null) {
      data['driverlocation'] = driverlocation!.toJson();
    }
    data['carNumber'] = carNumber;
    data['carModel'] = carModel;
    data['offerPrice'] = offerPrice;
    data['marsol'] = marsol;
    data['amount'] = amount;
    data['amountToPay'] = amountToPay;
    data['orderpaymentTypeId'] = orderpaymentTypeId;
    return data;
  }
}

class OtherUser {
  Data? data;
  String? phone;

  OtherUser({this.data, this.phone});

  OtherUser.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['phone'] = phone;
    return data;
  }
}

class Data {
  String? name;
  String? imageURl;
  double? rate;
  int? rateCount;
  String? phone;

  Data({this.name, this.imageURl, this.rate, this.rateCount, this.phone});

  Data.fromJson(Map<String, dynamic> json) {
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

class WorkLocation {
  double? lat;
  double? lng;

  WorkLocation({this.lat, this.lng});

  WorkLocation.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    lng = json['lng'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['lat'] = lat;
    data['lng'] = lng;
    return data;
  }
}
