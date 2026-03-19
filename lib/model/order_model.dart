class OrderModel {
  OrderModel({
    required this.success,
    required this.message,
    required this.orders,
  });

  final bool? success;
  final String? message;
  final List<Order> orders;

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      success: json["success"],
      message: json["message"],
      orders: json["orders"] == null
          ? []
          : List<Order>.from(json["orders"]!.map((x) => Order.fromJson(x))),
    );
  }
}

class Order {
  Order({
    required this.orderId,
    required this.totalAmt,
    required this.status,
    required this.paymentVerification,
    required this.paymentReceipt,
    required this.items,
  });

  final int? orderId;
  final String? totalAmt;
  final String? status;
  final String? paymentVerification;
  final String? paymentReceipt;
  final List<Item> items;

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      orderId: json["order id"],
      totalAmt: json["total_amt"],
      status: json["status"],
      paymentVerification: json["payment_verification"],
      paymentReceipt: json["payment_receipt"],
      items: json["items"] == null
          ? []
          : List<Item>.from(json["items"]!.map((x) => Item.fromJson(x))),
    );
  }
}

class Item {
  Item({required this.quantity, required this.product});

  final int? quantity;
  final Product? product;

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      quantity: json["quantity"],
      product: json["product"] == null
          ? null
          : Product.fromJson(json["product"]),
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
  final double? discountAmount;
  final double? discountedPrice;
  final String? image;
  final String? category;

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json["id"],
      title: json["title"],
      description: json["description"],
      // Use .toDouble() or casting to handle both 100 and 100.50
      price: json["price"]?.toInt(),
      discountPercent: json["discount_percent"],
      discountAmount: json["discount_amount"]?.toDouble(),
      discountedPrice: json["discounted_price"]?.toDouble(),
      image: json["image"],
      category: json["category"],
    );
  }
}
