import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:served_food/app/common/app_datas/user_model.dart';
import 'package:served_food/app/modules/chat/models/message_model.dart';

class MessageMethods {
  CollectionReference chatRoom =
      FirebaseFirestore.instance.collection('ChatRoom');

  Future<String> createChatRoom(int user1, int user2) async {
    bool isExist = false;
    String chatRoomId = '';
    await chatRoom.get().then((chatRooms) {
      chatRooms.docs.forEach((chatRoom) {
        if ((chatRoom["users"][1].toString() == user1.toString() &&
            chatRoom["users"][0].toString() == user2.toString())) {
          isExist = true;
          chatRoomId = chatRoom['chatRoomId'];
        }
        if ((chatRoom["users"][0].toString() == user1.toString() &&
            chatRoom["users"][1].toString() == user2.toString())) {
          isExist = true;
          chatRoomId = chatRoom['chatRoomId'];
        }
      });
    });
    if (isExist == false) {
      List<int> users = [user1, user2];
      String chatRoomId = user1.toString() + '_' + user2.toString();
      Map<String, dynamic> chatRoomMap = {
        "users": users,
        "chatRoomId": chatRoomId
      };
      chatRoom
          .doc(chatRoomId)
          .set(chatRoomMap)
          .then((value) {})
          .catchError((error) => print("Failed to add chat room: $error"));
      return chatRoomId;
    } else {
      return chatRoomId;
    }
  }

  Future<void> sendMessage(String chatRoomId, messageMap) async {
    chatRoom
        .doc(chatRoomId)
        .collection("chats")
        .add(messageMap)
        .catchError((e) {
      print(e.toString());
    });
  }

  Future<List<MessageModel>> getRecentChats(int userId) async {
    List<String> lstChatRoomIds = [];
    List<MessageModel> lstMessages = [];

    if (userId != null) {
      await chatRoom
          .where('users', arrayContains: userId)
          .get()
          .then((chatRooms) {
        chatRooms.docs.forEach((room) {
          lstChatRoomIds.add(room.id);
        });
      });
      for (var chatRoomId in lstChatRoomIds) {
        await chatRoom
            .doc(chatRoomId)
            .collection("chats")
            .limit(1)
            .get()
            .then((messages) {
          messages.docs.forEach((element) {
            lstMessages.add(MessageModel.fromJson(element.data()));
          });
        });
      }
    }

    return lstMessages;
  }

  Future<void> seenMessage(String chatRoomId, UserModel user) async {
    chatRoom.doc(chatRoomId).collection("chats").get().then((messages) {
      messages.docs.forEach((message) {
        if (user.id != message.data()["sender"]["id"]) {
          chatRoom
              .doc(chatRoomId)
              .collection("chats")
              .doc(message.id)
              .update({"unread": false});
        }
      });
    });
  }

  Future<void> updateMessage(
      String chatRoomId, MessageModel messageModel) async {
    chatRoom.doc(chatRoomId).collection("chats").get().then((messages) {
      String formatTime = messageModel.time.toString().replaceAll(" ", "T");
      messages.docs.forEach((message) {
        if (message["sender"].toString() == messageModel.sender.toString() ||
            message["time"] == formatTime) {
          chatRoom
              .doc(chatRoomId)
              .collection("chats")
              .doc(message.id)
              .update({"is_liked": messageModel.isLiked});
        }
      });
    });
  }

  Future<List<MessageModel>> getMessages(String chatRoomId) async {
    List<MessageModel> lstMessages = [];
    await chatRoom.doc(chatRoomId).collection("chats").get().then((messages) {
      messages.docs.forEach((message) {
        lstMessages.add(MessageModel.fromJson(message.data()));
      });
    });
    return lstMessages;
  }
}
