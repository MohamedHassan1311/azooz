import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class CategoriesArgument extends Equatable {
  final String? name;
  final int id;
  final double? lat;
  final double? lng;

  const CategoriesArgument({
    this.name,
    required this.id,
    this.lat,
    this.lng,
  });

  @override
  List<Object?> get props => [name, id, lat, lng];
}
