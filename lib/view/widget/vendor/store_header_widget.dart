import 'package:azooz/model/mixin/reviews_mixin.dart';
import 'package:azooz/providers/reviews_provider.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../common/config/assets.dart';
import '../../../common/style/colors.dart';
import '../../../common/style/dimens.dart';
import '../../../generated/locale_keys.g.dart';
import '../../../model/response/chat_with_store_model.dart';
import '../../../providers/chat_with_store/chat_with_store_provider.dart';
import '../../../providers/store_provider.dart';
import '../../custom_widget/custom_carousel_slider_widget.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../screen/home/chat_with_store_screen.dart';

class StoreHeaderWidget extends StatelessWidget {
  final int _current = 0;
  final _controller = CarouselController();

  int? storeRate;

  final TextEditingController _commentController = TextEditingController();

  StoreHeaderWidget({Key? key}) : super(key: key);

  _showRateDialog(BuildContext context) async {
    await showDialog<void>(
      context: context,
      builder: (_) {
        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.3,
          child: Center(
            child: AlertDialog(
              alignment: Alignment.center,
              title: Text(LocaleKeys.rate.tr()),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    RatingBar.builder(
                      itemBuilder: (context, index) => const Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (double rateValue) {
                        print("#### Star rates - store rate: $rateValue ####");
                        storeRate = rateValue.toInt();
                      },
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      // maxLength: 200,
                      maxLines: 5,
                      controller: _commentController,
                      decoration: const InputDecoration(
                        hintText: 'اترك تعليقًا',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    int storeRuleId = 63;
                    if (storeRate != null && storeRate! > 0) {
                      ReviewStoreModel reviewData = ReviewStoreModel(
                        storeId: 1,
                        rate: storeRate,
                        comment: _commentController.text,
                        toRateRuleId: storeRuleId,
                      );
                      context.read<ReviewsProvider>().setReviewData =
                          reviewData;
                      context
                          .read<ReviewsProvider>()
                          .postData(context: context)
                          .then(
                            (value) => Navigator.pop(context),
                          );
                    }
                  },
                  child: Text(
                    LocaleKeys.confirm.tr(),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    LocaleKeys.cancel.tr(),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(children: [
          CustomCarouselSliderWidget(
            list: Provider.of<StoreProvider>(context, listen: false)
                .storeModel
                .result!
                .store!
                .imageURls,
            isPureList: true,
            controller: _controller,
            currentIndex: _current,
            withDots: true,
            aspectRatio: 14 / 6,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Consumer<StoreProvider>(
                  builder: (context, provider, child) {
                    return Text(
                      provider.storeModel.result != null &&
                              provider.storeModel.result!.store != null
                          ? provider.storeModel.result!.store!.name!
                          : '',
                      style: Theme.of(context).textTheme.headline6,
                    );
                  },
                ),
                Consumer<StoreProvider>(
                  builder: (context, provider, child) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 7,
                          height: 7,
                          margin: edgeInsetsSymmetric(
                            vertical: 8.0,
                            horizontal: 4.0,
                          ),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color:
                                provider.storeModel.result!.store!.open == true
                                    ? Palette.kSuccess
                                    : Palette.errorColor,
                          ),
                        ),
                        // SizedBox(width: 5),
                        Text(
                          provider.storeModel.result!.store!.open == true
                              ? LocaleKeys.open.tr()
                              : LocaleKeys.close.tr(),
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Consumer<StoreProvider>(
              builder: (context, provider, child) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton.icon(
                      icon: const Icon(
                        Icons.chat,
                        color: Palette.secondaryLight,
                        size: 18,
                      ),
                      label: Text(
                        "تحدث مع المتجر",
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      onPressed: () {
                        context
                            .read<ChatWithStoreProvider>()
                            .postChatId(
                                context: context,
                                storeId: provider.storeModel.result!.store!.id!)
                            .then((ChatWithStoreModel response) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) {
                                print("Chat ID:: ${response.result!.chatid}##");
                                return ChatWithStoreScreen(
                                  chatID: response.result!.chatid,
                                );
                              },
                            ),
                          );
                        });
                      },
                    ),
                    Row(
                      children: [
                        SizedBox(
                          height: 18,
                          width: 18,
                          child: clockSVG,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '${provider.storeModel.result!.store!.time} ${LocaleKeys.minute.tr()}',
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                      ],
                    ),
                    const SizedBox(width: 8),
                    Selector<StoreProvider, double?>(
                      selector: (_, provider) =>
                          provider.storeModel.result!.store!.rate,
                      builder: (context, rate, _) {
                        if (rate == null) return const SizedBox();
                        if (rate > 3.0) {
                          return GestureDetector(
                            onTap: () {
                              _showRateDialog(context);
                            },
                            child: Row(
                              children: [
                                SizedBox(
                                  height: 18,
                                  width: 18,
                                  // child: starOutlineSVG,
                                  child: SvgPicture.asset(
                                    'assets/svg/star.svg',
                                    color: Colors.amber,
                                  ),
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  provider.storeModel.result!.store!.rate
                                      .toString(),
                                  style: Theme.of(context).textTheme.bodyText1,
                                ),
                              ],
                            ),
                          );
                        } else {
                          return SizedBox(
                            height: 18,
                            width: 18,
                            child: starOutlineSVG,
                          );
                        }
                      },
                    ),
                  ],
                );
              },
            ),
          ),
        ]),
      ],
    );
  }
}
