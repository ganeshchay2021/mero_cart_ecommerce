import 'dart:io';
import 'package:ecommerce/controller/storage_controller.dart';
import 'package:ecommerce/model/order_model.dart';
import 'package:ecommerce/model/order_place_model.dart';
import 'package:ecommerce/services/order_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class OrderController extends GetxController {
  RxBool isLoading = false.obs;
  var getOrderResponse = OrderPlaceModel(
    success: false,
    message: "",
    orders: null,
  ).obs;

  var getAllOrderResponse = OrderModel(
    success: false,
    message: "",
    orders: [],
  ).obs;
  ImagePicker imagePicker = ImagePicker();

  Rx<File?> image = Rx<File?>(null);

  //picked image from Gallery
  Future pickGalleryImage() async {
    final XFile? imagePicked = await imagePicker.pickImage(
      source: ImageSource.gallery,
    );

    if (imagePicked != null) {
      image.value = File(imagePicked.path);
    }
  }

  //picked image from Camera
  Future pickCameraImage() async {
    final XFile? imagePicked = await imagePicker.pickImage(
      source: ImageSource.camera,
    );

    if (imagePicked != null) {
      image.value = File(imagePicked.path);
    }
  }

  Future<void> placeOrder(File file) async {
    try {
      final response = await OrderServices.placeOrder(file);

      if (response.statusCode == 200) {
        final result = OrderPlaceModel.fromJson(response.data);
        getOrderResponse.value = result;
        image.value = null;
        if (!Get.isSnackbarOpen) {
          Get.snackbar(
            "Success",
            "Order Successfully Placed",
            backgroundColor: Colors.green,
            colorText: Colors.white,
            duration: Duration(seconds: 2),
          );
        }
      }
    } catch (e) {
      if (!Get.isSnackbarOpen) {
        Get.snackbar(
          "Error",
          "Somthing went wrong",
          backgroundColor: Colors.red,
          colorText: Colors.white,
          duration: Duration(seconds: 2),
        );
      }
    }
  }

  Future<void> getOrder() async {
    try {
      final response = await OrderServices.getOrder();
      print(response);
      if (response.statusCode == 200) {
        final result = OrderModel.fromJson(response.data);
        getAllOrderResponse.value = result;
      }
    } catch (e) {
      if (!Get.isSnackbarOpen) {
        Get.snackbar(
          "Error",
          "Somthing went wrong",
          backgroundColor: Colors.red,
          colorText: Colors.white,
          duration: Duration(seconds: 2),
        );
      }
    }
  }

  Future<void> cancelOrder(String orderId) async {
    try {
      final response = await OrderServices.orderCancel(orderId);
      if (response.statusCode == 200) {
        await getOrder();
        if (!Get.isSnackbarOpen) {
          Get.snackbar(
            "Success",
            "Order Cancel Successfully",
            backgroundColor: Colors.green,
            colorText: Colors.white,
            duration: Duration(seconds: 2),
          );
        }
      }
    } catch (e) {
      if (!Get.isSnackbarOpen) {
        Get.snackbar(
          "Error",
          "Somthing went wrong",
          backgroundColor: Colors.red,
          colorText: Colors.white,
          duration: Duration(seconds: 2),
        );
      }
    }
  }

  Future<void> orderDelete(String orderId) async {
    try {
      final response = await OrderServices.orderDelete(orderId);
      if (response.statusCode == 200) {
        await getOrder();
        if (!Get.isSnackbarOpen) {
          Get.snackbar(
            "Success",
            "Order delete Successfully",
            backgroundColor: Colors.green,
            colorText: Colors.white,
            duration: Duration(seconds: 2),
          );
        }
      }
    } catch (e) {
      if (!Get.isSnackbarOpen) {
        Get.snackbar(
          "Error",
          "Somthing went wrong",
          backgroundColor: Colors.red,
          colorText: Colors.white,
          duration: Duration(seconds: 2),
        );
      }
    }
  }

   final token = StorageController().getToken();
  @override
  void onInit() {
    if(token !=null){
      getOrder();
    }
    super.onInit();
  }
}
