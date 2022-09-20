import '../../../../common/config/tools.dart';
import '../../../../common/routes/app_router_control.dart';
import '../../../../common/style/colors.dart';
import '../../../../common/style/dimens.dart';
import '../../../../common/style/style.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../../../model/response/payments_model.dart';
import '../../../../model/screen_argument/add_payment_ways_argument.dart';
import '../../../../providers/payment_provider.dart';
import '../../../../utils/dialogs.dart';
import '../../../custom_widget/custom_button.dart';
import '../../../custom_widget/custom_drop_down.dart';
import '../../../custom_widget/custom_text_field_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:provider/provider.dart';

class AddPaymentWidget extends StatefulWidget {
  final AddPaymentWaysArgument? argument;

  const AddPaymentWidget({Key? key, this.argument}) : super(key: key);

  @override
  State<AddPaymentWidget> createState() => _AddPaymentWidgetState();
}

class _AddPaymentWidgetState extends State<AddPaymentWidget> {
  List years = [];

  List months = [];

  String selectedMonth = '';
  String selectedYear = '';

  /// These two variables is needed during Edit Card Information
  String? expiredMonth = '';
  String? expiredYear = '';

  final TextEditingController _cardHolderController = TextEditingController();
  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _cardCVVController = TextEditingController();

  @override
  void initState() {
    super.initState();
    addYearsAndMonths();

    if (widget.argument!.isNew! == true) {
      selectedMonth = months.first;
      selectedYear = years.first;
    } else {
      splitExpiredDate(widget.argument!.expiredDate);
      _cardHolderController.text = widget.argument!.fullName!;
      _cardNumberController.text = widget.argument!.number!;
    }
  }

  addYearsAndMonths() {
    var date = DateTime.now();
    print("Current date: $date end");
    int year = DateTime.now().year;
    int month = 0;
    for (var i = 0; i < 30; i++) {
      years.add(year.toString());
      year++;
    }

    for (var i = 0; i < 31; i++) {
      month++;
      if (i > 8) {
        months.add(month.toString());
      } else {
        months.add('0${month.toString()}');
      }
    }
  }

  splitExpiredDate(String? expiredDate) {
    List<String> result = Tools.split(expiredDate!, '/');
    expiredYear = result.first;
    expiredMonth = result[1];
    print('Expired Year: $expiredYear - Expired Month: $expiredMonth');
    selectedYear = expiredYear!;
    selectedMonth = expiredMonth!;
  }

  submit() {
    Tools.hideKeyboard(context);
    var provider = Provider.of<PaymentProvider>(context, listen: false);
    if (widget.argument!.isNew == true) {
      if (_cardNumberController.text.isEmpty ||
          _cardHolderController.text.isEmpty ||
          selectedYear == years.first ||
          selectedMonth == months.first) {
        errorDialog(context, LocaleKeys.pleaseInputFillAllFields.tr());
      } else {
        provider.addData(
          paymentModel: CardDetails(
            fullName: _cardHolderController.text.trim(),
            number: _cardNumberController.text.trim(),
            expiredDate: '$selectedYear-$selectedMonth-01',
            year: selectedYear,
            month: selectedMonth,
          ),
          context: context,
        );
      }
    } else {
      provider.editData(
        cardDetails: CardDetails(
          id: widget.argument!.id,
          fullName: _cardHolderController.text.trim(),
          number: _cardNumberController.text.trim(),
          expiredDate: '$selectedYear-$selectedMonth-01',
          year: selectedYear,
          month: selectedMonth,
        ),
        context: context,
      );
    }
  }

  @override
  void dispose() {
    super.dispose();
    _cardCVVController.dispose();
    _cardHolderController.dispose();
    _cardNumberController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: edgeInsetsSymmetric(horizontal: 35.0, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 35,
              decoration: cardDecoration6(context: context, radius: 12),
              margin: const EdgeInsetsDirectional.only(bottom: 5),
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: CustomTextFieldWidget(
                textCapitalization: TextCapitalization.words,
                contentPadding: edgeInsetsOnly(bottom: 10),
                hintText: LocaleKeys.cardHolder.tr(),
                textInputType: TextInputType.text,
                controller: _cardHolderController,
              ),
            ),
            sizedBox(height: 12),
            Container(
              height: 35,
              decoration: cardDecoration6(context: context, radius: 12),
              margin: const EdgeInsetsDirectional.only(bottom: 5),
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: CustomTextFieldWidget(
                contentPadding: edgeInsetsOnly(bottom: 10),
                hintText: LocaleKeys.cardNumber.tr(),
                textInputType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                controller: _cardNumberController,
              ),
            ),
            sizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                sizedBox(width: 12),
                Expanded(
                  child: CustomDropdownButton(
                    value: selectedMonth,
                    icon: Icons.keyboard_arrow_down_outlined,
                    isDense: true,
                    // style: Theme.of(context).textTheme.bodyText2,
                    items: months.map<DropdownMenuItem<String>>((map) {
                      return DropdownMenuItem<String>(
                        value: map,
                        child: Text(map),
                      );
                    }).toList(),
                    onChanged: (dynamic newValue) {
                      setState(() {
                        selectedMonth = newValue;
                      });
                      print('Selected Month: $selectedMonth');
                    },
                    hint: Text(
                      months.last.toString(),
                      style: TextStyle(
                        color: Palette.primaryColor.withOpacity(0.4),
                      ),
                    ),
                  ),
                ),
                sizedBox(width: 12),
                Expanded(
                  child: CustomDropdownButton(
                    value: selectedYear,
                    icon: Icons.keyboard_arrow_down_outlined,
                    // style: Theme.of(context).textTheme.bodyText2,
                    items: years.map<DropdownMenuItem<String>>((map) {
                      return DropdownMenuItem<String>(
                        value: map,
                        child: Text(map),
                      );
                    }).toList(),
                    onChanged: (dynamic newValue) {
                      setState(() {
                        selectedYear = newValue;
                      });
                      print('Selected Year: $selectedYear');
                    },
                    hint: Text(
                      years.first.toString(),
                      style: TextStyle(
                        color: Palette.primaryColor.withOpacity(0.4),
                      ),
                    ),
                  ),
                ),
                sizedBox(width: 12),
                Expanded(
                  child: Text(
                    LocaleKeys.expiryDate.tr(),
                  ),
                ),
              ],
            ),
            // sizedBox(height: 12),
            // Container(
            //   height: 35,
            //   decoration: cardDecoration6(context: context, radius: 12),
            //   margin: const EdgeInsetsDirectional.only(bottom: 5),
            //   padding: const EdgeInsets.symmetric(horizontal: 10),
            //   child: CustomTextFieldWidget(
            //     contentPadding: const EdgeInsets.only(bottom: 10),
            //     hintText: 'CVV',
            //     textInputType: TextInputType.number,
            //     inputFormatters: [
            //       FilteringTextInputFormatter.digitsOnly,
            //     ],
            //   ),
            // ),
            sizedBox(height: 12),
            CustomButton(
              text: widget.argument!.isNew == true
                  ? LocaleKeys.add.tr()
                  : LocaleKeys.edit.tr(),
              onPressed: submit,
              width: double.infinity,
              height: 50,
            ),
            sizedBox(height: 12),
            GestureDetector(
              onTap: () => routerPop(context),
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
      ),
    );
  }
}
