// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'products_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductsModel _$ProductsModelFromJson(Map<String, dynamic> json) =>
    ProductsModel(
      result: json['result'] == null
          ? null
          : Result.fromJson(json['result'] as Map<String, dynamic>),
      message: json['message'] as String?,
    );

Map<String, dynamic> _$ProductsModelToJson(ProductsModel instance) =>
    <String, dynamic>{
      'result': instance.result,
      'message': instance.message,
    };

Result _$ResultFromJson(Map<String, dynamic> json) => Result(
      product: (json['product'] as List<dynamic>?)
          ?.map((e) => CategoryProduct.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ResultToJson(Result instance) => <String, dynamic>{
      'product': instance.product,
    };

CategoryProduct _$CategoryProductFromJson(Map<String, dynamic> json) =>
    CategoryProduct(
      id: json['id'] as int?,
      name: json['title'] as String?,
      description: json['description'] as String?,
      price: (json['price'] as num?)?.toDouble(),
      imageURL: json['imageURl'] as String?,
      stock: json['stock'] as int?,
      quantity: json['quantity'] as int? ?? 0,
      calories: json['calories'] as int?,
    );

Map<String, dynamic> _$CategoryProductToJson(CategoryProduct instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.name,
      'description': instance.description,
      'price': instance.price,
      'imageURl': instance.imageURL,
      'stock': instance.stock,
      'calories': instance.calories,
      'quantity': instance.quantity,
    };
