// To parse this JSON data, do
//
//     final extraModel = extraModelFromJson(jsonString);

import 'dart:convert';

ExtraModel extraModelFromJson(String str) =>
    ExtraModel.fromJson(json.decode(str));

String extraModelToJson(ExtraModel data) => json.encode(data.toJson());

class ExtraModel {
  ExtraModel({
    this.id,
    this.name,
    this.description,
    this.variation,
    this.extraVariationOptions,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  String name;
  String description;
  Variation variation;
  List<ExtraVariationOption> extraVariationOptions;
  DateTime createdAt;
  DateTime updatedAt;

  factory ExtraModel.fromJson(Map<String, dynamic> json) => ExtraModel(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        variation: Variation.fromJson(json["variation"]),
        extraVariationOptions: List<ExtraVariationOption>.from(
            json["extra_variation_options"]
                .map((x) => ExtraVariationOption.fromJson(x))),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "variation": variation.toJson(),
        "extra_variation_options":
            List<dynamic>.from(extraVariationOptions.map((x) => x.toJson())),
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

class ExtraVariationOption {
  ExtraVariationOption({
    this.id,
    this.price,
    this.variationOption,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  int price;
  VariationOption variationOption;
  DateTime createdAt;
  DateTime updatedAt;

  factory ExtraVariationOption.fromJson(Map<String, dynamic> json) =>
      ExtraVariationOption(
        id: json["id"],
        price: json["price"],
        variationOption: VariationOption.fromJson(json["variation_option"]),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "price": price,
        "variation_option": variationOption.toJson(),
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
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

class Variation {
  Variation({
    this.id,
    this.name,
    this.description,
    this.variationOptions,
  });

  int id;
  String name;
  String description;
  List<VariationOption> variationOptions;

  factory Variation.fromJson(Map<String, dynamic> json) => Variation(
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
