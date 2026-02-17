import 'package:dio/dio.dart';
import 'package:ecommerce/utils/dio_connector.dart';

class ProductServices{
  static Future<Response> fetchAllProduct()async{
      final response= await DioConnector.dio.get("/products");
      return response;
  }
}