import 'package:azooz/model/response/store_hud_model.dart';
import 'package:azooz/providers/chat_provider.dart';

import '../../../../common/style/colors.dart';
import '../../../../common/style/dimens.dart';
import '../../../../common/style/style.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../../../providers/payment_provider.dart';
import '../../../../utils/util_url_launcher.dart';
import '../../../custom_widget/alert_dialog_widgets.dart';
import '../../../custom_widget/custom_button.dart';
import '../../../custom_widget/custom_error_widget.dart';
import '../../../custom_widget/custom_loading_widget.dart';
import '../../../custom_widget/marquee_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class StoreChatHudWidget extends StatefulWidget {
  final int chatId;

  const StoreChatHudWidget({Key? key, required this.chatId}) : super(key: key);

  @override
  State<StoreChatHudWidget> createState() => _StoreChatHudWidgetState();
}

class _StoreChatHudWidgetState extends State<StoreChatHudWidget> {
  late Future<StoreHudModel> storeHudFuture;

  PaymentChoice? paymentChoice;

  late final PaymentProvider providerPayment;

  @override
  void initState() {
    super.initState();
    storeHudFuture = context
        .read<ChatProvider>()
        .getStoreHud(context: context, chatId: widget.chatId);
    paymentChoice = PaymentChoice.cash;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<StoreHudModel>(
        future: storeHudFuture,
        builder: (context, snapshot) {
          return snapshot.hasData
              ? Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    // alignment: Alignment.center,
                    margin: edgeInsetsAll(8),
                    padding: edgeInsetsAll(8),
                    height: 120,
                    // color: Colors.purple,
                    decoration: cardDecoration5(context: context, radius: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: MarqueeWidget(
                                child: Consumer<ChatProvider>(
                                  builder: (context, provider, child) {
                                    return Text(
                                      '${LocaleKeys.speakingTo.tr()} ${provider.storeHudModel.result!.chat!.otherUser!.data!.name}',
                                      style:
                                          Theme.of(context).textTheme.subtitle1,
                                    );
                                  },
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                const Icon(
                                  Icons.star,
                                  color: Palette.kRating,
                                  size: 15,
                                ),
                                sizedBox(width: 3),
                                Consumer<ChatProvider>(
                                  builder: (context, provider, child) {
                                    return Text(
                                      '${provider.storeHudModel.result?.chat?.otherUser?.data?.rate}',
                                      style:
                                          Theme.of(context).textTheme.subtitle2,
                                    );
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                        // sizedBox(height: 20),
                        Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Selector<OrdersProvider, OrdersTypesModel>(
                            //   selector: (p0, p1) => p1.getOrderType,
                            //   builder: (context, value, child) {
                            //     if (value.type != OrdersTypes.order) {
                            //       return CustomButton(
                            //         text: LocaleKeys.tracking.tr(),
                            //         onPressed: () {},
                            //         top: 5,
                            //         color: kSuccess,
                            //         bottom: 5,
                            //         width: 85,
                            //         height: 32,
                            //         radius: 35,
                            //       );
                            //     }
                            //     return const SizedBox();
                            //   },
                            // ),
                            Consumer<ChatProvider>(
                              builder: (context, provider, child) {
                                return Expanded(
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: CustomButton(
                                      text: LocaleKeys.call.tr(),
                                      textColor:
                                          Theme.of(context).primaryColorDark,
                                      onPressed: () =>
                                          UtilURLLauncher.makePhoneCall(
                                        provider.storeHudModel.result!.chat!
                                            .otherUser!.phone!,
                                      ),
                                      color: Colors.transparent,
                                      isOutLinedButton: true,
                                      borderColor:
                                          Theme.of(context).primaryColorDark,
                                      width: 85,
                                      height: 32,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              : snapshot.hasError
                  ? const CustomErrorWidget()
                  : const CustomLoadingWidget(size: 35);
        });
  }
}
