import 'package:get/get_connect.dart';
import 'package:served_food/app/common/app_datas/get_request_url.dart';

class OrderProvider extends GetConnect {
  Future<List<dynamic>> getOrderItems(String id) async {
    try {
      final response = await get(GetRequestUrl.ORDER_ITEMS + id);
      if (response.status.hasError) {
        return Future.error(response.statusText);
      } else {
        return response.body;
      }
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future<dynamic> getOrderDetail(String id) async {
    try {
      final response = await get(GetRequestUrl.ORDER_DETAIL + id);
      if (response.status.hasError) {
        return Future.error(response.statusText);
      } else {
        return response.body;
      }
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future<dynamic> createOrder(dynamic body) async {
    try {
      final response = await post(GetRequestUrl.CREATE_ORDER, body);
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
