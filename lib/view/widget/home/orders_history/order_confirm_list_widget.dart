import 'dart:async';

import 'package:azooz/common/style/dimens.dart';
import 'package:azooz/main.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:provider/provider.dart';

import '../../../../common/style/colors.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../../../model/response/offers_model.dart';
import '../../../../model/screen_argument/order_confirm_argument.dart';
import '../../../../providers/offers_provider.dart';
import 'package:flutter/material.dart';

import '../../../custom_widget/custom_button.dart';
import '../../../custom_widget/custom_cached_image_widget.dart';
import '../../../custom_widget/custom_error_widget.dart';
import '../../../custom_widget/custom_loading_widget.dart';
import '../../../custom_widget/marquee_widget.dart';

class OrderConfirmListWidget extends StatefulWidget {
  final OrderConfirmArgument argument;

  const OrderConfirmListWidget({
    Key? key,
    required this.argument,
  }) : super(key: key);

  @override
  State<OrderConfirmListWidget> createState() => _OrderConfirmListWidgetState();
}

class _OrderConfirmListWidgetState extends State<OrderConfirmListWidget> {
  int page = 1;
  late Future<DriverOffersModel> future;

  @override
  void initState() {
    super.initState();
    currentRoute = "ConfirmScreen";
    future = context.read<OffersProvider>().getOffers(
          context: context,
          orderID: widget.argument.orderID,
          page: page,
        );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    return FutureBuilder<DriverOffersModel>(
      future: context.read<OffersProvider>().getOffers(
          context: context,
          orderID: widget.argument.orderID,
          page: page,
        ),
      builder: (context, snapshot) {
        return snapshot.hasData && snapshot.data != null
            ? Consumer<OffersProvider>(
                builder: (context, provider, child) {
                  var data = provider.offersModel?.result!.offers!;
                  if (data != null && data.isEmpty) {
                    return const Center(
                      child: Text(
                        "لا يوجد عروض",
                      ),
                    );
                  }
                  return ListView.builder(
                    itemCount: data?.length ?? 0,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 20,
                    ),
                    itemBuilder: (context, index) {
                      List<DriverOffers>? offers =
                          provider.offersModel!.result!.offers!;
                      return _CustomOfferCard(
                        driverOfferModel: offers[index],
                        orderId: widget.argument.orderID ?? 0,
                      );
                    },
                  );
                },
              )
            : snapshot.hasError
                ? const CustomErrorWidget()
                : const CustomLoadingWidget();
      },
    );
  }
}

class _CustomOfferCard extends StatelessWidget {
  const _CustomOfferCard({
    Key? key,
    required this.driverOfferModel,
    required this.orderId,
  }) : super(key: key);

  final DriverOffers driverOfferModel;
  final int orderId;

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        borderRadius: kBorderRadius10,
        color: Palette.kWhite,
        border: Border.all(
          color: const Color(0x7BE1E1E1),
          width: 2.0,
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0xFFDDDDDD),
            blurRadius: 20,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Flexible(
                child: CachedImageCircular(
                  imageUrl: driverOfferModel.provider!.imageURl,
                  width: 40,
                  height: 40,
                  boxFit: BoxFit.cover,
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: screenSize.width * 0.59,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(width: 5),
                        Expanded(
                          child: MarqueeWidget(
                            child: Text(
                              driverOfferModel.provider!.name!,
                              style: Theme.of(context).textTheme.bodyMedium,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.start,
                            ),
                          ),
                        ),
                        const SizedBox(width: 5),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: screenSize.width * 0.59,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(width: 5),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.star,
                                color: Palette.kRating,
                                size: 18,
                              ),
                              MarqueeWidget(
                                child: Text(
                                  driverOfferModel.provider!.rate.toString(),
                                  style: Theme.of(context).textTheme.bodySmall,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.start,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 5),
                      ],
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Text(
                    '${driverOfferModel.price} ${LocaleKeys.sar.tr()}',
                    style: const TextStyle(
                      color: Palette.kGreen,
                      fontSize: 14,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  Text(
                    '${driverOfferModel.distance.toString().substring(0, 3)} ${LocaleKeys.km.tr()}',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ],
          ),
          ...[
            const SizedBox(height: 10),
            Container(
              height: 50,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: const BoxDecoration(
                color: Color(0xFFF4F4F4),
                borderRadius: kBorderRadius10,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      "السعر ${driverOfferModel.price.toString()}",
                      textAlign: TextAlign.center,
                    ),
                  ),
                  // const SizedBox(width: 10),
                  const VerticalDivider(),
                  Expanded(
                    child: Text(
                      "المسافة ${driverOfferModel.distance.toString()}",
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ],
          if (driverOfferModel.carData != null) ...[
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 5,
              ),
              decoration: const BoxDecoration(
                color: Color(0xFFF4F4F4),
                borderRadius: kBorderRadius10,
              ),
              child: Column(
                children: [
                  Text(
                    'تفاصيل السيارة',
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: Palette.kTextCardColor,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 5),
                  const Divider(
                    height: 0,
                  ),
                  SizedBox(
                    height: 80,
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            "الموديل ${driverOfferModel.carData!.model}",
                            textAlign: TextAlign.center,
                            style:
                                Theme.of(context).textTheme.bodySmall!.copyWith(
                                      color: Palette.kTextCardColor,
                                    ),
                          ),
                        ),
                        const VerticalDivider(),
                        Expanded(
                          child: Text(
                            "رقم السيارة ${driverOfferModel.carData!.number}",
                            textAlign: TextAlign.center,
                            style:
                                Theme.of(context).textTheme.bodySmall!.copyWith(
                                      color: Palette.kTextCardColor,
                                    ),
                          ),
                        ),
                        const VerticalDivider(),
                        Expanded(
                          child: Text(
                            "تاريخ التصنيع ${driverOfferModel.carData!.manufacturingyear}",
                            textAlign: TextAlign.center,
                            style:
                                Theme.of(context).textTheme.bodySmall!.copyWith(
                                      color: Palette.kTextCardColor,
                                    ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                child: SizedBox(
                  height: 35,
                  child: CustomButton(
                    text: LocaleKeys.confirm.tr(),
                    onPressed: () {
                      context.read<OffersProvider>().acceptOffer(
                            context: context,
                            offerID: driverOfferModel.id!,
                            orderID: orderId,
                          );
                      print("Offer ID: ${driverOfferModel.id}");
                      print("Order ID: $orderId");
                    },
                    color: Palette.kAccentGreen,
                  ),
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: CustomButton(
                  height: 35,
                  text: LocaleKeys.refuse.tr(),
                  textColor: Colors.white,
                  onPressed: () {
                    context.read<OffersProvider>().rejectOffer(
                          context: context,
                          offerID: driverOfferModel.id,
                          item: driverOfferModel
                        );
                  },
                  color: Palette.kErrorRed,
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
        ],
      ),
    );
  }
}
