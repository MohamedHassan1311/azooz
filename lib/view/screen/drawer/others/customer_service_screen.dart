import '../../../../generated/locale_keys.g.dart';
import '../../../widget/home/chat/chat_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';

class CustomerServiceScreen extends StatelessWidget {
  static const routeName = 'customer_service';

  const CustomerServiceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return KeyboardDismisser(
      child: Scaffold(
        appBar: AppBar(
          title: Text(LocaleKeys.technicalSupport.tr()),
          elevation: 0.0,
        ),
        body: const SafeArea(
          child: ChatWidget(
            isCustomerService: true,
          ),
        ),
      ),
    );
  }
}
