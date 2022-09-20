import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../common/style/colors.dart';

class SmartInputTextField extends StatelessWidget {
  final TextEditingController? controller;
  final Function(dynamic)? onChanged;
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
  final String label;

  final CrossAxisAlignment alignment;
  final bool hasLabel;

  const SmartInputTextField({
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
    this.fillColor = Palette.kWhite,
    this.obscureText = false,
    this.textInputType,
    this.contentPadding = EdgeInsets.zero,
    this.textAlignVertical = TextAlignVertical.center,
    this.textInputAction = TextInputAction.done,
    this.withUnderlineBorder = false,
    this.isDense = false,
    this.textCapitalization = TextCapitalization.none,
    required this.label,
    this.alignment = CrossAxisAlignment.start,
    this.hasLabel = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: alignment,
      children: [
        if (hasLabel) ...[
          const SizedBox(height: 10),
          Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 5),
        ],
        TextFormField(
          autofocus: false,
          focusNode: focusNode,
          cursorColor: Palette.kBlack,
          readOnly: readOnly!,
          controller: controller,
          autofillHints: autofillHints,
          onChanged: onChanged,
          textInputAction: textInputAction,
          textAlign: textAlign,
          textAlignVertical: textAlignVertical,
          keyboardType: textInputType,
          onEditingComplete: onEditingComplete,
          inputFormatters: inputFormatters,
          textCapitalization: textCapitalization,
          style: const TextStyle(fontSize: 14),
          decoration: InputDecoration(
            // contentPadding: contentPadding,
            // contentPadding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
            isDense: true,
            counterText: "",

            prefix: prefixWidget,
            suffix: suffixWidget,
            hintText: hintText,

            filled: true,

            // fillColor: Palette.activeWidgetsColor,
            fillColor: fillColor,
            hintStyle: const TextStyle(fontSize: 14, color: Palette.kGrey),
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
              borderSide: BorderSide.none,
            ),
            // border: InputBorder.none,
          ),
          maxLength: maxLength,
          maxLines: maxLines,
          obscureText: obscureText!,
          validator: validator,
        ),
      ],
    );
  }
}

class SmartDropDownField<T> extends StatelessWidget {
  final List<DropdownMenuItem<T>>? items;
  final dynamic value;
  final Widget? hint;
  final ValueChanged<dynamic>? onChanged;
  final int? elevation;
  final double? iconSize;
  final bool? withUnderLine;
  final bool? isDense;
  final bool? isExpanded;
  final bool? alignedDropdown;
  final IconData? icon;
  final IconData? prefixIcon;
  final Color? prefixIconColor;
  final Color? iconColor;
  final String? placeHolder;

  final String label;
  final bool hasLabel;
  final Color fillColor;

  const SmartDropDownField({
    Key? key,
    required this.items,
    this.value,
    this.hint,
    required this.onChanged,
    this.prefixIcon,
    this.prefixIconColor = Colors.grey,
    this.iconColor = Colors.grey,
    this.elevation = 8,
    this.icon = Icons.arrow_drop_down,
    this.iconSize = 24.0,
    this.isDense = true,
    this.isExpanded = true,
    this.alignedDropdown = true,
    this.withUnderLine = false,
    this.placeHolder = "",
    required this.label,
    this.hasLabel = true,
    this.fillColor = Palette.kWhite,
  })  : assert(items != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    const outlineInputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(10),
      ),
      borderSide: BorderSide.none,
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (hasLabel) ...[
          const SizedBox(height: 10),
          Text(label),
        ],
        const SizedBox(height: 5),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: ButtonTheme(
            alignedDropdown: true,
            child: DropdownButtonFormField<T>(
              decoration: InputDecoration(
                isDense: true,
                filled: true,
                fillColor: fillColor,
                border: outlineInputBorder,
                enabledBorder: outlineInputBorder,
                focusedBorder: outlineInputBorder,
              ),
              elevation: elevation!,
              items: items,
              isExpanded: false,
              iconSize: iconSize!,
              icon: Icon(icon, color: iconColor),
              onChanged: onChanged,
              borderRadius: const BorderRadius.all(
                Radius.circular(10),
              ),
              hint: hint,
              style: const TextStyle(
                color: Colors.black,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
