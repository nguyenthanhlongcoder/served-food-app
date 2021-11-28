// To parse this JSON data, do
//
//     final orderItemRecordModel = orderItemRecordModelFromJson(jsonString);

import 'dart:convert';

OrderItemRecordModel orderItemRecordModelFromJson(String str) =>
    OrderItemRecordModel.fromJson(json.decode(str));

String orderItemRecordModelToJson(OrderItemRecordModel data) =>
    json.encode(data.toJson());

class OrderItemRecordModel {
  OrderItemRecordModel({
    this.count,
    this.cancelledCount,
    this.paidCount,
    this.totalSales,
    this.totalCancelledSales,
    this.totalProductSales,
    this.totalProductCancelledSales,
    this.totalExtraSales,
    this.totalExtraCancelledSales,
    this.results,
  });

  int count;
  int cancelledCount;
  int paidCount;
  int totalSales;
  int totalCancelledSales;
  int totalProductSales;
  int totalProductCancelledSales;
  int totalExtraSales;
  int totalExtraCancelledSales;
  List<Result> results;

  factory OrderItemRecordModel.fromJson(Map<String, dynamic> json) =>
      OrderItemRecordModel(
        count: json["count"],
        cancelledCount: json["cancelled_count"],
        paidCount: json["paid_count"],
        totalSales: json["total_sales"],
        totalCancelledSales: json["total_cancelled_sales"],
        totalProductSales: json["total_product_sales"],
        totalProductCancelledSales: json["total_product_cancelled_sales"],
        totalExtraSales: json["total_extra_sales"],
        totalExtraCancelledSales: json["total_extra_cancelled_sales"],
        results:
            List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "cancelled_count": cancelledCount,
        "paid_count": paidCount,
        "total_sales": totalSales,
        "total_cancelled_sales": totalCancelledSales,
        "total_product_sales": totalProductSales,
        "total_product_cancelled_sales": totalProductCancelledSales,
        "total_extra_sales": totalExtraSales,
        "total_extra_cancelled_sales": totalExtraCancelledSales,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
      };
}

class Result {
  Result({
    this.id,
    this.isActive,
    this.product,
    this.user,
    this.orderProductTotalPriceRecord,
    this.orderExtraTotalPriceRecord,
    this.orderItemPriceRecord,
    this.quantity,
    this.updatedAt,
  });

  int id;
  bool isActive;
  int product;
  int user;
  int orderProductTotalPriceRecord;
  int orderExtraTotalPriceRecord;
  int orderItemPriceRecord;
  int quantity;
  DateTime updatedAt;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        isActive: json["is_active"],
        product: json["product"],
        user: json["user"],
        orderProductTotalPriceRecord: json["order_product_total_price_record"],
        orderExtraTotalPriceRecord: json["order_extra_total_price_record"],
        orderItemPriceRecord: json["order_item_price_record"],
        quantity: json["quantity"],
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "is_active": isActive,
        "product": product,
        "user": user,
        "order_product_total_price_record": orderProductTotalPriceRecord,
        "order_extra_total_price_record": orderExtraTotalPriceRecord,
        "order_item_price_record": orderItemPriceRecord,
        "quantity": quantity,
        "updated_at": updatedAt.toIso8601String(),
      };
}
