import 'package:ecommerce/model/product_model.dart';
import 'package:ecommerce/services/product_services.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  RxBool isLoading = false.obs;
  var productResponse = ProductModel(success: false, data: []);

  //fetch Product Method
  Future<void> getProduct() async {
    try {
      isLoading(true);
      final response = await ProductServices.fetchAllProduct();

      if (response.statusCode == 200) {
        final result = ProductModel.fromJson(response.data);
        productResponse = result;
        isLoading(false);
      }
    } finally {
      isLoading(false);
    }
  }

  @override
  void onInit() {
    getProduct();
    super.onInit();
  }
}
