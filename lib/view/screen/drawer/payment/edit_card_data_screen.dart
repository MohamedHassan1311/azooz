import '../../../../common/style/dimens.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../../../model/screen_argument/add_payment_ways_argument.dart';
import '../../../widget/drawer/payment/edit_card_data.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';

class EditCardDataScreen extends StatelessWidget {
  static const routeName = 'edit_card_data';
  final AddPaymentWaysArgument? argument;

  const EditCardDataScreen({Key? key, this.argument}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return KeyboardDismisser(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text(
            LocaleKeys.paymentMethods.tr(),
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: edgeInsetsSymmetric(horizontal: 8),
            child: EditCardDataWidget(argument: argument),
          ),
        ),
      ),
    );
  }
}
