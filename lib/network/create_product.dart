import 'package:dio/dio.dart';
import 'package:my_stock/network/http_service.dart';

Future createProduct(
  {String endPoint,
  String id,
  String name,
  String quanitity,
  String sellPrice,
  String catName,
  String desc,
  String createDate,}
) async {
  Response response;
  HttpService http = HttpService();
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
}
