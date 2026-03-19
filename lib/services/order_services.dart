import 'dart:io';

import 'package:dio/dio.dart';
import 'package:ecommerce/controller/cart_controller.dart';
import 'package:ecommerce/controller/storage_controller.dart';
import 'package:ecommerce/utils/dio_connector.dart';
import 'package:get/get.dart' hide FormData, Response, MultipartFile;

class OrderServices {
  static Future<Response> placeOrder(File file) async {
    final token = StorageController().getToken();
    final cartController = Get.find<CartController>();

    final item = cartController.getCartResponse.value.data
        .map((e) => {"product_id": e.productId, "qty": e.quantity})
        .toList();

    FormData formData = FormData.fromMap({
      "payment_receipt": await MultipartFile.fromFile(file.path),
      "items": item,
    });

    final response = await DioConnector.dio.post(
      "/order",
      options: Options(headers: {'Authorization': 'Bearer $token'}),
      data: formData,
    );
    return response;
  }

  static Future<Response> getOrder() async {
    final token = StorageController().getToken();
    final response = await DioConnector.dio.get(
      "/orders",
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );
    return response;
  }

  static Future<Response> orderCancel(String orderId) async {
    final token = StorageController().getToken();
    final response = await DioConnector.dio.patch(
      "/order/$orderId",
      options: Options(headers: {'Authorization': 'Bearer $token'}),
      data: {"status": "cancel"},
    );
    return response;
  }

  static Future<Response> orderDelete(String orderId) async {
    final token = StorageController().getToken();
    final response = await DioConnector.dio.delete(
      "/order/$orderId",
      options: Options(headers: {'Authorization': 'Bearer $token'}),
      data: {"status": "cancel"},
    );
    return response;
  }
}
