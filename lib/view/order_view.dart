import 'package:ecommerce/controller/cart_controller.dart';
import 'package:ecommerce/controller/order_controller.dart';
import 'package:ecommerce/model/cart_model.dart';
import 'package:ecommerce/routes/app_routes.dart';
import 'package:ecommerce/utils/assets.dart';
import 'package:ecommerce/widgets/common_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class OrderView extends GetView<OrderController> {
  OrderView({super.key});

  final cartController = Get.find<CartController>();
  @override
  Widget build(BuildContext context) {
    final List<CartProduct> cartProduct = Get.arguments;
    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) {
          controller.image.value = null;
        }
      },
      child: Scaffold(
        backgroundColor: Colors.grey.shade100,
        appBar: AppBar(
          backgroundColor: Assets.appColor.withOpacity(0.5),
          title: Text("My Order"),
        ),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsetsGeometry.symmetric(horizontal: 15),
            child: Column(
              children: [
                Gap(20),
                //receipt upload
                Card(
                  color: Colors.white,
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Payment Receipt",
                          style: TextStyle(
                            color: Colors.amber,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Gap(10),
                        Obx(
                          () => Container(
                            height: 200,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.amber.shade200),
                            ),
                            child: controller.image.value != null
                                ? ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.file(
                                      controller.image.value!,
                                      fit: BoxFit.cover,
                                    ),
                                )
                                : Icon(
                                    Icons.flip_camera_ios_outlined,
                                    size: 60,
                                    color: Colors.amber.shade200,
                                  ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Gap(20),
                //ordered Items
                Card(
                  color: Colors.white,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                          text: TextSpan(
                            style: TextStyle(
                              color: Colors.amber,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                            children: [
                              WidgetSpan(
                                child: Icon(
                                  Icons.shopping_bag_outlined,
                                  color: Colors.amber,
                                ),
                              ),
                              TextSpan(text: "  Order Details"),
                            ],
                          ),
                        ),
                        Gap(10),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: cartProduct.length,
                          itemBuilder: (context, index) {
                            final cproduct = cartProduct[index];
                            return Container(
                              padding: EdgeInsets.all(10),
                              margin: EdgeInsets.symmetric(vertical: 10),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade50,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              height: 70,
                              width: double.infinity,
                              child: Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(1),
                                    decoration: BoxDecoration(
                                      color: Colors.amber,
                                      shape: BoxShape.circle,
                                    ),
                                    child: CircleAvatar(
                                      radius: 30,
                                      backgroundImage: NetworkImage(
                                        "${cproduct.productImage}",
                                      ),
                                    ),
                                  ),
                                  Gap(10),
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${cproduct.productName}",
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          "Quantity: ${cproduct.quantity}",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w300,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "रु.${cproduct.sellingPrice}",
                                          style: TextStyle(
                                            color: Colors.amber,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16,
                                          ),
                                        ),
                                        RichText(
                                          text: TextSpan(
                                            text: "Save  ",
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w500,
                                            ),
                                            children: [
                                              TextSpan(
                                                text:
                                                    "रु.${cproduct.discountAmt}",
                                                style: TextStyle(
                                                  color: Colors.green,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 14,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomSheet: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(width: 1, color: Colors.grey.shade300),
          ),
          padding: EdgeInsets.all(10),
          height: 200,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Total Amount",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                  ),
                  Text(
                    "रु.${cartController.total}",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.amber,
                    ),
                  ),
                ],
              ),
              Gap(10),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    OutlinedButton(
                      onPressed: () {
                        _showPicker(context);
                      },
                      style: OutlinedButton.styleFrom(
                        padding: EdgeInsets.all(10),

                        side: BorderSide(color: Colors.amber),
                        shape: RoundedRectangleBorder(
                          borderRadius: .circular(10),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.credit_card),
                          Gap(10),
                          Text(
                            "Choose payment method",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Gap(10),
                    CommonButton(
                      buttonName: "Confirm Order",
                      onTap: ()async {
                        Loader.show(context);
                        if (controller.image.value == null) {
                          if (!Get.isSnackbarOpen) {
                            Get.snackbar(
                              "Error",
                              "Please upload payment Receipt",
                              backgroundColor: Colors.red,
                              colorText: Colors.white,
                              duration: Duration(seconds: 2),
                            );
                          }
                        } else {
                            await controller.placeOrder(controller.image.value!);
                            await cartController.getCart();
                            await controller.getOrder();
                            Get.offNamedUntil(AppRoutes.bottomNavBar, (route)=> false);
                        }
                        Loader.hide();

                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showPicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Choose from Gallery'),
                onTap: () async {
                  Loader.show(context);
                  await controller.pickGalleryImage();
                  Get.back();
                  Loader.hide();
                },
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Open Camera'),
                onTap: () async {
                  Loader.show(context);
                  await controller.pickCameraImage();
                  Get.back();
                  Loader.hide();
                },
              ),
              const SizedBox(height: 20), // Bottom padding
            ],
          ),
        );
      },
    );
  }
}
