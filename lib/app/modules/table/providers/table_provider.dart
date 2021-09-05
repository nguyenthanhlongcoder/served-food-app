import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:served_food/app/common/app_datas/get_request_url.dart';
import 'package:http/http.dart' as http;

class TableProvider extends GetConnect {
  static var client = http.Client();

  Future<List<dynamic>> getTables() async {
    try {
      var dio = Dio();
      final response = await dio.get(GetRequestUrl.TABLES);
      if (response.statusCode == 200) {
        return response.data;
      } else {
        print(response.statusCode.toString());
        throw Exception(
            'Failed Load Data with status code ${response.statusCode}');
      }
    } catch (e) {
      return Future.error(e.toString());
    }
  }
}
