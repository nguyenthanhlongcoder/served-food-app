import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:served_food/app/common/app_datas/user_model.dart';
import 'package:served_food/app/common/app_datas/user_repository.dart';
import 'package:served_food/app/common/firestore_methods/message_methods.dart';
import 'package:served_food/app/common/firestore_methods/user_methods.dart';
import 'package:served_food/app/modules/chat/models/message_model.dart';

class ChatHomeController extends GetxController {
  var me = UserModel().obs;
  var isLoading = false.obs;
  var lstFavorites = List<dynamic>.empty(growable: true).obs;
  var chatRoomId = ''.obs;
  var lstMessages = List<dynamic>.empty(growable: true);
  List<UserModel> lstUsers = [];
  @override
  void onInit() {
    getMe();
    getFavorites();
    getRecentChats();
    super.onInit();
  }

  void getMe() {
    UserRepository().getUser().then((user) {
      me.value = user;
    });
  }

  void getFavorites() {
    UserMethods().getUsers().then((value) {
      lstFavorites.addAll(value);
      lstUsers.addAll(value);
    });
  }

  void createChatRoom(int user1, int user2) {
    MessageMethods().createChatRoom(user1, user2).then((value) {
      if (value != '') {
        chatRoomId.value = value;
      }
    });
  }

  Stream getRecentChats() async* {
    CollectionReference chatRoom =
        FirebaseFirestore.instance.collection("ChatRoom");
    yield* Stream.periodic(Duration(seconds: 1), (_) async {
      List<String> lstChatRoomIds = [];

      await chatRoom
          .where("users", arrayContains: me.value.id)
          .get()
          .then((chatRooms) {
        chatRooms.docs.forEach((room) {
          if (room.id.contains(me.value.id.toString())) {
            lstChatRoomIds.add(room.id);
          }
        });
      });
      lstMessages.clear();

      for (var chatRoomId in lstChatRoomIds) {
        await chatRoom
            .doc(chatRoomId)
            .collection("chats")
            .limit(1)
            .orderBy("time", descending: true)
            .get()
            .then((messages) {
          messages.docs.forEach((element) {
            lstMessages.add(MessageModel.fromJson(element.data()));
          });
        });
      }

      lstMessages.sort((a, b) {
        return a.time.isBefore(b.time) ? 1 : -1;
      });
      isLoading(false);
      return lstMessages;
    });
  }

  UserModel getSender(int id) {
    UserModel sender = UserMethods().getUserByID(id);

    return sender;
  }
}
