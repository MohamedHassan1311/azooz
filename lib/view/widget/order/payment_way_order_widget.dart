import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../common/config/assets.dart';
import '../../../common/style/colors.dart';
import '../../../generated/locale_keys.g.dart';

class PaymentWayOrderWidget extends StatelessWidget {
  const PaymentWayOrderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              LocaleKeys.paymentMethod.tr(),
              style: Theme.of(context).textTheme.subtitle1,
            ),
            Text(
              LocaleKeys.change.tr(),
              style: const TextStyle(
                color: Palette.secondaryLight,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            SizedBox(
              height: 20,
              width: 20,
              child: creditCardSVG,
            ),
            const SizedBox(width: 20),
            const Text('**** ***** **** 4747')
          ],
        ),
      ],
    );
  }
}
