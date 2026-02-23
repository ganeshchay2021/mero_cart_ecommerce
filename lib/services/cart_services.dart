import 'package:dio/dio.dart';
import 'package:ecommerce/utils/dio_connector.dart';

class CartServices {
  //get cart method
  static Future<Response> getCart({required String token}) async {
    final response = await DioConnector.dio.get(
      "/carts",
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );
    return response;
  }

  //add to cart method
  static Future<Response> addToCart({
    required String token,
    required int productId,
    required int quantity,
  }) async {
    final response = await DioConnector.dio.post(
      "/cart",
      queryParameters: {"product_id": productId, "qty": quantity},
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );
    return response;
  }

  //delete cart product
  static Future<Response> deleteCart({
    required int productId,
    required String token,
  }) async {
    final response = await DioConnector.dio.delete(
      "/cart/$productId",
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );
    return response;
  }

  //update cart
  Future<Response> updateCart({
    required int productId,
    required int quantity,
    required int cartId,


    required String token,
  }) async {
    final response = await DioConnector.dio.patch(
      "/cart/$cartId",
      options: Options(headers: {'Authorization': 'Bearer $token'}),
      queryParameters: {"product_id": productId, "qty": quantity},
    );
    return response;
  }
}
