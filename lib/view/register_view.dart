import 'package:ecommerce/controller/auth_controller.dart';
import 'package:ecommerce/utils/assets.dart';
import 'package:ecommerce/widgets/common_button.dart';
import 'package:ecommerce/widgets/common_icon_button.dart';
import 'package:ecommerce/widgets/common_text_field.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class RegisterView extends GetView<AuthController> {
  RegisterView({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    //variables Declaration
    final size = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: RepaintBoundary(
        child: Container(
          height: size.height,
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomLeft,
              end: Alignment.topLeft,
              colors: [
                Colors.amber.shade300,
                Colors.amber.shade200,
                Colors.amber.shade100,
              ],
            ),
          ),
          child: Stack(
            children: [
              //logo and app name
              Positioned(
                top: 30,
                right: 0,
                left: 0,
                child: Column(
                  children: [
                    Text(
                      textAlign: TextAlign.center,
                      "Mero Cart",
                      style: Theme.of(context).textTheme.headlineLarge!
                          .copyWith(fontSize: 25, fontWeight: FontWeight.w500),
                    ),
                    Gap(10),
                    Image.asset(Assets.logo, height: 80),
                  ],
                ),
              ),

              //Login Credential area
              Positioned(
                bottom: 0,
                right: 0,
                left: 0,
                child: Container(
                  padding: EdgeInsets.only(
                    top: 10,
                    right: 20,
                    left: 20,
                    bottom: 0,
                  ),
                  height: size.height * 0.80,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(50),
                      topLeft: Radius.circular(50),
                    ),
                  ),
                  child: SingleChildScrollView(
                    controller: _scrollController,
                    child: Column(
                      children: [
                        //Welcome text
                        Text(
                          "Register",
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 20,
                          ),
                        ),
                        Gap(10),

                        //informative text
                        Text(
                          "Create new account for better service",
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.black54,
                            letterSpacing: 1.5,
                          ),
                        ),

                        Gap(20),

                        //Name Text Field
                        Form(
                          key: _formKey,
                          autovalidateMode: AutovalidateMode.onUnfocus,
                          child: Column(
                            children: [
                              CommonTextField(
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return "Name is required";
                                  } else {
                                    return null;
                                  }
                                },
                                textInputType: TextInputType.emailAddress,
                                controller: controller.nameController,
                                titleText: "Name",
                                icon: Icons.person,
                                hintText: "Name",
                              ),

                              Gap(10),

                              //Email Text Field
                              CommonTextField(
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return "Email is required";
                                  } else {
                                    return null;
                                  }
                                },
                                textInputType: TextInputType.emailAddress,
                                controller: controller.emailController,
                                titleText: "Email",
                                icon: Icons.email_outlined,
                                hintText: "Email",
                              ),

                              Gap(10),

                              CommonTextField(
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return "Password is required";
                                  } else {
                                    return null;
                                  }
                                },
                                controller: controller.passwordController,
                                titleText: "Password",
                                icon: Icons.lock,
                                hintText: "Password",
                                isPasswordField: true,
                              ),

                              Gap(10),

                              //Password Text Field
                              CommonTextField(
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return "Confirm password is required";
                                  } else {
                                    return null;
                                  }
                                },
                                controller:
                                    controller.confirmPasswordController,
                                titleText: "Confirm Password",
                                icon: Icons.lock,
                                hintText: "Confirm Password",
                                isPasswordField: true,
                              ),
                            ],
                          ),
                        ),

                        Gap(20),

                        //Login Button
                        CommonButton(
                          buttonName: "Sign Up",
                          onTap: () async{
                            if (_formKey.currentState!.validate()) {
                              if (controller.passwordController.text ==
                                  controller.confirmPasswordController.text) {
                                Loader.show(context);
                               await controller.registerUser();
                                Loader.hide();
                              } else {
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
                                    "Pasword and Confirm password doesn't match",
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                  ),
                                );
                              }
                            }
                          },
                        ),

                        Gap(10),

                        Column(
                          children: [
                            Row(
                              mainAxisAlignment: .center,
                              children: [
                                Expanded(
                                  child: Divider(
                                    color: Colors.grey,
                                    thickness: 1,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  child: Text(
                                    "Or sign up with",
                                    style: TextStyle(
                                      color: Colors.black38,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Divider(
                                    color: Colors.grey,
                                    thickness: 1,
                                  ),
                                ),
                              ],
                            ),

                            Gap(5),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CommonIconButton(
                                  icon: FontAwesomeIcons.google,
                                  onTap: () {},
                                  iconColor: Colors.red,
                                ),
                                Gap(10),
                                CommonIconButton(
                                  icon: FontAwesomeIcons.apple,
                                  onTap: () {},
                                  iconColor: Colors.black,
                                ),
                                Gap(10),
                                CommonIconButton(
                                  icon: FontAwesomeIcons.facebook,
                                  onTap: () {},
                                  iconColor: Colors.blue,
                                ),
                              ],
                            ),

                            Gap(10),

                            RichText(
                              text: TextSpan(
                                style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 16,
                                ),
                                text: "Already have an account?  ",
                                children: [
                                  TextSpan(
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        Get.back();
                                        controller.nameController.clear();
                                        controller.emailController.clear();
                                        controller.passwordController.clear();
                                        controller.confirmPasswordController
                                            .clear();
                                      },
                                    text: "Login",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Gap(10),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
