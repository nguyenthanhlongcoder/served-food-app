import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:served_food/app/common/app_datas/get_request_url.dart';
import 'package:http/http.dart' as http;
import 'package:served_food/app/common/app_datas/request_headers.dart';
import 'package:served_food/app/common/app_datas/user_repository.dart';

class TableProvider extends GetConnect {
  static var client = http.Client();

  Future<List<dynamic>> getTables() async {
    try {
      var dio = Dio();
      dio.options.headers['authorization'] =
          'Bearer ' + await new UserRepository().fetchToken();
      final response = await dio.get(
        GetRequestUrl.TABLES,
      );
      if (response.statusCode == 200) {
        return response.data['results'];
      } else {
        print(response.statusCode.toString());
        throw Exception(
            'Failed Load Data with status code ${response.statusCode}');
      }
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future<dynamic> cancelOrder(String id, dynamic body) async {
    try {
      final response = await put(GetRequestUrl.CANCEL_ORDER + id, body,
          headers: await RequestHeaders().getRequestHeader());
      if (response.statusCode == 200) {
        return response.body;
      } else {
        print(response.statusCode.toString());
        throw Exception(
            'Failed Load Data with status code ${response.statusCode}');
      }
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future<List<dynamic>> getTabless() async {
    try {
      final response = await get(GetRequestUrl.TABLES,
          headers: await RequestHeaders().getRequestHeader());
      if (response.statusCode == 200) {
        return response.body['results'];
      } else {
        print(response.statusCode.toString());
        throw Exception(
            'Failed Load Data with status code ${response.statusCode}');
      }
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future<dynamic> updateTable(String id, dynamic body) async {
    try {
      final response = await put(GetRequestUrl.TABLE_DETAIL + id, body,
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
