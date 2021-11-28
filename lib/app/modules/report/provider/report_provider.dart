import 'package:get/get_connect.dart';
import 'package:served_food/app/common/app_datas/get_request_url.dart';
import 'package:served_food/app/common/app_datas/request_headers.dart';

class ReportProvider extends GetConnect {
  Future<dynamic> getTotalSaleReport(String startAt, String endAt) async {
    try {
      final response = await get(
          new GetRequestUrl().getTotalSale(startAt, endAt),
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

  Future<dynamic> getCancelSaleReport(String startAt, String endAt) async {
    try {
      final response = await get(
          new GetRequestUrl().getCancelSale(startAt, endAt),
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

  Future<dynamic> getItemSaleReport(
      String startAt, String endAt, String user, String product) async {
    try {
      final response = await get(
          new GetRequestUrl().getItemSale(startAt, endAt, user, product),
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
