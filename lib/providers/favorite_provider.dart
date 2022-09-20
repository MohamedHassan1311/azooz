import 'dart:collection';

import '../common/config/tools.dart';
import '../model/error_model.dart';
import '../model/mixin/favorite_mixin.dart';
import '../model/response/favorite_model.dart';
import '../service/network/api_provider.dart';
import '../service/network/url_constants.dart';
import '../utils/dialogs.dart';
import 'package:flutter/material.dart';

class FavoriteProvider extends ChangeNotifier with FavoriteMixin {
  final ApiProvider _apiProvider = ApiProvider.internal();
  late ErrorModel _errorModel;
  late FavoriteModel _favoriteModel;
  List<Stores>? _filteredList = [];
  List<Stores>? _paginationList = [];
  bool? loading = false;
  bool loadingPagination = false;
  bool endPage = false;

  @override
  Future<FavoriteModel> getFavorites({
    required int? page,
    required BuildContext context,
  }) async {
    _filteredList = [];
    if (page != 1) {
      loadingPagination = true;
      notifyListeners();
    }
    await _apiProvider.get(
      apiRoute: getFavoriteURL,
      queryParameters: {
        'Page': page,
      },
      successResponse: (response) {
        _favoriteModel = FavoriteModel.fromJson(response);
        if (_favoriteModel.result!.stores!.isNotEmpty) {
          _filteredList!.addAll(
            LinkedHashSet.of(_favoriteModel.result!.stores!).toList(),
          );
          _paginationList!.addAll(
            LinkedHashSet.of(_favoriteModel.result!.stores!).toList(),
          );

          _filteredList = Tools.removeDuplicates(_filteredList!);
          _paginationList = Tools.removeDuplicates(_paginationList!);
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
        loadingPagination = false;
        notifyListeners();
      },
    );
    notifyListeners();

    return _favoriteModel;
  }

  @override
  Future<void> addFavorite({
    required int? id,
    required BuildContext context,
  }) async {
    circularDialog(context);
    Map body = {
      'storeId': id,
    };
    await _apiProvider.post(
      apiRoute: addFavoriteURL,
      successResponse: (response) {
        dismissDialog(context);
        successDialogWithTimer(context);
        // dismissLoading().whenComplete(
        //   () => delayMilliseconds(
        //     250,
        //     () => showSuccess(
        //       durationMilliseconds: 850,
        //     ),
        //   ),
        // );

        notifyListeners();
      },
      errorResponse: (response) {
        _errorModel = ErrorModel.fromJson(response);
        dismissDialog(context);
        errorDialog(context, _errorModel.message);
        notifyListeners();
      },
      data: body,
    );
    notifyListeners();
  }

  @override
  Future<void> deleteFavorite({
    int? id,
    required int? storeId,
    required BuildContext context,
  }) async {
    circularDialog(context);
    Map<String, dynamic> body = {
      'id': storeId,
    };
    await _apiProvider.delete(
      apiRoute: deleteFavoriteURL,
      successResponse: (response) {
        dismissDialog(context);
        successDialogWithTimer(context).then((value) {
          getFavorites(
            page: 1,
            context: context,
          );
        });
        // dismissLoading().whenComplete(
        //   () => delayMilliseconds(
        //     250,
        //     () {
        //       showSuccess(
        //         durationMilliseconds: 850,
        //       ).then((value) {

        //       });
        //     },
        //   ),
        // );
        _filteredList!.removeWhere((element) => element.id == id);
        notifyListeners();
      },
      errorResponse: (response) {
        _errorModel = ErrorModel.fromJson(response);
        errorDialog(context, _errorModel.message);
        notifyListeners();
      },
      data: body,
    );
    notifyListeners();
  }

  @override
  bool? isLoading(bool? loading) {
    this.loading = loading;
    notifyListeners();
    return null;
  }

  @override
  List<Stores>? filterAddress(String queryWord) {
    Iterable<Stores> result = [];
    // _paginationList = _filteredList;
    if (queryWord.trim().isNotEmpty) {
      result = _paginationList!.where(
        (element) => element.name!.toLowerCase().contains(
              queryWord.toLowerCase().trim(),
            ),
      );
      notifyListeners();
    } else {
      result = _paginationList!;
      notifyListeners();
    }
    _filteredList = result.toSet().toList();
    notifyListeners();
    return _filteredList;
  }

  @override
  disposeData() {
    loadingPagination = false;
    endPage = false;
    _filteredList!.clear();
  }

  FavoriteModel get favoriteModel => _favoriteModel;

  List<Stores>? get filteredList => _filteredList;
  List<Stores>? get paginationList => _paginationList;
  paginationListRemove(item) {
    _paginationList!.remove(item);
    notifyListeners();
  }
}
