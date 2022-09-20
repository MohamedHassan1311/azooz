import 'package:flutter/material.dart';

import '../response/gender_model.dart';

mixin GenderMixin {
  Future getGenderData({required BuildContext context});

  setGenderData({required BuildContext context, required UserGender gender});
}
