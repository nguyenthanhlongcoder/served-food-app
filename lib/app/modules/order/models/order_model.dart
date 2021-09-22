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
    this.orderItems,
    this.orderTotalPrice,
    this.orderTotalPriceRecord,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  int table;
  String status;
  List<OrderItem> orderItems;
  int orderTotalPrice;
  int orderTotalPriceRecord;
  DateTime createdAt;
  DateTime updatedAt;

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
        id: json["id"],
        table: json["table"],
        status: json["status"],
        orderItems: List<OrderItem>.from(
            json["order_items"].map((x) => OrderItem.fromJson(x))),
        orderTotalPrice: json["order_total_price"],
        orderTotalPriceRecord: json["order_total_price_record"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "table": table,
        "status": status,
        "order_items": List<dynamic>.from(orderItems.map((x) => x.toJson())),
        "order_total_price": orderTotalPrice,
        "order_total_price_record": orderTotalPriceRecord,
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
    this.orderItemVariationOptions,
    this.extras,
    this.quantity,
    this.note,
    this.orderItemPrice,
    this.orderItemPriceRecord,
    this.orderProductTotalPriceRecord,
    this.orderExtraTotalPriceRecord,
    this.isActive,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  int order;
  User user;
  Product product;
  ProductVariationOption productVariationOption;
  List<Extra> orderItemVariationOptions;
  List<Extra> extras;
  int quantity;
  String note;
  int orderItemPrice;
  int orderItemPriceRecord;
  int orderProductTotalPriceRecord;
  int orderExtraTotalPriceRecord;
  bool isActive;
  DateTime createdAt;
  DateTime updatedAt;

  factory OrderItem.fromJson(Map<String, dynamic> json) => OrderItem(
        id: json["id"],
        order: json["order"],
        user: User.fromJson(json["user"]),
        product: Product.fromJson(json["product"]),
        productVariationOption:
            ProductVariationOption.fromJson(json["product_variation_option"]),
        orderItemVariationOptions: List<Extra>.from(
            json["order_item_variation_options"].map((x) => Extra.fromJson(x))),
        extras: List<Extra>.from(json["extras"].map((x) => Extra.fromJson(x))),
        quantity: json["quantity"],
        note: json["note"],
        orderItemPrice: json["order_item_price"],
        orderItemPriceRecord: json["order_item_price_record"],
        orderProductTotalPriceRecord: json["order_product_total_price_record"],
        orderExtraTotalPriceRecord: json["order_extra_total_price_record"],
        isActive: json["is_active"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "order": order,
        "user": user.toJson(),
        "product": product.toJson(),
        "product_variation_option": productVariationOption.toJson(),
        "order_item_variation_options": List<dynamic>.from(
            orderItemVariationOptions.map((x) => x.toJson())),
        "extras": List<dynamic>.from(extras.map((x) => x.toJson())),
        "quantity": quantity,
        "note": note,
        "order_item_price": orderItemPrice,
        "order_item_price_record": orderItemPriceRecord,
        "order_product_total_price_record": orderProductTotalPriceRecord,
        "order_extra_total_price_record": orderExtraTotalPriceRecord,
        "is_active": isActive,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

class Extra {
  Extra({
    this.id,
    this.name,
    this.description,
    this.price,
    this.createdAt,
    this.updatedAt,
    this.variation,
  });

  int id;
  String name;
  String description;
  int price;
  DateTime createdAt;
  DateTime updatedAt;
  int variation;

  factory Extra.fromJson(Map<String, dynamic> json) => Extra(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        price: json["price"] == null ? null : json["price"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        variation: json["variation"] == null ? null : json["variation"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "price": price == null ? null : price,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "variation": variation == null ? null : variation,
      };
}

class Product {
  Product({
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
  Extra category;
  List<dynamic> labels;
  List<Variation> variations;
  String image;
  List<ProductVariationOption> productVariationOptions;
  DateTime createdAt;
  DateTime updatedAt;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        category: Extra.fromJson(json["category"]),
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
  List<Extra> variationOptions;
  DateTime createdAt;
  DateTime updatedAt;

  factory ProductVariationOption.fromJson(Map<String, dynamic> json) =>
      ProductVariationOption(
        id: json["id"],
        price: json["price"],
        variationOptions: List<Extra>.from(
            json["variation_options"].map((x) => Extra.fromJson(x))),
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
  List<Extra> variationOptions;

  factory Variation.fromJson(Map<String, dynamic> json) => Variation(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        variationOptions: List<Extra>.from(
            json["variation_options"].map((x) => Extra.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "variation_options":
            List<dynamic>.from(variationOptions.map((x) => x.toJson())),
      };
}

class User {
  User({
    this.id,
    this.password,
    this.lastLogin,
    this.email,
    this.firstName,
    this.lastName,
    this.image,
    this.contactPhone,
    this.isSuperuser,
    this.isStaff,
    this.isActive,
    this.dateJoined,
    this.table,
    this.groups,
    this.userPermissions,
  });

  int id;
  String password;
  DateTime lastLogin;
  String email;
  String firstName;
  String lastName;
  String image;
  String contactPhone;
  bool isSuperuser;
  bool isStaff;
  bool isActive;
  DateTime dateJoined;
  dynamic table;
  List<dynamic> groups;
  List<dynamic> userPermissions;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        password: json["password"],
        lastLogin: DateTime.parse(json["last_login"]),
        email: json["email"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        image: json["image"],
        contactPhone: json["contact_phone"],
        isSuperuser: json["is_superuser"],
        isStaff: json["is_staff"],
        isActive: json["is_active"],
        dateJoined: DateTime.parse(json["date_joined"]),
        table: json["table"],
        groups: List<dynamic>.from(json["groups"].map((x) => x)),
        userPermissions:
            List<dynamic>.from(json["user_permissions"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "password": password,
        "last_login": lastLogin.toIso8601String(),
        "email": email,
        "first_name": firstName,
        "last_name": lastName,
        "image": image,
        "contact_phone": contactPhone,
        "is_superuser": isSuperuser,
        "is_staff": isStaff,
        "is_active": isActive,
        "date_joined": dateJoined.toIso8601String(),
        "table": table,
        "groups": List<dynamic>.from(groups.map((x) => x)),
        "user_permissions": List<dynamic>.from(userPermissions.map((x) => x)),
      };
}
