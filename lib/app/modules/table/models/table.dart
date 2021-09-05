// To parse this JSON data, do
//
//     final table = tableFromJson(jsonString);

import 'dart:convert';

List<Table> tableFromJson(String str) =>
    List<Table>.from(json.decode(str).map((x) => Table.fromJson(x)));

String tableToJson(List<Table> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Table {
  Table({
    this.id,
    this.name,
    this.description,
    this.isActive,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  String name;
  String description;
  bool isActive;
  String status;
  DateTime createdAt;
  DateTime updatedAt;

  factory Table.fromJson(Map<String, dynamic> json) => Table(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        isActive: json["is_active"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "is_active": isActive,
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
