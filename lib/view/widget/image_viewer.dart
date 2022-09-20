import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../common/style/colors.dart';

class ImageViewer extends StatelessWidget {
  const ImageViewer({
    Key? key,
    required this.image,
    this.isFromInternet = false,
  }) : super(key: key);

  final dynamic image;
  final bool isFromInternet;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: isFromInternet
          ? CachedNetworkImage(
              imageUrl: image,
              errorWidget: (context, image, error) {
                return const SizedBox();
              },
              placeholder: (context, placeholder) => Center(
                child: LoadingAnimationWidget.inkDrop(
                  size: 20,
                  color: Palette.primaryColor,
                ),
              ),
            )
          : Image.file(
              image,
              fit: BoxFit.cover,
            ),
    );
  }
}
