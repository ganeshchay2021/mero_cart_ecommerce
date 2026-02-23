import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce/controller/cart_controller.dart';
import 'package:ecommerce/controller/storage_controller.dart';
import 'package:ecommerce/utils/assets.dart';
import 'package:ecommerce/widgets/common_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class CartView extends StatefulWidget {
  const CartView({super.key});

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  final controller = Get.find<CartController>();
  @override
  void initState() {
    controller.getCart();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("My Cart"),
        backgroundColor: Assets.appColor.withOpacity(0.5),
      ),
      body: Obx(() {
        if (controller.isLoading.isTrue) {
          return Center(child: CircularProgressIndicator.adaptive());
        } else {
          return Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${controller.getCartResponse.value.data.length} Item availabls",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .65,
                  child: controller.getCartResponse.value.data.isEmpty
                      ? Center(
                          child: Image.asset(
                            "assets/cart.png",
                            height: 100,
                            color: Colors.grey,
                          ),
                        )
                      : ListView.builder(
                          itemCount:
                              controller.getCartResponse.value.data.length,
                          itemBuilder: (context, index) {
                            final cartProduct =
                                controller.getCartResponse.value.data[index];
                            return Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: 8,
                                horizontal: 5,
                              ),
                              child: Card(
                                clipBehavior: Clip.antiAlias,
                                color: Colors.grey.shade50,
                                child: Row(
                                  children: [
                                    CachedNetworkImage(
                                      height: 100,
                                      width: 100,
                                      fit: BoxFit.cover,
                                      imageUrl: "${cartProduct.productImage}",
                                      progressIndicatorBuilder:
                                          (
                                            context,
                                            url,
                                            downloadProgress,
                                          ) => Center(
                                            child: CircularProgressIndicator(
                                              value: downloadProgress.progress,
                                            ),
                                          ),
                                      errorWidget: (context, url, error) =>
                                          Icon(Icons.error, color: Colors.red),
                                    ),

                                    Gap(10),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                cartProduct.productName!,
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                              RichText(
                                                text: TextSpan(
                                                  text:
                                                      "रु.${cartProduct.productPrice} ",
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                    decoration: TextDecoration
                                                        .lineThrough,
                                                    decorationColor:
                                                        Colors.black,

                                                    color: Colors.grey,
                                                  ),
                                                  children: [
                                                    TextSpan(
                                                      text:
                                                          " रु.${cartProduct.sellingPrice}",
                                                      style: TextStyle(
                                                        fontSize: 18,
                                                        decoration:
                                                            TextDecoration.none,
                                                        decorationColor:
                                                            Colors.red,
                                                        color: Colors.red,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          Gap(8),
                                          Text(
                                            "रु.${cartProduct.totalAmt}",
                                            style: TextStyle(
                                              color: const Color.fromARGB(
                                                255,
                                                16,
                                                126,
                                                19,
                                              ),
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        IconButton(
                                          onPressed: () async {
                                            Loader.show(context);
                                            await controller.deteleCart(
                                              productId: cartProduct.cartId!,
                                            );
                                            await controller.getCart();
                                            Loader.hide();
                                          },
                                          icon: Icon(
                                            Icons.delete,
                                            color: Colors.red,
                                          ),
                                        ),

                                        Row(
                                          children: [
                                            IconButton(
                                              style: IconButton.styleFrom(
                                                backgroundColor: Assets.appColor
                                                    .withOpacity(0.2),
                                              ),
                                              onPressed: () async {
                                                if (cartProduct.quantity! > 1) {
                                                  // // var qty = ;
                                                  // print(cartProduct.productId);
                                                  Loader.show(context);
                                                  await controller.updateCart(
                                                    productId:
                                                        cartProduct.productId!,
                                                    cartId: cartProduct.cartId!,
                                                    quantity:
                                                        cartProduct.quantity! -
                                                        1,
                                                  );
                                                  controller.getCart();
                                                  Loader.hide();
                                                }
                                              },
                                              icon: Icon(Icons.remove),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                horizontal: 5,
                                              ),
                                              child: Text(
                                                "${cartProduct.quantity}",
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            ),
                                            IconButton(
                                              style: IconButton.styleFrom(
                                                backgroundColor: Assets.appColor
                                                    .withOpacity(0.2),
                                              ),
                                              onPressed: () async {
                                                if (cartProduct.quantity! <
                                                    10) {
                                                  Loader.show(context);
                                                  await controller.updateCart(
                                                    productId:
                                                        cartProduct.productId!,
                                                    cartId: cartProduct.cartId!,
                                                    quantity:
                                                        cartProduct.quantity! +
                                                        1,
                                                  );
                                                  controller.getCart();
                                                  print(
                                                    "${cartProduct.quantity}",
                                                  );
                                                  Loader.hide();
                                                }
                                              },
                                              icon: Icon(Icons.add),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                ),
              ],
            ),
          );
        }
      }),
      bottomSheet: Obx(() {
        if (controller.isLoading.isTrue) {
          return SizedBox();
        } else {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            width: double.infinity,
            height: 170,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Sub Total Selling Price",
                      style: TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      "रू.${controller.subTotal}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Sub total Discount amount",
                      style: TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      "रू.${controller.discount}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Total",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      "रू.${controller.total}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
                CommonButton(
                  buttonName: "Checkout",
                  onTap: () {
                    final token = StorageController().getToken();
                    print("Token $token");
                  },
                ),
              ],
            ),
          );
        }
      }),
    );
  }
}
