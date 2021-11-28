import 'package:get/get_connect.dart';
import 'package:served_food/app/common/app_datas/get_request_url.dart';
import 'package:served_food/app/common/app_datas/request_headers.dart';

class ExtraProvider extends GetConnect {
  Future<List<dynamic>> getExtras() async {
    try {
      final response = await get(GetRequestUrl.EXTRAS,
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
