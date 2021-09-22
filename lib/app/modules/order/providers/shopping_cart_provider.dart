import 'package:get/get_connect.dart';
import 'package:served_food/app/common/app_datas/get_request_url.dart';

class ShoppingCartProvider extends GetConnect {
  Future<dynamic> addOrderItem(dynamic body) async {
    try {
      final response = await post(GetRequestUrl.CREATE_ORDER_ITEM, body);
      if (response.status.hasError) {
        print(body);
        return Future.error(response.statusText);
      } else {
        print(response.body);
        return response.body;
      }
    } catch (e) {
      return Future.error(e.toString());
    }
  }
}
