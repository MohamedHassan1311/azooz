import '../../../generated/locale_keys.g.dart';
import '../../../providers/product_provider.dart';
import '../../custom_widget/custom_error_widget.dart';
import '../../custom_widget/custom_outlined_list_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderProductsWidget extends StatefulWidget {
  const OrderProductsWidget({Key? key}) : super(key: key);

  @override
  State<OrderProductsWidget> createState() => _OrderProductsWidgetState();
}

class _OrderProductsWidgetState extends State<OrderProductsWidget> {
  /// There is not pagination here
  ScrollController scrollController = ScrollController();

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductProvider>(
      builder: (context, provider, child) {
        print("I am list products....: ${provider.productsArgumentList}");
        if (provider.productsArgumentList.isEmpty) {
          return CustomErrorWidget(
            message: LocaleKeys.noProducts.tr(),
          );
        } else {
          return CustomOutlinedListWidget(
            list: provider.productsArgumentList,
            boxFit: BoxFit.cover,
            isQuantity: true,
            isButton: false,
            withNoOutlined: false,
            isScrollable: false,
            scrollController: scrollController,
          );
        }
      },
    );
  }
}
