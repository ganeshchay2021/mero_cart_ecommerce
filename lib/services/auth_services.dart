import 'package:dio/dio.dart';
import 'package:ecommerce/utils/dio_connector.dart';

class AuthServices {
  static Future<Response> registerUser({
    required String name,
    required String email,
    required String password,
  }) async {
    final response = await DioConnector.dio.post(
      "/register",
      queryParameters: {
        "name": name,
        "email": email,
        "password": password,
      },
    );
    return response;
  }
}
