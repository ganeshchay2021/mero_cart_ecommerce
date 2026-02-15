import 'package:dio/dio.dart';
import 'package:ecommerce/utils/dio_connector.dart';

class AuthServices {
  //Method for Registration
  static Future<Response> registerUser({
    required String name,
    required String email,
    required String password,
  }) async {
    final response = await DioConnector.dio.post(
      "/register",
      queryParameters: {"name": name, "email": email, "password": password},
    );
    return response;
  }

  //Method for login
  static Future<Response> loginUser({
    required String email,
    required String password,
  }) async {
    final response = await DioConnector.dio.post(
      "/login",
      queryParameters: {"email": email, "password": password},
    );
    return response;
  }
}
