import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:my_stock/models/product_model.dart';

class ProductNotifier extends ChangeNotifier {
  bool loading = false;
  bool isValidate = true;
  List<Product> productsList;
  Product choosedProduct;
  int totalQuantityIn = 0;
  int totalQuantityOut = 0;
  int totalQuantityInHand = 0;

  load() async {
    setLoading(true);
    await Future.delayed(Duration(seconds: 3)).then((value) {
      this.productsList = Product.prodcut;
      for (var product in this.productsList) {
        updateTotalQuantityIn(product.numOfStock);
        // totalQuantityInHand += product.numOfStock;
      }
      setLoading(false);
    });
  }

  chooseProduct(Product product) {
    this.choosedProduct = product;
    notifyListeners();
  }

  updateProduct(Product product) {
    this.productsList.removeWhere((element) => element.id == product.id);
    this.productsList.add(product);
    print('proudct updated');
    notifyListeners();
  }

  setIsValidate(bool validate) {
    this.isValidate = validate;
    notifyListeners();
  }

  setLoading(bool loading) {
    this.loading = loading;
    notifyListeners();
  }

  updateTotalQuantityIn(int quantity) {
    this.totalQuantityIn += quantity;
    this.totalQuantityInHand += quantity;
    notifyListeners();
  }

  updateTotalQuantityOut(int quantity) {
    this.totalQuantityInHand -= quantity;
    this.totalQuantityOut += quantity;
    notifyListeners();
  }
}

final productNotifier = ChangeNotifierProvider<ProductNotifier>(
  (ref) {
    var notifier = ProductNotifier()..load();
    return notifier;
  },
);
