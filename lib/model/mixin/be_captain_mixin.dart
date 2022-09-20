import 'package:flutter/material.dart';

mixin BeCaptainMixin {
  Future<void> postData({
    required String? firstName,
    required String? lastName,
    required String? email,
    required String? phone,
    required String? nationalID,
    required String? cityID,
    required String? bankID,
    required String? iban,
    required String? nationalImage,
    required String? taxNumber,
    required bool? isTax,
    required bool? isTransport,
    required String? dateOfBirthHijri,
    required String? vehicleSequenceNumber,
    required String? vehiclePlateLetterRight,
    required String? vehiclePlateLetterMiddle,
    required String? vehiclePlateLetterLeft,
    required String? vehiclePlateNumber,
    required int? driverTypeId,
    required int? carCategoryId,
    required String? vehicleTypeId,
    required String? idTypeIdentifier,
    required int? carModel,
    required String? operatingCard,
    required int? carsKindId,
    required BuildContext context,
  });

  regionSelect(newValue);

  citySelect(newValue);

  bankSelect(newValue);

  disposeData();
}
