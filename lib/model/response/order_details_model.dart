// part 'order_details_model.g.dart';

// @immutable
// @JsonSerializable(ignoreUnannotated: false)
// class OrderDetailsModel extends Equatable {
//   @JsonKey(name: 'result')
//   final Result? result;
//   @JsonKey(name: 'message')
//   final String? message;

//   const OrderDetailsModel({
//     this.result,
//     this.message,
//   });

//   factory OrderDetailsModel.fromJson(Map<String, dynamic> json) =>
//       _$OrderDetailsModelFromJson(json);

//   Map<String, dynamic> toJson() => _$OrderDetailsModelToJson(this);

//   @override
//   List<Object?> get props => [result, message];
// }

// @immutable
// @JsonSerializable(ignoreUnannotated: false)
// class Result extends Equatable {
//   @JsonKey(name: 'orders')
//   final Orders? orders;

//   const Result({
//     this.orders,
//   });

//   factory Result.fromJson(Map<String, dynamic> json) => _$ResultFromJson(json);

//   Map<String, dynamic> toJson() => _$ResultToJson(this);

//   @override
//   List<Object?> get props => [orders];
// }

// @immutable
// @JsonSerializable(ignoreUnannotated: false)
// class Orders extends Equatable {
//   @JsonKey(name: 'id')
//   final int? id;
//   @JsonKey(name: 'status')
//   final Status? status;
//   @JsonKey(name: 'store')
//   final Store? store;
//   @JsonKey(name: 'deliveryAddress')
//   final DeliveryAddress? deliveryAddress;
//   @JsonKey(name: 'createdAt')
//   final String? createdAt;
//   @JsonKey(name: 'duration')
//   final String? duration;
//   @JsonKey(name: 'details')
//   final String? details;

//   const Orders({
//     this.id,
//     this.status,
//     this.store,
//     this.deliveryAddress,
//     this.createdAt,
//     this.duration,
//     this.details,
//   });

//   factory Orders.fromJson(Map<String, dynamic> json) => _$OrdersFromJson(json);

//   Map<String, dynamic> toJson() => _$OrdersToJson(this);

//   @override
//   List<Object?> get props => [
//         id,
//         status,
//         store,
//         deliveryAddress,
//         createdAt,
//         duration,
//         details,
//       ];
// }

// @immutable
// @JsonSerializable(ignoreUnannotated: false)
// class Status extends Equatable {
//   @JsonKey(name: 'id')
//   final int? id;
//   @JsonKey(name: 'name')
//   final String? name;

//   const Status({
//     this.id,
//     this.name,
//   });

//   factory Status.fromJson(Map<String, dynamic> json) => _$StatusFromJson(json);

//   Map<String, dynamic> toJson() => _$StatusToJson(this);

//   @override
//   List<Object?> get props => [id, name];
// }

// @immutable
// @JsonSerializable(ignoreUnannotated: false)
// class Store extends Equatable {
//   @JsonKey(name: 'details')
//   final Details? details;
//   @JsonKey(name: 'location')
//   final Location? location;

//   const Store({
//     this.details,
//     this.location,
//   });

//   factory Store.fromJson(Map<String, dynamic> json) => _$StoreFromJson(json);

//   Map<String, dynamic> toJson() => _$StoreToJson(this);

//   @override
//   List<Object?> get props => [details, location];
// }

// @immutable
// @JsonSerializable(ignoreUnannotated: false)
// class Details extends Equatable {
//   @JsonKey(name: 'name')
//   final String? name;
//   @JsonKey(name: 'imageURl')
//   final String? imageURL;
//   @JsonKey(name: 'rate')
//   final double? rate;
//   @JsonKey(name: 'rateCount')
//   final int? rateCount;

//   const Details({
//     this.name,
//     this.imageURL,
//     this.rate,
//     this.rateCount,
//   });

//   factory Details.fromJson(Map<String, dynamic> json) =>
//       _$DetailsFromJson(json);

//   Map<String, dynamic> toJson() => _$DetailsToJson(this);

//   @override
//   List<Object?> get props => [name, imageURL, rate, rateCount];
// }

// @immutable
// @JsonSerializable(ignoreUnannotated: false)
// class Location extends Equatable {
//   @JsonKey(name: 'lat')
//   final double? lat;
//   @JsonKey(name: 'lng')
//   final double? lng;

//   const Location({
//     this.lat,
//     this.lng,
//   });

//   factory Location.fromJson(Map<String, dynamic> json) =>
//       _$LocationFromJson(json);

//   Map<String, dynamic> toJson() => _$LocationToJson(this);

//   @override
//   List<Object?> get props => [lat, lng];
// }

// @immutable
// @JsonSerializable(ignoreUnannotated: false)
// class DeliveryAddress extends Equatable {
//   @JsonKey(name: 'lat')
//   final double? lat;
//   @JsonKey(name: 'lng')
//   final double? lng;
//   @JsonKey(name: 'details')
//   final String? details;

//   const DeliveryAddress({
//     this.lat,
//     this.lng,
//     this.details,
//   });

//   factory DeliveryAddress.fromJson(Map<String, dynamic> json) =>
//       _$DeliveryAddressFromJson(json);

//   Map<String, dynamic> toJson() => _$DeliveryAddressToJson(this);

//   @override
//   List<Object?> get props => [lat, lng, details];
// }

class OrderDetailsModel {
  Result? result;
  String? message;

  OrderDetailsModel({this.result, this.message});

  OrderDetailsModel.fromJson(Map<String, dynamic> json) {
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
  Orders? orders;

  Result({this.orders});

  Result.fromJson(Map<String, dynamic> json) {
    orders = json['orders'] != null ? Orders.fromJson(json['orders']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (orders != null) {
      data['orders'] = orders!.toJson();
    }
    return data;
  }
}

class Orders {
  int? id;
  int? orderType;
  Status? status;
  Store? store;
  DeliveryAddress? deliveryAddress;
  String? createdAt;
  String? duration;
  String? details;
  List<Products>? products;
  String? goodsTransferMessage;
  String? delayedTripDate;
  CarCategory? carCategory;
  CarCategory? carData;

  Orders(
      {this.id,
      this.orderType,
      this.status,
      this.store,
      this.deliveryAddress,
      this.createdAt,
      this.duration,
      this.details,
      this.products,
      this.goodsTransferMessage,
      this.delayedTripDate,
      this.carCategory,
      this.carData});

  Orders.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderType = json['orderType'];
    status = json['status'] != null ? Status.fromJson(json['status']) : null;
    store = json['store'] != null ? Store.fromJson(json['store']) : null;
    deliveryAddress = json['deliveryAddress'] != null
        ? DeliveryAddress.fromJson(json['deliveryAddress'])
        : null;
    createdAt = json['createdAt'];
    duration = json['duration'];
    details = json['details'];
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(Products.fromJson(v));
      });
    }
    goodsTransferMessage = json['goodsTransferMessage'];
    delayedTripDate = json['delayedTripDate'];
    carCategory = json['carCategory'] != null
        ? CarCategory.fromJson(json['carCategory'])
        : null;
    carData =
        json['carData'] != null ? CarCategory.fromJson(json['carData']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['orderType'] = orderType;
    if (status != null) {
      data['status'] = status!.toJson();
    }
    if (store != null) {
      data['store'] = store!.toJson();
    }
    if (deliveryAddress != null) {
      data['deliveryAddress'] = deliveryAddress!.toJson();
    }
    data['createdAt'] = createdAt;
    data['duration'] = duration;
    data['details'] = details;
    if (products != null) {
      data['products'] = products!.map((v) => v.toJson()).toList();
    }
    data['goodsTransferMessage'] = goodsTransferMessage;
    data['delayedTripDate'] = delayedTripDate;
    if (carCategory != null) {
      data['carCategory'] = carCategory!.toJson();
    }
    if (carData != null) {
      data['carData'] = carData!.toJson();
    }
    return data;
  }
}

class Status {
  int? id;
  String? name;

  Status({this.id, this.name});

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
  Location? location;

  Store({this.details, this.location});

  Store.fromJson(Map<String, dynamic> json) {
    details =
        json['details'] != null ? Details.fromJson(json['details']) : null;
    location =
        json['location'] != null ? Location.fromJson(json['location']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (details != null) {
      data['details'] = details!.toJson();
    }
    if (location != null) {
      data['location'] = location!.toJson();
    }
    return data;
  }
}

class Details {
  String? name;
  String? imageURl;
  List<String>? imagesUrls;
  String? logo;
  double? rate;
  int? rateCount;

  Details(
      {this.name,
      this.imageURl,
      this.imagesUrls,
      this.logo,
      this.rate,
      this.rateCount});

  Details.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    imageURl = json['imageURl'];
    imagesUrls = json['imagesUrls'].cast<String>();
    logo = json['logo'];
    rate = json['rate'];
    rateCount = json['rateCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['imageURl'] = imageURl;
    data['imagesUrls'] = imagesUrls;
    data['logo'] = logo;
    data['rate'] = rate;
    data['rateCount'] = rateCount;
    return data;
  }
}

class Location {
  double? lat;
  double? lng;

  Location({this.lat, this.lng});

  Location.fromJson(Map<String, dynamic> json) {
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

class Products {
  int? id;
  String? title;
  int? count;
  int? productId;
  String? imageURl;

  Products({this.id, this.title, this.count, this.productId, this.imageURl});

  Products.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    count = json['count'];
    productId = json['productId'];
    imageURl = json['imageURl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['count'] = count;
    data['productId'] = productId;
    data['imageURl'] = imageURl;
    return data;
  }
}

class CarCategory {
  CarCategory.fromJson(Map<String, dynamic> json);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    return data;
  }
}
