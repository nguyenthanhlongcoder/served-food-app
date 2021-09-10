import 'package:get/get_connect.dart';
import 'package:served_food/app/common/app_datas/get_request_url.dart';

class OrderItemProvider extends GetConnect {
  Future<dynamic> deleteOrderItem(int id) async {
    try {
      final response =
          await delete(GetRequestUrl.ORDER_ITEM_DETAIL + id.toString());
      if (response.status.hasError) {
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
