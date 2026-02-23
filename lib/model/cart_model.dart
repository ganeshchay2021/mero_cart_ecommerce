class AddToCartModel {
    AddToCartModel({
        required this.success,
        required this.message,
    });

    final bool? success;
    final String? message;

    factory AddToCartModel.fromJson(Map<String, dynamic> json){ 
        return AddToCartModel(
            success: json["success"],
            message: json["message"],
        );
    }

}


class GetCartModel {
    GetCartModel({
        required this.sucess,
        required this.data,
    });

    final bool? sucess;
    final List<CartProduct> data;

    factory GetCartModel.fromJson(Map<String, dynamic> json){ 
        return GetCartModel(
            sucess: json["sucess"],
            data: json["data"] == null ? [] : List<CartProduct>.from(json["data"]!.map((x) => CartProduct.fromJson(x))),
        );
    }

}

class CartProduct {
    CartProduct({
        required this.cartId,
        required this.productId,
        required this.productName,
        required this.productPrice,
        required this.sellingPrice,
        required this.quantity,
        required this.discount,
        required this.discountAmt,
        required this.totalAmt,
        required this.productImage,
    });

    final int? cartId;
    final int? productId;
    final String? productName;
    final int? productPrice;
    final dynamic sellingPrice;
    final int? quantity;
    final String? discount;
    final dynamic discountAmt;
    final dynamic totalAmt;
    final String? productImage;

    factory CartProduct.fromJson(Map<String, dynamic> json){ 
        return CartProduct(
            cartId: json["cart_id"],
            productId: json["product_id"],
            productName: json["product_name"],
            productPrice: json["product_price"],
            sellingPrice: json["selling_price"],
            quantity: json["quantity"],
            discount: json["discount"],
            discountAmt: json["discount_amt"],
            totalAmt: json["total_amt"],
            productImage: json["product_image"],
        );
    }

}
