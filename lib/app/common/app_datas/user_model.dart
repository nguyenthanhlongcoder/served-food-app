// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  UserModel({
    this.id,
    this.password,
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
  String email;
  String firstName;
  String lastName;
  dynamic image;
  String contactPhone;
  bool isSuperuser;
  bool isStaff;
  bool isActive;
  DateTime dateJoined;
  dynamic table;
  List<dynamic> groups;
  List<dynamic> userPermissions;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        password: json["password"],
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

  static Map<String, dynamic> toMap(UserModel user) => {
        "id": user.id,
        "password": user.password,
        "email": user.email,
        "first_name": user.firstName,
        "last_name": user.lastName,
        "image": user.image,
        "contact_phone": user.contactPhone,
        "is_superuser": user.isSuperuser,
        "is_staff": user.isStaff,
        "is_active": user.isActive,
        "date_joined": user.dateJoined,
        "table": user.table,
        "groups": user.groups,
        "user_permissions": user.userPermissions,
      };
  static String encode(UserModel user) => json.encode(user);

  static UserModel decode(String user) => UserModel.fromJson(json.decode(user));
}
