import 'package:ecommerce/controller/auth_controller.dart';
import 'package:ecommerce/routes/app_routes.dart';
import 'package:ecommerce/utils/assets.dart';
import 'package:ecommerce/widgets/common_button.dart';
import 'package:ecommerce/widgets/common_icon_button.dart';
import 'package:ecommerce/widgets/common_text_field.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class LoginView extends GetView<AuthController> {
  LoginView({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    //variables Declaration
    final size = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
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
              top: 40,
              right: 0,
              left: 0,
              child: Column(
                children: [
                  Text(
                    textAlign: TextAlign.center,
                    "Mero Cart",
                    style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                      fontSize: 25,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Gap(20),
                  Image.asset(Assets.logo, height: 120),
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
                  left: 20,
                  right: 20,
                  bottom: 0,
                ),
                height: size.height * 0.72,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(50),
                    topLeft: Radius.circular(50),
                  ),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      //Welcome text
                      Text(
                        "Welcome Back",
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 20,
                        ),
                      ),
                      Gap(20),

                      //informative text
                      Text(
                        "Sign to enjoy the best Beauty experience",
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.black54,
                          letterSpacing: 1.5,
                        ),
                      ),

                      Gap(20),

                      //Email Text Field
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            CommonTextField(
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return "Email is required";
                                } else {
                                  return null;
                                }
                              },
                              controller: controller.emailController,
                              textInputType: TextInputType.emailAddress,
                              titleText: "Email",
                              icon: Icons.email_outlined,
                              hintText: "Email",
                            ),

                            Gap(20),

                            //Password Text Field
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
                              icon: Icons.lock_outline,
                              hintText: "Password",
                              isPasswordField: true,
                            ),
                          ],
                        ),
                      ),

                      //Fotget Password Button
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () {},
                            child: Text(
                              "Forget Passport?",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),

                      Gap(10),

                      //Login Button
                      CommonButton(
                        buttonName: "Login",
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            controller.loginUser();
                          }
                        },
                      ),

                      Gap(20),

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
                                  "Or login with",
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

                          Gap(20),

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

                          Gap(16),

                          RichText(
                            text: TextSpan(
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 16,
                              ),
                              text: "Don't have an account?  ",
                              children: [
                                TextSpan(
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Get.toNamed(AppRoutes.register);
                                      controller.emailController.clear();
                                      controller.passwordController.clear();
                                    },
                                  text: "Sign up",
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
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
