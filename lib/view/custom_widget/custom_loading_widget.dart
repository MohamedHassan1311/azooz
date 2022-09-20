import '../../common/style/colors.dart';
import '../../common/style/dimens.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class CustomLoadingWidget extends StatelessWidget {
  final double? size;
  final double? paddingAll;

  const CustomLoadingWidget({
    Key? key,
    this.size = 40,
    this.paddingAll = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return Padding(
    //   padding: edgeInsetsAll(paddingAll!),
    //   child: Center(
    //     child: LoadingAnimationWidget.inkDrop(
    //       size: size!,
    //       color: Palette.primaryColor,
    //     ),
    //   ),
    // );
    return const Center(
      child: SizedBox(
        width: 25,
        height: 25,
        child: Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation(Palette.primaryColor),
          ),
        ),
      ),
    );
  }
}

class CustomLoadingPaginationWidget extends StatelessWidget {
  final double? size;
  final double? paddingAll;

  const CustomLoadingPaginationWidget({
    Key? key,
    this.size = 40,
    this.paddingAll = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: edgeInsetsAll(paddingAll!),
      child: Center(
        child: LoadingAnimationWidget.staggeredDotsWave(
          size: size!,
          color: Palette.primaryColor,
        ),
      ),
    );
  }
}
