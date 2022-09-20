import '../../../common/config/tools.dart';
import '../../../common/style/colors.dart';
import '../../../common/style/dimens.dart';
import '../../../common/style/style.dart';
import '../../../generated/locale_keys.g.dart';
import '../../../providers/orders_provider.dart';
import '../../../utils/easy_loading_functions.dart';
import '../../custom_widget/custom_text_field_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class OrderSecondPartWidget extends StatefulWidget {
  const OrderSecondPartWidget({Key? key}) : super(key: key);

  @override
  _OrderSecondPartWidgetState createState() => _OrderSecondPartWidgetState();
}

class _OrderSecondPartWidgetState extends State<OrderSecondPartWidget> {
  final TextEditingController _couponController = TextEditingController();
  final TextEditingController _detailsController = TextEditingController();

  checkCoupon() async {
    Tools.hideKeyboard(context);
    final provider = Provider.of<OrdersProvider>(context, listen: false);
    if (_couponController.text.isNotEmpty) {
      provider.couponCheck(
        context: context,
        code: _couponController.text.trim(),
      );
    } else {
      showInfo(msg: LocaleKeys.enterPromoCode.tr());
    }
  }

  @override
  void dispose() {
    _detailsController.dispose();
    _couponController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: Container(
            decoration: cardDecoration5(context: context, radius: 8),
            margin: edgeInsetsSymmetric(vertical: 8),
            padding: edgeInsetsSymmetric(horizontal: 8),
            child: CustomTextFieldWidget(
              hintText: LocaleKeys.leaveNote.tr(),
              maxLines: 2,
              controller: _detailsController,
            ),
          ),
        ),
        Expanded(
          child: Container(
            decoration: cardDecoration6(
              context: context,
              radius: 15,
              colorOutline: Palette.secondaryLight,
            ),
            margin: edgeInsetsSymmetric(vertical: 0),
            padding: edgeInsetsSymmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Padding(
                    padding: edgeInsetsOnly(bottom: 25),
                    child: CustomTextFieldWidget(
                      hintText: LocaleKeys.promoCode.tr(),
                      controller: _couponController,
                    ),
                  ),
                ),
                SizedBox(
                  height: 22,
                  width: 80,
                  child: OutlinedButton(
                    onPressed: () => checkCoupon(),
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
                            color: Palette.kWhite, fontSize: 12),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
