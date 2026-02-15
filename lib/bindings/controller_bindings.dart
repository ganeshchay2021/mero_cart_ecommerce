import 'package:ecommerce/controller/auth_controller.dart';
import 'package:ecommerce/controller/storage_controlle.dart';
import 'package:get/get.dart';

class ControllerBindings extends Bindings{
  @override
  void dependencies() {
    Get.put<AuthController>(AuthController(), permanent: true);
    Get.put<StorageController>(StorageController(), permanent: true);

  }
}