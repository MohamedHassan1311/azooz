import '../../../common/config/assets.dart';
import '../../../common/routes/app_router_control.dart';
import '../../../common/routes/app_router_import.gr.dart';
import '../../../common/style/colors.dart';
import '../../../generated/locale_keys.g.dart';
import '../../../model/response/duration_model.dart';
import '../../../model/screen_argument/address_argument.dart';
import '../../../providers/address_provider.dart';
import '../../custom_widget/marquee_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class AddressDetailsWidget extends StatefulWidget {
  const AddressDetailsWidget({Key? key}) : super(key: key);

  @override
  State<AddressDetailsWidget> createState() => _AddressDetailsWidgetState();
}

class _AddressDetailsWidgetState extends State<AddressDetailsWidget> {
  late Future<DurationModel> future;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  LocaleKeys.deliveryAddress.tr(),
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                GestureDetector(
                  onTap: () => routerPush(
                    context: context,
                    route: AddressRoute(
                      argument: const AddressArgument(
                        fromOrdersDetails: true,
                        newAddress: false,
                        fromAdsScreen: false,
                      ),
                    ),
                  ),
                  child: Consumer<AddressProvider>(
                    builder: (context, provider, child) {
                      return Text(
                        provider.selectedName.isEmpty
                            ? LocaleKeys.chooseAddress.tr()
                            : LocaleKeys.editAddresses.tr(),
                        style: const TextStyle(
                          color: Palette.secondaryLight,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Row(
                  children: [
                    SizedBox(
                      height: 20,
                      width: 20,
                      child: homeSVG,
                    ),
                    const SizedBox(width: 20),
                  ],
                ),
                Expanded(
                  child: MarqueeWidget(
                    child: Consumer<AddressProvider>(
                      builder: (context, provider, child) {
                        return Text(
                          provider.selectedName.isEmpty
                              ? LocaleKeys.address.tr()
                              : provider.selectedName,
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 15),
        // Column(
        //   children: [
        //     // Row(
        //     //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //     //   children: [
        //     //     Text(
        //     //       LocaleKeys.deliveryTime.tr(),
        //     //       style: Theme.of(context).textTheme.subtitle1,
        //     //     ),
        //     //     GestureDetector(
        //     //       onTap: () => alertDialogDurationWidget(
        //     //         context: context,
        //     //         list: Provider.of<OrdersProvider>(context, listen: false)
        //     //             .durationModel
        //     //             .result!
        //     //             .durations,
        //     //       ),
        //     //       child: Text(
        //     //         LocaleKeys.edit.tr(),
        //     //         style: const TextStyle(
        //     //           color: Palette.secondaryLight,
        //     //         ),
        //     //       ),
        //     //     ),
        //     //   ],
        //     // ),
        //     // SizedBox(height: 10),

        //     Align(
        //       alignment: AlignmentDirectional.centerStart,
        //       child: MarqueeWidget(
        //         child: Consumer<OrdersProvider>(
        //           builder: (context, provider, child) {
        //             return Text(
        //               provider.durationName,
        //             );
        //           },
        //         ),
        //       ),
        //     ),
        //   ],
        // ),
      ],
    );
  }
}
