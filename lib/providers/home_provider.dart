import 'dart:collection';

import 'package:azooz/common/config/app_status.dart';

import '../common/config/tools.dart';
import '../model/error_model.dart';
import '../model/mixin/home_mixin.dart';
import '../model/response/app_status_model.dart';
import '../model/response/home_ads_model.dart';
import '../model/response/home_departments_model.dart';
import '../model/response/home_model.dart';
import '../service/network/api_provider.dart';
import '../service/network/url_constants.dart';
import '../utils/dialogs.dart';
import 'package:flutter/material.dart';

import '../model/response/home_smart_departments_model.dart';

class HomeProvider extends ChangeNotifier with HomeMixin {
  final ApiProvider _apiProvider = ApiProvider.internal();
  late ErrorModel _errorModel;
  late AppStatusModel _appStatusModel;
  late HomeModel _homeModel;
  List<DepartmentHome> _listCategories = [];
  late HomeDepartmentsModel _homeDepartmentsModel;
  List<SmartDepartmentHome> _listDepartments = [];
  late HomeSmartDepartmentsModel _homeSmartDepartmentsModel;

  get homeSmartListDep => _homeSmartDepartmentsModel;
  List<AdHome> _listAds = [];
  late HomeAdsModel _homeAdsModel;

  bool loadingPagination = false;
  bool endPage = false;

  int _storeType = AppStatus.defaultStoreType;
  int get getStoreType => _storeType;

  set setStoreType(int newStoreType) {
    _storeType = newStoreType;
    notifyListeners();
  }

  @override
  Future<AppStatusModel> getAppStatus({
    required BuildContext context,
  }) async {
    await _apiProvider.get(
      apiRoute: appStatusURL,
      successResponse: (response) {
        _appStatusModel = AppStatusModel.fromJson(response);
        notifyListeners();
      },
      errorResponse: (response) {
        _errorModel = ErrorModel.fromJson(response);
        errorDialog(context, _errorModel.message);
        logger.e(response);
        notifyListeners();
      },
    );
    return _appStatusModel;
  }

  @override
  Future<HomeModel> getHomeDetails({
    required BuildContext context,
  }) async {
    await _apiProvider.get(
      apiRoute: homeURL,
      queryParameters: {
        'StoreType': _storeType,
      },
      successResponse: (response) {
        _homeModel = HomeModel.fromJson(response);
        // notifyListeners();
      },
      errorResponse: (response) {
        _errorModel = ErrorModel.fromJson(response);
        errorDialog(context, _errorModel.message);
        logger.e(response);
        // notifyListeners();
      },
    );
    notifyListeners();
    return _homeModel;
  }

  @override
  Future<List<DepartmentHome>> getAllCategories({
    required BuildContext context,
    required int page,
  }) async {
    if (page != 1) {
      loadingPagination = true;
      notifyListeners();
    }
    await _apiProvider.get(
      apiRoute: allCategoriesURL,
      queryParameters: {
        'Page': page,
      },
      successResponse: (response) {
        _homeDepartmentsModel = HomeDepartmentsModel.fromJson(response);
        if (_homeDepartmentsModel.result!.departments!.isNotEmpty) {
          List<DepartmentHome> list = [];
          list.addAll(LinkedHashSet<DepartmentHome>.from(
                  _homeDepartmentsModel.result!.departments!)
              .toList());

          _listCategories = Tools.removeDuplicates(list);
        } else {
          endPage = true;
          notifyListeners();
        }
        loadingPagination = false;
        notifyListeners();
      },
      errorResponse: (response) {
        _errorModel = ErrorModel.fromJson(response);
        errorDialog(context, _errorModel.message);
        logger.e(response);
        notifyListeners();
      },
    );
    notifyListeners();
    return _listCategories;
  }

  @override
  Future<List<SmartDepartmentHome>> getAllDepartments({
    required BuildContext context,
    required int page,
  }) async {
    if (page != 1) {
      loadingPagination = true;
      notifyListeners();
    }
    await _apiProvider.get(
      apiRoute: allDepartmentsURL,
      queryParameters: {
        'Page': page,
      },
      successResponse: (response) {
        _homeSmartDepartmentsModel =
            HomeSmartDepartmentsModel.fromJson(response);
        if (_homeSmartDepartmentsModel.result!.smartDepartments!.isNotEmpty) {
          List<SmartDepartmentHome> list = [];
          list.addAll(LinkedHashSet<SmartDepartmentHome>.from(
                  _homeSmartDepartmentsModel.result!.smartDepartments!)
              .toList());
          _listDepartments = Tools.removeDuplicates(list);
        } else {
          endPage = true;
          notifyListeners();
        }
        loadingPagination = false;
        notifyListeners();
      },
      errorResponse: (response) {
        _errorModel = ErrorModel.fromJson(response);
        errorDialog(context, _errorModel.message);
        logger.e(response);
        notifyListeners();
      },
    );
    notifyListeners();
    return _listDepartments;
  }

  @override
  Future<List<AdHome>> getAllAds({
    required BuildContext context,
    required int page,
  }) async {
    if (page != 1) {
      loadingPagination = true;
      notifyListeners();
    }
    await _apiProvider.get(
      apiRoute: allAdsURL,
      queryParameters: {
        'Page': page,
      },
      successResponse: (response) {
        _homeAdsModel = HomeAdsModel.fromJson(response);
        if (_homeAdsModel.result!.adds!.isNotEmpty) {
          List<AdHome> list = [];
          list.addAll(
              LinkedHashSet<AdHome>.from(_homeAdsModel.result!.adds!).toList());
          _listAds = Tools.removeDuplicates(list);
        } else {
          endPage = true;
          notifyListeners();
        }
        loadingPagination = false;
        notifyListeners();
      },
      errorResponse: (response) {
        _errorModel = ErrorModel.fromJson(response);
        errorDialog(context, _errorModel.message);
        logger.e(response);
        notifyListeners();
      },
    );
    notifyListeners();
    return _listAds;
  }

  @override
  disposeData() {
    loadingPagination = false;
    endPage = false;
    // notifyListeners();
  }

  AppStatusModel get appStatusModel => _appStatusModel;

  HomeModel get homeModel => _homeModel;

  List<AdHome> get listAds => _listAds;

  List<SmartDepartmentHome> get listDepartments => _listDepartments;

  List<DepartmentHome> get listCategories => _listCategories;
}
