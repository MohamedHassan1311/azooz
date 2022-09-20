// import 'package:equatable/equatable.dart';
// import 'package:flutter/material.dart';
// import 'package:json_annotation/json_annotation.dart';

// part 'store_model.g.dart';

// @immutable
// @JsonSerializable(ignoreUnannotated: false)
// class StoreModel extends Equatable {
//   @JsonKey(name: 'result')
//   final Result? result;
//   @JsonKey(name: 'message')
//   final String? message;

//   const StoreModel({
//     this.result,
//     this.message,
//   });

//   factory StoreModel.fromJson(Map<String, dynamic> json) =>
//       _$StoreModelFromJson(json);

//   Map<String, dynamic> toJson() => _$StoreModelToJson(this);

//   @override
//   List<Object?> get props => [result, message];
// }

// @immutable
// @JsonSerializable(ignoreUnannotated: false)
// class Result extends Equatable {
//   @JsonKey(name: 'store')
//   final Store? store;

//   const Result({
//     this.store,
//   });

//   factory Result.fromJson(Map<String, dynamic> json) => _$ResultFromJson(json);

//   Map<String, dynamic> toJson() => _$ResultToJson(this);

//   @override
//   List<Object?> get props => [store];
// }

// @immutable
// @JsonSerializable(ignoreUnannotated: false)
// class Store extends Equatable {
//   @JsonKey(name: 'id')
//   final int? id;
//   @JsonKey(name: 'name')
//   final String? name;
//   @JsonKey(name: 'time')
//   final double? time;
//   @JsonKey(name: 'rate')
//   final double? rate;
//   @JsonKey(name: 'freeDelivery')
//   final bool? freeDelivery;
//   @JsonKey(name: 'favorite')
//   bool? favorite;
//   @JsonKey(name: 'open')
//   final bool? open;
//   @JsonKey(name: 'imageURls')
//   final List<dynamic>? imagesURL;
//   @JsonKey(name: 'categorys')
//   final List<Category>? categorys;

//   Store({
//     this.id,
//     this.name,
//     this.time,
//     this.rate,
//     this.freeDelivery,
//     this.open,
//     this.categorys,
//     this.favorite,
//     this.imagesURL,
//   });

//   factory Store.fromJson(Map<String, dynamic> json) => _$StoreFromJson(json);

//   Map<String, dynamic> toJson() => _$StoreToJson(this);

//   @override
//   List<Object?> get props =>
//       [id, name, time, rate, freeDelivery, open, categorys];
// }

// @immutable
// @JsonSerializable(ignoreUnannotated: false)
// class Category extends Equatable {
//   @JsonKey(name: 'id')
//   final int? id;
//   @JsonKey(name: 'name')
//   final String? name;
//   @JsonKey(name: 'imageURl')
//   final String? imageURL;

//   const Category({
//     this.id,
//     this.name,
//     this.imageURL,
//   });

//   factory Category.fromJson(Map<String, dynamic> json) =>
//       _$CategoryFromJson(json);

//   Map<String, dynamic> toJson() => _$CategoryToJson(this);

//   @override
//   List<Object?> get props => [id, name, imageURL];
// }

import 'products_model.dart';

class StoreModel {
  Result? result;
  String? message;

  StoreModel({this.result, this.message});

  StoreModel.fromJson(Map<String, dynamic> json) {
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
  Store? store;

  Result({this.store});

  Result.fromJson(Map<String, dynamic> json) {
    store = json['store'] != null ? Store.fromJson(json['store']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (store != null) {
      data['store'] = store!.toJson();
    }
    return data;
  }
}

class Store {
  int? id;
  String? name;
  double? time;
  double? rate;
  bool? freeDelivery;
  bool? open;
  List<String>? imageURls;
  String? logo;
  List<Categorys>? categorys;
  bool? favorite;

  Store(
      {this.id,
      this.name,
      this.time,
      this.rate,
      this.freeDelivery,
      this.open,
      this.imageURls,
      this.logo,
      this.categorys,
      this.favorite});

  Store.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    time = json['time'];
    rate = json['rate'];
    freeDelivery = json['freeDelivery'];
    open = json['open'];
    imageURls = json['imageURls'].cast<String>();
    logo = json['logo'];
    if (json['categorys'] != null) {
      categorys = <Categorys>[];
      json['categorys'].forEach((v) {
        categorys!.add(Categorys.fromJson(v));
      });
    }
    favorite = json['favorite'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['time'] = time;
    data['rate'] = rate;
    data['freeDelivery'] = freeDelivery;
    data['open'] = open;
    data['imageURls'] = imageURls;
    data['logo'] = logo;
    if (categorys != null) {
      data['categorys'] = categorys!.map((v) => v.toJson()).toList();
    }
    data['favorite'] = favorite;
    return data;
  }
}

class Categorys {
  int? id;
  String? name;
  String? imageURl;
  List<CategoryProduct>? product;

  Categorys({this.id, this.name, this.imageURl, this.product});

  Categorys.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    imageURl = json['imageURl'];
    if (json['product'] != null) {
      product = <CategoryProduct>[];
      json['product'].forEach((v) {
        product!.add(CategoryProduct.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['imageURl'] = imageURl;
    if (product != null) {
      data['product'] = product!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

// class CategoryProduct {
//   int? id;
//   String? title;
//   String? description;
//   double? price;
//   String? imageURl;
//   int? stock;

//   CategoryProduct(
//       {this.id,
//       this.title,
//       this.description,
//       this.price,
//       this.imageURl,
//       this.stock});

//   CategoryProduct.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     title = json['title'];
//     description = json['description'];
//     price = json['price'];
//     imageURl = json['imageURl'];
//     stock = json['stock'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['id'] = id;
//     data['title'] = title;
//     data['description'] = description;
//     data['price'] = price;
//     data['imageURl'] = imageURl;
//     data['stock'] = stock;
//     return data;
//   }
// }


