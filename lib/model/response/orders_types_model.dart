import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:json_annotation/json_annotation.dart';
part 'orders_types_model.g.dart';

@immutable
@JsonSerializable()
class OrdersTypesModel extends Equatable {
  @JsonKey(name: 'name')
  String? name;
  @JsonKey(name: 'type')
  int? type;

  OrdersTypesModel({
    this.name,
    this.type,
  });

  factory OrdersTypesModel.fromJson(Map<String, dynamic> json) {
    return OrdersTypesModel(
      name: json['name'],
      type: json['type'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'type': type,
    };
  }

  @override
  List<Object?> get props => [name, type];
}
