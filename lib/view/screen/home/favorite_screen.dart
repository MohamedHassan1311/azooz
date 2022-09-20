import '../../../common/style/dimens.dart';
import '../../widget/home/favorite/favorite_widget.dart';
import 'package:flutter/material.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: edgeInsetsSymmetric(horizontal: 8.0),
      child: const FavoriteWidget(),
      // child: const CategoriesListWidget(),
    );
  }
}
