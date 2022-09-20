import 'package:flutter/material.dart';

class CustomDropdownButton<T> extends StatelessWidget {
  final List<DropdownMenuItem<T>>? items;
  final T? value;
  final Widget? hint;
  final Function(T?)? onChanged;
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

  const CustomDropdownButton({
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
  })  : assert(items != null),
        // assert(value == null ||
        //     items!
        //             .where((DropdownMenuItem<T> item) => item.value == value)
        //             .length ==
        //         1),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: ButtonTheme(
        alignedDropdown: alignedDropdown!,
        padding: EdgeInsets.zero,
        child: DropdownButtonFormField(
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: placeHolder,
            prefixIcon: prefixIcon == null
                ? null
                : Icon(
                    prefixIcon,
                    color: prefixIconColor,
                  ),
            // enabledBorder: UnderlineInputBorder(
            //   borderSide: BorderSide(
            //     color: withUnderLine == false ? Colors.transparent : Palette.kBlack,
            //     width: 0.5,
            //   ),
            // ),
          ),
          elevation: elevation!,
          value: value,
          items: items,
          isExpanded: isExpanded!,
          isDense: isDense!,
          enableFeedback: true,
          iconSize: iconSize!,
          icon: Icon(icon, color: iconColor),
          onChanged: onChanged,
          // hint: hint,
          style: Theme.of(context).textTheme.bodyText2,
        ),
      ),
    );
  }
}
