import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:served_food/app/common/app_datas/user_model.dart';
import 'package:served_food/app/common/app_datas/user_repository.dart';

class UserMethods {
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  UserModel getUserByID(int id) {
    UserModel user;
    FirebaseFirestore.instance
        .collection('users')
        .where('id', isEqualTo: id)
        .get()
        .then((user) {
      user = user;
    });
    return user;
  }

  Future<void> addUser(UserModel user) {
    // Call the user's CollectionReference to add a new user
    return users
        .doc(user.id.toString())
        .set(user.toJson())
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  Future<List<UserModel>> getUsers() async {
    List<UserModel> lstUsers = [];
    UserModel me;
    await UserRepository().getUser().then((value) {
      me = value;
    });

    await users.get().then((users) {
      users.docs.forEach((user) {
        if (user["id"] != me.id) {
          lstUsers.add(UserModel.fromJson(user.data()));
        }
      });
    });
    return lstUsers;
  }
}
