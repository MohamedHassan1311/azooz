import '../../common/style/colors.dart';
import 'custom_cached_image_widget.dart';
import 'package:flutter/material.dart';

import 'marquee_widget.dart';

class CustomCardWidget extends StatelessWidget {
  final String? imageUrl;
  final double? imageWidth;
  final double? imageHeight;
  final String? title;
  final String? subtitle;
  final Function()? onTap;

  const CustomCardWidget({
    Key? key,
    required this.imageUrl,
    this.imageWidth = 45,
    this.imageHeight = 45,
    required this.title,
    required this.subtitle,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsetsDirectional.only(
          bottom: 10,
          top: 10,
        ),
        padding: const EdgeInsetsDirectional.only(
          bottom: 10,
          top: 10,
          start: 10,
          end: 10,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          color: Palette.kWhite,
          // boxShadow: const [
          //   BoxShadow(
          //     color: kGrey400,
          //     offset: Offset(0.0, 1.0),
          //     blurRadius: 6.0,
          //   ),
          // ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: const BoxDecoration(
                    // boxShadow: [
                    //   BoxShadow(
                    //     color: kGrey400,
                    //     offset: Offset(0.0, 1.0), //(x,y)
                    //     blurRadius: 6.0,
                    //   ),
                    // ],
                    shape: BoxShape.circle,
                    color: Palette.kWhite,
                  ),
                  child: CachedImageCircular(
                    imageUrl: imageUrl,
                    width: imageWidth,
                    height: imageHeight,
                  ),
                ),
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MarqueeWidget(
                      child: Text(
                        title!,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w900,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.start,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        SizedBox(
                          width: screenWidth / 1.5,
                          child: Text.rich(
                            TextSpan(text: subtitle),
                            style: const TextStyle(
                              fontSize: 14,
                              color: Palette.kGrey600,
                            ),
                            maxLines: 20,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.start,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
