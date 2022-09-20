import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class MakeOrderArgument extends Equatable {
  final int? id;
  final String? name;

  const MakeOrderArgument({
    this.id,
    this.name,
  });

  @override
  List<Object?> get props => [id, name];
}
