import '../../common/config/assets.dart';
import '../../common/style/colors.dart';
import '../../common/style/dimens.dart';
import '../../service/network/url_constants.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class CachedImageBorderRadius extends StatelessWidget {
  final String? imageUrl;
  final double? borderRadius;
  final double? width;
  final double? height;
  final Function()? onTap;
  final BoxFit? boxFit;

  const CachedImageBorderRadius({
    Key? key,
    required this.imageUrl,
    this.borderRadius = 5,
    this.width = 100,
    this.height = double.infinity,
    this.onTap,
    this.boxFit = BoxFit.cover,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(borderRadius!),
      onTap: onTap,
      child: CachedNetworkImage(
        imageUrl: baseImageURL + imageUrl!,
        fit: boxFit,
        width: width,
        height: height,
        errorWidget: (context, image, error) {
          return SizedBox(
            width: width,
            // child: storePlaceHolder,
          );
        },
        placeholder: (context, placeholder) => Center(
          child: LoadingAnimationWidget.inkDrop(
            size: 20,
            color: Palette.primaryColor,
          ),
        ),
      ),
    );
  }
}

class CachedImageCircular extends StatelessWidget {
  final String? imageUrl;
  final Function()? onTap;
  final double? height;
  final double? width;
  final BoxFit? boxFit;

  const CachedImageCircular({
    Key? key,
    required this.imageUrl,
    this.onTap,
    this.boxFit = BoxFit.contain,
    this.height = 80.0,
    this.width = 100.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: CachedNetworkImage(
        imageUrl: baseImageURL + imageUrl!,
        imageBuilder: (context, imageProvider) => Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: imageProvider,
              fit: boxFit,
            ),
          ),
        ),
        errorWidget: (context, image, error) => ClipOval(
          child: sizedBox(
            height: height,
            width: width,
            child: logoImg,
          ),
        ),
        placeholder: (context, placeholder) => Center(
          child: LoadingAnimationWidget.inkDrop(
            size: 20,
            color: Palette.primaryColor,
          ),
        ),
      ),
    );
  }
}
