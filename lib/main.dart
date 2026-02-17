import 'package:ecommerce/bindings/controller_bindings.dart';
import 'package:ecommerce/routes/app_pages.dart';
import 'package:ecommerce/view/splash_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Mero Cart',
      initialBinding: ControllerBindings(),
      getPages: AppPages.routes,
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
      home: SplashView(),
    );
  }
}
