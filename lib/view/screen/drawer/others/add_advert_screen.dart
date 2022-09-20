import '../../../../generated/locale_keys.g.dart';
import '../../../../model/screen_argument/add_advert_argument.dart';
import '../../../widget/drawer/others/advert_fields_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';

class AddAdvertScreen extends StatelessWidget {
  static const routeName = 'add_advert';

  final AddAdvertArgument argument;

  const AddAdvertScreen({Key? key, required this.argument}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return KeyboardDismisser(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            argument.isNew == true
                ? LocaleKeys.addAdvert.tr()
                : LocaleKeys.edit.tr(),
            style: const TextStyle(
              color: Colors.black87,
            ),
          ),
        ),
        body: AdvertFieldsWidget(argument: argument),
      ),
    );
  }
}
