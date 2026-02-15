import 'package:dio/dio.dart';
import 'package:ecommerce/model/register_model.dart';
import 'package:ecommerce/routes/app_routes.dart';
import 'package:ecommerce/services/auth_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  RxBool isLoggedIn = false.obs;
  RxBool isLoading = false.obs;
  var registerResponce = RegisterModel(
    success: "false",
    token: null,
    message: null,
  ).obs;

  var registerError = RegisterErrorModel(
    success: "false",
    errors: Errors(),
  ).obs;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  //Splash Logic
  void checkAuth() {
    Future.delayed(Duration(seconds: 5), () {
      Get.offNamed(AppRoutes.login);
    });
  }

  Future<void> registerUser() async {
    try {
      isLoading(true);
      // Reset errors before a new request
      registerError.value = RegisterErrorModel(
        success: "false",
        errors: Errors(),
      );

      final response = await AuthServices.registerUser(
        name: nameController.text,
        email: emailController.text,
        password: passwordController.text,
      );

      if (response.data['success'] == "false" ||
          response.data['errors'] != null) {
        registerError.value = RegisterErrorModel.fromJson(response.data);
        if (!Get.isSnackbarOpen) {
          Get.snackbar(
            "",
            "",
            backgroundColor: Colors.red,
            colorText: Colors.white,
            titleText: const Text(
              "Error",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            messageText: Text(
              registerError.value.errors?.name?.first ??
                  registerError.value.errors?.email?.first ??
                  registerError.value.errors?.password?.first ??
                  "Registration Failed",
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
          );
        }
      } else {
        registerResponce.value = RegisterModel.fromJson(response.data);

        nameController.clear();
        emailController.clear();
        passwordController.clear();
        confirmPasswordController.clear();
        Get.back();
        Get.snackbar(
          "Success",
          "Account created successfully!",
          backgroundColor: Colors.green,
          colorText: Colors.white,
          duration: Duration(seconds: 2),
        );
        // Future.delayed(const Duration(seconds: 3), () {
        // });
      }
    } on DioException catch (e) {
      if (e.response != null) {
        registerError.value = RegisterErrorModel.fromJson(e.response!.data);
      }
    } finally {
      isLoading(false);
    }
  }

  @override
  void onInit() {
    checkAuth();
    super.onInit();
  }
}
