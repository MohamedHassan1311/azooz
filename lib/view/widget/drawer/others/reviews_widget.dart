import '../../../../common/config/tools.dart';
import '../../../../common/style/colors.dart';
import '../../../../common/style/dimens.dart';
import '../../../../common/style/style.dart';
import '../../../../model/response/reviews_model.dart';
import '../../../../providers/reviews_provider.dart';
import '../../../custom_widget/custom_cached_image_widget.dart';
import '../../../custom_widget/custom_error_widget.dart';
import '../../../custom_widget/custom_loading_widget.dart';
import '../../../custom_widget/marquee_widget.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class ReviewsWidget extends StatefulWidget {
  const ReviewsWidget({Key? key}) : super(key: key);

  @override
  State<ReviewsWidget> createState() => _ReviewsWidgetState();
}

class _ReviewsWidgetState extends State<ReviewsWidget> {
  late Future<ReviewsModel> future;

  late final ReviewsProvider provider;

  int page = 1;

  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    provider = Provider.of<ReviewsProvider>(context, listen: false);
    future = provider.getData(page: page, context: context);

    scrollController.addListener(scrollListener);
  }

  getMoreData() {
    if (!provider.endPage) {
      if (provider.loadingPagination == false) {
        page++;
        provider.getData(page: page, context: context);
      }
    }
  }

  scrollListener() => Tools.scrollListener(
        scrollController: scrollController,
        getMoreData: getMoreData,
      );

  @override
  void dispose() {
    scrollController.removeListener(scrollListener);
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return FutureBuilder<ReviewsModel>(
      future: future,
      builder: (context, snapshot) {
        return snapshot.hasData
            ? Consumer<ReviewsProvider>(
                builder: (context, provider, child) {
                  return ListView.builder(
                    shrinkWrap: true,
                    addAutomaticKeepAlives: false,
                    addRepaintBoundaries: false,
                    controller: scrollController,
                    itemCount: provider.listReviews!.length + 1,
                    itemBuilder: (context, index) {
                      if (index == provider.listReviews!.length) {
                        return provider.loadingPagination
                            ? const CustomLoadingPaginationWidget()
                            : const SizedBox();
                      }
                      return GestureDetector(
                        onTap: () {},
                        child: Container(
                          margin: const EdgeInsets.all(8),
                          decoration:
                              cardDecoration5(context: context, radius: 12),
                          child: Container(
                            // padding: const EdgeInsets.only(bottom: 5),
                            margin: edgeInsetsOnly(bottom: 10, top: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    sizedBox(width: 5),
                                    CachedImageCircular(
                                      imageUrl: provider
                                          .listReviews![index].from?.imageURl,
                                      width: 45,
                                      height: 55,
                                      boxFit: BoxFit.cover,
                                    ),
                                    sizedBox(width: 8),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        sizedBox(
                                          width: screenSize.width * 0.72,
                                          child: Row(
                                            children: [
                                              Expanded(
                                                flex: 2,
                                                child: MarqueeWidget(
                                                  child: Text(
                                                    provider.listReviews![index]
                                                        .from!.name
                                                        .toString(),
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .subtitle1,
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    textAlign: TextAlign.start,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    edgeInsetsOnly(start: 3.0),
                                                child: Row(
                                                  children: [
                                                    const Icon(
                                                      Icons.star,
                                                      color: Palette.kRating,
                                                      size: 15,
                                                    ),
                                                    sizedBox(width: 3),
                                                    MarqueeWidget(
                                                      child: Text(
                                                        provider
                                                            .listReviews![index]
                                                            .from!
                                                            .rate
                                                            .toString(),
                                                        style: const TextStyle(
                                                          color:
                                                              Palette.kAccent,
                                                          fontSize: 10,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                        maxLines: 1,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        textAlign:
                                                            TextAlign.center,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        // sizedBox(height: 5),
                                        sizedBox(
                                          width: screenSize.width * 0.72,
                                          child: Text(
                                            provider.listReviews![index].comment
                                                .toString(),
                                            maxLines: 10,
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.start,
                                            style: const TextStyle(
                                              color: Palette.secondaryLight,
                                            ),
                                          ),
                                        ),
                                        sizedBox(height: 5),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
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
