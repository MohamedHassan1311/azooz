import 'package:azooz/common/style/colors.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../generated/locale_keys.g.dart';
import '../../../model/screen_argument/make_order_argument.dart';
import '../../widget/order/order_products_widget.dart';
import '../../widget/order/order_receipt_widget.dart';
import 'package:flutter/material.dart';

class MakeOrderScreen extends StatefulWidget {
  static const routeName = 'make_order';
  final MakeOrderArgument argument;

  const MakeOrderScreen({
    Key? key,
    required this.argument,
  }) : super(key: key);

  @override
  State<MakeOrderScreen> createState() => _MakeOrderScreenState();
}

class _MakeOrderScreenState extends State<MakeOrderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          LocaleKeys.orderDetails.tr(),
          style: const TextStyle(color: Colors.black),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const OrderProductsWidget(),
              Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(20),
                  ),
                  color: Palette.activeWidgetsColor,
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: OrderReceiptWidget(argument: widget.argument),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
