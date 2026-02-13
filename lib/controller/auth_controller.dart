import 'package:ecommerce/routes/app_routes.dart';
import 'package:get/get.dart';

class AuthController extends GetxController{
  RxBool isLoggedIn=false.obs;

  void checkAuth(){
    Future.delayed(Duration(seconds: 4), (){
        Get.offNamed(AppRoutes.login);
    });
  }

  @override
  void onInit() {
    checkAuth();
    super.onInit();
  }
}