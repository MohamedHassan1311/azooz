import 'package:azooz/app.dart';

import '../../../generated/locale_keys.g.dart';
import '../../widget/home/stores/notification_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  static const routeName = 'notification';

  const NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("getItRoutePath: $getItRoutePath");
    final path = ModalRoute.of(context)?.settings.name;
    final isCurrent = ModalRoute.of(context)?.isCurrent;
    print("getItRoutePath-ModalRoute: $getItRoutePath");
    print("getItRoutePath-isCurrent: $isCurrent");
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(LocaleKeys.notifications.tr()),
      ),
      body: const SafeArea(
        child: NotificationWidget(),
      ),
    );
  }
}
