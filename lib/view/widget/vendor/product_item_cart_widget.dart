import 'package:azooz/common/style/dimens.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../../model/response/products_model.dart';
import '../../../providers/product_provider.dart';

final Map<String, CategoryProduct> mapProduct = {};

class ProductItemCartWidget extends StatefulWidget {
  final CategoryProduct? product;
  final int? index;

  const ProductItemCartWidget({
    Key? key,
    required this.product,
    required this.index,
  }) : super(key: key);

  @override
  ProductItemCartWidgetState createState() => ProductItemCartWidgetState();
}

class ProductItemCartWidgetState extends State<ProductItemCartWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      width: 100,
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 255, 255, 255),
        borderRadius: kBorderRadius10,
      ),
      child: Row(
        children: [
          const SizedBox(width: 5),
          GestureDetector(
            onTap: () {
              final productId = widget.product!.id!;
              int qty = context.read<ProductProvider>().getQtyById(productId);
              if (qty > 1) {
                mapProduct[widget.product!.id.toString()] = CategoryProduct(
                  id: widget.product!.id,
                  name: widget.product!.name,
                  description: widget.product!.description,
                  imageURL: widget.product!.imageURL,
                  price: widget.product!.price,
                  stock: widget.product!.stock,
                  quantity: --qty,
                );
                Provider.of<ProductProvider>(context, listen: false)
                    .productsArgumentList = mapProduct.values.toSet().toList();

                context
                    .read<ProductProvider>()
                    .calculateTotalPrice(couponValue: 0);
              } else {
                mapProduct.removeWhere(
                    (key, value) => value.id == widget.product!.id);
                Provider.of<ProductProvider>(context, listen: false)
                    .removeElement(widget.product!.id!);
              }
              context
                  .read<ProductProvider>()
                  .calculateTotalPrice(couponValue: 0);
            },
            child: const Icon(
              Icons.remove,
              size: 20,
            ),
          ),
          const SizedBox(width: 5),
          Container(
            color: Colors.white,
            width: 30,
            child: Consumer<ProductProvider>(
              builder: ((context, value, child) => Center(
                    child: Text(
                      value.getQtyById(widget.product!.id!).toString(),
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                  )),
            ),
          ),
          const SizedBox(width: 5),
          GestureDetector(
            onTap: () {
              if (widget.product!.quantity < widget.product!.stock!.toInt() &&
                  widget.product!.quantity >= 0) {
                final productId = widget.product!.id!;
                int qty = context.read<ProductProvider>().getQtyById(productId);

                mapProduct[widget.product!.id.toString()] = CategoryProduct(
                  id: widget.product!.id,
                  name: widget.product!.name,
                  description: widget.product!.description,
                  imageURL: widget.product!.imageURL,
                  price: widget.product!.price,
                  stock: widget.product!.stock,
                  quantity: ++qty,
                );
                Provider.of<ProductProvider>(context, listen: false)
                    .productsArgumentList = mapProduct.values.toSet().toList();

                context
                    .read<ProductProvider>()
                    .calculateTotalPrice(couponValue: 0);
              } else {
                mapProduct.removeWhere(
                    (key, value) => value.id == widget.product!.id);
                Provider.of<ProductProvider>(context, listen: false)
                    .removeElement(widget.product!.id!);
              }
              context
                  .read<ProductProvider>()
                  .calculateTotalPrice(couponValue: 0);
            },
            child: const Icon(
              Icons.add_box_rounded,
              size: 20,
              color: Color(0xFF343434),
            ),
          ),
        ],
      ),
    );
  }
}
