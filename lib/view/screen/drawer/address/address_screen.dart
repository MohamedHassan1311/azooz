import 'package:azooz/common/routes/app_router_control.dart';
import 'package:azooz/view/custom_widget/custom_button.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../../common/routes/app_router_import.gr.dart';
import '../../../../common/style/dimens.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../../../model/screen_argument/address_argument.dart';
import '../../../widget/drawer/address/address_list_widget.dart';
import '../../../widget/drawer/address/address_search_widget.dart';
import 'package:flutter/material.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';

class AddressScreen extends StatelessWidget {
  static const routeName = 'address';

  final AddressArgument argument;

  const AddressScreen({Key? key, required this.argument}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return KeyboardDismisser(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        // floatingActionButton: FloatingActionButtonWidget(
        //   route: AddAddressRoute(
        //     argument: const AddressArgument(
        //       newAddress: true,
        //       fromOrdersDetails: false,
        //       fromAdsScreen: false,
        //     ),
        //   ),
        // ),
        appBar: AppBar(
          title: Text(LocaleKeys.addresses.tr()),
        ),
        body: SafeArea(
          child: Padding(
            padding: edgeInsetsSymmetric(horizontal: 8),
            child: Column(
              children: [
                const SizedBox(height: 5),
                const AddressSearchWidget(),
                const SizedBox(height: 5),
                Expanded(
                  child: AddressListWidget(argument: argument),
                ),
                const SizedBox(height: 10),
                CustomButton(
                  text: LocaleKeys.addAddresses.tr(),
                  onPressed: () {
                    routerPush(
                      context: context,
                      route: AddAddressRoute(
                        argument: const AddressArgument(
                          newAddress: true,
                          fromOrdersDetails: false,
                          fromAdsScreen: false,
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
