import 'package:ecommerce/controller/auth_controller.dart';
import 'package:ecommerce/controller/cart_controller.dart';
import 'package:ecommerce/controller/product_controller.dart';
import 'package:ecommerce/controller/storage_controller.dart';
import 'package:get/get.dart';

class ControllerBindings extends Bindings{
  @override
  void dependencies() {
    Get.put<AuthController>(AuthController(), permanent: false);
    Get.put<StorageController>(StorageController(), permanent: true);
    Get.put<ProductController>(ProductController(), permanent: true);
    Get.put<CartController>(CartController(), permanent: true);
  }
}