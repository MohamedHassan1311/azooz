import 'dart:convert';

import '../../utils/decimal_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logger/logger.dart';

final Logger logger = Logger();

class Tools {
  static final Tools _instance = Tools.internal();

  Tools.internal();

  factory Tools() => _instance;

  static List<TextInputFormatter> digitsOnlyFormatter() {
    return <TextInputFormatter>[
      FilteringTextInputFormatter.digitsOnly,
      FilteringTextInputFormatter.allow(RegExp("[0-9]")),
    ];
  }

  static List<TextInputFormatter> digitsDecimalOnlyFormatter() {
    return <TextInputFormatter>[
      FilteringTextInputFormatter.digitsOnly,
      DecimalTextInputFormatter(decimalRange: 2),
    ];
  }

  static Future<Map<String, dynamic>> loadJson(String path) async {
    String content = await rootBundle.loadString(path);
    return jsonDecode(content);
  }

  static fieldFocusChange(
      BuildContext context, FocusNode current, FocusNode next) {
    current.unfocus();
    FocusScope.of(context).requestFocus(next);
  }

  static void hideKeyboard(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  static List<String> split(String string, String separator, {int max = 0}) {
    var result = <String>[];

    if (separator.isEmpty) {
      result.add(string);
      return result;
    }

    while (true) {
      var index = string.indexOf(separator, 0);
      if (index == -1 || (max > 0 && result.length >= max)) {
        result.add(string);
        break;
      }

      result.add(string.substring(0, index));
      string = string.substring(index + separator.length);
    }

    return result;
  }

  static List<T> removeDuplicates2<T>(List<T> list) {
    final Map<String, T> map = {};
    int count = -1;
    for (var item in list) {
      count++;
      map[count.toString()] = item;
    }
    return map.values.toList();
  }

  static List<T> removeDuplicates<T>(List<T> list) {
    return list.toSet().toList();
  }

  static scrollListener({
    required ScrollController scrollController,
    required Function getMoreData,
    double offSet = 250,
  }) {
    if (scrollController.position.pixels >
        scrollController.position.maxScrollExtent - offSet) {
      getMoreData();
    }
  }
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
