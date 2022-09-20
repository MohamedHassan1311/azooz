import 'package:flutter/material.dart';

import '../response/departments_model.dart';

mixin DepartmentMixin {
  Future<DepartmentsModel> getDepartments({
    required BuildContext context,
  });
}
