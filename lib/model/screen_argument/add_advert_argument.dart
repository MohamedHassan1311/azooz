import 'package:equatable/equatable.dart';

class AddAdvertArgument extends Equatable {
  final int? id;
  final bool? isNew;
  final String? address;
  final String? details;
  final String? contactNumber;
  final double? lat;
  final double? lng;
  final double? price;
  final String? image;

  const AddAdvertArgument({
    this.id,
    this.isNew,
    this.address,
    this.details,
    this.contactNumber,
    this.lat,
    this.lng,
    this.price,
    this.image,
  });

  @override
  List<Object?> get props => [
        id,
        isNew,
        address,
        details,
        contactNumber,
        lat,
        lng,
        price,
        image,
      ];
}
