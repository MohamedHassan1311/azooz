import 'package:flutter/material.dart';

import '../../common/style/colors.dart';

typedef RatingChangeCallback = void Function(double rating);

class StarRatingWidget extends StatelessWidget {
  final int? starCount;
  final double? rating;
  final RatingChangeCallback? onRatingChanged;
  final Color? color;

  const StarRatingWidget({
    Key? key,
    this.starCount = 5,
    this.rating = .0,
    this.onRatingChanged,
    this.color = Palette.kRating,
  }) : super(key: key);

  Widget buildStar(BuildContext context, int index) {
    Icon icon;
    if (index >= rating!) {
      icon = const Icon(
        Icons.star_border,
        color: Colors.white,
      );
    } else if (index > rating! - 1 && index < rating!) {
      icon = Icon(
        Icons.star_half,
        color: color ?? Theme.of(context).primaryColor,
      );
    } else {
      icon = Icon(
        Icons.star,
        color: color ?? Theme.of(context).primaryColor,
      );
    }
    return GestureDetector(
      onTap:
          onRatingChanged == null ? null : () => onRatingChanged!(index + 1.0),
      child: icon,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(
        starCount!,
        (index) => buildStar(context, index),
      ),
    );
  }
}
