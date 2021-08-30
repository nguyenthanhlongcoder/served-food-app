import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserRepository {
  static const ID_KEY = 'id';
  static const EXPIRY_KEY = 'expiry';
  Future<void> persistUser(String id, String expiry) async {
    const FlutterSecureStorage storage = FlutterSecureStorage();
    try {
      await storage.write(key: ID_KEY, value: id);
      await storage.write(key: EXPIRY_KEY, value: expiry);
      return true;
    } on Exception catch (e) {
      print('Something went wrong when store user infomation: ' + e.toString());
    }
    return false;
  }

  Future<void> deleteAll() async {
    const FlutterSecureStorage storage = FlutterSecureStorage();
    try {
      await storage.deleteAll();
      return true;
    } on Exception catch (e) {
      print(
          'Something went wrong when delete user infomation: ' + e.toString());
    }
    return false;
  }

  Future<bool> hasUser() async {
    const FlutterSecureStorage storage = FlutterSecureStorage();

    final all = await storage.readAll();

    if (all != null) {
      return true;
    }
    return false;
  }

  Future<String> fetchUserID() async {
    const FlutterSecureStorage storage = FlutterSecureStorage();
    Map<String, String> all = await storage.readAll();
    String id = '';
    for (var item in all.entries) {
      if (item.key == ID_KEY) {
        id = item.value;
      }
    }
    return id;
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
}
