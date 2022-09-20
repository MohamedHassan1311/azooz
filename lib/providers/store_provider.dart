import 'dart:collection';

import '../common/config/tools.dart';
import '../model/error_model.dart';
import '../model/mixin/store_mixin.dart';
import '../model/response/products_model.dart';
import '../model/response/store_model.dart';
import '../model/response/stores_model.dart';
import '../service/network/api_provider.dart';
import '../service/network/url_constants.dart';
import '../utils/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import 'location_provider.dart';

class StoreProvider extends ChangeNotifier with StoreMixin {
  final ApiProvider _apiProvider = ApiProvider.internal();
  late StoreModel _storeModel;
  late StoresModel _storesModel;
  late ErrorModel _errorModel;

  int _selectedIndex = 0;

  get getIndex => _selectedIndex;
  set setIndex(int value) {
    _selectedIndex = value;
    notifyListeners();
  }

  List<Categorys>? get categories => _storeModel.result!.store!.categorys;
  List<CategoryProduct>? get products =>
      _storeModel.result!.store!.categorys![_selectedIndex].product;

  List<Stores> _filteredList = [];
  List<Stores> _paginationList = [];

  int? indexFilter;

  String? searchWord = '';

  bool loading = false;

  bool endPage = false;

  bool loadingPagination = false;

  BitmapDescriptor? markerIcon;

  Map<int, bool>? favorite = {};

  @override
  Future<StoresModel> getStores({
    required int? id,
    required String? searchWord,
    required int? page,
    required double? lat,
    required double? lng,
    required BuildContext context,
  }) async {
    if (page != 1) {
      loadingPagination == true;
      notifyListeners();
    }

    await _apiProvider.get(
      apiRoute: storesByDepURL,
      queryParameters: {
        "Id": id,
        'SearchQuare': searchWord,
        'Page': page,
        'Lat': lat,
        'Lng': lng,
      },
      successResponse: (response) {
        _storesModel = StoresModel.fromJson(response);
        if (_storesModel.result!.stores!.isNotEmpty) {
          _filteredList.addAll(
            LinkedHashSet<Stores>.from(_storesModel.result!.stores!).toList(),
          );
          _paginationList.addAll(
            LinkedHashSet<Stores>.from(_storesModel.result!.stores!).toList(),
          );
          _filteredList = Tools.removeDuplicates(_filteredList);
          _paginationList = Tools.removeDuplicates(_paginationList);

          final Map<String, Stores> map = {};
          final Map<String, Stores> map2 = {};

          for (var item in _filteredList) {
            map[item.id.toString()] = item;
          }

          for (var item in _paginationList) {
            map2[item.id.toString()] = item;
          }

          _filteredList = map.values.toList();
          _paginationList = map2.values.toList();
        } else {
          endPage = true;
          notifyListeners();
        }

        loadingPagination == false;
        notifyListeners();
      },
      errorResponse: (response) {
        _errorModel = ErrorModel.fromJson(response);
        errorDialog(context, _errorModel.message);
        loadingPagination == false;
        notifyListeners();
      },
    );
    notifyListeners();

    return _storesModel;
  }

  // 0 => Price & 1 => Distance & 2 => Rate & 3 => Time
  @override
  List<Stores>? filterStores(int indexFilter) {
    if (_filteredList.isNotEmpty) {
      for (var element in _filteredList) {
        logger.d('## _filteredList.isNotEmpty: ${element.lowestPrice} ##');
      }
      if (indexFilter == 0) {
        _filteredList.sort((a, b) => b.lowestPrice!.compareTo(a.lowestPrice!));
        logger.d('Price Filter');
        for (var element in _filteredList) {
          logger.d('## _filteredList: ${element.lowestPrice} ##');
        }

        notifyListeners();
      } else if (indexFilter == 1) {
        _filteredList.sort((a, b) => b.distance!.compareTo(a.distance!));
        for (var element in _filteredList) {
          logger.d('## Distance Filter: ${element.lowestPrice} ##');
        }
        logger.d('Distance Filter');
        notifyListeners();
      } else if (indexFilter == 2) {
        _filteredList.sort((a, b) => b.rate!.compareTo(a.rate!));
        for (var element in _filteredList) {
          logger.d('## Rate Filter: ${element.lowestPrice} ##');
        }
        logger.d('Rate Filter');
        notifyListeners();
      } else if (indexFilter == 3) {
        _filteredList.sort((a, b) => b.time!.compareTo(a.time!));
        for (var element in _filteredList) {
          logger.d('## Time Filter: ${element.lowestPrice} ##');
        }
        logger.d('Time Filter');
        notifyListeners();
      }
      notifyListeners();
      return _filteredList;
    }
    return null;
  }

  @override
  Future<StoreModel> getStore({
    required int? id,
    required BuildContext context,
  }) async {
    await _apiProvider.get(
      apiRoute: storeByIdURL,
      queryParameters: {
        "Id": id,
      },
      successResponse: (response) {
        _storeModel = StoreModel.fromJson(response);
        favorite![_storeModel.result?.store?.id! as int] =
            _storeModel.result?.store?.favorite ?? false;
        notifyListeners();
      },
      errorResponse: (response) {
        _errorModel = ErrorModel.fromJson(response);
        errorDialog(context, _errorModel.message);
        notifyListeners();
      },
    );
    notifyListeners();

    return _storeModel;
  }

  @override
  int? selectFilter({required int? index}) {
    indexFilter = index;
    notifyListeners();
    return index;
  }

  @override
  Future<String?> searchStore({
    String? searchWord,
    int? id,
    int? page,
    double? lat,
    double? lng,
    required BuildContext context,
    required bool searchIsEmpty,
  }) async {
    if (searchIsEmpty) {
      _filteredList = _paginationList;
      notifyListeners();
    } else {
      this.searchWord = searchWord;
      _filteredList.clear();
      await getStores(
        id: id,
        searchWord: searchWord,
        page: page,
        lat: lat,
        lng: lng,
        context: context,
      );
      notifyListeners();
    }

    notifyListeners();
    return null;
  }

  @override
  String? changeSearchWord({
    required String? searchWord,
  }) {
    this.searchWord = searchWord;
    notifyListeners();
    return null;
  }

  @override
  bool? isLoading({
    required bool? loading,
  }) {
    this.loading = loading!;
    notifyListeners();
    return null;
  }

  @override
  Future<void> getMarkerIcon({
    required BuildContext context,
    required String? path,
    required int? width,
  }) async {
    var provider = Provider.of<LocationProvider>(context, listen: false);
    markerIcon = await provider.getBitmapDescriptorFromAssetBytes(
      path!,
      width!,
    );
    notifyListeners();
  }

  @override
  changeFavorite(bool? favorite, int id) {
    this.favorite![id] = favorite!;
    notifyListeners();
  }

  StoreModel get storeModel => _storeModel;

  StoresModel get storesModel => _storesModel;

  List<Stores> get filteredList => _filteredList;
}
