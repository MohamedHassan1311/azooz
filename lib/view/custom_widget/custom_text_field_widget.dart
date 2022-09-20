import '../../common/style/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextFieldWidget extends StatelessWidget {
  final TextEditingController? controller;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;
  final int? maxLength;
  final FocusNode? focusNode;
  final String? hintText;
  final int? maxLines;
  final String? errorText;
  final Widget? prefixWidget;
  final Widget? suffixWidget;
  final Color? fillColor;
  final bool? filled;
  final bool? readOnly;
  final TextAlign textAlign;
  final TextStyle? hintStyle;
  final bool? obscureText;
  final TextInputType? textInputType;
  final List<TextInputFormatter>? inputFormatters;
  final Iterable<String>? autofillHints;
  final Function()? onEditingComplete;
  final TextAlignVertical? textAlignVertical;
  final TextInputAction? textInputAction;
  final bool? withUnderlineBorder;
  final bool? isDense;
  final EdgeInsetsGeometry? contentPadding;
  final TextCapitalization textCapitalization;

  const CustomTextFieldWidget({
    Key? key,
    this.controller,
    this.onChanged,
    this.validator,
    this.errorText,
    this.onEditingComplete,
    this.maxLength,
    this.autofillHints,
    this.focusNode,
    this.inputFormatters,
    this.maxLines = 1,
    this.hintText,
    this.hintStyle,
    this.prefixWidget,
    this.suffixWidget,
    this.textAlign = TextAlign.start,
    this.readOnly = false,
    this.filled = false,
    this.fillColor = Palette.activeWidgetsColor,
    this.obscureText = false,
    this.textInputType,
    this.contentPadding = const EdgeInsets.symmetric(horizontal: 10),
    this.textAlignVertical = TextAlignVertical.center,
    this.textInputAction = TextInputAction.done,
    this.withUnderlineBorder = false,
    this.isDense = false,
    this.textCapitalization = TextCapitalization.none,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: false,
      focusNode: focusNode,
      cursorColor: Palette.kBlack,
      readOnly: readOnly!,
      controller: controller,
      autofillHints: autofillHints,
      onChanged: onChanged,
      // style: const TextStyle(color: Palette.primaryColor),
      textInputAction: textInputAction,
      textAlign: textAlign,
      textAlignVertical: textAlignVertical,
      keyboardType: textInputType,
      onEditingComplete: onEditingComplete,
      inputFormatters: inputFormatters,
      textCapitalization: textCapitalization,
      decoration: InputDecoration(
        // isDense: isDense,
        prefix: prefixWidget,
        suffix: suffixWidget,
        hintText: hintText,

        // filled: filled,
        filled: true,
        fillColor: fillColor,
        hintStyle: hintStyle,
        contentPadding: contentPadding,
        // border: withUnderlineBorder == false ? InputBorder.none : null,
        // focusedBorder: UnderlineInputBorder(
        //   borderSide: BorderSide(
        //     color: withUnderlineBorder == false
        //         ? Colors.transparent
        //         : Palette.primaryColor,
        //   ),
        // ),

        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
          borderSide: BorderSide.none,
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
          borderSide: BorderSide.none,
        ),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
          borderSide: BorderSide.none,
        ),
      ),
      maxLength: maxLength,
      maxLines: maxLines,
      obscureText: obscureText!,
      validator: validator,
    );
  }
}
