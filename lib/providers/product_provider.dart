import 'dart:collection';

import '../common/config/tools.dart';
import '../model/error_model.dart';
import '../model/mixin/product_mixin.dart';
import '../model/response/products_model.dart';
import '../service/network/api_provider.dart';
import '../service/network/url_constants.dart';
import '../utils/dialogs.dart';
import 'package:flutter/material.dart';

class ProductProvider extends ChangeNotifier with ProductMixin {
  final ApiProvider _apiProvider = ApiProvider.internal();
  late ErrorModel _errorModel;
  late ProductsModel _productsModel;
  late List<CategoryProduct> productsArgumentList = [];
  List<CategoryProduct> _listProducts = [];
  double totalProductsPrice = 0;

  // late Map<String, Product> mapProduct = {};
  late List<Map<String, CategoryProduct>> mapsListProduct = [];

  int? _qty;
  get currentQty => _qty ?? 0;

  ProductsModel get productsModel => _productsModel;

  List<CategoryProduct> get listProducts => _listProducts;

  int? _productQty;

  get getProductQty => _productQty ?? 0;

  int getQtyById(int id) {
    print("Products list - args::# $productsArgumentList");

    try {
      _qty = productsArgumentList
          .where((element) => element.id == id)
          .first
          .quantity;

      return _qty ?? 0;
    } catch (error) {
      return 0;
    }
  }

  int get totalItems {
    return productsArgumentList.map((e) => e).fold<int>(0,
        (currentValue, cartItem) {
      return currentValue += cartItem.quantity;
    });
  }

  // productQtyById(int productId) {
  //   print("I am prodddduct list productsArgumentList::# $productsArgumentList");

  //   if (productsArgumentList.isNotEmpty) {
  //     _productQty = productsArgumentList
  //         .where((product) {
  //           return productId == product.id;
  //         })
  //         .first
  //         .quantity;
  //   } else {
  //     _productQty = 0;
  //   }
  //   notifyListeners();
  // }

  bool loadingPagination = false;
  bool endPage = false;

  @override
  Future<ProductsModel> getProducts({
    required int? categoryId,
    required int? page,
    required BuildContext context,
  }) async {
    if (page != 1) {
      loadingPagination = true;
      notifyListeners();
    }
    print("#### categoryId: $categoryId end");
    await _apiProvider.get(
      apiRoute: productsURL,
      queryParameters: {
        'CategoryId': categoryId,
        'Page': page,
      },
      successResponse: (response) {
        _productsModel = ProductsModel.fromJson(response);
        if (_productsModel.result!.product!.isNotEmpty) {
          _listProducts.addAll(
            LinkedHashSet<CategoryProduct>.from(_productsModel.result!.product!)
                .toList(),
          );

          final Map<String, CategoryProduct> map = {};
          for (var item in _listProducts) {
            map[item.id.toString()] = item;
          }

          _listProducts = map.values.toSet().toList();

          _listProducts = Tools.removeDuplicates(_listProducts);
        } else {
          endPage = true;
          _listProducts = [];
          notifyListeners();
        }
        loadingPagination = false;
        notifyListeners();
      },
      errorResponse: (response) {
        _errorModel = ErrorModel.fromJson(response);
        errorDialog(context, _errorModel.message);
        loadingPagination = false;
        notifyListeners();
      },
    );
    notifyListeners();

    return _productsModel;
  }

  @override
  removeElement(int id) {
    productsArgumentList.removeWhere((element) => element.id == id);
    notifyListeners();
  }

  @override
  double calculateTotalPrice({required double couponValue}) {
    List<double> allPrices = [];

    for (var element in productsArgumentList) {
      if (element.price! > 0) {
        allPrices.add(element.price! * element.quantity);
      }
    }

    totalProductsPrice = allPrices.fold<double>(0.0, (currentValue, element) {
      return currentValue += element;
    });

    print("##### Total Price: $totalProductsPrice #####");

    notifyListeners();
    return totalProductsPrice;
  }

  // TEST
  double totalPriceSum(int id) {
    return productsArgumentList
        .where((product) => product.id == id)
        .fold(0.0, (sum, item) => sum + item.price!);
  }

  @override
  void clearCart() {
    // mapProduct.clear();
    listProducts.clear();
    _listProducts.clear();
    productsArgumentList.clear();
  }
}
