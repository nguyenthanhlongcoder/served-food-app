// To parse this JSON data, do
//
//     final productModel = productModelFromJson(jsonString);

import 'dart:convert';

ProductModel productModelFromJson(String str) =>
    ProductModel.fromJson(json.decode(str));

String productModelToJson(ProductModel data) => json.encode(data.toJson());

class ProductModel {
  ProductModel({
    this.id,
    this.name,
    this.description,
    this.category,
    this.label,
    this.variation,
    this.image,
    this.productVariationOption,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  String name;
  String description;
  Category category;
  List<Category> label;
  List<Category> variation;
  String image;
  List<ProductVariationOption> productVariationOption;
  DateTime createdAt;
  DateTime updatedAt;

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        category: Category.fromJson(json["category"]),
        label:
            List<Category>.from(json["label"].map((x) => Category.fromJson(x))),
        variation: List<Category>.from(
            json["variation"].map((x) => Category.fromJson(x))),
        image: json["image"],
        productVariationOption: List<ProductVariationOption>.from(
            json["product_variation_option"]
                .map((x) => ProductVariationOption.fromJson(x))),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "category": category.toJson(),
        "label": List<dynamic>.from(label.map((x) => x.toJson())),
        "variation": List<dynamic>.from(variation.map((x) => x.toJson())),
        "image": image,
        "product_variation_option":
            List<dynamic>.from(productVariationOption.map((x) => x.toJson())),
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
    this.backgroundColor,
    this.variation,
    this.priceAffected,
  });

  int id;
  String name;
  String description;
  DateTime createdAt;
  DateTime updatedAt;
  String backgroundColor;
  int variation;
  bool priceAffected;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        backgroundColor:
            json["background_color"] == null ? null : json["background_color"],
        variation: json["variation"] == null ? null : json["variation"],
        priceAffected:
            json["price_affected"] == null ? null : json["price_affected"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "background_color": backgroundColor == null ? null : backgroundColor,
        "variation": variation == null ? null : variation,
        "price_affected": priceAffected == null ? null : priceAffected,
      };
}

class ProductVariationOption {
  ProductVariationOption({
    this.id,
    this.price,
    this.variationOption,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  int price;
  Category variationOption;
  DateTime createdAt;
  DateTime updatedAt;

  factory ProductVariationOption.fromJson(Map<String, dynamic> json) =>
      ProductVariationOption(
        id: json["id"],
        price: json["price"],
        variationOption: Category.fromJson(json["variation_option"]),
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
