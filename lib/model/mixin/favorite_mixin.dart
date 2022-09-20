import 'package:flutter/material.dart';

import '../response/favorite_model.dart';

mixin FavoriteMixin {
  Future<FavoriteModel> getFavorites({
    required int? page,
    required BuildContext context,
  });

  Future<void> addFavorite({
    required int? id,
    required BuildContext context,
  });

  Future<void> deleteFavorite({
    int? id,
    required int? storeId,
    required BuildContext context,
  });

  bool? isLoading(bool? loading);

  List<Stores>? filterAddress(String queryWord);

  disposeData();
}
