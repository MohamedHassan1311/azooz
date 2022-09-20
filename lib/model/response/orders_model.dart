// part 'orders_model.g.dart';

// @immutable
// @JsonSerializable(ignoreUnannotated: false)
// class OrdersModel extends Equatable {
//   @JsonKey(name: 'result')
//   final Result? result;
//   @JsonKey(name: 'message')
//   final String? message;

//   const OrdersModel({
//     this.result,
//     this.message,
//   });

//   factory OrdersModel.fromJson(Map<String, dynamic> json) =>
//       _$OrdersModelFromJson(json);

//   Map<String, dynamic> toJson() => _$OrdersModelToJson(this);

//   @override
//   List<Object?> get props => [result, message];
// }

// @immutable
// @JsonSerializable(ignoreUnannotated: false)
// class Result extends Equatable {
//   @JsonKey(name: 'orders')
//   final List<Order>? orders;

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
// class Order extends Equatable {
//   @JsonKey(name: 'storeName')
//   final String? storeName;
//   @JsonKey(name: 'details')
//   final String? details;
//   @JsonKey(name: 'id')
//   final int? id;
//   @JsonKey(name: 'offersCount')
//   final int? offersCount;
//   @JsonKey(name: 'createdAt')
//   final String? createdAt;
//   @JsonKey(name: 'status')
//   final Status? status;

//   const Order({
//     this.storeName,
//     this.details,
//     this.id,
//     this.offersCount,
//     this.createdAt,
//     this.status,
//   });

//   factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);

//   Map<String, dynamic> toJson() => _$OrderToJson(this);

//   @override
//   List<Object?> get props => [
//         storeName,
//         details,
//         id,
//         offersCount,
//         createdAt,
//         status,
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

class OrdersModel {
  Result? result;
  String? message;

  OrdersModel({this.result, this.message});

  OrdersModel.fromJson(Map<String, dynamic> json) {
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
  List<Order>? orders;

  Result({this.orders});

  Result.fromJson(Map<String, dynamic> json) {
    if (json['orders'] != null) {
      orders = <Order>[];
      json['orders'].forEach((v) {
        orders!.add(Order.fromJson(v));
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

class Order {
  String? storeName;
  int? storeType;
  String? details;
  int? orderType;
  int? id;
  int? offersCount;
  String? createdAt;
  Status? status;
  CarData? carData;
  List<Products>? products;

  Order(
      {this.storeName,
      this.storeType,
      this.details,
      this.orderType,
      this.id,
      this.offersCount,
      this.createdAt,
      this.status,
      this.carData,
      this.products});

  Order.fromJson(Map<String, dynamic> json) {
    storeName = json['storeName'];
    storeType = json['storeType'];
    details = json['details'];
    orderType = json['orderType'];
    id = json['id'];
    offersCount = json['offersCount'];
    createdAt = json['createdAt'];
    status = json['status'] != null ? Status.fromJson(json['status']) : null;
    carData =
        json['carData'] != null ? CarData.fromJson(json['carData']) : null;
    if (json['products'] != null && json['products'].isNotEmpty) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(Products.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['storeName'] = storeName;
    data['storeType'] = storeType;
    data['details'] = details;
    data['orderType'] = orderType;
    data['id'] = id;
    data['offersCount'] = offersCount;
    data['createdAt'] = createdAt;
    if (status != null) {
      data['status'] = status!.toJson();
    }
    if (carData != null) {
      data['carData'] = carData!.toJson();
    }
    if (products != null) {
      data['products'] = products!.map((v) => v.toJson()).toList();
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

class CarData {
  CarData.fromJson(Map<String, dynamic> json);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    return data;
  }
}

class Products {
  String? name;
  int? count;

  Products({this.name, this.count});

  Products.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['count'] = count;
    return data;
  }
}
