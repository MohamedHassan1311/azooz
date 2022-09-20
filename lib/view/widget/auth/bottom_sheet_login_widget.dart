import 'package:azooz/common/style/colors.dart';

import '../../../common/config/tools.dart';
import '../../../common/style/dimens.dart';
import '../../../generated/locale_keys.g.dart';
import '../../../utils/smart_text_inputs.dart';
import '../../custom_widget/country_code_widget.dart';
import '../../custom_widget/custom_button.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class BottomSheetLoginWidget extends StatelessWidget {
  final Function(CountryCode)? onChangedCountryCode;
  final Function()? onPressed;
  final TextEditingController? controller;
  final int phoneLength;

  const BottomSheetLoginWidget({
    Key? key,
    required this.onChangedCountryCode,
    required this.controller,
    required this.onPressed,
    required this.phoneLength,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: MediaQuery.of(context).size.height * 0.37,
      decoration: const BoxDecoration(
        color: Palette.kSelectorColor,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(30),
        ),
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
          Padding(
            padding: edgeInsetsOnly(top: 20.0, bottom: 30),
            child: Text(
              LocaleKeys.login.tr(),
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            // padding: EdgeInsets.symmetric(horizontal: 20),
            height: 60,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: kBorderRadius10,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: CountryCodeWidget(
                    onChanged: onChangedCountryCode,
                  ),
                ),
                Flexible(
                  child: Center(
                    child: SmartInputTextField(
                      label: "",
                      hasLabel: false,
                      isDense: false,
                      controller: controller,
                      hintText: LocaleKeys.phoneNumber.tr(),
                      textInputType: TextInputType.number,
                      inputFormatters: Tools.digitsOnlyFormatter(),
                      fillColor: const Color(0xFFFFFFFF),
                      maxLength: phoneLength,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: edgeInsetsOnly(top: 20),
            child: CustomButton(
              text: LocaleKeys.confirm.tr(),
              onPressed: onPressed,
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
