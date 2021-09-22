// To parse this JSON data, do
//
//     final variationOptionModel = variationOptionModelFromJson(jsonString);

import 'dart:convert';

VariationOptionModel variationOptionModelFromJson(String str) =>
    VariationOptionModel.fromJson(json.decode(str));

String variationOptionModelToJson(VariationOptionModel data) =>
    json.encode(data.toJson());

class VariationOptionModel {
  VariationOptionModel({
    this.id,
    this.name,
    this.description,
    this.createdAt,
    this.updatedAt,
    this.variation,
  });

  int id;
  String name;
  String description;
  DateTime createdAt;
  DateTime updatedAt;
  int variation;

  factory VariationOptionModel.fromJson(Map<String, dynamic> json) =>
      VariationOptionModel(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        variation: json["variation"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "variation": variation,
      };
}
