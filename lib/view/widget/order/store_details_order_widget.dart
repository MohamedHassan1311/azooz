import '../../../generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class StoreDetailsOrderWidget extends StatelessWidget {
  final String? storeName;
  final String orderNumber;

  const StoreDetailsOrderWidget({
    Key? key,
    required this.storeName,
    required this.orderNumber,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Text(
        //   LocaleKeys.orderNumber.tr(),
        //   style: Theme.of(context).textTheme.subtitle1,
        //   maxLines: 1,
        //   overflow: TextOverflow.ellipsis,
        //   textAlign: TextAlign.start,
        // ),
        // SizedBox(height: 5),
        Text(
          orderNumber,
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.start,
        ),
        const SizedBox(height: 5),
        Text(
          LocaleKeys.storeName.tr(),
          style: Theme.of(context).textTheme.subtitle1,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.start,
        ),
        const SizedBox(height: 5),
        Text(
          storeName!,
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.start,
        ),
      ],
    );
  }
}
