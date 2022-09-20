import '../response/banks_model.dart';
import 'package:flutter/material.dart';

mixin BanksMixin {
  Future<BanksModel> getBanks({
    required BuildContext context,
  });
}
