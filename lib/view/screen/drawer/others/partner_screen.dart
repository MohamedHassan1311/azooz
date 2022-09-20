import '../../../../common/style/dimens.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../../widget/drawer/others/partner_fields_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';

class PartnerScreen extends StatelessWidget {
  static const routeName = 'partner';

  const PartnerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return KeyboardDismisser(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
            title: Text(
          LocaleKeys.bePartner.tr(),
        )),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: edgeInsetsSymmetric(horizontal: 8),
            child: const PartnerFieldsWidget(),
          ),
        ),
      ),
    );
  }
}
