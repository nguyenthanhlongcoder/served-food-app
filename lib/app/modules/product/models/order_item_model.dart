// To parse this JSON data, do
//
//     final orderItemModel = orderItemModelFromJson(jsonString);

import 'dart:convert';

OrderItemModel orderItemModelFromJson(String str) =>
    OrderItemModel.fromJson(json.decode(str));

String orderItemModelToJson(OrderItemModel data) => json.encode(data.toJson());

class OrderItemModel {
  OrderItemModel({
    this.id,
    this.order,
    this.user,
    this.product,
    this.productVariationOption,
    this.orderItemVariationOptions,
    this.extras,
    this.quantity,
    this.note,
    this.orderItemPrice,
    this.orderItemPriceRecord,
    this.orderProductTotalPriceRecord,
    this.orderExtraTotalPriceRecord,
    this.isActive,
  });

  int id;
  int order;
  int user;
  int product;
  int productVariationOption;
  List<int> orderItemVariationOptions;
  List<int> extras;
  int quantity;
  String note;
  int orderItemPrice;
  int orderItemPriceRecord;
  int orderProductTotalPriceRecord;
  int orderExtraTotalPriceRecord;
  bool isActive;

  factory OrderItemModel.fromJson(Map<String, dynamic> json) => OrderItemModel(
        id: json["id"],
        order: json["order"],
        user: json["user"],
        product: json["product"],
        productVariationOption: json["product_variation_option"],
        orderItemVariationOptions:
            List<int>.from(json["order_item_variation_options"].map((x) => x)),
        extras: List<int>.from(json["extras"].map((x) => x)),
        quantity: json["quantity"],
        note: json["note"],
        orderItemPrice: json["order_item_price"],
        orderItemPriceRecord: json["order_item_price_record"],
        orderProductTotalPriceRecord: json["order_product_total_price_record"],
        orderExtraTotalPriceRecord: json["order_extra_total_price_record"],
        isActive: json["is_active"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "order": order,
        "user": user,
        "product": product,
        "product_variation_option": productVariationOption,
        "order_item_variation_options":
            List<dynamic>.from(orderItemVariationOptions.map((x) => x)),
        "extras": List<dynamic>.from(extras.map((x) => x)),
        "quantity": quantity,
        "note": note,
        "order_item_price": orderItemPrice,
        "order_item_price_record": orderItemPriceRecord,
        "order_product_total_price_record": orderProductTotalPriceRecord,
        "order_extra_total_price_record": orderExtraTotalPriceRecord,
        "is_active": isActive,
      };

  static Map<String, dynamic> toMap(OrderItemModel orderItem) => {
        "order": orderItem.order,
        "user": orderItem.user,
        "product": orderItem.product,
        "product_variation_option": orderItem.productVariationOption,
        "order_item_variation_options": orderItem.orderItemVariationOptions,
        "extras": orderItem.extras,
        "quantity": orderItem.quantity,
        "note": orderItem.note,
        "order_item_price": orderItem.orderItemPrice,
        "order_item_price_record": orderItem.orderItemPriceRecord,
        "order_product_total_price_record":
            orderItem.orderProductTotalPriceRecord,
        "order_extra_total_price_record": orderItem.orderExtraTotalPriceRecord,
        "is_active": orderItem.isActive,
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
