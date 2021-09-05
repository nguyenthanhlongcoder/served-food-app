// To parse this JSON data, do
//
//     final orderModel = orderModelFromJson(jsonString);

import 'dart:convert';

OrderModel orderModelFromJson(String str) =>
    OrderModel.fromJson(json.decode(str));

String orderModelToJson(OrderModel data) => json.encode(data.toJson());

class OrderModel {
  OrderModel({
    this.id,
    this.table,
    this.status,
    this.orderItem,
    this.orderTotalPrice,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  int table;
  String status;
  List<OrderItem> orderItem;
  int orderTotalPrice;
  DateTime createdAt;
  DateTime updatedAt;

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
        id: json["id"],
        table: json["table"],
        status: json["status"],
        orderItem: List<OrderItem>.from(
            json["order_item"].map((x) => OrderItem.fromJson(x))),
        orderTotalPrice: json["order_total_price"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "table": table,
        "status": status,
        "order_item": List<dynamic>.from(orderItem.map((x) => x.toJson())),
        "order_total_price": orderTotalPrice,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

class OrderItem {
  OrderItem({
    this.id,
    this.order,
    this.user,
    this.product,
    this.productVariationOption,
    this.quantity,
    this.note,
    this.orderItemPrice,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  int order;
  User user;
  Product product;
  ProductVariationOption productVariationOption;
  int quantity;
  String note;
  int orderItemPrice;
  DateTime createdAt;
  DateTime updatedAt;

  factory OrderItem.fromJson(Map<String, dynamic> json) => OrderItem(
        id: json["id"],
        order: json["order"],
        user: User.fromJson(json["user"]),
        product: Product.fromJson(json["product"]),
        productVariationOption:
            ProductVariationOption.fromJson(json["product_variation_option"]),
        quantity: json["quantity"],
        note: json["note"],
        orderItemPrice: json["order_item_price"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "order": order,
        "user": user.toJson(),
        "product": product.toJson(),
        "product_variation_option": productVariationOption.toJson(),
        "quantity": quantity,
        "note": note,
        "order_item_price": orderItemPrice,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

class Product {
  Product({
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

  factory Product.fromJson(Map<String, dynamic> json) => Product(
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

class User {
  User({
    this.id,
    this.password,
    this.lastLogin,
    this.isSuperuser,
    this.username,
    this.firstName,
    this.lastName,
    this.email,
    this.isStaff,
    this.isActive,
    this.dateJoined,
    this.groups,
    this.userPermissions,
  });

  int id;
  String password;
  DateTime lastLogin;
  bool isSuperuser;
  String username;
  String firstName;
  String lastName;
  String email;
  bool isStaff;
  bool isActive;
  DateTime dateJoined;
  List<dynamic> groups;
  List<dynamic> userPermissions;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        password: json["password"],
        lastLogin: DateTime.parse(json["last_login"]),
        isSuperuser: json["is_superuser"],
        username: json["username"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        email: json["email"],
        isStaff: json["is_staff"],
        isActive: json["is_active"],
        dateJoined: DateTime.parse(json["date_joined"]),
        groups: List<dynamic>.from(json["groups"].map((x) => x)),
        userPermissions:
            List<dynamic>.from(json["user_permissions"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "password": password,
        "last_login": lastLogin.toIso8601String(),
        "is_superuser": isSuperuser,
        "username": username,
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "is_staff": isStaff,
        "is_active": isActive,
        "date_joined": dateJoined.toIso8601String(),
        "groups": List<dynamic>.from(groups.map((x) => x)),
        "user_permissions": List<dynamic>.from(userPermissions.map((x) => x)),
      };
}
