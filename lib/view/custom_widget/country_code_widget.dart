import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';

class CountryCodeWidget extends StatelessWidget {
  final Function(CountryCode)? onChanged;
  final TextStyle? textStyle;
  final bool? showFlag;
  final bool? showFlagMain;
  final bool? showDropDownButton;
  final String initialSelection;

  const CountryCodeWidget({
    Key? key,
    required this.onChanged,
    this.textStyle,
    this.showFlag = true,
    this.showFlagMain = true,
    this.showDropDownButton = true,
    this.initialSelection = '+966',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2.0),
      child: CountryCodePicker(
        onChanged: onChanged,
        initialSelection: initialSelection,
        enabled: true,
        showOnlyCountryWhenClosed: false,
        showFlagDialog: true,
        showFlagMain: true,
        showFlag: true,
        hideSearch: true,
        hideMainText: false,
        flagWidth: 30,
        showDropDownButton: showDropDownButton!,
        countryFilter: const ['SA', 'EG', 'AE'],
        textStyle: textStyle,
        dialogSize: Size(screenWidth * 0.8, screenHeight * 0.3),
        flagDecoration: const BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(3),
          ),
        ),
        onInit: (code) => print(
            "On Init: Code Name => ${code!.name} - Dial Code => ${code.dialCode}"),
        comparator: (a, b) => b.code!.compareTo(a.code!),
        padding: const EdgeInsets.all(2),
      ),
    );
  }
}
