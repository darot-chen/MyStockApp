import 'dart:io';

import 'package:dio/dio.dart';

class HttpService {
  Dio _dio;
  String baseUrl = "http://localhost:8888/StockAPI/";
  HttpService() {
    _dio = Dio(
      BaseOptions(baseUrl: baseUrl,) ,
    );
  }

  Future<Response> getRequest({String endpoint}) async {
    Response response;
    try {
      response = await _dio.get('$baseUrl$endpoint');
    } on DioError catch (e) {
      print(e.message);
      throw Exception(e.message);
    }
    return response;
  }

  Future<Response> postRequest({
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
    try {
      response = await _dio.post(
        'http://localhost:8888/StockAPI/create_product.php',
        data: {
          "id": id,
          "name": name,
          "quantity": quanitity,
          "sell_price": sellPrice,
          "cat_name": catName,
          "desc": desc,
          "create_date": createDate,
        },
        options: Options(headers: {'content-type' : 'application/json'}),
    );
    } on DioError catch (e) {
      print(e.message);
      throw Exception(e.message);
    }
    return response;
  }

  initailInterceptor() {
    _dio.interceptors.add(
        InterceptorsWrapper(onError: (error, ErrorInterceptorHandler handler) {
      print(error.message);
      // print('${handler.next(error)}');
    }, onRequest: (request, requestHandler) {
      print("${request.method} ${request.path}");
    }, onResponse: (response, responeHandler) {
      print(response.data);
    }));
  }
}
