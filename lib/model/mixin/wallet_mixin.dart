import 'package:flutter/material.dart';

import '../response/wallet_model.dart';

mixin WalletMixin {
  Future<WalletModel> getData({
    required BuildContext context,
  });

  Future sendData({
    required BuildContext context,
    required double? amount,
  });
}
