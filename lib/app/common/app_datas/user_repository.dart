import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:served_food/app/common/app_datas/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserRepository {
  static const EXPIRY_KEY = 'expiry';
  static const TOKEN_KEY = 'token';
  Future<void> persistExpiry(String expiry) async {
    const FlutterSecureStorage storage = FlutterSecureStorage();
    try {
      await storage.write(key: EXPIRY_KEY, value: expiry);
      return true;
    } on Exception catch (e) {
      print('Something went wrong when store user infomation: ' + e.toString());
    }
    return false;
  }

  Future<void> persistToken(String token) async {
    const FlutterSecureStorage storage = FlutterSecureStorage();
    try {
      await storage.write(key: TOKEN_KEY, value: token);
      return true;
    } on Exception catch (e) {
      print('Something went wrong when store user infomation: ' + e.toString());
    }
    return false;
  }

  Future<String> fetchToken() async {
    const FlutterSecureStorage storage = FlutterSecureStorage();
    Map<String, String> all = await storage.readAll();
    String token = '';
    for (var item in all.entries) {
      if (item.key == TOKEN_KEY) {
        token = item.value;
      }
    }
    return token;
  }

  Future<void> deleteAll() async {
    const FlutterSecureStorage storage = FlutterSecureStorage();
    try {
      await storage.deleteAll();
      SharedPreferences pref = await SharedPreferences.getInstance();
      pref.clear();
      return true;
    } on Exception catch (e) {
      print(
          'Something went wrong when delete user infomation: ' + e.toString());
    }
    return false;
  }

  Future<bool> hasUser() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String userString = pref.getString('user');
    if (userString == null) {
      return false;
    } else {
      return true;
    }
  }

  Future<String> fetchExpiry() async {
    const FlutterSecureStorage storage = FlutterSecureStorage();
    Map<String, String> all = await storage.readAll();
    String expiry = '';
    for (var item in all.entries) {
      if (item.key == EXPIRY_KEY) {
        expiry = item.value;
      }
    }
    return expiry;
  }

  Future<void> setUser(UserModel user) async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    final String encodedUser = UserModel.encode(user);

    pref.setString('user', encodedUser);
  }

  Future<UserModel> getUser() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    final String userString = await pref.getString('user');
    final UserModel user = userModelFromJson(userString);
    return user;
  }
}
