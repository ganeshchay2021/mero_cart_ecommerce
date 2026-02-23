
import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce/model/product_model.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ProductCardWidget extends StatelessWidget {
  const ProductCardWidget({
    super.key,
    required this.product,
  });

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: "${product.id}",
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: 165,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: CachedNetworkImage(
                      fit: BoxFit.cover,
                      imageUrl: "${product.image}",
                      placeholder: (context, url) {
                        return Center(
                          child: CircularProgressIndicator.adaptive(),
                        );
                      },
                      errorWidget: (context, url, error) =>
                          Icon(Icons.error_outline, color: Colors.red,),
                    ),
                  ),
                ),
              ],
            ),
            Gap(5),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    "${product.title}",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "रु. ${product.price}",
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                        width: 60,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.zero,
                            backgroundColor: Colors.black,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          onPressed: () {},
                          child: Text(
                            "Buy",
                            style: TextStyle(fontSize: 15),
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
  }
}
