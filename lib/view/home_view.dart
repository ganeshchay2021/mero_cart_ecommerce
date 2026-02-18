import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecommerce/controller/auth_controller.dart';
import 'package:ecommerce/controller/product_controller.dart';
import 'package:ecommerce/controller/storage_controller.dart';
import 'package:ecommerce/routes/app_routes.dart';
import 'package:ecommerce/utils/assets.dart';
import 'package:ecommerce/widgets/product_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class HomeView extends GetView<ProductController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthController>();
    final token = StorageController().getToken();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Assets.appColor.withOpacity(0.5),
        elevation: 5,
        title: const Text("Mero Cart"),
        actions: [
          token == null
              ? SizedBox()
              : IconButton(
                  onPressed: () {
                    Get.defaultDialog(
                      titlePadding: EdgeInsets.only(top: 10),
                      title: "Warning",
                      content: Column(
                        children: [
                          Icon(Icons.error, color: Colors.red, size: 45),
                          Gap(10),
                          const Text("Are you sure you want to logout?"),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Expanded(
                                child: OutlinedButton(
                                  style: OutlinedButton.styleFrom(
                                    backgroundColor: Colors.black,
                                    foregroundColor: Colors.white,
                                  ),
                                  onPressed: () => Get.back(),
                                  child: const Text("Cancel"),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ), // Space between buttons
                              Expanded(
                                child: OutlinedButton(
                                  style: OutlinedButton.styleFrom(
                                    padding: EdgeInsets.all(8),
                                    backgroundColor: Colors.black,
                                    foregroundColor: Colors.white,
                                  ),
                                  onPressed: () async {
                                    Get.back();
                                    Loader.show(context);
                                    await authController.logout();
                                    Loader.hide();
                                  },
                                  child: const Text("Yes"),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                  icon: const Icon(Icons.logout_sharp),
                ),
          const Gap(10),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.isTrue) {
          return Center(child: CircularProgressIndicator.adaptive());
        } else {
          return SingleChildScrollView(
            // physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                Gap(10),
                CarouselSlider(
                  items: controller.productResponse.value.data.map((e) {
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.grey.shade200),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadiusGeometry.circular(10),
                        child: CachedNetworkImage(
                          width: double.infinity,
                          fit: BoxFit.cover,
                          imageUrl: "${e.image}",
                          placeholder: (context, url) {
                            return Center(
                              child: CircularProgressIndicator.adaptive(),
                            );
                          },
                          errorWidget: (context, url, error) => Icon(
                            Icons.error_outline,
                            color: Colors.red,
                            size: 50,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                  options: CarouselOptions(
                    height: 150,
                    aspectRatio: 16 / 9,
                    viewportFraction: 0.8,
                    initialPage: 0,
                    enableInfiniteScroll: true,
                    reverse: false,
                    autoPlay: true,
                    autoPlayInterval: Duration(seconds: 3),
                    autoPlayAnimationDuration: Duration(milliseconds: 800),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enlargeCenterPage: true,
                    enlargeFactor: 0.3,
                    scrollDirection: Axis.horizontal,
                  ),
                ),

                Gap(20),
                SingleChildScrollView(
                  padding: EdgeInsets.zero,
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      Row(
                        children: List.generate(
                          controller.categoryList.length,
                          (index) {
                            return Padding(
                              padding: controller.categoryState.value == 0
                                  ? EdgeInsets.only(left: 15)
                                  : EdgeInsets.only(right: 15),
                              child: Obx(
                                () => ChoiceChip(
                                  showCheckmark: false,
                                  label: Text(
                                    controller.categoryList[index],
                                    style: TextStyle(
                                      color:
                                          controller.categoryState.value ==
                                              index
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  ),
                                  selected:
                                      controller.categoryState.value == index,
                                  selectedColor: Assets.appColor,
                                  backgroundColor:
                                      controller.categoryState.value == index
                                      ? Assets.appColor
                                      : Colors.grey.shade300,
                                  labelStyle: TextStyle(
                                    color:
                                        controller.categoryState.value == index
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                                  onSelected: (bool selected) {
                                    if (selected) {
                                      controller.categoryState.value = index;
                                      controller.cateGoryName.value =
                                          controller.categoryList[index];
                                    }
                                  },
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Gap(10),

                GridView.builder(
                  cacheExtent: 500,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.only(top: 0, left: 10, right: 10),
                  itemCount: controller.filteredProducts.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 0.8,
                  ),
                  itemBuilder: (context, index) {
                    final product = controller.filteredProducts[index];
                    return InkWell(
                      onTap: () {
                        Get.toNamed(AppRoutes.product, arguments: product);
                      },
                      child: ProductCardWidget(product: product),
                    );
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
