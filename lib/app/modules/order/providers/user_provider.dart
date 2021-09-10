import 'package:get/get_connect.dart';
import 'package:served_food/app/common/app_datas/get_request_url.dart';

class UserProvider extends GetConnect {
  Future<Map<String, dynamic>> getUserDetail(String id) async {
    try {
      final response = await get(GetRequestUrl.USER_DETAIL + id);
      if (response.status.hasError) {
        return Future.error(response.statusText);
      } else {
        return response.body;
      }
    } catch (e) {
      return Future.error(e.toString());
    }
  }
}
