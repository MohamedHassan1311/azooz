import 'package:fluentui_system_icons/fluentui_system_icons.dart';

import '../../../../common/style/colors.dart';
import '../../../../common/style/dimens.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../../../model/response/wallet_model.dart';
import '../../../../providers/wallet_provider.dart';
import '../../../custom_widget/custom_error_widget.dart';
import '../../../custom_widget/custom_loading_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class WalletListWidget extends StatefulWidget {
  const WalletListWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<WalletListWidget> createState() => _WalletListWidgetState();
}

class _WalletListWidgetState extends State<WalletListWidget> {
  late Future<WalletModel> future;

  @override
  void initState() {
    super.initState();

    future = Provider.of<WalletProvider>(context, listen: false)
        .getData(context: context);
  }

  @override
  Widget build(BuildContext context) {
    // var wlletModel = context.watch<WalletProvider>().walletModelData;
    return FutureBuilder<WalletModel>(
        future: future,
        builder: (context, snapshot) {
          return snapshot.hasData
              ? Padding(
                  padding: edgeInsetsSymmetric(horizontal: 8.0),
                  child: Column(
                    children: [
                      Container(
                        width: 120,
                        height: 120,
                        decoration: const BoxDecoration(
                          color: Palette.activeWidgetsColor,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          FluentIcons.wallet_48_regular,
                          size: 48,
                          color: Colors.grey.shade600,
                        ),
                      ),
                      Padding(
                        padding: edgeInsetsOnly(bottom: 10.0, top: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  LocaleKeys.amount.tr(),
                                  style: Theme.of(context).textTheme.subtitle1,
                                ),
                                sizedBox(width: 8),

                                Consumer<WalletProvider>(
                                  builder: (context, provider, child) {
                                    if (provider.walletModelData.result
                                                ?.amount ==
                                            null ||
                                        provider.walletModelData.result!
                                                .amount ==
                                            0) {
                                      return Text(
                                        '0',
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle1,
                                      );
                                    }
                                    return Text(
                                      '${provider.walletModelData.result!.amount} ${LocaleKeys.sar.tr()}',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: Palette.primaryColor,
                                      ),
                                    );
                                  },
                                ),

                                // Text(
                                //   '${wlletModel.result!.amount} ${LocaleKeys.sar.tr()}',
                                //   style: const TextStyle(
                                //     fontWeight: FontWeight.w600,
                                //     color: Palette.kBlue2,
                                //   ),
                                // ),
                              ],
                            ),
                            // sizedBox(
                            //   width: 60,
                            //   height: 60,
                            //   child: wallet2SVG,
                            // ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              : snapshot.hasError
                  ? const CustomErrorWidget()
                  : const CustomLoadingWidget();
        });
  }
}
