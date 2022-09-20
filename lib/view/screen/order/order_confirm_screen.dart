import 'package:azooz/main.dart';

import '../../../model/screen_argument/order_confirm_argument.dart';
import '../../widget/home/orders_history/order_confirm_list_widget.dart';
import 'package:flutter/material.dart';

class OrderConfirmScreen extends StatefulWidget {
  static const routeName = 'order_confirm';
  final OrderConfirmArgument argument;

  const OrderConfirmScreen({Key? key, required this.argument})
      : super(key: key);

  @override
  State<OrderConfirmScreen> createState() => _OrderConfirmScreenState();
}

class _OrderConfirmScreenState extends State<OrderConfirmScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      currentRoute = ModalRoute.of(context)?.settings.name;
      currentRouteArgs = ModalRoute.of(context)?.settings.arguments;
      print("## -- currentRoute11 :: $currentRoute -- ##");
      print("## -- currentRoute11 :: $currentRouteArgs -- ##");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: Text(widget.argument.storeName.toString()),
        title: const Text("عروض الطلب"),
      ),
      body: SafeArea(
        child: OrderConfirmListWidget(argument: widget.argument),
      ),
    );
  }
}
