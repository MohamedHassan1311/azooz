import '../../../common/config/tools.dart';
import '../../../common/style/colors.dart';
import 'package:flutter/material.dart';

import 'package:pin_code_fields/pin_code_fields.dart';

class OtpCodeWidget extends StatefulWidget {
  final Function(String)? onCompleted;

  const OtpCodeWidget({Key? key, required this.onCompleted}) : super(key: key);

  @override
  OtpCodeWidgetState createState() => OtpCodeWidgetState();
}

class OtpCodeWidgetState extends State<OtpCodeWidget> {
  @override
  Widget build(BuildContext context) {
    return PinCodeTextField(
      obscuringCharacter: '*',
      keyboardType: TextInputType.number,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      appContext: context,

      length: 5,
      obscureText: false,
      animationType: AnimationType.fade,
      pinTheme: PinTheme(
        shape: PinCodeFieldShape.box,
        borderRadius: BorderRadius.circular(15),
        activeColor: Colors.black12,
        inactiveColor: Colors.black12,
        activeFillColor: Palette.kGrey200,
        inactiveFillColor: Palette.kGrey200,
        selectedFillColor: Palette.kGrey100,
        fieldHeight: 55,
        fieldWidth: 55,
        selectedColor: Palette.kGrey200,
        disabledColor: Palette.kGrey200,
      ),
      animationDuration: const Duration(milliseconds: 200),
      backgroundColor: Palette.kWhite,

      useHapticFeedback: true,
      enableActiveFill: true,
      useExternalAutoFillGroup: true,
      // autoDisposeControllers: true,
      enablePinAutofill: true,
      autoDismissKeyboard: true,
      inputFormatters: Tools.digitsOnlyFormatter(),
      hapticFeedbackTypes: HapticFeedbackTypes.vibrate,
      onCompleted: widget.onCompleted,
      beforeTextPaste: (text) {
        print("Allowing to paste $text");
        return true;
      },
      onChanged: (String value) {
        print('## On Change: $value');
      },
    );
  }
}
