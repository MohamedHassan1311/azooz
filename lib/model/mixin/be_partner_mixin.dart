import 'package:flutter/material.dart';

mixin BePartnerMixin {
  Future<void> postData({
    required String? name,
    required String? description,
    required String? email,
    required String? phone,
    required String? nationalID,
    required String? cityID,
    required String? bankID,
    required String? departmentId,
    required String? iban,
    required String? commercialRegistrationNo,
    required String? imagePath,
    required String? taxNumber,
    required BuildContext context,
  });

  regionSelect(newValue);

  citySelect(newValue);

  bankSelect(newValue);

  departmentSelect(newValue);

  disposeData();
}
