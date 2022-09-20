import 'package:flutter/material.dart';

mixin HomeMixin {
  getAppStatus({required BuildContext context});

  getHomeDetails({required BuildContext context});

  getAllCategories({
    required BuildContext context,
    required int page,
  });

  getAllDepartments({
    required BuildContext context,
    required int page,
  });

  getAllAds({
    required BuildContext context,
    required int page,
  });

  disposeData();
}
