import 'package:flutter/material.dart';

mixin ProfileMixin {
  onSubmitDataPicker( datePicked) {}

  genderSelect(dynamic newValue) {}

  regionSelect(dynamic newValue) {}

  citySelect(dynamic newValue) {}

  pickImage() {}

  editCheck({
    TextEditingController? firstNameController,
    TextEditingController? lastNameController,
    TextEditingController? emailController,
    TextEditingController? phoneController,
  }) {}

  clearItems({
    TextEditingController? firstNameController,
    TextEditingController? lastNameController,
    TextEditingController? emailController,
    TextEditingController? phoneController,
  }) {}

  dynamic putData({
    required String? firstName,
    required String? lastName,
    required String? email,
    required BuildContext context,
    String? imagePath,
  }) {}

  dynamic editProfile({
    required String? firstName,
    required String? lastName,
    required String? email,
    required BuildContext context,
    String? imagePath,
    String? date,
    int? selectedCityID,
    int? selectedGenderID,
  }) {}

  dynamic getData({
    required BuildContext context,
  }) {}
}
