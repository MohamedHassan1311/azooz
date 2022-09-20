import 'dart:collection';

import '../common/config/tools.dart';
import '../model/error_model.dart';
import '../model/mixin/reviews_mixin.dart';
import '../model/response/reviews_model.dart';
import '../service/network/api_provider.dart';
import '../service/network/url_constants.dart';
import '../utils/delay.dart';
import '../utils/dialogs.dart';
import '../utils/easy_loading_functions.dart';
import 'package:flutter/material.dart';

class ReviewsProvider extends ChangeNotifier with ReviewsMixin {
  final ApiProvider _apiProvider = ApiProvider.internal();
  late ErrorModel _errorModel;
  late ReviewsModel _reviewsModel;

  List<Review>? _listReviews = [];

  ReviewStoreModel? _reviewStoreModel;

  set setReviewData(ReviewStoreModel review) {
    _reviewStoreModel = review;
    notifyListeners();
  }

  bool loadingPagination = false;
  bool endPage = false;

  @override
  Future<void> postData({
    required BuildContext context,
  }) async {
    await _apiProvider.post(
      apiRoute: postStoreReviewsURL,
      data: _reviewStoreModel,
      successResponse: (response) {},
      errorResponse: (error) {},
    );
  }

  @override
  Future<ReviewsModel> getData({
    required int? page,
    required BuildContext context,
  }) async {
    if (page != 1) {
      loadingPagination = true;
      notifyListeners();
    }

    await _apiProvider.get(
      apiRoute: reviewsURL,
      queryParameters: {
        'Page': page,
      },
      successResponse: (response) {
        _reviewsModel = ReviewsModel.fromJson(response);
        if (_reviewsModel.result!.reviews!.isNotEmpty) {
          _listReviews!.addAll(
            LinkedHashSet<Review>.from(_reviewsModel.result!.reviews!).toList(),
          );
          _listReviews = Tools.removeDuplicates(_listReviews!);
        } else {
          endPage = true;
          notifyListeners();
        }
        loadingPagination = false;
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
        loadingPagination = false;
        notifyListeners();
      },
    );
    return _reviewsModel;
  }

  ReviewsModel get reviewsModel => _reviewsModel;

  List<Review>? get listReviews => _listReviews;
}
