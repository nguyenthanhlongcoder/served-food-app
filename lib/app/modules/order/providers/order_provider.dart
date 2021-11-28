import 'package:get/get_connect.dart';
import 'package:served_food/app/common/app_datas/get_request_url.dart';
import 'package:served_food/app/common/app_datas/request_headers.dart';

class OrderProvider extends GetConnect {
  Future<List<dynamic>> getOrderItems(String id) async {
    try {
      final response = await get(GetRequestUrl.ORDER_ITEMS + id,
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

  Future<dynamic> getOrderDetail(String id) async {
    try {
      final response = await get(GetRequestUrl.ORDER_DETAIL + id,
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

  Future<dynamic> createOrder(dynamic body) async {
    try {
      final response = await post(GetRequestUrl.CREATE_ORDER, body,
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

  Future<dynamic> updateOrder(String id, dynamic body) async {
    try {
      final response = await put(GetRequestUrl.CREATE_ORDER_DETAIL + id, body,
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
}
