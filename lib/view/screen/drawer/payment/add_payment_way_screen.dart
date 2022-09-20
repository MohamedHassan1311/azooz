import '../../../../common/style/dimens.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../../../model/screen_argument/add_payment_ways_argument.dart';
import '../../../widget/drawer/payment/add_payment_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';

class AddPaymentWayScreen extends StatelessWidget {
  static const routeName = 'add_payment_way';
  final AddPaymentWaysArgument? argument;

  const AddPaymentWayScreen({Key? key, this.argument}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return KeyboardDismisser(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text(LocaleKeys.paymentMethods.tr()),
        ),
        body: SafeArea(
          child: Padding(
            padding: edgeInsetsSymmetric(horizontal: 8),
            child: AddPaymentWidget(argument: argument),
          ),
        ),
      ),
    );
  }
}
