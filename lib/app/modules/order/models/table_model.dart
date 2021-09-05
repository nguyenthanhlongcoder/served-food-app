// To parse this JSON data, do
//
//     final tableModel = tableModelFromJson(jsonString);

import 'dart:convert';

TableModel tableModelFromJson(String str) =>
    TableModel.fromJson(json.decode(str));

String tableModelToJson(TableModel data) => json.encode(data.toJson());

class TableModel {
  TableModel({
    this.id,
    this.name,
    this.description,
    this.isActive,
    this.isInUse,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  String name;
  String description;
  bool isActive;
  bool isInUse;
  String status;
  DateTime createdAt;
  DateTime updatedAt;

  factory TableModel.fromJson(Map<String, dynamic> json) => TableModel(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        isActive: json["is_active"],
        isInUse: json["is_in_use"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "is_active": isActive,
        "is_in_use": isInUse,
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
