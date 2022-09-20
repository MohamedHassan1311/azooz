import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'products_model.g.dart';

@immutable
@JsonSerializable(ignoreUnannotated: false)
class ProductsModel extends Equatable {
  @JsonKey(name: 'result')
  final Result? result;
  @JsonKey(name: 'message')
  final String? message;

  const ProductsModel({
    this.result,
    this.message,
  });

  factory ProductsModel.fromJson(Map<String, dynamic> json) =>
      _$ProductsModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductsModelToJson(this);

  @override
  List<Object?> get props => [result, message];
}

@immutable
@JsonSerializable(ignoreUnannotated: false)
class Result extends Equatable {
  @JsonKey(name: 'product')
  final List<CategoryProduct>? product;

  const Result({
    this.product,
  });

  factory Result.fromJson(Map<String, dynamic> json) => _$ResultFromJson(json);

  Map<String, dynamic> toJson() => _$ResultToJson(this);

  @override
  List<Object?> get props => [product];
}

@immutable
@JsonSerializable(ignoreUnannotated: false)
class CategoryProduct extends Equatable {
  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'title')
  final String? name;
  @JsonKey(name: 'description')
  final String? description;
  @JsonKey(name: 'price')
  final double? price;
  @JsonKey(name: 'imageURl')
  final String? imageURL;
  @JsonKey(name: 'stock')
  final int? stock;
  @JsonKey(name: 'calories')
  final int? calories;

  int quantity;

  CategoryProduct({
    this.id,
    this.name,
    this.description,
    this.price,
    this.imageURL,
    this.stock,
    this.quantity = 0,
    this.calories,
  });

  factory CategoryProduct.fromJson(Map<String, dynamic> json) =>
      _$CategoryProductFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryProductToJson(this);

  @override
  List<Object?> get props =>
      [id, name, description, price, imageURL, stock, quantity, calories];
}
