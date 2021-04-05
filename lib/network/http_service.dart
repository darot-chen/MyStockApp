import 'package:dio/dio.dart';

class HttpService {
  Dio _dio;
  String baseUrl = "http://localhost:8888/StockAPI/";
  HttpService() {
    _dio = Dio(
      BaseOptions(baseUrl: baseUrl),
    );
  }

  Future<Response> getRequest({String endpoint}) async {
    Response response;
    try {
      response = await _dio.get('http://localhost:8888/StockAPI/$endpoint');
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
