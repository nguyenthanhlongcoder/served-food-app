import 'package:served_food/app/common/app_datas/user_repository.dart';

class RequestHeaders {
  UserRepository userRepository = new UserRepository();

  Future<Map<String, String>> getRequestHeader() async {
    String token = await userRepository.fetchToken();

    return {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ' + token
    };
  }
}
