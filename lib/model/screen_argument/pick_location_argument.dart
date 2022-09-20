import 'package:equatable/equatable.dart';

class PickLocationArgument extends Equatable{
  final bool? isPickUpTo;

  const PickLocationArgument({
    this.isPickUpTo,
  });

  @override
  List<Object?> get props => [isPickUpTo];


}