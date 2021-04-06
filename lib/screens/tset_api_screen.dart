import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:my_stock/components/my_app_bar.dart';
import 'package:my_stock/components/product_list_tile.dart';
import 'package:my_stock/models/product_models.dart';
import 'package:my_stock/network/create_product.dart';
import 'package:my_stock/network/http_service.dart';

class TestApiScreen extends StatefulWidget {
  @override
  _TestApiScreenState createState() => _TestApiScreenState();
}

class _TestApiScreenState extends State<TestApiScreen> {
  bool isLoading = false;

  HttpService http;

  ProductModel productModel;
  List<Product> products;

  Future getProduct() async {
    Response response;
    try {
      isLoading = true;

      response = await http.getRequest(endpoint: '/get_products.php');

      isLoading = false;

      if (response.statusCode == 200) {
        setState(() {
          productModel = ProductModel.fromMap(response.data);
          products = productModel.products;
          print(products);
        });
      } else {
        print("There is some problem status code not 200");
      }
    } on Exception catch (e) {
      isLoading = false;
      print(e);
    }
  }

  @override
  void initState() {
    http = HttpService();

    getProduct();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: 'Test Api'),
      body: Column(
        children: [
          TextButton(
            child: Text('Get product'),
            onPressed: createProduct,
          ),
        ],
      ),
    );
  }
}
