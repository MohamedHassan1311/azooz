import 'package:azooz/common/payment_consts.dart';
import 'package:azooz/providers/payment_provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../common/routes/app_router_import.gr.dart';
import '../../../../common/style/dimens.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../../../model/screen_argument/add_advert_argument.dart';
import '../../../custom_widget/floating_action_button_widget.dart';
import '../../../widget/drawer/others/adverts_list_widget.dart';

class AdvertsScreen extends StatefulWidget {
  static const routeName = 'adverts';

  const AdvertsScreen({Key? key}) : super(key: key);

  @override
  State<AdvertsScreen> createState() => _AdvertsScreenState();
}

class _AdvertsScreenState extends State<AdvertsScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<PaymentProvider>().setPayRechargeId =
          PayRechargeIds.payAdsId;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          LocaleKeys.myAdverts.tr(),
          style: const TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      resizeToAvoidBottomInset: false,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButtonWidget(
        route: AddAdvertRoute(
          argument: const AddAdvertArgument(
            isNew: true,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: edgeInsetsSymmetric(horizontal: 8),
          child: Column(
            children: [
              Expanded(
                child: Padding(
                  padding: edgeInsetsSymmetric(horizontal: 8),
                  child: const AdvertsListWidget(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
