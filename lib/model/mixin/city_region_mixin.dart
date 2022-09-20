import '../response/city_model.dart';
import '../response/region_model.dart';
import 'package:flutter/material.dart';

mixin CityRegionMixin {
  Future<CityModel> getCity({
    required BuildContext context,
    required int? id,
  });

  Future<RegionModel> getRegion({
    required BuildContext context,
  });
}
