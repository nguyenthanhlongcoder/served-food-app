// To parse this JSON data, do
//
//     final orderItemModel = orderItemModelFromJson(jsonString);

import 'dart:convert';

OrderItemModel orderItemModelFromJson(String str) =>
    OrderItemModel.fromJson(json.decode(str));

String orderItemModelToJson(OrderItemModel data) => json.encode(data.toJson());

class OrderItemModel {
  OrderItemModel({
    this.order,
    this.user,
    this.product,
    this.productVariationOption,
    this.quantity,
    this.note,
  });

  int order;
  int user;
  int product;
  int productVariationOption;
  int quantity;
  String note;

  factory OrderItemModel.fromJson(Map<String, dynamic> json) => OrderItemModel(
        order: json["order"],
        user: json["user"],
        product: json["product"],
        productVariationOption: json["product_variation_option"],
        quantity: json["quantity"],
        note: json["note"],
      );

  Map<String, dynamic> toJson() => {
        "order": order,
        "user": user,
        "product": product,
        "product_variation_option": productVariationOption,
        "quantity": quantity,
        "note": note,
      };
  static Map<String, dynamic> toMap(OrderItemModel orderItem) => {
        "order": orderItem.order,
        "user": orderItem.user,
        "product": orderItem.product,
        "product_variation_option": orderItem.productVariationOption,
        "quantity": orderItem.quantity,
        "note": orderItem.note,
      };
  static String encode(List<OrderItemModel> orderItems) => json.encode(
        orderItems
            .map<Map<String, dynamic>>(
                (orderItem) => OrderItemModel.toMap(orderItem))
            .toList(),
      );

  static List<OrderItemModel> decode(String orderItems) =>
      (json.decode(orderItems) as List<dynamic>)
          .map<OrderItemModel>((item) => OrderItemModel.fromJson(item))
          .toList();
}
