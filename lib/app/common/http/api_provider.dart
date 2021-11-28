import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:served_food/app/common/app_datas/request_headers.dart';
import 'custom_exception.dart';

class ApiProvider {
  Future<Map<String, dynamic>> post(String url, dynamic body) async {
    dynamic responseJson;
    try {
      final dynamic response = await http.post(Uri.parse(url),
          body: body, headers: await RequestHeaders().getRequestHeader());

      responseJson = _response(response);
    } on SocketException {
      throw FetchDataException();
    }
    return responseJson;
  }

  
  Future<dynamic> get(String url) async {
    dynamic responseJson;
    try {
      final dynamic response = await http.get(Uri.parse(url),
          headers: await RequestHeaders().getRequestHeader());

      responseJson = _response(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<int> delete(String url) async {
    try {
      final http.Response response =
          await http.delete(Uri.parse(url), headers: {
        'content-type': 'application/json',
        'accept': 'application/json',
      });
      return response.statusCode;
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
  }

  dynamic _response(http.Response response) {
    switch (response.statusCode) {
      case 201:
      case 401:
      case 403:
      case 200:
        final dynamic responseJson = json.decode(response.body.toString());
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());

      case 500:

      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}
