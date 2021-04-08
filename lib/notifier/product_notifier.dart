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

  Future load(String endPoint) async {
    HttpService http = HttpService();
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

  Future productPostRequest({
    String endPoint,
    String id,
    String name,
    String quanitity,
    String sellPrice,
    String catName,
    String desc,
    String createDate,
  }) async {
    Response response;
    HttpService http = HttpService();
    setLoading(true);
    try {
      response = await http.postRequest(
        endPoint: endPoint,
        id: id,
        name: name,
        quanitity: quanitity,
        sellPrice: sellPrice,
        catName: catName,
        desc: desc,
        createDate: createDate,
      );
      if (response.statusCode >= 200 && response.statusCode <= 299) {
        print("product created succesfully");
        print(response.data);
      } else {
        print("There is some problem status code not 200");
      }
    } on Exception catch (e) {
      print(e);
    }
    setLoading(false);
    // notifyListeners();
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
}

final productNotifier = ChangeNotifierProvider.family<ProductNotifier, String>(
  (ref, endpoint) {
    var notifier = ProductNotifier();
    notifier.load(endpoint);
    return notifier;
  },
);

final getProductNotifier = ChangeNotifierProvider<ProductNotifier>(
  (ref) {
    var notifier = ProductNotifier();
    return notifier;
  },
);
