import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class TermsAboutAppArgument extends Equatable {
  final bool? isTerms;

  const TermsAboutAppArgument({
    this.isTerms,
  });

  @override
  List<Object?> get props => [isTerms];
}
