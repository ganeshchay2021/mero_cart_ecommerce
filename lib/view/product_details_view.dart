import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce/controller/auth_controller.dart';
import 'package:ecommerce/controller/cart_controller.dart';
import 'package:ecommerce/controller/product_controller.dart';
import 'package:ecommerce/controller/storage_controller.dart';
import 'package:ecommerce/model/product_model.dart';
import 'package:ecommerce/utils/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class ProductDetailsView extends GetView<AuthController> {
  final Product product;
  ProductDetailsView({super.key, required this.product});

  final productContorller = Get.find<ProductController>();
  final cartController = Get.find<CartController>();

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) {
          productContorller.productQuantity.value = 1;
    
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Assets.appColor.withOpacity(0.5),
          title: Text("${product.title}"),
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Hero(
                tag: "${product.id}",
                child: CachedNetworkImage(
                  height: MediaQuery.of(context).size.height * 0.4,
                  fit: BoxFit.cover,
                  imageUrl: "${product.image}",
                  placeholder: (context, url) {
                    return Center(child: CircularProgressIndicator.adaptive());
                  },
                  errorWidget: (context, url, error) =>
                      Icon(Icons.error_outline, color: Colors.red, size: 50),
                ),
              ),
              Gap(20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Assets.appColor,
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () {
                      if (productContorller.productQuantity.value > 1) {
                        productContorller.productQuantity--;
                      }
                    },
                    child: Icon(Icons.remove, size: 25),
                  ),
                  Gap(20),
                  Obx(
                    () => Text(
                      "${productContorller.productQuantity.value}",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                  Gap(20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Assets.appColor,
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () {
                      productContorller.productQuantity++;
                    },
                    child: Icon(Icons.add, size: 25),
                  ),
                ],
              ),
              Gap(20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                "${product.title}",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Gap(5),
                              Text(
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                "From ${product.category} category",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Gap(50),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "रु.${product.price}",
                              style: TextStyle(
                                decoration: TextDecoration.lineThrough,
                                decorationColor: Colors.red,
                                decorationThickness: 2,
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            RichText(
                              text: TextSpan(
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                ),
                                text: "Discount: ",
                                children: [
                                  TextSpan(
                                    text: "${product.discountPercent}",
                                    style: TextStyle(
                                      color: const Color.fromARGB(
                                        255,
                                        26,
                                        124,
                                        30,
                                      ),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            Text(
                              "रु.${product.discountedPrice}",
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Gap(10),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.amber.shade100,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.fromBorderSide(
                          BorderSide(width: 0.5, color: Colors.grey.shade300),
                        ),
                      ),
                      child: Text(
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        "Discription",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Divider(thickness: 0.5),
                    Gap(10),
                    HtmlWidget(
                      "${product.description}",
                      renderMode: RenderMode.column,
                      textStyle: const TextStyle(
                        fontSize: 16,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Assets.appColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(100),
          ),
          onPressed: () async {
            final token = StorageController().getToken();
            if (token == null) {
              controller.checkAuth();
            } else {
              await cartController.getCart();
              if (cartController.productId.contains(product.id)) {
                Get.snackbar(
                  "Warning",
                  "Item already exist on cart",
                  backgroundColor: Colors.red,
                  colorText: Colors.white,
                  duration: Duration(seconds: 2),
                );
              } else {
                Loader.show(context);
                await cartController.addToCart(
                  token: token,
                  productId: product.id!,
                  quantity: productContorller.productQuantity.toInt(),
                );
                await cartController.getCart();
                Loader.hide();
              }
            }
          },
          child: Icon(Icons.shopping_cart, color: Colors.white, size: 30),
        ),
        floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      ),
    );
  }
}
