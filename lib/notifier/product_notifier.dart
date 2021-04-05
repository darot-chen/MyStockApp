import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:my_stock/models/product_models.dart';
import 'package:my_stock/network/http_service.dart';

class ProductNotifier extends ChangeNotifier {
  bool loading = false;
  bool isValidate = true;
  List<Product> productsList;
  Product choosedProduct;
  int totalQuantityIn = 0;
  int totalQuantityOut = 0;
  int totalQuantityInHand = 0;

  ProductModel productModel;
  HttpService http = HttpService();

  Future load(String endPoint) async {
    Response response;
    try {
      setLoading(true);

      response = await http.getRequest(endpoint: endPoint);

      setLoading(false);

      if (response.statusCode == 200) {
        productModel = ProductModel.fromMap(response.data);
        productsList = productModel.products;
      } else {
        print("There is some problem status code not 200");
      }
    } on Exception catch (e) {
      setLoading(false);
      print(e);
    }
  }

  setProductList(List<Product> products) {
    this.productsList = products;
    print(this.productsList);
    notifyListeners();
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

  // updateTotalQuantityIn(int quantity) {
  //   this.totalQuantityIn += quantity;
  //   this.totalQuantityInHand += quantity;
  //   notifyListeners();
  // }

  // updateTotalQuantityOut(int quantity) {
  //   this.totalQuantityInHand -= quantity;
  //   this.totalQuantityOut += quantity;
  //   notifyListeners();
  // }
}

final productNotifier = ChangeNotifierProvider.family<ProductNotifier, String>(
  (ref, endpoint) {
    var notifier = ProductNotifier();
    notifier.load(endpoint);
    return notifier;
  },
);
