import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:my_stock/models/categories_model.dart';
import 'package:my_stock/network/http_service.dart';

class CategoriesNotifier extends ChangeNotifier {
  bool loading = false;
  HttpService htpp = HttpService();

  CategoryModel categoryModel;
  List<Category> categories;

  load() async {
    Response response;

    try {
      setLoading(true);
      response = await htpp.getRequest(endpoint: '/get_categories.php');
      setLoading(false);
      if (response.statusCode == 200) {
        categoryModel = CategoryModel.fromMap(response.data);
        categories = categoryModel.categories;
      }else 
        print("Error Server problems");
    } catch (e) {
      print(e.message);
    }
  }

  setLoading(bool loading) {
    this.loading = loading;
    notifyListeners();
  }
}

final categoryNotifier = ChangeNotifierProvider<CategoriesNotifier>((ref){
  var notifier = CategoriesNotifier()..load();
  return notifier;
},);
