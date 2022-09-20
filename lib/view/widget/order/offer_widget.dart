import '../../../common/style/colors.dart';
import '../../../generated/locale_keys.g.dart';
import '../../custom_widget/custom_button.dart';
import '../vendor/vendor_details_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class OfferWidget extends StatelessWidget {
  const OfferWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
        // boxShadow: [
        //   BoxShadow(
        //     color: kGreyCards.withOpacity(0.6),
        //     offset: const Offset(0.0, 1.0),
        //     blurRadius: 2.0,
        //   ),
        // ],
      ),
      child: Column(
        children: [
          VendorDetailsWidget(
            imageUrl:
                'https://www.pngkit.com/png/detail/2-24962_food-png-image-with-transparent-background-indian-restaurant.png',
            name: 'اسم المطعم',
            rating: 5,
            onRatingChanged: (rate) {},
            boxFit: BoxFit.cover,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  Text(LocaleKeys.deliveryTime.tr()),
                  Text(
                    'فى السريع',
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ],
              ),
              Column(
                children: [
                  Text(LocaleKeys.deliveryCost.tr()),
                  Text(
                    '70',
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ],
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CustomButton(
                text: LocaleKeys.refuse.tr(),
                onPressed: () {},
                color: Palette.kDarkGreyCards,
                width: 120,
              ),
              CustomButton(
                text: LocaleKeys.confirm.tr(),
                onPressed: () {},
                color: Palette.kDarkGreyCards,
                width: 120,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
