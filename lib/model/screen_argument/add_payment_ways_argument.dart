import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class AddPaymentWaysArgument extends Equatable {
  final bool? isNew;
  final int? id;
  final String? fullName;
  final String? number;
  final String? month;
  final String? year;
  final String? expiredDate;

  const AddPaymentWaysArgument({
    required this.isNew,
    this.id,
    this.fullName,
    this.number,
    this.month,
    this.year,
    this.expiredDate,
  });

  @override
  List<Object?> get props => [id, fullName, number, month, year, expiredDate];
}
