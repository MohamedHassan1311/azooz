import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class StoreArgument extends Equatable {
  final String? name;
  final int? storeId;

  const StoreArgument({
    this.name,
    this.storeId,
  });

  @override
  List<Object?> get props => [name, storeId];
}
