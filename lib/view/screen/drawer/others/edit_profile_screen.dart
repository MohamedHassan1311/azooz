import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';

import '../../../../common/style/dimens.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../../widget/drawer/others/edit_profile_widget.dart';

class EditProfileScreen extends StatelessWidget {
  static const routeName = 'edit_profile';

  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return KeyboardDismisser(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            LocaleKeys.myPage.tr(),
          ),
        ),
        // resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          padding: edgeInsetsOnly(start: 25, end: 25),
          child: const EditProfileWidget(),
        ),
      ),
    );
  }
}
