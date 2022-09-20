import '../../../common/style/dimens.dart';
import '../../../generated/locale_keys.g.dart';
import '../../widget/order/offer_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class OffersScreen extends StatelessWidget {
  static const routeName = 'offers';

  const OffersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
        LocaleKeys.offers.tr(),
      )),
      body: SafeArea(
        child: Padding(
          padding: edgeInsetsSymmetric(horizontal: 10),
          child: const OfferWidget(),
        ),
      ),
    );
  }
}
