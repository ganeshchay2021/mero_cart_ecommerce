import 'package:ecommerce/controller/auth_controller.dart';
import 'package:ecommerce/utils/assets.dart';
import 'package:ecommerce/view/cart_view..dart';
import 'package:ecommerce/view/home_view.dart';
import 'package:ecommerce/view/profile_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottonNavBar extends GetView<AuthController> {
  const BottonNavBar({super.key});

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
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.home_outlined),
              label: "Home",
            ),
            NavigationDestination(
              icon: Icon(Icons.shopping_cart_outlined),
              label: "My Courses",
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
