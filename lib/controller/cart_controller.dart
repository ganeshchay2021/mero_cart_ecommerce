import 'package:ecommerce/controller/storage_controller.dart';
import 'package:ecommerce/model/cart_model.dart';
import 'package:ecommerce/services/cart_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  RxBool isLoading = false.obs;
  RxInt qty = 1.obs;

  var addToCartResponse = AddToCartModel(success: false, message: "").obs;

  var getCartResponse = GetCartModel(sucess: false, data: []).obs;

  List<int?> get productId =>
      getCartResponse.value.data.map((e) => e.productId).toList().obs;

  List<dynamic> get subTotalList =>
      getCartResponse.value.data.map((e) => e.sellingPrice).toList().obs;
  num get subTotal => subTotalList.fold(0, (sum, item) => sum + item);

   List<dynamic> get discountList =>
      getCartResponse.value.data.map((e) => e.discountAmt).toList().obs;
  num get discount => discountList.fold(0, (sum, item) => sum + item);


 List<dynamic> get totalList =>
      getCartResponse.value.data.map((e) => e.totalAmt).toList().obs;
  num get total => totalList.fold(0, (sum, item) => sum + item);


  //add to cart
  Future<void> addToCart({
    required String token,
    required int productId,
    required int quantity,
  }) async {
    try {
      isLoading(true);

      final response = await CartServices.addToCart(
        token: token,
        productId: productId,
        quantity: quantity,
      );
      if (response.statusCode == 200) {
        final result = AddToCartModel.fromJson(response.data);
        addToCartResponse.value = result;
        isLoading(true);
        if (!Get.isSnackbarOpen) {
          Get.snackbar(
            "Success",
            "${addToCartResponse.value.message}",
            backgroundColor: Colors.green,
            colorText: Colors.white,
            duration: Duration(seconds: 2),
          );
        }
      } else {
        if (!Get.isSnackbarOpen) {
          Get.snackbar(
            "Warning",
            "Sonthing went wrong!",
            backgroundColor: Colors.red,
            colorText: Colors.white,
            duration: Duration(seconds: 2),
          );
        }
        isLoading(false);
      }
    } finally {
      isLoading(false);
    }
  }

  //Get cart
  Future<void> getCart() async {
    try {
      isLoading(true);
      final token = StorageController().getToken();
      final response = await CartServices.getCart(token: "$token");

      if (response.statusCode == 200) {
        final result = GetCartModel.fromJson(response.data);
        getCartResponse.value = result;
        isLoading(false);
      }
    } finally {
      isLoading(false);
    }
  }

  Future<void> deteleCart({required int productId}) async {
    try {
      final token = StorageController().getToken();
      final response = await CartServices.deleteCart(
        productId: productId,
        token: "$token",
      );
      if (response.statusCode == 200) {
      } else {
        if (!Get.isSnackbarOpen) {
          Get.snackbar(
            "Warning",
            "Sonthing went wrong!",
            backgroundColor: Colors.red,
            colorText: Colors.white,
            duration: Duration(seconds: 2),
          );
        }
      }
    } finally {}
  }

  //cart update
  Future<void> updateCart({
    required int productId,
    required int cartId,

    required int quantity,
  }) async {
    try {
      final token = StorageController().getToken();
      final response = await CartServices().updateCart(
        productId: productId,
        cartId: cartId,
        quantity: quantity,
        token: "$token",
      );

      if (response.statusCode == 200) {
      } else {
        if (!Get.isSnackbarOpen) {
          Get.snackbar(
            "Warning",
            "Sonthing went wrong!",
            backgroundColor: Colors.red,
            colorText: Colors.white,
            duration: Duration(seconds: 2),
          );
        }
      }
    } finally {}
  }

  @override
  void onInit() {
    getCart();
    super.onInit();
  }
}
