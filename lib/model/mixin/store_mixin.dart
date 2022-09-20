import 'package:flutter/material.dart';

mixin StoreMixin {
  dynamic getStores({
    required int? id,
    required String? searchWord,
    required int? page,
    required double? lat,
    required double? lng,
    required BuildContext context,
  });

  dynamic getStore({
    required int? id,
    required BuildContext context,
  });

  dynamic searchStore({
    String? searchWord,
    int? id,
    int? page,
    double? lat,
    double? lng,
    required BuildContext context,
    required bool searchIsEmpty,
  }) {}

  int? selectFilter({required int? index}) {
    return null;
  }

  String? changeSearchWord({required String? searchWord}) {
    return null;
  }

  bool? isLoading({required bool? loading}) {
    return null;
  }

  dynamic getMarkerIcon({
    required BuildContext context,
    required String? path,
    required int? width,
  }) {}

  dynamic filterStores(int indexFilter){}

  dynamic changeFavorite(bool? favorite, int id){}
}