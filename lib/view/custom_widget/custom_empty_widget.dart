import 'package:flutter/material.dart';

import '../../common/style/colors.dart';

class CustomEmptyWidget extends StatelessWidget {
  final String? message;

  const CustomEmptyWidget({
    Key? key,
    this.message = 'لا يوجد بيانات متاحه حاليا',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        message!,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 14,
          color: Palette.kErrorRed,
        ),
      ),
    );
  }
}
