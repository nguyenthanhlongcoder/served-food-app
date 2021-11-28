// To parse this JSON data, do
//
//     final orderRecordModel = orderRecordModelFromJson(jsonString);

import 'dart:convert';

OrderRecordModel orderRecordModelFromJson(String str) =>
    OrderRecordModel.fromJson(json.decode(str));

String orderRecordModelToJson(OrderRecordModel data) =>
    json.encode(data.toJson());

class OrderRecordModel {
  OrderRecordModel({
    this.count,
    this.cancelledCount,
    this.paidCount,
    this.totalSales,
    this.totalCancelSales,
    this.results,
  });

  int count;
  int cancelledCount;
  int paidCount;
  int totalSales;
  int totalCancelSales;
  List<Result> results;

  factory OrderRecordModel.fromJson(Map<String, dynamic> json) =>
      OrderRecordModel(
        count: json["count"],
        cancelledCount: json["cancelled_count"],
        paidCount: json["paid_count"],
        totalSales: json["total_sales"],
        totalCancelSales: json["total_cancel_sales"],
        results:
            List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "cancelled_count": cancelledCount,
        "paid_count": paidCount,
        "total_sales": totalSales,
        "total_cancel_sales": totalCancelSales,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
      };
}

class Result {
  Result({
    this.id,
    this.table,
    this.status,
    this.orderItems,
    this.orderTotalPriceRecord,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  int table;
  Status status;
  List<int> orderItems;
  int orderTotalPriceRecord;
  DateTime createdAt;
  DateTime updatedAt;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        table: json["table"],
        status: statusValues.map[json["status"]],
        orderItems: List<int>.from(json["order_items"].map((x) => x)),
        orderTotalPriceRecord: json["order_total_price_record"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "table": table,
        "status": statusValues.reverse[status],
        "order_items": List<dynamic>.from(orderItems.map((x) => x)),
        "order_total_price_record": orderTotalPriceRecord,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

enum Status { CANCELLED, PAID }

final statusValues =
    EnumValues({"cancelled": Status.CANCELLED, "paid": Status.PAID});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
