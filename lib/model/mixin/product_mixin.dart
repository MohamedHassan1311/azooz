import 'package:flutter/material.dart';

mixin ProductMixin {
  dynamic getProducts({
    required int? categoryId,
    required int? page,
    required BuildContext context,
  });

  dynamic removeElement(int id);

  double calculateTotalPrice({required double couponValue});

  void clearCart();
}
