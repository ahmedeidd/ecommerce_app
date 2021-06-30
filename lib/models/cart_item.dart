import 'package:ecommerce_app_eid/models/product.dart';
import 'dart:convert';

class CartItem {
  Product product;
  int quantity;

  CartItem({this.product, this.quantity, int});

  Map<String, dynamic> toJson() => {
        "product": product.toJson(),
        "quantity": quantity,
      };

  factory CartItem.fromJson(Map<String, dynamic> json) => CartItem(
        product: Product.fromJson(json["product"]),
        quantity: json["quantity"],
      );
}

String cartItemToJson(List<CartItem> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

List<CartItem> cartItemFromJson(String str) =>
    List<CartItem>.from(json.decode(str).map((x) => CartItem.fromJson(x)));
