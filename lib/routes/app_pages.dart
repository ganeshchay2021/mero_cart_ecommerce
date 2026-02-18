import 'package:ecommerce/model/product_model.dart';
import 'package:ecommerce/routes/app_routes.dart';
import 'package:ecommerce/view/botton_nav_bar.dart';
import 'package:ecommerce/view/home_view.dart';
import 'package:ecommerce/view/login_view.dart';
import 'package:ecommerce/view/product_details_view.dart';
import 'package:ecommerce/view/register_view.dart';
import 'package:ecommerce/view/splash_view.dart';
import 'package:get/route_manager.dart';

class AppPages {
  static final routes = [
    GetPage(name: AppRoutes.splash, page: () => SplashView()),
    GetPage(name: AppRoutes.login, page: () => LoginView()),
    GetPage(name: AppRoutes.register, page: () => RegisterView()),
    GetPage(name: AppRoutes.home, page: () => HomeView()),
    GetPage(name: AppRoutes.bottomNavBar, page: () => BottonNavBar()),
    GetPage(
      name: AppRoutes.product,
      page: () {
        final Product product = Get.arguments;
        return ProductDetailsView(product: product);
      },
    ),
  ];
}
