import '../../common/style/colors.dart';
import '../../generated/locale_keys.g.dart';
import 'custom_loading_widget.dart';
import 'custom_outlined_widget.dart';
import '../widget/vendor/product_item_cart_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'custom_button.dart';
import 'custom_cached_image_widget.dart';
import 'marquee_widget.dart';

class CustomOutlinedListWidget extends StatefulWidget {
  final List? list;
  final double? imageWidth;
  final double imageHeight;
  final BoxFit? boxFit;
  final bool? isQuantity;
  final bool? isButton;
  final bool? loadingPagination;
  final bool? withPagination;
  final Function()? onTapButton;
  final bool? withNoOutlined;
  final Color? colorOutlined;
  final bool? isScrollable;
  final int? quantity;
  final ScrollController? scrollController;

  const CustomOutlinedListWidget({
    Key? key,
    required this.list,
    this.imageHeight = 45,
    this.imageWidth = 45,
    this.boxFit = BoxFit.contain,
    this.isQuantity = false,
    this.isButton = false,
    this.withNoOutlined = false,
    this.isScrollable = true,
    this.withPagination = false,
    this.loadingPagination,
    this.onTapButton,
    this.quantity,
    required this.scrollController,
    this.colorOutlined = Palette.kAccentGreyCards,
  }) : super(key: key);

  @override
  State<CustomOutlinedListWidget> createState() =>
      _CustomOutlinedListWidgetState();
}

class _CustomOutlinedListWidgetState extends State<CustomOutlinedListWidget> {
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return widget.withPagination == true
        ? SingleChildScrollView(
            controller: widget.scrollController,
            child: Column(
              children: [
                widget.withNoOutlined == false
                    ? ListView.separated(
                        shrinkWrap: true,
                        addAutomaticKeepAlives: false,
                        addRepaintBoundaries: false,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        separatorBuilder: (context, index) => const Divider(),
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: widget.list!.length + 1,
                        itemBuilder: (context, index) {
                          if (index == widget.list!.length) {
                            return widget.loadingPagination!
                                ? const CustomLoadingPaginationWidget()
                                : const SizedBox();
                          }
                          return CustomOutlinedWidget(
                            color: widget.colorOutlined,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: CachedImageCircular(
                                          imageUrl:
                                              widget.list![index].imageURL,
                                          width: 40,
                                          height: 40,
                                          boxFit: widget.boxFit,
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            width: screenSize.width * 0.51,
                                            child: MarqueeWidget(
                                              child: Text(
                                                widget.list![index].name,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .subtitle1,
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.start,
                                              ),
                                            ),
                                          ),
                                          // SizedBox(height: 5),
                                          SizedBox(
                                            width: screenSize.width * 0.51,
                                            child: Text.rich(
                                              TextSpan(
                                                text: widget
                                                    .list![index].description,
                                              ),
                                              maxLines: 10,
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.start,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                widget.isQuantity == true
                                    ? ProductItemCartWidget(
                                        product: widget.list![index],
                                        index: index,
                                      )
                                    : Text(
                                        '${widget.list![index].distance} ${LocaleKeys.km.tr()}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle1,
                                      ),

                                // TextButton(
                                //   style: ButtonStyle(
                                //     backgroundColor: MaterialStateProperty.all(
                                //       Palette.activeWidgetsColor,
                                //     ),
                                //   ),
                                //   onPressed: () {
                                //     if (widget.list![index]!.quantity <
                                //         widget.list![index]!.stock!.toInt()) {
                                //       widget.list![index]!.quantity++;
                                //       mapProduct[widget.list![index]!.id
                                //           .toString()] = Product(
                                //         id: widget.list![index]!.id,
                                //         name: widget.list![index]!.name,
                                //         description:
                                //             widget.list![index]!.description,
                                //         imageURL: widget.list![index]!.imageURL,
                                //         price: widget.list![index]!.price,
                                //         stock: widget.list![index]!.stock,
                                //         quantity: widget.list![index]!.quantity,
                                //       );
                                //       Provider.of<ProductProvider>(context,
                                //                   listen: false)
                                //               .productsArgumentList =
                                //           mapProduct.values.toList();
                                //     }
                                //   },
                                //   child: Text(
                                //     LocaleKeys.addToCart.tr(),
                                //     style: const TextStyle(
                                //       color: Colors.black,
                                //       fontSize: 14,
                                //     ),
                                //   ),
                                // ),
                              ],
                            ),
                          );
                        },
                      )
                    : ListView.separated(
                        shrinkWrap: true,
                        addAutomaticKeepAlives: false,
                        addRepaintBoundaries: false,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 5, vertical: 10),
                        separatorBuilder: (context, index) => const Divider(),
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: widget.list!.length,
                        itemBuilder: (context, index) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CachedImageCircular(
                                    imageUrl: widget.list![index].imageURL,
                                    width: 40,
                                    height: 40,
                                    boxFit: widget.boxFit,
                                  ),
                                  const SizedBox(width: 8),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: screenSize.width * 0.51,
                                        child: MarqueeWidget(
                                          child: Text(
                                            widget.list![index].name!,
                                            style: Theme.of(context)
                                                .textTheme
                                                .subtitle1,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.start,
                                          ),
                                        ),
                                      ),
                                      // SizedBox(height: 5),
                                      SizedBox(
                                        width: screenSize.width * 0.51,
                                        child: Text.rich(
                                          TextSpan(
                                            text: widget
                                                .list![index].description!,
                                          ),
                                          maxLines: 10,
                                          overflow: TextOverflow.ellipsis,
                                          textAlign: TextAlign.start,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              widget.isQuantity == true
                                  ? ProductItemCartWidget(
                                      product: widget.list![index],
                                      index: index,
                                    )
                                  : Text(
                                      '${widget.list![index].distance} ${LocaleKeys.km.tr()}',
                                      style:
                                          Theme.of(context).textTheme.subtitle1,
                                    ),
                            ],
                          );
                        },
                      ),
                widget.isButton == true
                    ? Column(
                        children: [
                          CustomButton(
                            width: screenSize.width * 0.94,
                            text: LocaleKeys.next.tr(),
                            onPressed: widget.onTapButton,
                          ),
                          const SizedBox(height: 10),
                        ],
                      )
                    : const SizedBox(height: 15),
              ],
            ),
          )
        : SingleChildScrollView(
            controller: widget.scrollController,
            physics: widget.isScrollable == true
                ? const AlwaysScrollableScrollPhysics()
                : const NeverScrollableScrollPhysics(),
            child: Column(
              children: [
                widget.withNoOutlined == false
                    ? ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: widget.list!.length,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        itemBuilder: (context, index) {
                          return CustomOutlinedWidget(
                            color: widget.colorOutlined,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CachedImageCircular(
                                      imageUrl: widget.list![index].imageURL,
                                      width: 40,
                                      height: 40,
                                      boxFit: widget.boxFit,
                                    ),
                                    const SizedBox(width: 8),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          child: MarqueeWidget(
                                            child: Text(
                                              widget.list![index].name,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .subtitle1,
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.start,
                                            ),
                                          ),
                                        ),
                                        // SizedBox(height: 5),
                                        SizedBox(
                                          child: Text.rich(
                                            TextSpan(
                                              text: widget
                                                  .list![index].description,
                                            ),
                                            maxLines: 10,
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.start,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                widget.isQuantity == true
                                    ? ProductItemCartWidget(
                                        product: widget.list![index],
                                        index: index,
                                      )
                                    : Text(
                                        '${widget.list![index].distance} ${LocaleKeys.km.tr()}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle1,
                                      ),
                              ],
                            ),
                          );
                        },
                      )
                    : ListView.separated(
                        shrinkWrap: true,
                        addAutomaticKeepAlives: false,
                        addRepaintBoundaries: false,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        separatorBuilder: (context, index) => const Divider(),
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: widget.list!.length,
                        itemBuilder: (context, index) => Container(
                          padding: const EdgeInsets.all(5),
                          decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 235, 230, 230),
                            borderRadius: BorderRadius.all(
                              Radius.circular(14),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CachedImageCircular(
                                    imageUrl: widget.list![index].imageURL,
                                    width: 40,
                                    height: 40,
                                    boxFit: widget.boxFit,
                                  ),
                                  const SizedBox(width: 8),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: screenSize.width * 0.51,
                                        child: MarqueeWidget(
                                          child: Text(
                                            widget.list![index].name!,
                                            style: Theme.of(context)
                                                .textTheme
                                                .subtitle1,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.start,
                                          ),
                                        ),
                                      ),
                                      // SizedBox(height: 5),
                                      SizedBox(
                                        width: screenSize.width * 0.51,
                                        child: Text.rich(
                                          TextSpan(
                                            text: widget
                                                .list![index].description!,
                                          ),
                                          maxLines: 10,
                                          overflow: TextOverflow.ellipsis,
                                          textAlign: TextAlign.start,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              widget.isQuantity == true
                                  ? ProductItemCartWidget(
                                      product: widget.list![index],
                                      index: index,
                                    )
                                  : Text(
                                      '${widget.list![index].distance} ${LocaleKeys.km.tr()}',
                                      style:
                                          Theme.of(context).textTheme.subtitle1,
                                    ),
                            ],
                          ),
                        ),
                      ),
                widget.isButton == true
                    ? Column(
                        children: [
                          CustomButton(
                            width: screenSize.width * 0.94,
                            text: LocaleKeys.next.tr(),
                            onPressed: widget.onTapButton,
                          ),
                        ],
                      )
                    : const SizedBox(height: 15),
              ],
            ),
          );
  }
}
