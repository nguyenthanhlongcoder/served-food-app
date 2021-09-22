import 'package:get/get_connect.dart';
import 'package:served_food/app/common/app_datas/get_request_url.dart';

class ExtraProvider extends GetConnect {
  Future<List<dynamic>> getExtras() async {
    try {
      final response = await get(GetRequestUrl.EXTRAS);
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
