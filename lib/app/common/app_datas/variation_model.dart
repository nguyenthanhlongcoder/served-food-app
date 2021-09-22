// To parse this JSON data, do
//
//     final variationModel = variationModelFromJson(jsonString);

import 'dart:convert';

VariationModel variationModelFromJson(String str) =>
    VariationModel.fromJson(json.decode(str));

String variationModelToJson(VariationModel data) => json.encode(data.toJson());

class VariationModel {
  VariationModel({
    this.id,
    this.name,
    this.description,
    this.variationOptions,
  });

  int id;
  String name;
  String description;
  List<VariationOption> variationOptions;

  factory VariationModel.fromJson(Map<String, dynamic> json) => VariationModel(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        variationOptions: List<VariationOption>.from(
            json["variation_options"].map((x) => VariationOption.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "variation_options":
            List<dynamic>.from(variationOptions.map((x) => x.toJson())),
      };
}

class VariationOption {
  VariationOption({
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

  factory VariationOption.fromJson(Map<String, dynamic> json) =>
      VariationOption(
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
