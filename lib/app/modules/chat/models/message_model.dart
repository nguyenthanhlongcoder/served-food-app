// To parse this JSON data, do
//
//     final messageModel = messageModelFromJson(jsonString);

import 'dart:convert';

import 'package:served_food/app/common/app_datas/user_model.dart';

MessageModel messageModelFromJson(String str) =>
    MessageModel.fromJson(json.decode(str));

String messageModelToJson(MessageModel data) => json.encode(data.toJson());

class MessageModel {
  MessageModel(
      {this.sender,
      this.time,
      this.text,
      this.isLiked,
      this.unread,
      this.receiver});

  UserModel sender;
  UserModel receiver;
  DateTime time;
  String text;
  bool isLiked;
  bool unread;

  factory MessageModel.fromJson(Map<String, dynamic> json) => MessageModel(
        sender: UserModel.fromJson(json["sender"]),
        receiver: UserModel.fromJson(json["receiver"]),
        time: DateTime.parse(json["time"]),
        text: json["text"],
        isLiked: json["is_liked"],
        unread: json["unread"],
      );

  Map<String, dynamic> toJson() => {
        "sender": sender.toJson(),
        "receiver": receiver.toJson(),
        "time": time.toIso8601String(),
        "text": text,
        "is_liked": isLiked,
        "unread": unread,
      };
}
