import 'package:get/get_connect.dart';
import 'package:served_food/app/common/app_datas/get_request_url.dart';

class FilterProductProvider extends GetConnect {
  Future<List<dynamic>> getFilterProducts() async {
    try {
      final response = await get(GetRequestUrl.FILTER_PRODUCTS);
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
