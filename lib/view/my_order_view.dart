import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce/controller/order_controller.dart';
import 'package:ecommerce/utils/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:gap/gap.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/state_manager.dart';

class MyOrderView extends GetView<OrderController> {
  const MyOrderView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Assets.appColor.withOpacity(0.5),
        title: Text("My Order"),
      ),
      body: Obx(() {
        if (controller.getAllOrderResponse.value.success==false) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("assets/cart.png", height: 100, color: Colors.grey),
                Text(
                  "Empty Order",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
                ),
              ],
            ),
          );
        } else {
          return ListView.builder(
            itemCount: controller.getAllOrderResponse.value.orders.length,
            itemBuilder: (context, index) {
              final order = controller.getAllOrderResponse.value.orders[index];
              return Card(
                margin: EdgeInsets.only(
                  top: 10,
                  right: 20,
                  left: 20,
                  bottom: 10,
                ),
                child: Container(
                  padding: EdgeInsets.all(10),
                  height: 180,
                  width: double.infinity,
                  color: Assets.appColor.withOpacity(0.1),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: CachedNetworkImage(
                          fit: BoxFit.cover,
                          imageUrl: "${order.paymentReceipt}",
                          width: 70,
                          height: 150,
                          placeholder: (context, url) {
                            return Center(
                              child: CircularProgressIndicator.adaptive(),
                            );
                          },
                          errorWidget: (context, url, error) => Center(
                            child: Icon(Icons.error_outline, color: Colors.red),
                          ),
                        ),
                      ),
                      SizedBox(width: 15),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Order No.: ${order.orderId}",
                              style: TextStyle(fontSize: 18),
                            ),
                            Text(
                              "No. of Ordered Items.: ${order.items.length}",
                              style: TextStyle(fontSize: 18),
                            ),
                            RichText(
                              text: TextSpan(
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                ),
                                text: "Total Amount.: ",
                                children: [
                                  TextSpan(
                                    text: "रु ${order.totalAmt}",
                                    style: TextStyle(color: Colors.green),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 10,
                                        vertical: 5,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Text(
                                        "${order.paymentVerification}",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 10,
                                        vertical: 5,
                                      ),
                                      decoration: BoxDecoration(
                                        color: order.status == "cancel"
                                            ? Colors.grey
                                            : Colors.amber.shade400,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Text(
                                        "${order.status}",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Spacer(),
                                order.status == "cancel"
                                    ? GestureDetector(
                                        onTap: () {
                                          Get.defaultDialog(
                                            titlePadding: EdgeInsets.only(
                                              top: 10,
                                            ),
                                            title: "Order Delete",
                                            content: Column(
                                              children: [
                                                Icon(
                                                  Icons.delete_forever_outlined,
                                                  color: Colors.red,
                                                  size: 60,
                                                ),
                                                Gap(10),
                                                const Text(
                                                  "Are you sure you want to delete the order?",
                                                ),
                                                const SizedBox(height: 10),
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      child: OutlinedButton(
                                                        style:
                                                            OutlinedButton.styleFrom(
                                                              backgroundColor:
                                                                  Colors.black,
                                                              foregroundColor:
                                                                  Colors.white,
                                                            ),
                                                        onPressed: () =>
                                                            Get.back(),
                                                        child: const Text(
                                                          "Cancel",
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      width: 10,
                                                    ), // Space between buttons
                                                    Expanded(
                                                      child: OutlinedButton(
                                                        style:
                                                            OutlinedButton.styleFrom(
                                                              padding:
                                                                  EdgeInsets.all(
                                                                    8,
                                                                  ),
                                                              backgroundColor:
                                                                  Colors.black,
                                                              foregroundColor:
                                                                  Colors.white,
                                                            ),
                                                        onPressed: () async {
                                                          Get.back();
                                                          Loader.show(context);
                                                          await controller
                                                              .orderDelete(
                                                                "${order.orderId}",
                                                              );
                                                          Loader.hide();
                                                        },
                                                        child: const Text(
                                                          "Yes",
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 10,
                                            vertical: 5,
                                          ),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(
                                              10,
                                            ),
                                          ),
                                          child: Icon(
                                            Icons.delete,
                                            color: Colors.red,
                                          ),
                                        ),
                                      )
                                    : GestureDetector(
                                        onTap: () {
                                          Get.defaultDialog(
                                            titlePadding: EdgeInsets.only(
                                              top: 10,
                                            ),
                                            title: "Order Cancel",
                                            content: Column(
                                              children: [
                                                Icon(
                                                  Icons.cancel,
                                                  color: Colors.red,
                                                  size: 60,
                                                ),
                                                Gap(10),
                                                const Text(
                                                  "Are you sure you want to cancel the order?",
                                                ),
                                                const SizedBox(height: 10),
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      child: OutlinedButton(
                                                        style:
                                                            OutlinedButton.styleFrom(
                                                              backgroundColor:
                                                                  Colors.black,
                                                              foregroundColor:
                                                                  Colors.white,
                                                            ),
                                                        onPressed: () =>
                                                            Get.back(),
                                                        child: const Text(
                                                          "Cancel",
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      width: 10,
                                                    ), // Space between buttons
                                                    Expanded(
                                                      child: OutlinedButton(
                                                        style:
                                                            OutlinedButton.styleFrom(
                                                              padding:
                                                                  EdgeInsets.all(
                                                                    8,
                                                                  ),
                                                              backgroundColor:
                                                                  Colors.black,
                                                              foregroundColor:
                                                                  Colors.white,
                                                            ),
                                                        onPressed: () async {
                                                          Get.back();
                                                          Loader.show(context);
                                                          await controller
                                                              .cancelOrder(
                                                                "${order.orderId}",
                                                              );
                                                          Loader.hide();
                                                        },
                                                        child: const Text(
                                                          "Yes",
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 10,
                                            vertical: 5,
                                          ),
                                          decoration: BoxDecoration(
                                            color: Colors.black,
                                            borderRadius: BorderRadius.circular(
                                              10,
                                            ),
                                          ),
                                          child: Text(
                                            "Cancel Order",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18,
                                            ),
                                          ),
                                        ),
                                      ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        }
      }),
    );
  }
}
