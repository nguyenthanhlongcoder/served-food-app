// To parse this JSON data, do
//
//     final promotionModel = promotionModelFromJson(jsonString);

import 'dart:convert';

PromotionModel promotionModelFromJson(String str) =>
    PromotionModel.fromJson(json.decode(str));

String promotionModelToJson(PromotionModel data) => json.encode(data.toJson());

class PromotionModel {
  PromotionModel({
    this.id,
    this.name,
    this.description,
    this.image,
    this.startAt,
    this.endAt,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  String name;
  String description;
  String image;
  DateTime startAt;
  DateTime endAt;
  Status status;
  DateTime createdAt;
  DateTime updatedAt;

  factory PromotionModel.fromJson(Map<String, dynamic> json) => PromotionModel(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        image: json["image"],
        startAt: DateTime.parse(json["start_at"]),
        endAt: DateTime.parse(json["end_at"]),
        status: Status.fromJson(json["status"]),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "image": image,
        "start_at":
            "${startAt.year.toString().padLeft(4, '0')}-${startAt.month.toString().padLeft(2, '0')}-${startAt.day.toString().padLeft(2, '0')}",
        "end_at":
            "${endAt.year.toString().padLeft(4, '0')}-${endAt.month.toString().padLeft(2, '0')}-${endAt.day.toString().padLeft(2, '0')}",
        "status": status.toJson(),
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

class Status {
  Status({
    this.id,
    this.name,
    this.description,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  String name;
  String description;
  DateTime createdAt;
  DateTime updatedAt;

  factory Status.fromJson(Map<String, dynamic> json) => Status(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
