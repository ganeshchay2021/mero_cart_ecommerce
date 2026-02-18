import 'package:ecommerce/model/product_model.dart';
import 'package:ecommerce/services/product_services.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  RxBool isLoading = false.obs;
  var productResponse = ProductModel(success: false, data: []).obs;
  List<String> get categoryList {
    List<String> uniqueCategories = productResponse.value.data
        .map((e) => e.category ?? "General")
        .toSet()
        .toList();

    return ["All", ...uniqueCategories];
  }

  RxInt categoryState = 0.obs;

  // Set the default to "All" instead of ""
  RxString cateGoryName = "".obs;

  List<Product> get filteredProducts {
    final products = productResponse.value.data;
    final selected = cateGoryName.value;

    if (selected == "All" || selected == "") {
      return products;
    } else {
      return products.where((p) => p.category == selected).toList();
    }
  }

  //fetch Product Method
  Future<void> getProduct() async {
    try {
      isLoading(true);
      final response = await ProductServices.fetchAllProduct();

      if (response.statusCode == 200) {
        final result = ProductModel.fromJson(response.data);
        result.data.shuffle();
        productResponse.value = result;
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
