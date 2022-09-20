import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../generated/locale_keys.g.dart';
import '../../widget/order/delivery_map_widget.dart';

class DeliveryDetailsScreen extends StatelessWidget {
  static const routeName = 'delivery_details';

  const DeliveryDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(LocaleKeys.deliveryLocation.tr())),
      body: const SafeArea(
        child: DeliveryMapWidget(),
      ),
    );
  }
}
