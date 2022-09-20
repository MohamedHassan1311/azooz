import '../../common/config/assets.dart';
import '../../common/routes/app_router_control.dart';
import '../../common/style/colors.dart';
import '../../common/style/dimens.dart';
import '../../common/style/style.dart';
import '../../generated/locale_keys.g.dart';
import '../../model/response/duration_model.dart';
import '../../providers/home_provider.dart';
import '../../providers/orders_provider.dart';
import 'custom_button.dart';
import 'custom_error_widget.dart';
import 'custom_outlined_widget.dart';
import 'custom_text_field_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:provider/provider.dart';

import '../../common/routes/app_router_import.gr.dart';
import '../../model/response/home_departments_model.dart';
import '../../model/screen_argument/categories_argument.dart';
import 'custom_cached_image_widget.dart';
import 'custom_loading_widget.dart';

enum PaymentChoice { cash, wallet, ePayment }

enum PaymentChoice2 { visa, stc, aPay }

PaymentChoice paymentChoiceTest = PaymentChoice.cash;

Future<void> alertCategoriesWidget({
  required BuildContext context,
  required Future<List<DepartmentHome>> future,
  required ScrollController scrollController,
}) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: true,
    builder: (context) => AlertDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      actionsAlignment: MainAxisAlignment.center,
      actionsPadding: EdgeInsets.zero,
      buttonPadding: EdgeInsets.zero,
      insetPadding: EdgeInsets.zero,
      titlePadding: edgeInsetsOnly(bottom: 15),
      contentPadding: edgeInsetsAll(10.0),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IconButton(
            onPressed: () => routerPop(context),
            icon: const Icon(Icons.close),
          ),
          Center(
            child: Text(
              LocaleKeys.categories.tr(),
              style: const TextStyle(
                color: Palette.secondaryLight,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
      content: FutureBuilder<List<DepartmentHome>>(
          future: future,
          builder: (context, snapshot) {
            return snapshot.hasData
                ? SizedBox(
                    height: 0.44,
                    //0.47,
                    width: 0.85,
                    child: Consumer<HomeProvider>(
                      builder: (context, provider, child) {
                        return GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            mainAxisSpacing: 25,
                            crossAxisSpacing: 25,
                            crossAxisCount: 2,
                            childAspectRatio: 0.25 / 0.05,
                          ),
                          controller: scrollController,
                          itemCount: provider.listCategories.length + 1,
                          itemBuilder: (context, index) {
                            if (index == provider.listCategories.length) {
                              return provider.loadingPagination
                                  ? const CustomLoadingPaginationWidget()
                                  : const SizedBox();
                            }
                            return GestureDetector(
                              onTap: () => routerPush(
                                context: context,
                                route: CategoriesRoute(
                                  argument: CategoriesArgument(
                                    name: provider.listCategories[index].name,
                                    id: provider.listCategories[index].id!,
                                  ),
                                ),
                              ),
                              child: Container(
                                margin: edgeInsetsOnly(end: 8, start: 8),
                                padding: edgeInsetsAll(5.0),
                                decoration: cardDecoration5(
                                    context: context, radius: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      provider.listCategories[index].name!,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText2!
                                          .copyWith(
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                    ),
                                    // sizedBox(width: 5),
                                    sizedBox(
                                      height: 35,
                                      width: 35,
                                      child: CachedImageBorderRadius(
                                        imageUrl: provider
                                            .listCategories[index].imageURL,
                                        width: 35,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  )
                : snapshot.hasError
                    ? const CustomLoadingWidget()
                    : const CustomErrorWidget();
          }),
      // actions: <Widget>[
      //   CustomButton(
      //     text: 'تم',
      //     onPressed: () => routerPop(context),
      //     width: 140,
      //     radius: 9,
      //   )
      // ],
    ),
  );
}

Future<void> alertDialogDurationWidget({
  required BuildContext context,
  required List<Durationi>? list,
}) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: true,
    builder: (context) => AlertDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      actionsAlignment: MainAxisAlignment.center,
      actionsPadding: EdgeInsets.zero,
      buttonPadding: EdgeInsets.zero,
      insetPadding: EdgeInsets.zero,
      titlePadding: edgeInsetsOnly(bottom: 15),
      contentPadding: edgeInsetsAll(10.0),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IconButton(
            onPressed: () => routerPop(context),
            icon: const Icon(Icons.close),
          ),
          Center(
            child: Text(
              LocaleKeys.deliveryTime.tr(),
              style: const TextStyle(
                color: Palette.secondaryLight,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
      content: SizedBox(
        height: 0.44,
        //0.47,
        width: 0.85,
        child: ListView.builder(
          itemCount: list!.length,
          shrinkWrap: true,
          itemBuilder: (context, index) => GestureDetector(
            onTap: () {
              Provider.of<OrdersProvider>(context, listen: false)
                  .changeDuration(
                list[index].name!,
                list[index].id!,
              );
              Navigator.of(context).pop();
            },
            child: Container(
              margin: edgeInsetsOnly(end: 8, start: 8, top: 8, bottom: 8),
              padding: edgeInsetsAll(10.0),
              decoration: cardDecoration5(context: context, radius: 10),
              child: Text(
                list[index].name ?? '',
                style: Theme.of(context).textTheme.bodyText2,
              ),
            ),
          ),
        ),
      ), // actions: <Widget>[
    ),
  );
}

Future<void> alertDialogPromoCode({required BuildContext context}) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: true,
    builder: (context) => AlertDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      actionsAlignment: MainAxisAlignment.center,
      actionsPadding: EdgeInsets.zero,
      buttonPadding: EdgeInsets.zero,
      insetPadding: EdgeInsets.zero,
      titlePadding: EdgeInsets.zero,
      contentPadding: edgeInsetsAll(10.0),
      title: Container(
        width: double.infinity,
        padding: edgeInsetsAll(5),
        decoration: const BoxDecoration(
          color: Palette.secondaryLight,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
          ),
        ),
        child: Center(
          child: Text(
            LocaleKeys.promoCode.tr(),
            style: TextStyle(color: Theme.of(context).primaryColorLight),
            textAlign: TextAlign.center,
          ),
        ),
      ),
      content: SizedBox(
        // height: 0.1,
        width: 0.35,
        child: Wrap(
          children: [
            Padding(
              padding: edgeInsetsOnly(bottom: 8),
              child: Text(
                LocaleKeys.enterPromoCode.tr(),
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ),
            SizedBox(
              height: 40,
              width: double.infinity,
              child: CustomOutlinedWidget(
                paddingAll: 0,
                marginVertical: 0,
                color: Palette.secondaryLight,
                child: Padding(
                  padding: edgeInsetsOnly(bottom: 20.0, start: 5),
                  child: CustomTextFieldWidget(
                    hintText: LocaleKeys.promoCode.tr(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        Column(
          children: [
            CustomButton(
              text: LocaleKeys.confirm.tr(),
              onPressed: () => routerPop(context),
            ),
            Padding(
              padding: edgeInsetsOnly(bottom: 10.0),
              child: GestureDetector(
                onTap: () => routerPop(context),
                child: Text(
                  LocaleKeys.cancel.tr(),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Palette.errorColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

Future<void> alertDialogWalletAmount({
  required BuildContext context,
  required Function()? onPressed,
  required TextEditingController? controller,
}) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: true,
    builder: (context) => AlertDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      actionsAlignment: MainAxisAlignment.center,
      actionsPadding: EdgeInsets.zero,
      buttonPadding: EdgeInsets.zero,
      // insetPadding: EdgeInsets.zero,
      titlePadding: EdgeInsets.zero,
      contentPadding: edgeInsetsAll(10.0),
      title: Container(
        width: MediaQuery.of(context).size.width * 0.50,
        padding: edgeInsetsAll(5),
        decoration: const BoxDecoration(
          color: Palette.secondaryLight,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
          ),
        ),
        child: Center(
          child: Text(
            LocaleKeys.wallet.tr(),
            style: TextStyle(color: Theme.of(context).primaryColorLight),
            textAlign: TextAlign.center,
          ),
        ),
      ),
      content: SizedBox(
        child: Wrap(
          children: [
            Padding(
              padding: edgeInsetsOnly(bottom: 8),
              child: Text(
                LocaleKeys.enterToWallet.tr(),
                style: const TextStyle(fontSize: 11),
              ),
            ),
            SizedBox(
              height: 40,
              width: double.infinity,
              child: CustomTextFieldWidget(
                contentPadding: edgeInsetsOnly(bottom: 11.0, start: 5),
                hintText: LocaleKeys.amount.tr(),
                controller: controller,
                textInputType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
              ),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: CustomButton(
                text: LocaleKeys.confirm.tr(),
                onPressed: onPressed,
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: edgeInsetsOnly(bottom: 10.0),
              child: GestureDetector(
                onTap: () => routerPop(context),
                child: Text(
                  LocaleKeys.cancel.tr(),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).errorColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

Future<void> alertDialogPaymentChoice({
  required BuildContext context,
  required PaymentChoice paymentChoice,
  required void Function(PaymentChoice)? onPressed,
}) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: true,
    builder: (context) => StatefulBuilder(builder: (context, setState) {
      return AlertDialog(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
        ),
        actionsAlignment: MainAxisAlignment.center,
        actionsPadding: EdgeInsets.zero,
        buttonPadding: EdgeInsets.zero,
        insetPadding: EdgeInsets.zero,
        titlePadding: EdgeInsets.zero,
        contentPadding: edgeInsetsAll(10.0),
        title: Container(
          width: double.infinity,
          padding: edgeInsetsAll(5),
          decoration: const BoxDecoration(
            color: Palette.secondaryLight,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
            ),
          ),
          child: Center(
            child: Text(
              LocaleKeys.confirmPayment.tr(),
              style: TextStyle(color: Theme.of(context).primaryColorLight),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        content: SizedBox(
          // height: 0.1,
          width: 0.35,
          child: Wrap(
            children: [
              Row(
                children: [
                  Radio<PaymentChoice>(
                    fillColor: MaterialStateColor.resolveWith(
                        (states) => Palette.kAccent),
                    value: PaymentChoice.cash,
                    groupValue: paymentChoice,
                    onChanged: (newValue) => setState(
                      () => {
                        paymentChoice = newValue!,
                        paymentChoiceTest = newValue,
                        print('@@@@ $paymentChoice'),
                      },
                    ),
                  ),
                  Text(
                    LocaleKeys.cash.tr(),
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                ],
              ),
              Row(
                children: [
                  Radio<PaymentChoice>(
                    fillColor: MaterialStateColor.resolveWith(
                        (states) => Palette.kAccent),
                    value: PaymentChoice.wallet,
                    groupValue: paymentChoice,
                    onChanged: (newValue) => setState(
                      () => {
                        paymentChoice = newValue!,
                        paymentChoiceTest = newValue,
                      },
                    ),
                  ),
                  Text(
                    LocaleKeys.wallet.tr(),
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                ],
              ),
              // Row(
              //   children: [
              //     Radio<PaymentChoice>(
              //       fillColor:
              //           MaterialStateColor.resolveWith((states) => Palette.kAccent),
              //       value: PaymentChoice.ePayment,
              //       groupValue: paymentChoice,
              //       onChanged: (newValue) => setState(
              //         () => {
              //           paymentChoice = newValue!,
              //           paymentChoiceTest = newValue,
              //         },
              //       ),
              //     ),
              //     Text(
              //       LocaleKeys.ePayment.tr(),
              //       style: Theme.of(context).textTheme.subtitle2,
              //     )
              //   ],
              // ),
            ],
          ),
        ),
        actions: <Widget>[
          Column(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.50,
                child: CustomButton(
                  text: LocaleKeys.confirm.tr(),
                  onPressed: () => {
                    onPressed!(paymentChoice),
                  },
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ],
      );
    }),
  );
}

Future<void> alertDialogPaymentChoice2({
  required BuildContext context,
  required PaymentChoice2 paymentChoice,
  required void Function()? onPressed,
}) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (context) => StatefulBuilder(builder: (context, setState) {
      return AlertDialog(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
        ),
        actionsAlignment: MainAxisAlignment.center,
        actionsPadding: EdgeInsets.zero,
        buttonPadding: EdgeInsets.zero,
        insetPadding: EdgeInsets.zero,
        titlePadding: EdgeInsets.zero,
        contentPadding: edgeInsetsAll(10.0),
        content: SizedBox(
          // height: 0.1,
          width: 0.35,
          child: Wrap(
            children: [
              Padding(
                padding: edgeInsetsOnly(top: 15.0),
                child: Center(
                  child: Text(
                    LocaleKeys.addCredit.tr(),
                    style: const TextStyle(fontWeight: FontWeight.w600),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Row(
                children: [
                  Radio<PaymentChoice2>(
                    fillColor: MaterialStateColor.resolveWith(
                        (states) => Palette.kAccent),
                    value: PaymentChoice2.visa,
                    groupValue: paymentChoice,
                    onChanged: (newValue) => setState(
                      () => paymentChoice = newValue!,
                    ),
                  ),
                  SizedBox(
                    width: 100,
                    height: 45,
                    child: visaImg,
                  ),
                ],
              ),
              Row(
                children: [
                  Radio<PaymentChoice2>(
                    fillColor: MaterialStateColor.resolveWith(
                        (states) => Palette.kAccent),
                    value: PaymentChoice2.stc,
                    groupValue: paymentChoice,
                    onChanged: (newValue) => setState(
                      () => paymentChoice = newValue!,
                    ),
                  ),
                  SizedBox(
                    width: 110,
                    height: 45,
                    child: stcImg,
                  ),
                ],
              ),
              Row(
                children: [
                  Radio<PaymentChoice2>(
                    fillColor: MaterialStateColor.resolveWith(
                        (states) => Palette.kAccent),
                    value: PaymentChoice2.aPay,
                    groupValue: paymentChoice,
                    onChanged: (newValue) => setState(
                      () => paymentChoice = newValue!,
                    ),
                  ),
                  SizedBox(
                    width: 85,
                    height: 45,
                    child: applePayImg,
                  ),
                ],
              ),
            ],
          ),
        ),
        actions: <Widget>[
          Column(
            children: [
              CustomButton(
                text: LocaleKeys.confirm.tr(),
                onPressed: onPressed,
              ),
              const SizedBox(height: 10),
            ],
          ),
        ],
      );
    }),
  );
}

Future<void> alertDialogPaymentSuccess({
  required BuildContext context,
}) async {
  return showDialog<void>(
    context: context,
    builder: (context) => StatefulBuilder(builder: (context, setState) {
      return AlertDialog(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
        ),
        actionsAlignment: MainAxisAlignment.center,
        actionsPadding: EdgeInsets.zero,
        buttonPadding: EdgeInsets.zero,
        insetPadding: EdgeInsets.zero,
        titlePadding: EdgeInsets.zero,
        contentPadding: edgeInsetsAll(10.0),
        content: SizedBox(
          // height: 0.1,
          width: 0.35,
          child: Wrap(
            children: [
              Padding(
                padding: edgeInsetsOnly(top: 15.0),
                child: Center(
                  child: SizedBox(
                    width: 85,
                    height: 85,
                    child: successSVG,
                  ),
                ),
              ),
              Center(
                child: Padding(
                  padding: edgeInsetsSymmetric(vertical: 15),
                  child: Text(
                    LocaleKeys.creditSuccessfullyAdded.tr(),
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      );
    }),
  );
}

Future<void> alertDialogConfirmPayment({
  required BuildContext context,
  required void Function()? onPressed,
}) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: true,
    builder: (context) => AlertDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      actionsAlignment: MainAxisAlignment.center,
      actionsPadding: EdgeInsets.zero,
      buttonPadding: EdgeInsets.zero,
      insetPadding: EdgeInsets.zero,
      titlePadding: EdgeInsets.zero,
      contentPadding: edgeInsetsAll(10.0),
      title: Container(
        width: double.infinity,
        padding: edgeInsetsAll(5),
        decoration: const BoxDecoration(
          color: Palette.secondaryLight,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
          ),
        ),
        child: Center(
          child: Text(
            LocaleKeys.confirmPayment.tr(),
            style: TextStyle(color: Theme.of(context).primaryColorLight),
            textAlign: TextAlign.center,
          ),
        ),
      ),
      content: SizedBox(
        // height: 0.1,
        width: 0.35,
        child: Wrap(
          alignment: WrapAlignment.center,
          children: [
            Padding(
              padding: edgeInsetsOnly(top: 15.0),
              child: Text(
                'هل تريد خصم ٧٠ ريال',
                style: Theme.of(context).textTheme.subtitle1,
              ),
            )
          ],
        ),
      ),
      actions: <Widget>[
        Column(
          children: [
            CustomButton(
              text: LocaleKeys.confirm.tr(),
              onPressed: onPressed,
            ),
            Padding(
              padding: edgeInsetsOnly(bottom: 10.0),
              child: Text(
                LocaleKeys.cancel.tr(),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).errorColor,
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

Future<void> alertDialogPaymentValue({
  required BuildContext context,
  required void Function()? onPressed,
  required String paymentValue,
}) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: true,
    builder: (context) => AlertDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      actionsAlignment: MainAxisAlignment.center,
      actionsPadding: EdgeInsets.zero,
      buttonPadding: EdgeInsets.zero,
      insetPadding: EdgeInsets.zero,
      titlePadding: EdgeInsets.zero,
      contentPadding: edgeInsetsAll(10.0),
      title: Container(
        width: double.infinity,
        padding: edgeInsetsAll(5),
        decoration: const BoxDecoration(
          color: Palette.secondaryLight,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
          ),
        ),
        child: Center(
          child: Text(
            LocaleKeys.confirmPayment.tr(),
            style: TextStyle(color: Theme.of(context).primaryColorLight),
            textAlign: TextAlign.center,
          ),
        ),
      ),
      content: SizedBox(
        // height: 0.1,
        width: 0.35,
        child: Wrap(
          alignment: WrapAlignment.center,
          children: [
            Padding(
              padding: edgeInsetsOnly(top: 15.0),
              child: Text(
                '${LocaleKeys.orderAmount.tr()} $paymentValue',
                style: Theme.of(context).textTheme.subtitle1,
              ),
            )
          ],
        ),
      ),
      actions: <Widget>[
        Column(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.50,
              child: CustomButton(
                text: LocaleKeys.confirm.tr(),
                onPressed: onPressed,
              ),
            ),
            const SizedBox(height: 10),
            GestureDetector(
              onTap: () => routerPop(context),
              child: Padding(
                padding: edgeInsetsOnly(bottom: 10.0),
                child: Text(
                  LocaleKeys.cancel.tr(),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).errorColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

Future<void> alertDialogFeedBack({
  required BuildContext context,
  required void Function()? onPressed,
}) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: true,
    builder: (context) => AlertDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      actionsAlignment: MainAxisAlignment.center,
      actionsPadding: EdgeInsets.zero,
      buttonPadding: EdgeInsets.zero,
      insetPadding: EdgeInsets.zero,
      titlePadding: EdgeInsets.zero,
      contentPadding: edgeInsetsAll(10.0),
      title: Container(
        width: double.infinity,
        padding: edgeInsetsAll(5),
        decoration: const BoxDecoration(
          color: Palette.secondaryLight,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
          ),
        ),
        child: Center(
          child: Text(
            LocaleKeys.rate.tr(),
            style: TextStyle(color: Theme.of(context).primaryColorLight),
            textAlign: TextAlign.center,
          ),
        ),
      ),
      content: SizedBox(
        // height: 0.1,
        width: 0.35,
        child: Wrap(
          alignment: WrapAlignment.center,
          children: [
            Padding(
              padding: edgeInsetsSymmetric(vertical: 10),
              child: Text(
                'برجاء تقييم مرسول',
                style: Theme.of(context).textTheme.subtitle1,
              ),
            ),
            RatingBar.builder(
              initialRating: 3,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemPadding: edgeInsetsSymmetric(horizontal: 4.0),
              itemSize: 25,
              glowColor: Palette.kRating,
              itemBuilder: (context, _) => const Icon(
                Icons.star,
                color: Palette.kRating,
              ),
              onRatingUpdate: (rating) {
                print(rating.toString());
              },
            ),
          ],
        ),
      ),
      actions: <Widget>[
        Column(
          children: [
            CustomButton(
              text: LocaleKeys.confirm.tr(),
              onPressed: onPressed,
            ),
            Padding(
              padding: edgeInsetsOnly(bottom: 10.0),
              child: Text(
                LocaleKeys.cancel.tr(),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).errorColor,
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

Future<void> alertDialogConfirmAddressDelete({
  required BuildContext context,
  required void Function()? onPressed,
}) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: true,
    builder: (context) => AlertDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      actionsAlignment: MainAxisAlignment.center,
      actionsPadding: EdgeInsets.zero,
      buttonPadding: EdgeInsets.zero,
      insetPadding: EdgeInsets.zero,
      titlePadding: EdgeInsets.zero,
      contentPadding: edgeInsetsAll(10.0),
      title: Container(
        width: double.infinity,
        padding: edgeInsetsAll(5),
        decoration: const BoxDecoration(
          color: Palette.secondaryLight,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
          ),
        ),
        child: Center(
          child: Text(
            LocaleKeys.areYouSureWantToRemove.tr(),
            style: TextStyle(color: Theme.of(context).primaryColorLight),
            textAlign: TextAlign.center,
          ),
        ),
      ),
      actions: <Widget>[
        Column(
          children: [
            Padding(
              padding: edgeInsetsOnly(top: 40, bottom: 15),
              child: CustomButton(
                text: LocaleKeys.confirm.tr(),
                onPressed: onPressed,
                width: 175,
                height: 58,
              ),
            ),
            Padding(
              padding: edgeInsetsOnly(bottom: 20.0),
              child: GestureDetector(
                onTap: () => routerPop(context),
                child: Text(
                  LocaleKeys.cancel.tr(),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).errorColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

// Future<void> alertDialogLogout({
//   required BuildContext context,
//   required void Function()? onPressed,
// }) async {
//   return showDialog<void>(
//     context: context,
//     barrierDismissible: true,
//     builder: (context) => AlertDialog(
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.all(
//           Radius.circular(15),
//         ),
//       ),
//       actionsAlignment: MainAxisAlignment.center,
//       actionsPadding: EdgeInsets.zero,
//       buttonPadding: EdgeInsets.zero,
//       insetPadding: EdgeInsets.zero,
//       titlePadding: EdgeInsets.zero,
//       contentPadding: edgeInsetsAll(10.0),
//       title: Container(
//         width: MediaQuery.of(context).size.width * 0.85,
//         padding: const EdgeInsets.symmetric(horizontal: 10),
//         decoration: const BoxDecoration(
//           color: Palette.secondaryLight,
//           borderRadius: BorderRadius.only(
//             topLeft: Radius.circular(15),
//             topRight: Radius.circular(15),
//           ),
//         ),
//         child: Center(
//           child: Text(
//             LocaleKeys.logoutMsg.tr(),
//             style: Theme.of(context)
//                 .textTheme
//                 .subtitle1!
//                 .copyWith(color: Palette.kLightPrimary),
//             textAlign: TextAlign.center,
//           ),
//         ),
//       ),
//       actions: <Widget>[
//         Column(
//           children: [
//             Padding(
//               padding: edgeInsetsOnly(top: 40, bottom: 15),
//               child: SizedBox(
//                 width: MediaQuery.of(context).size.width * 0.50,
//                 child: CustomButton(
//                   text: LocaleKeys.confirm.tr(),
//                   onPressed: onPressed,
//                   width: 175,
//                   height: 58,
//                   radius: 8,
//                   bottom: 10,
//                 ),
//               ),
//             ),
//             GestureDetector(
//               onTap: () => routerPop(context),
//               child: Padding(
//                 padding: edgeInsetsOnly(bottom: 20.0),
//                 child: Text(
//                   LocaleKeys.cancel.tr(),
//                   style: TextStyle(
//                     fontWeight: FontWeight.bold,
//                     color: Theme.of(context).errorColor,
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ],
//     ),
//   );
// }

// Future<void> alertDialogDeleteAccount({
//   required BuildContext context,
//   required void Function()? onPressed,
// }) async {
//   return showDialog<void>(
//     context: context,
//     barrierDismissible: true,
//     builder: (context) => AlertDialog(
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.all(
//           Radius.circular(15),
//         ),
//       ),
//       actionsAlignment: MainAxisAlignment.center,
//       actionsPadding: EdgeInsets.zero,
//       buttonPadding: EdgeInsets.zero,
//       insetPadding: EdgeInsets.zero,
//       titlePadding: EdgeInsets.zero,
//       contentPadding: edgeInsetsAll(10.0),
//       title: Container(
//         width: MediaQuery.of(context).size.width * 0.85,
//         padding: const EdgeInsets.symmetric(horizontal: 10),
//         decoration: const BoxDecoration(
//           color: Palette.secondaryLight,
//           borderRadius: BorderRadius.only(
//             topLeft: Radius.circular(15),
//             topRight: Radius.circular(15),
//           ),
//         ),
//         child: Center(
//           child: Text(
//             "هل تريد حذف الحساب؟",
//             style: Theme.of(context)
//                 .textTheme
//                 .subtitle1!
//                 .copyWith(color: Palette.kLightPrimary),
//             textAlign: TextAlign.center,
//           ),
//         ),
//       ),
//       actions: <Widget>[
//         Column(
//           children: [
//             Padding(
//               padding: edgeInsetsOnly(top: 40, bottom: 15),
//               child: SizedBox(
//                 width: MediaQuery.of(context).size.width * 0.50,
//                 child: CustomButton(
//                   text: LocaleKeys.confirm.tr(),
//                   onPressed: onPressed,
//                   width: 175,
//                   height: 58,
//                   radius: 8,
//                   bottom: 10,
//                 ),
//               ),
//             ),
//             GestureDetector(
//               onTap: () => routerPop(context),
//               child: Padding(
//                 padding: edgeInsetsOnly(bottom: 20.0),
//                 child: Text(
//                   LocaleKeys.cancel.tr(),
//                   style: TextStyle(
//                     fontWeight: FontWeight.bold,
//                     color: Theme.of(context).errorColor,
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ],
//     ),
//   );
// }
// End
