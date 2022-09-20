import '../common/config/tools.dart';
import '../model/error_model.dart';
import '../model/mixin/department_mixin.dart';
import '../model/response/departments_model.dart';
import '../service/network/api_provider.dart';
import '../service/network/url_constants.dart';
import '../utils/delay.dart';
import '../utils/dialogs.dart';
import '../utils/easy_loading_functions.dart';
import 'package:flutter/material.dart';

class DepartmentProvider extends ChangeNotifier with DepartmentMixin {
  final ApiProvider _apiProvider = ApiProvider.internal();
  late ErrorModel _errorModel;
  late DepartmentsModel _departmentsModel;

  @override
  Future<DepartmentsModel> getDepartments({
    required BuildContext context,
  }) async {
    await _apiProvider.get(
      apiRoute: departmentURL,
      successResponse: (response) {
        _departmentsModel = DepartmentsModel.fromJson(response);
        notifyListeners();
      },
      errorResponse: (response) {
        _errorModel = ErrorModel.fromJson(response);
        dismissLoading().whenComplete(
          () => delayMilliseconds(
            250,
            () => errorDialog(context, _errorModel.message),
          ),
        );
        logger.e(response);
        notifyListeners();
      },
    );
    return _departmentsModel;
  }

  DepartmentsModel get departmentsModel => _departmentsModel;
}
