import '../../../../common/style/dimens.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../../widget/drawer/others/reviews_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ReviewsScreen extends StatelessWidget {
  static const routeName = 'reviews';

  const ReviewsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(LocaleKeys.rates.tr()),
      ),
      body: SafeArea(
        child: Padding(
          padding: edgeInsetsSymmetric(horizontal: 8),
          child: const ReviewsWidget(),
        ),
      ),
    );
  }
}
