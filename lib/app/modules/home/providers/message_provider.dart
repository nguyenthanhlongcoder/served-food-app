import 'package:dio/dio.dart';
import 'package:get/get_connect.dart';
import 'package:served_food/app/common/app_datas/get_request_url.dart';

class MessageProvider {
  Future<List<dynamic>> getMessage() async {
    try {
      var dio = Dio();
      final response = await dio.get(GetRequestUrl.SEND_MESSAGES);
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
