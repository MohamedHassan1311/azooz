import 'package:azooz/view/custom_widget/custom_button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../common/custom_waiting_dialog.dart';
import '../../../../common/payment_consts.dart';
import '../../../../common/style/dimens.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../../../providers/payment_provider.dart';
import '../../../custom_widget/alert_dialog_widgets.dart';
import '../../../custom_widget/animated_switcher_widget.dart';
import '../../../widget/drawer/payment/wallet_list_widget.dart';
import '../../payment/reacharge_screen.dart';

class PaymentWaysScreen extends StatefulWidget {
  static const routeName = 'payment_ways';

  const PaymentWaysScreen({Key? key}) : super(key: key);

  @override
  State<PaymentWaysScreen> createState() => _PaymentWaysScreenState();
}

class _PaymentWaysScreenState extends State<PaymentWaysScreen>
    with TickerProviderStateMixin {
  PaymentChoice2 paymentChoice = PaymentChoice2.visa;

  late TextEditingController _walletController;
  late TabController _tabController;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
    _walletController = TextEditingController();
    selectedSwitch = ValueNotifier<bool>(false);
    _tabController = TabController(length: 1, vsync: this);
  }

  @override
  void dispose() {
    _walletController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: false,

      // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      // floatingActionButton: ValueListenableBuilder<bool>(
      //   valueListenable: selectedSwitch,
      //   builder: (context, value, widget) {
      //     return FloatingActionButton(
      //       backgroundColor: Palette.primaryColor,
      //       onPressed: () {
      //         showDialog(
      //             context: _scaffoldKey.currentContext!,
      //             builder: (context) {
      //               return SmartAlertDialogWithTextField(
      //                 controller: _walletController,
      //                 confirmPress: () {
      //                   context.read<PaymentProvider>().setPayRechargeId =
      //                       PayRechargeIds.rechargeWalletId;
      //                   Navigator.push(
      //                     context,
      //                     MaterialPageRoute(
      //                       builder: (_) {
      //                         return RechargeScreen(
      //                           id: 0,
      //                           amount: double.parse(
      //                             _walletController.text.trim().toString(),
      //                           ),
      //                         );
      //                       },
      //                     ),
      //                   ).then((value) {
      //                     _walletController.clear();
      //                     Navigator.of(context, rootNavigator: true).pop();
      //                   });
      //                 },
      //                 cancelPress: () {
      //                   Navigator.of(context, rootNavigator: true).pop();
      //                 },
      //                 confirmText: LocaleKeys.confirm.tr(),
      //                 cancelText: LocaleKeys.cancel.tr(),
      //               );
      //             });
      //       },
      //       child: const Icon(Icons.add),
      //     );
      //   },
      // ),

      appBar: AppBar(
        title: Text(
          LocaleKeys.wallet.tr(),
          style: const TextStyle(color: Colors.black),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            children: [
              Expanded(
                child: Column(
                  children: [
                    const SizedBox(height: 10),

                    // AnimatedContainer(
                    //   duration: const Duration(seconds: 2),
                    //   height: 40,
                    //   // padding: const EdgeInsets.symmetric(horizontal: 10),
                    //   margin: const EdgeInsets.symmetric(horizontal: 10),
                    //   decoration: const BoxDecoration(
                    //     color: Color.fromARGB(255, 239, 237, 237),
                    //     borderRadius: kBorderRadius10,
                    //   ),
                    //   child: TabBar(
                    //     indicator: const BoxDecoration(
                    //       color: Palette.primaryColor,
                    //       borderRadius: kBorderRadius10,
                    //     ),

                    //     controller: _tabController,
                    //     tabs: [
                    //       // Text(LocaleKeys.ePayment.tr()),
                    //       Text(LocaleKeys.wallet.tr()),
                    //     ],
                    //     // child: Padding(
                    //     //   padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    //     //   child: Column(children: [
                    //     //     SmartInputTextField(
                    //     //       label: "",
                    //     //       hintText: LocaleKeys.phone.tr(),
                    //     //       fillColor: Colors.white,
                    //     //     ),
                    //     //     // TextFormField(),
                    //     //   ]),
                    //     // ),
                    //   ),
                    // ),

                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.all(10.0),
                        decoration: const BoxDecoration(
                          borderRadius: kBorderRadius10,
                          color: Color.fromARGB(255, 255, 255, 255),
                        ),
                        child: TabBarView(
                          controller: _tabController,
                          children: const [
                            // PaymentWaysListWidget(),
                            WalletListWidget(),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    CustomButton(
                      text: "شحن المحفظة",
                      onPressed: () {
                        showDialog(
                            context: _scaffoldKey.currentContext!,
                            builder: (context) {
                              return SmartAlertDialogWithTextField(
                                controller: _walletController,
                                confirmPress: () {
                                  context
                                          .read<PaymentProvider>()
                                          .setPayRechargeId =
                                      PayRechargeIds.rechargeWalletId;
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) {
                                        return RechargeScreen(
                                          id: 0,
                                          amount: double.parse(
                                            _walletController.text
                                                .trim()
                                                .toString(),
                                          ),
                                        );
                                      },
                                    ),
                                  ).then((value) {
                                    _walletController.clear();
                                    Navigator.of(context, rootNavigator: true)
                                        .pop();
                                  });
                                },
                                cancelPress: () {
                                  Navigator.of(context, rootNavigator: true)
                                      .pop();
                                },
                                confirmText: LocaleKeys.confirm.tr(),
                                cancelText: LocaleKeys.cancel.tr(),
                              );
                            });
                      },
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
