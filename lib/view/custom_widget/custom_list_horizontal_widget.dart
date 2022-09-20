import '../../common/routes/app_router_control.dart';
import '../../common/style/colors.dart';
import '../../common/style/dimens.dart';
import '../../common/style/style.dart';
import '../../model/screen_argument/categories_argument.dart';
import 'custom_cached_image_widget.dart';
import '../../common/routes/app_router_import.gr.dart';
import 'package:flutter/material.dart';

class CustomListWidget extends StatelessWidget {
  final List? list;
  final List? listIMG;
  final bool withListIMG;
  final bool navigateToCategories;
  final double? radius;
  final double? height;
  final Function()? onTap;
  final Function(int index)? onTapWithIndex;
  final bool? withShadow;
  final int? indexFilter;
  final Axis? scrollDirection;

  const CustomListWidget({
    Key? key,
    required this.list,
    this.radius = 10,
    this.height = 45,
    this.listIMG,
    this.withListIMG = false,
    this.withShadow = true,
    this.navigateToCategories = false,
    this.indexFilter,
    this.onTapWithIndex,
    this.onTap,
    this.scrollDirection = Axis.horizontal,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return sizedBox(
      height: withListIMG == true ? 50 : height,
      child: Align(
        alignment: AlignmentDirectional.centerStart,
        child: ListView.builder(
          scrollDirection: scrollDirection!,
          shrinkWrap: true,
          itemCount: list!.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: withListIMG == true
                  ? () => onTapWithIndex!(index)
                  : () => navigateToCategories == true
                      ? routerPush(
                          context: context,
                          route: CategoriesRoute(
                            argument: CategoriesArgument(
                              name: list![index].name,
                              id: list![index].paymentTypeId,
                            ),
                          ),
                        )
                      : onTap,
              child: Container(
                margin: edgeInsetsAll(5),
                padding: edgeInsetsAll(withListIMG == true ? 7 : 5),
                decoration: cardDecoration5(
                  context: context,
                  radius: radius,
                  withShadow: withShadow!,
                  color: indexFilter == index
                      ? Palette.kBottomNav
                      : Palette.activeWidgetsColor,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      withListIMG == true
                          ? list![index]
                          : list![index]?.name ?? '',
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                    sizedBox(width: withListIMG == true ? 5 : 20),
                    sizedBox(
                      height: 35,
                      width: 35,
                      child: withListIMG == true
                          ? listIMG![index]
                          : CachedImageBorderRadius(
                              imageUrl: list![index]?.imageURL ?? '',
                              // width: 35,
                            ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
