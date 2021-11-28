import 'package:get/state_manager.dart';
import 'package:served_food/app/common/app_datas/user_model.dart';
import 'package:served_food/app/common/app_datas/user_repository.dart';
import 'package:served_food/app/common/firestore_methods/message_methods.dart';

class ChatController extends GetxController {
  var me = new UserModel().obs;
  var lstMessages = List<dynamic>.empty(growable: true).obs;
  @override
  void onInit() {
    getMe();
    super.onInit();
  }

  void getMe() {
    UserRepository().getUser().then((value) {
      me.value = value;
    });
  }

  void getMessages(String chatRoomId) {
    lstMessages.clear();
    MessageMethods()
        .getMessages(chatRoomId)
        .then((value) => lstMessages.addAll(value));
  }

  void seenMessage(String chatRoomId, UserModel user) {
    MessageMethods().seenMessage(chatRoomId, user);
  }

  void sendMesage(String chatRoomId, messageMap) {
    lstMessages.clear();
    MessageMethods().sendMessage(chatRoomId, messageMap);
  }
}
