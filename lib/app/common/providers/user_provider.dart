import 'package:get/get_connect.dart';
import 'package:served_food/app/common/app_datas/get_request_url.dart';
import 'package:served_food/app/common/app_datas/request_headers.dart';

class UserProvider extends GetConnect {
  Future<Map<String, dynamic>> getUserDetail(String id) async {
    try {
      final response = await get(GetRequestUrl.USER_DETAIL + id,
          headers: await RequestHeaders().getRequestHeader());
      if (response.status.hasError) {
        return Future.error(response.statusText);
      } else {
        return response.body;
      }
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future<List<dynamic>> getAllUser() async {
    try {
      final response = await get(GetRequestUrl.USERS,
          headers: await RequestHeaders().getRequestHeader());
      if (response.status.hasError) {
        return Future.error(response.statusText);
      } else {
        return response.body['results'];
      }
    } catch (e) {
      return Future.error(e.toString());
    }
  }
}
