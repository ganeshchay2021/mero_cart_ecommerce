import 'package:ecommerce/controller/auth_controller.dart';
import 'package:ecommerce/controller/storage_controlle.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final controller = Get.find<StorageController>();

  @override
  Widget build(BuildContext context) {
    final String token = controller.getToken().toString();
    final authController=Get.find<AuthController>();

    return Scaffold(
      appBar: AppBar(),
      drawer: Drawer(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ListTile(
              onTap: () {
                authController.logout();
              },
              leading: Icon(Icons.logout), title: Text("Logout"),),
            Gap(20)
          ],
        ),
      ),
      body: Center(child: Text(token)),
    );
  }
}
