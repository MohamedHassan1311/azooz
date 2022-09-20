import 'package:azooz/common/routes/app_router_control.dart';
import 'package:azooz/common/routes/app_router_import.gr.dart';
import 'package:azooz/common/style/dimens.dart';
import 'package:azooz/utils/dialogs.dart';

import '../../../app.dart';
import '../../../common/config/assets.dart';
import '../../../common/style/colors.dart';
import '../../../generated/locale_keys.g.dart';
import '../../../providers/orders_provider.dart';
import '../../custom_widget/custom_button.dart';
import 'package:clipboard/clipboard.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class OrderSuccessfulScreen extends StatefulWidget {
  static const routeName = 'order_successful';

  const OrderSuccessfulScreen({Key? key}) : super(key: key);

  @override
  State<OrderSuccessfulScreen> createState() => _OrderSuccessfulScreenState();
}

class _OrderSuccessfulScreenState extends State<OrderSuccessfulScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        getIt<AppRouter>().pushAndPopUntil(const HomeRoute(), predicate: (val) {
          return false;
        });
        return Future.value(false);
      },
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 7,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 35),
                    SizedBox(
                      height: 45,
                      width: 45,
                      child: correctSVG,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      LocaleKeys.successfullyOrdered.tr(),
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                    const SizedBox(height: 10),
                    Container(
                      // width: 280,
                      height: 120,
                      width: MediaQuery.of(context).size.width * 0.94,
                      padding: const EdgeInsets.all(10),

                      decoration: const BoxDecoration(
                        color: Palette.activeWidgetsColor,
                        borderRadius: kBorderRadius15,
                      ),
                      child: Row(
                        children: [
                          const SizedBox(width: 5),
                          Consumer<OrdersProvider>(
                            builder: (context, provider, child) {
                              return GestureDetector(
                                onTap: () => FlutterClipboard.copy(
                                  provider.createOrderModel != null
                                      ? provider.createOrderModel!.result!.id
                                          .toString()
                                      : '0',
                                ).then(
                                  (value) {
                                    successDialog(
                                      context,
                                      LocaleKeys.successfullyCopied.tr(),
                                    );
                                  },
                                ),
                                child: SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: copySVG,
                                ),
                              );
                            },
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                Expanded(
                                  child: Text(
                                    LocaleKeys.orderNumber.tr(),
                                    style:
                                        Theme.of(context).textTheme.subtitle1,
                                  ),
                                ),
                                Consumer<OrdersProvider>(
                                  builder: (context, provider, child) {
                                    return Text(
                                      provider.createOrderModel != null
                                          ? provider
                                              .createOrderModel!.result!.id
                                              .toString()
                                          : '0',
                                      style: const TextStyle(
                                          color: Palette.kAccent),
                                    );
                                  },
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      '${LocaleKeys.note.tr()}:',
                                      style: const TextStyle(
                                        color: Palette.secondaryLight,
                                        fontSize: 10,
                                      ),
                                    ),
                                    const SizedBox(width: 5),
                                    Text(
                                      LocaleKeys.orderNoteMsg.tr(),
                                      style: const TextStyle(
                                        fontSize: 10,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 15),
                  ],
                ),
              ),
              Expanded(
                child: CustomButton(
                  width: MediaQuery.of(context).size.width * 0.94,
                  text: "قائمة الطلبات",
                  onPressed: () {
                    // routerPush(
                    //   context: context,
                    //   route: const HomeRoute(),
                    // );
                    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                      // getIt<AppRouter>().pushAndPopUntil(
                      //     const OrdersRoute(), predicate: (val) {
                      //   return false;
                      // });

                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (_) =>
                      //         const NavigationManager(selectedIndex: 3),
                      //   ),
                      //   // (route) => false,
                      // );

                      // getIt<AppRouter>().pushAndPopUntil(
                      //     const OrdersRoute(), predicate: (val) {
                      //   return false;
                      // });

                      routerPushAndPopUntil(
                        context: context,
                        route: NavigationManagerRoute(
                          selectedIndex: 3,
                        ),
                      );
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
