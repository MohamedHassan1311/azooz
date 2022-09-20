class StoreHudModel {
  Result? result;
  String? message;

  StoreHudModel({this.result, this.message});

  StoreHudModel.fromJson(Map<String, dynamic> json) {
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
  OtherUser? otherUser;
  WorkLocation? workLocation;
  WorkLocation? clientlocation;

  Chat({this.id, this.otherUser, this.workLocation, this.clientlocation});

  Chat.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    otherUser = json['otherUser'] != null
        ? OtherUser.fromJson(json['otherUser'])
        : null;
    workLocation = json['workLocation'] != null
        ? WorkLocation.fromJson(json['workLocation'])
        : null;
    clientlocation = json['clientlocation'] != null
        ? WorkLocation.fromJson(json['clientlocation'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (otherUser != null) {
      data['otherUser'] = otherUser!.toJson();
    }
    if (workLocation != null) {
      data['workLocation'] = workLocation!.toJson();
    }
    if (clientlocation != null) {
      data['clientlocation'] = clientlocation!.toJson();
    }
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
