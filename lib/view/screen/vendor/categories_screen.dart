import '../../../model/screen_argument/categories_argument.dart';
import '../../widget/vendor/categories_details_widget.dart';
import 'package:flutter/material.dart';

class CategoriesScreen extends StatelessWidget {
  static const routeName = 'categories';
  final CategoriesArgument argument;

  const CategoriesScreen({Key? key, required this.argument}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(argument.name.toString()),
      ),
      resizeToAvoidBottomInset: false,
      body: CategoriesDetailsWidget(argument: argument),
    );
  }
}
