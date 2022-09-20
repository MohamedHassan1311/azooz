class DriverOffersModel {
  Result? result;
  String? msg;

  DriverOffersModel({this.result, this.msg});

  DriverOffersModel.fromJson(Map<String, dynamic> json) {
    result = json['result'] != null ? Result.fromJson(json['result']) : null;
    msg = json['msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (result != null) {
      data['result'] = result!.toJson();
    }
    data['msg'] = msg;
    return data;
  }
}

class Result {
  List<DriverOffers>? offers;

  Result({this.offers});

  Result.fromJson(Map<String, dynamic> json) {
    if (json['offers'] != null) {
      offers = <DriverOffers>[];
      json['offers'].forEach((v) {
        offers!.add(DriverOffers.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (offers != null) {
      data['offers'] = offers!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DriverOffers {
  int? id;
  DriverProvider? provider;
  double? price;
  bool? discount;
  double? distance;
  CarData? carData;

  DriverOffers({
    required this.id,
    this.provider,
    this.price,
    this.discount,
    this.distance,
    this.carData,
  });

  DriverOffers.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    provider = json['provider'] != null
        ? DriverProvider.fromJson(json['provider'])
        : null;
    price = json['price'];
    discount = json['discount'];
    distance = json['distance'];
    carData =
        json['carData'] != null ? CarData.fromJson(json['carData']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (provider != null) {
      data['provider'] = provider!.toJson();
    }
    data['price'] = price;
    data['discount'] = discount;
    data['distance'] = distance;
    if (carData != null) {
      data['carData'] = carData!.toJson();
    }
    return data;
  }
}

class DriverProvider {
  String? name;
  String? imageURl;
  double? rate;
  int? rateCount;
  String? phone;

  DriverProvider(
      {this.name, this.imageURl, this.rate, this.rateCount, this.phone});

  DriverProvider.fromJson(Map<String, dynamic> json) {
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

class CarData {
  String? number;
  String? model;
  int? manufacturingyear;

  CarData({this.number, this.model, this.manufacturingyear});

  CarData.fromJson(Map<String, dynamic> json) {
    number = json['number'];
    model = json['model'];
    manufacturingyear = json['manufacturingyear'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['number'] = number;
    data['model'] = model;
    data['manufacturingyear'] = manufacturingyear;
    return data;
  }
}
