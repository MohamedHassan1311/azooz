import '../../../common/routes/app_router_import.gr.dart';
import '../../../common/routes/app_router_control.dart';
import '../../../common/style/colors.dart';
import '../../../common/style/dimens.dart';
import '../../../common/style/style.dart';
import '../../../generated/locale_keys.g.dart';
import '../../../model/response/duration_model.dart';
import '../../../providers/orders_provider.dart';
import '../../custom_widget/custom_background_widget.dart';
import '../../custom_widget/custom_button.dart';
import '../../custom_widget/marquee_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class DeliveryBottomWidget extends StatefulWidget {
  const DeliveryBottomWidget({Key? key}) : super(key: key);

  @override
  State<DeliveryBottomWidget> createState() => _DeliveryBottomWidgetState();
}

class _DeliveryBottomWidgetState extends State<DeliveryBottomWidget> {
  late Future<DurationModel> future;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: edgeInsetsOnly(
        start: 10,
        end: 10,
        top: 10,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(LocaleKeys.arrivePoint.tr()),
          Row(
            children: [
              Expanded(
                flex: 3,
                child: CustomBackgroundWidget(
                  color: Palette.activeWidgetsColor,
                  child: MarqueeWidget(
                    child: Text(
                      LocaleKeys.address.tr(),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  height: 30,
                  decoration: cardDecoration6(
                    context: context,
                    colorOutline: Palette.secondaryLight,
                    withShadow: false,
                  ),
                  child: Center(
                    child: Text(
                      LocaleKeys.location.tr(),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ],
          ),
          sizedBox(height: 5),
          Text(LocaleKeys.arriveTime.tr()),
          CustomBackgroundWidget(
            width: double.infinity,
            color: Palette.activeWidgetsColor,
            child: MarqueeWidget(
              child: Consumer<OrdersProvider>(
                builder: (context, provider, child) {
                  return Text(
                    provider.durationName,
                  );
                },
              ),
            ),
          ),
          sizedBox(height: 5),
          CustomButton(
            text: LocaleKeys.confirm.tr(),
            onPressed: () => routerPush(
              context: context,
              route: const OrderSuccessfulRoute(),
            ),
            width: 250,
          ),
        ],
      ),
    );
  }
}
