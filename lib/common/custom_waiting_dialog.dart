import 'package:azooz/common/style/colors.dart';
import 'package:azooz/providers/payment_provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../generated/locale_keys.g.dart';
import 'circular_progress.dart';
import 'style/dimens.dart';

Future<dynamic> customWaitingDialog(BuildContext context) {
  return showDialog(
    context: context,
    builder: (context) => WillPopScope(
      onWillPop: () async => false,
      child: const CustomProgressIndicator(),
    ),
  );
}

Future<dynamic> paymentSuccessfully(BuildContext context) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("تأكيد الدفع"),
          content: const Text("تم تأكيد الدفع بنجاح"),
          actions: [
            TextButton(
              child: const Text("حسنا"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      });
}

Future<dynamic> creditStatusDialog(BuildContext context) async {
  final status = context.read<PaymentProvider>().creditStatusResult;
  await showDialog(
      context: context,
      builder: (context) {
        return SuccessSingleAlertDialog(
          description: status,
          cancelPress: () {
            Navigator.of(context).pop();
          },
          cancelText: LocaleKeys.cancel.tr(),
        );
        // return AlertDialog(
        //   title: const Text("تأكيد الشحن"),
        //   content: Text(status),
        //   actions: [
        //     TextButton(
        //       child: const Text("حسنا"),
        //       onPressed: () {
        //         Navigator.of(context).pop();
        //       },
        //     ),
        //   ],
        // );
      });
}

Future<dynamic> rechargeWalletFailure(BuildContext context) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("تأكيد الشحن"),
          content: const Text("لم يتم شحن المحفظة"),
          actions: [
            TextButton(
              child: const Text("حسنا"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      });
}

class SmartAlertDialog extends StatelessWidget {
  SmartAlertDialog({
    Key? key,
    required this.title,
    required this.description,
    required this.confirmPress,
    required this.cancelPress,
    required this.confirmText,
    required this.cancelText,
    this.isCancelable = false,
  }) : super(key: key);

  void Function()? confirmPress;
  void Function()? cancelPress;
  final String title;
  final String description;
  final String confirmText;
  final String cancelText;
  final bool isCancelable;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 0,
      backgroundColor: const Color(0xffffffff),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 15),
          // Text(
          //   title,
          //   style: const TextStyle(
          //     fontSize: 18.0,
          //     fontWeight: FontWeight.bold,
          //   ),
          // ),
          Center(
              child: Container(
            width: 60,
            height: 60,
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey.shade100,
            ),
            child: const Icon(
              FluentIcons.warning_16_regular,
              color: Palette.primaryColor,
              size: 35,
            ),
          )),
          const SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Text(description),
          ),
          const SizedBox(height: 20),
          const Divider(
            height: 1,
            color: Color(0xFFEEEEEE),
            thickness: 1.0,
          ),
          SizedBox(
            height: 50,
            child: Row(
              children: [
                Expanded(
                  child: InkWell(
                    borderRadius: const BorderRadius.only(
                      bottomRight: Radius.circular(15.0),
                    ),
                    highlightColor: const Color(0xFFEEEEEE),
                    onTap: confirmPress,
                    child: Center(
                      child: Text(
                        confirmText,
                        style: TextStyle(
                          fontSize: 14.0,
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                const VerticalDivider(
                  color: Color(0xFFEEEEEE),
                  thickness: 1.0,
                  width: 1,
                ),
                Expanded(
                  child: InkWell(
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(15.0),
                    ),
                    highlightColor: const Color(0xFFEEEEEE),
                    onTap: cancelPress,
                    child: Center(
                      child: Text(
                        cancelText,
                        style: const TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SuccessSingleAlertDialog extends StatelessWidget {
  SuccessSingleAlertDialog({
    Key? key,
    required this.description,
    required this.cancelPress,
    required this.cancelText,
    this.isCancelable = false,
  }) : super(key: key);

  void Function()? cancelPress;
  final String description;
  final String cancelText;
  final bool isCancelable;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return Future.value(isCancelable);
      },
      child: Dialog(
        elevation: 0,
        backgroundColor: const Color(0xffffffff),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 15),
            Center(
                child: Container(
              width: 60,
              height: 60,
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey.shade100,
              ),
              child: const Icon(
                FluentIcons.checkmark_32_filled,
                color: Palette.primaryColor,
                size: 35,
              ),
            )),
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Text(description),
            ),
            const SizedBox(height: 20),
            const Divider(
              height: 1,
              color: Color(0xFFEEEEEE),
              thickness: 1.0,
            ),
            SizedBox(
              height: 50,
              child: InkWell(
                borderRadius: const BorderRadius.vertical(
                  bottom: Radius.circular(15.0),
                ),
                highlightColor: const Color(0xFFEEEEEE),
                onTap: cancelPress,
                child: Center(
                  child: Text(
                    cancelText,
                    style: const TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SmartSingleAlertDialog extends StatelessWidget {
  SmartSingleAlertDialog({
    Key? key,
    required this.description,
    required this.cancelPress,
    required this.cancelText,
    this.isCancelable = false,
  }) : super(key: key);

  void Function()? cancelPress;
  final String description;
  final String cancelText;
  final bool isCancelable;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return Future.value(isCancelable);
      },
      child: Dialog(
        elevation: 0,
        backgroundColor: const Color(0xffffffff),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 15),
            Center(
                child: Container(
              width: 60,
              height: 60,
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey.shade100,
              ),
              child: const Icon(
                FluentIcons.warning_16_regular,
                color: Palette.primaryColor,
                size: 35,
              ),
            )),
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Text(description),
            ),
            const SizedBox(height: 20),
            const Divider(
              height: 1,
              color: Color(0xFFEEEEEE),
              thickness: 1.0,
            ),
            SizedBox(
              height: 50,
              child: InkWell(
                borderRadius: const BorderRadius.vertical(
                  bottom: Radius.circular(15.0),
                ),
                highlightColor: const Color(0xFFEEEEEE),
                onTap: cancelPress,
                child: Center(
                  child: Text(
                    cancelText,
                    style: const TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/////////
class SmartAlertDialogWithTextField extends StatelessWidget {
  SmartAlertDialogWithTextField({
    Key? key,
    required this.confirmPress,
    required this.cancelPress,
    required this.confirmText,
    required this.cancelText,
    required this.controller,
    this.isCancelable = false,
  }) : super(key: key);

  void Function()? confirmPress;
  void Function()? cancelPress;
  final String confirmText;
  final String cancelText;
  final bool isCancelable;
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 0,
      backgroundColor: const Color(0xffffffff),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 15),
          Center(
            child: Container(
              width: 60,
              height: 60,
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey.shade100,
              ),
              child: const Icon(
                FluentIcons.wallet_16_regular,
                color: Palette.primaryColor,
                size: 35,
              ),
            ),
          ),
          const SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Text(LocaleKeys.enterToWallet.tr()),
          ),
          const SizedBox(height: 20),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 14.0),
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            height: 42,
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 234, 234, 234),
              borderRadius: kBorderRadius5,
            ),
            child: TextFormField(
              controller: controller,
              keyboardType: TextInputType.number,
              // inputFormatters: [
              //   FilteringTextInputFormatter.digitsOnly,
              // ],
              decoration: InputDecoration(
                border: InputBorder.none,
                isDense: true,
                hintText: LocaleKeys.amount.tr(),
                hintStyle: TextStyle(
                  fontSize: 14.0,
                  color: Colors.black.withOpacity(0.5),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          const Divider(
            height: 1,
            color: Color(0xFFEEEEEE),
            thickness: 1.0,
          ),
          SizedBox(
            height: 50,
            child: Row(
              children: [
                Expanded(
                  child: InkWell(
                    borderRadius: const BorderRadius.only(
                      bottomRight: Radius.circular(15.0),
                    ),
                    highlightColor: const Color(0xFFEEEEEE),
                    onTap: confirmPress,
                    child: Center(
                      child: Text(
                        confirmText,
                        style: TextStyle(
                          fontSize: 14.0,
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                const VerticalDivider(
                  color: Color(0xFFEEEEEE),
                  thickness: 1.0,
                  width: 1,
                ),
                Expanded(
                  child: InkWell(
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(15.0),
                    ),
                    highlightColor: const Color(0xFFEEEEEE),
                    onTap: cancelPress,
                    child: Center(
                      child: Text(
                        cancelText,
                        style: const TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SmartAlertWithDescription extends StatelessWidget {
  const SmartAlertWithDescription({
    Key? key,
    required this.description,
    this.isCancelable = true,
  }) : super(key: key);

  final String description;
  final bool isCancelable;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return Future.value(isCancelable);
      },
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.50,
        child: Dialog(
          elevation: 0,
          backgroundColor: const Color(0xffffffff),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 15),
              Center(
                  child: Container(
                width: 60,
                height: 60,
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey.shade100,
                ),
                child: const Icon(
                  FluentIcons.checkmark_16_regular,
                  color: Palette.primaryColor,
                  size: 35,
                ),
              )),
              const SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Text(description),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
