import 'package:ecommerce/controller/auth_controller.dart';
import 'package:ecommerce/controller/cart_controller.dart';
import 'package:ecommerce/utils/assets.dart';
import 'package:ecommerce/view/cart_view..dart';
import 'package:ecommerce/view/home_view.dart';
import 'package:ecommerce/view/profile_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottonNavBar extends GetView<AuthController> {
  BottonNavBar({super.key});

  final cartController= Get.find<CartController>();

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = const [HomeView(), CartView(), ProfileView()];
    return Scaffold(
      body: Obx(() => pages[controller.stateIndex.value]),
      bottomNavigationBar: Obx(
        () => NavigationBar(
          backgroundColor: Colors.white,
          indicatorColor: Assets.appColor.withOpacity(0.5),
          selectedIndex: controller.stateIndex.value,
          onDestinationSelected: (value) {
            controller.stateIndex.value = value;
          },
          destinations: [
            NavigationDestination(
              icon: Icon(Icons.home_outlined),
              label: "Home",
            ),
            NavigationDestination(
              icon: Stack(
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    child: Icon(Icons.shopping_cart_outlined),
                  ),
                 cartController.getCartResponse.value.data.isEmpty? SizedBox(): Positioned(
                    top: 0, right: 0,
                    child: Container(
                      alignment: Alignment.center,
                      height: 20,
                      width: 20,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      child: Obx(()=> Text("${cartController.getCartResponse.value.data.length}", style: TextStyle(color: Colors.white),),)
                    ),
                  ),
                ],
              ),
              label: "My Cart",
            ),
            NavigationDestination(
              icon: Icon(Icons.person_outline),
              label: "Profile",
            ),
          ],
        ),
      ),
    );
  }
}
