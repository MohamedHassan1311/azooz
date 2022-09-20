import 'package:azooz/providers/payment_provider.dart';
import 'package:azooz/utils/smart_text_inputs.dart';
import 'package:azooz/view/widget/home/driver/order_payment_type.dart';

import '../../../common/config/tools.dart';
import '../../../common/routes/app_router_control.dart';
import '../../../common/routes/app_router_import.gr.dart';
import '../../../common/style/colors.dart';
import '../../../common/style/dimens.dart';
import '../../../generated/locale_keys.g.dart';
import '../../../model/screen_argument/make_order_argument.dart';
import '../../../model/screen_argument/order_details_argument.dart';
import '../../../providers/orders_provider.dart';
import '../../../providers/product_provider.dart';
import '../../../utils/easy_loading_functions.dart';
import '../../custom_widget/custom_button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class OrderReceiptWidget extends StatefulWidget {
  final MakeOrderArgument argument;

  const OrderReceiptWidget({Key? key, required this.argument})
      : super(key: key);

  @override
  State<OrderReceiptWidget> createState() => _OrderReceiptWidgetState();
}

class _OrderReceiptWidgetState extends State<OrderReceiptWidget> {
  final TextEditingController _couponController = TextEditingController();
  final TextEditingController _detailsController = TextEditingController();

  String coupon = '';

  checkCoupon() async {
    Tools.hideKeyboard(context);
    final provider = Provider.of<OrdersProvider>(context, listen: false);
    if (_couponController.text.isNotEmpty) {
      provider
          .couponCheck(
            context: context,
            code: _couponController.text.trim(),
          )
          .then(
            (value) => coupon = _couponController.text.trim(),
          );
    } else {
      showInfo(msg: LocaleKeys.enterCoupon.tr());
    }
  }

  @override
  void dispose() {
    _detailsController.dispose();
    _couponController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    Provider.of<OrdersProvider>(context, listen: false).coupon = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          children: [
            SmartInputTextField(
              label: "",
              hasLabel: false,
              fillColor: Palette.kWhite,
              hintText: LocaleKeys.leaveNote.tr(),
              maxLines: 3,
              controller: _detailsController,
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  // flex: 2,
                  child: SmartInputTextField(
                    fillColor: Palette.kWhite,
                    hasLabel: false,
                    label: "",
                    hintText: LocaleKeys.promoCode.tr(),
                    controller: _couponController,
                  ),
                ),
                const SizedBox(width: 10),
                SizedBox(
                  height: 50,
                  child: OutlinedButton(
                    onPressed: checkCoupon,
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.resolveWith<Color>(
                          (_) => Palette.primaryColor),
                      shape: MaterialStateProperty.resolveWith<OutlinedBorder>(
                        (_) => RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        LocaleKeys.verify.tr(),
                        style: const TextStyle(
                          color: Palette.kWhite,
                          fontSize: 11,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 10),
        const OrderPaymentTypeWidget(
          color: Palette.kWhite,
        ),
        const SizedBox(height: 10),
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  LocaleKeys.totalAmount.tr(),
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                Consumer<ProductProvider>(
                  builder: (context, provider, child) {
                    if (provider.totalProductsPrice <= 0) {
                      return Text(
                        '0.00',
                        style: Theme.of(context).textTheme.subtitle1,
                      );
                    }
                    return Text(
                      provider.totalProductsPrice.toString(),
                      style: Theme.of(context).textTheme.subtitle1,
                    );
                  },
                ),
              ],
            ),
            Padding(
              padding: edgeInsetsOnly(top: 5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    LocaleKeys.promoCode.tr(),
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                  Consumer<OrdersProvider>(
                    builder: (context, provider, child) {
                      return Text(
                        provider.coupon == 0 ? '0.00' : '${provider.coupon}0',
                        style: Theme.of(context).textTheme.bodyText2,
                      );
                    },
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  LocaleKeys.total.tr(),
                  style: Theme.of(context).textTheme.subtitle1,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.start,
                ),
                sizedBox(width: 15),
                Consumer<ProductProvider>(
                  builder: (context, provider, child) {
                    return Text(
                      provider.totalProductsPrice.toString(),
                      style: Theme.of(context).textTheme.subtitle1,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.start,
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 30),
            CustomButton(
              text: LocaleKeys.continueOrder.tr(),
              textColor: Theme.of(context).primaryColorLight,
              onPressed: () {
                final selectedPayment =
                    context.read<PaymentProvider>().orderPaymentType;
                if (_detailsController.text.isEmpty) {
                  showInfo(msg: LocaleKeys.leaveNoteMsg.tr());
                } else if (selectedPayment == null) {
                  showInfo(msg: "يجب عليك تحديد طريقة السداد");
                } else {
                  routerPush(
                    context: context,
                    route: OrderConfirmationScreenRoute(
                      argument: OrderConfirmationArgument(
                        coupon: coupon,
                        details: _detailsController.text.trim(),
                        storeName: widget.argument.name,
                        storeID: widget.argument.id,
                      ),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ],
    );
  }
}
