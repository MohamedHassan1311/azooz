import '../../../generated/locale_keys.g.dart';
import '../../../model/screen_argument/order_details_argument.dart';
import '../../widget/order/order_details_widget.dart';
import '../../widget/order/trip_details_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class OrderConfirmationScreen extends StatelessWidget {
  static const routeName = 'order_confirmation_screen';

  final OrderConfirmationArgument? argument;

  const OrderConfirmationScreen({
    Key? key,
    required this.argument,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
        LocaleKeys.confirmOrder.tr(),
      )),
      body: SafeArea(
        child: ConfirmationDetails(
          argument: argument!,
        ),
      ),
    );
  }
}

class OrderDetailsScreen extends StatelessWidget {
  static const routeName = 'order_details';

  final OrderDetailsArgument? argument;

  const OrderDetailsScreen({
    Key? key,
    required this.argument,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
        LocaleKeys.orderDetails.tr(),
      )),
      body: SafeArea(
        child: OrderDetailsWidget(argument: argument!),
      ),
    );
  }
}

class TripDetailsScreen extends StatelessWidget {
  static const routeName = 'order_details';

  final TripDetailsArgument? argument;

  const TripDetailsScreen({
    Key? key,
    required this.argument,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("تفاصيل المشوار"),
      ),
      body: TripDetailsWidget(argument: argument!),
    );
  }
}
