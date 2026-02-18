import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce/controller/auth_controller.dart';
import 'package:ecommerce/controller/storage_controller.dart';
import 'package:ecommerce/model/product_model.dart';
import 'package:ecommerce/utils/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class ProductDetailsView extends GetView<AuthController> {
  final Product product;
  const ProductDetailsView({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                            "Rs.${product.price}",
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
                            "Rs.${product.discountedPrice}",
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
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
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
                    "${product.description}", // This is your HTML string from JSON
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
        onPressed: () {
          final token = StorageController().getToken();
          if (token == null) {
            controller.checkAuth();
          } else {
            Get.snackbar(
          "Success",
          token,
          backgroundColor: Colors.green,
          colorText: Colors.white,
          duration: Duration(seconds: 2),
        );
          }
        },
        child: Icon(Icons.shopping_cart, color: Colors.white, size: 30),
      ),
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
    );
  }
}
