// To parse this JSON data, do
//
//     final productModel = productModelFromJson(jsonString);

import 'dart:convert';

import 'package:served_food/app/common/app_datas/variation_option_model.dart';

ProductModel productModelFromJson(String str) =>
    ProductModel.fromJson(json.decode(str));

String productModelToJson(ProductModel data) => json.encode(data.toJson());

class ProductModel {
  ProductModel({
    this.id,
    this.name,
    this.description,
    this.category,
    this.labels,
    this.variations,
    this.image,
    this.productVariationOptions,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  String name;
  String description;
  Category category;
  List<dynamic> labels;
  List<Variation> variations;
  String image;
  List<ProductVariationOption> productVariationOptions;
  DateTime createdAt;
  DateTime updatedAt;

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        category: Category.fromJson(json["category"]),
        labels: List<dynamic>.from(json["labels"].map((x) => x)),
        variations: List<Variation>.from(
            json["variations"].map((x) => Variation.fromJson(x))),
        image: json["image"],
        productVariationOptions: List<ProductVariationOption>.from(
            json["product_variation_options"]
                .map((x) => ProductVariationOption.fromJson(x))),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "category": category.toJson(),
        "labels": List<dynamic>.from(labels.map((x) => x)),
        "variations": List<dynamic>.from(variations.map((x) => x.toJson())),
        "image": image,
        "product_variation_options":
            List<dynamic>.from(productVariationOptions.map((x) => x.toJson())),
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

class Category {
  Category({
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

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        variation: json["variation"] == null ? null : json["variation"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "variation": variation == null ? null : variation,
      };
}

class ProductVariationOption {
  ProductVariationOption({
    this.id,
    this.price,
    this.variationOptions,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  int price;
  List<VariationOptionModel> variationOptions;
  DateTime createdAt;
  DateTime updatedAt;

  factory ProductVariationOption.fromJson(Map<String, dynamic> json) =>
      ProductVariationOption(
        id: json["id"],
        price: json["price"],
        variationOptions: List<VariationOptionModel>.from(
            json["variation_options"]
                .map((x) => VariationOptionModel.fromJson(x))),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "price": price,
        "variation_options":
            List<dynamic>.from(variationOptions.map((x) => x.toJson())),
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
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
  List<VariationOptionModel> variationOptions;

  factory Variation.fromJson(Map<String, dynamic> json) => Variation(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        variationOptions: List<VariationOptionModel>.from(
            json["variation_options"]
                .map((x) => VariationOptionModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "variation_options": List<VariationOptionModel>.from(
            variationOptions.map((x) => x.toJson())),
      };
}
