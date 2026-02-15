import 'package:dio/dio.dart';
import 'package:ecommerce/controller/storage_controlle.dart';
import 'package:ecommerce/model/login_model.dart';
import 'package:ecommerce/model/register_model.dart';
import 'package:ecommerce/routes/app_routes.dart';
import 'package:ecommerce/services/auth_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  RxBool isLoading = false.obs;

  //Registration Success response
  var registerResponce = RegisterModel(
    success: "false",
    token: null,
    message: null,
  ).obs;

  //Error response
  var registerError = RegisterErrorModel(
    success: "false",
    errors: Errors(),
  ).obs;

  //login response
  var loginResponse = LoginModel(
    success: false,
    token: null,
    message: null,
  ).obs;

  //login error response
  var loginEror = LoginErrorModel(
    success: "false",
    errors: LoginErrors(email: []),
  ).obs;

  //text controller variables
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  //Splash Logic
  void checkAuth() {
    final token = StorageController().getToken();
    Future.delayed(Duration(seconds: 5), () {
      if (token == null) {
        Get.offNamed(AppRoutes.login);
      } else {
        Get.offNamed(AppRoutes.home);
      }
    });
  }

  //User Registration Logic
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
      }
    } on DioException catch (e) {
      if (e.response != null) {
        registerError.value = RegisterErrorModel.fromJson(e.response!.data);
      }
    } finally {
      isLoading(false);
    }
  }

  //login user logic
  Future<void> loginUser() async {
    try {
      isLoading(true);
      final response = await AuthServices.loginUser(
        email: emailController.text,
        password: passwordController.text,
      );

      if (response.data["success"] == "false" ||
          response.data["errors"] != null) {
        final result = LoginErrorModel.fromJson(response.data);
        loginEror.value = result;
        isLoading(false);
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
              loginEror.value.errors!.email.first,
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
          );
        }
      } else if (response.data["success"] == true) {
        final result = LoginModel.fromJson(response.data);
        loginResponse.value = result;
        //save token
        StorageController().saveToken(loginResponse.value.token!);
        isLoading(false);
        Get.offNamedUntil(AppRoutes.home, (route) => false);
        Get.snackbar(
          "Success",
          "${loginResponse.value.message}",
          backgroundColor: Colors.green,
          colorText: Colors.white,
          duration: Duration(seconds: 2),
        );
      } else {
        final result = LoginModel.fromJson(response.data);
        loginResponse.value = result;
        isLoading(false);
        Get.snackbar(
          "Error",
          "${loginResponse.value.message}",
          backgroundColor: Colors.red,
          colorText: Colors.white,
          duration: Duration(seconds: 2),
        );
      }
    } finally {
      isLoading(false);
    }
  }

  //logout logic
  void logout() {
    StorageController().deleteToken();
    Get.offNamedUntil(AppRoutes.login, (route) => false);
    Get.snackbar(
      "Success",
      "Logout Success",
      backgroundColor: Colors.green,
      colorText: Colors.white,
      duration: Duration(seconds: 2),
    );
  }

  @override
  void onInit() {
    checkAuth();
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
  }
}
