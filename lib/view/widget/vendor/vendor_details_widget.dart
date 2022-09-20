import 'package:flutter/material.dart';

import '../../custom_widget/custom_cached_image_widget.dart';
import '../../custom_widget/marquee_widget.dart';
import '../../custom_widget/star_rating_widget.dart';

class VendorDetailsWidget extends StatelessWidget {
  final String? imageUrl;
  final String? name;
  final double? rating;
  final BoxFit? boxFit;
  final Function(double)? onRatingChanged;

  const VendorDetailsWidget({
    Key? key,
    required this.imageUrl,
    required this.name,
    required this.rating,
    this.boxFit = BoxFit.contain,
    required this.onRatingChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(width: 5),
            CachedImageCircular(
              imageUrl: imageUrl,
              width: 45,
              height: 45,
              boxFit: boxFit,
            ),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 0.78,
                  child: MarqueeWidget(
                    child: Text(
                      name!,
                      style: Theme.of(context).textTheme.subtitle1,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.start,
                    ),
                  ),
                ),
                // SizedBox(height: 5),
                SizedBox(
                  width: 0.78,
                  child: StarRatingWidget(
                    rating: rating!,
                    onRatingChanged: onRatingChanged!,
                  ),
                ),
                const SizedBox(height: 5),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
