import 'dart:async';

import '../../common/style/colors.dart';
import '../../common/style/style.dart';
import '../../generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:flutter_typeahead/flutter_typeahead.dart';

class CustomSearchFormWidget extends StatelessWidget {
  final FutureOr<Iterable<String>> Function(String)? suggestionsCallback;
  final TextEditingController? controller;
  final String? validatorText;
  final double? radius;
  final bool? withShadow;
  final bool? withSuggestion;
  final Function(String?)? onSaved;
  final Function(String)? onChanged;
  final Function(String)? onSubmitted;
  final Color? fillColor;

  const CustomSearchFormWidget({
    Key? key,
    this.suggestionsCallback,
    this.withSuggestion = true,
    required this.controller,
    required this.validatorText,
    this.withShadow = true,
    this.radius = 30,
    this.fillColor = Palette.activeWidgetsColor,
    this.onSaved,
    this.onChanged,
    this.onSubmitted,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: cardDecoration6(
        context: context,
        radius: radius,
        withShadow: withShadow!,
      ),
      child: TypeAheadFormField(
        textFieldConfiguration: TextFieldConfiguration(
          autocorrect: true,
          onChanged: onChanged,
          onSubmitted: onSubmitted,
          controller: controller,
          decoration: InputDecoration(
            hintText: LocaleKeys.search.tr(),
            hintStyle: const TextStyle(
              fontSize: 14,
              color: Palette.kBlack,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(radius!),
              borderSide: const BorderSide(
                width: 0,
                style: BorderStyle.none,
              ),
            ),
            filled: true,
            fillColor: fillColor,
            contentPadding: const EdgeInsets.all(10),
            prefixIcon: const Padding(
              padding: EdgeInsetsDirectional.only(start: 24.0, end: 16.0),
              child: Icon(
                Icons.search,
                color: Palette.kBlack,
                size: 25,
              ),
            ),
          ),
        ),
        errorBuilder: (BuildContext context, Object? error) => Text(
          '$error',
          style: TextStyle(
            color: Theme.of(context).errorColor,
          ),
        ),
        suggestionsCallback: suggestionsCallback!,
        hideOnLoading: withSuggestion == true ? false : true,
        hideOnError: withSuggestion == true ? false : true,
        hideOnEmpty: withSuggestion == true ? false : true,
        itemBuilder: (context, String suggestion) {
          return ListTile(
            title: Text(suggestion),
          );
        },
        transitionBuilder: (context, suggestionsBox, controller) {
          return suggestionsBox;
        },
        onSuggestionSelected: (String suggestion) {
          controller!.text = suggestion;
        },
        validator: (value) => value!.isEmpty ? validatorText! : null,
        onSaved: onSaved,
      ),
    );
  }
}
