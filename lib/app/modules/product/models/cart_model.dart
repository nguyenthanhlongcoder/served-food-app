// To parse this JSON data, do
//
//     final cartModel = cartModelFromJson(jsonString);

import 'dart:convert';

CartModel cartModelFromJson(String str) => CartModel.fromJson(json.decode(str));

String cartModelToJson(CartModel data) => json.encode(data.toJson());

class CartModel {
  CartModel({
    this.title,
    this.image,
    this.quantity,
    this.extras,
    this.note,
    this.orderItemPrice,
  });

  String title;
  String image;
  int quantity;
  List<String> extras;
  String note;
  int orderItemPrice;

  factory CartModel.fromJson(Map<String, dynamic> json) => CartModel(
        title: json["title"],
        image: json["image"],
        quantity: json["quantity"],
        extras: List<String>.from(json["extras"].map((x) => x)),
        note: json["note"],
        orderItemPrice: json["order_item_price"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "image": image,
        "quantity": quantity,
        "extras": List<dynamic>.from(extras.map((x) => x)),
        "note": note,
        "order_item_price": orderItemPrice,
      };

  static Map<String, dynamic> toMap(CartModel cart) => {
        "title": cart.title,
        "image": cart.image,
        "quantity": cart.quantity,
        "note": cart.note,
        "extras": cart.extras,
        "order_item_price": cart.orderItemPrice,
      };
  static String encode(List<CartModel> carts) => json.encode(
        carts
            .map<Map<String, dynamic>>((cart) => CartModel.toMap(cart))
            .toList(),
      );

  static List<CartModel> decode(String carts) =>
      (json.decode(carts) as List<dynamic>)
          .map<CartModel>((item) => CartModel.fromJson(item))
          .toList();
}
