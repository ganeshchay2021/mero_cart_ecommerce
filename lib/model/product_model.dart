class ProductModel {
    ProductModel({
        required this.success,
        required this.data,
    });

    final bool? success;
    final List<Product> data;

    factory ProductModel.fromJson(Map<String, dynamic> json){ 
        return ProductModel(
            success: json["success"],
            data: json["data"] == null ? [] : List<Product>.from(json["data"]!.map((x) => Product.fromJson(x))),
        );
    }

}

class Product {
    Product({
        required this.id,
        required this.title,
        required this.description,
        required this.price,
        required this.discountPercent,
        required this.discountAmount,
        required this.discountedPrice,
        required this.image,
        required this.category,
    });

    final int? id;
    final String? title;
    final String? description;
    final int? price;
    final String? discountPercent;
    final dynamic discountAmount;
    final dynamic discountedPrice;
    final String? image;
    final String? category;

    factory Product.fromJson(Map<String, dynamic> json){ 
        return Product(
            id: json["id"],
            title: json["title"],
            description: json["description"],
            price: json["price"],
            discountPercent: json["discount_percent"],
            discountAmount: json["discount_amount"],
            discountedPrice: json["discounted_price"],
            image: json["image"],
            category: json["category"],
        );
    }

}
