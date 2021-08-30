import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'custom_exception.dart';

class ApiProvider {
  Future<Map<String, dynamic>> post(String url, dynamic body) async {
    dynamic responseJson;
    try {
      final dynamic response =
          await http.post(Uri.parse(url), body: body, headers: {
        'content-type': 'application/Json',
      });
      responseJson = _response(response);
    } on SocketException {
      throw FetchDataException();
    }
    return responseJson;
  }

  Future<dynamic> get(String url) async {
    dynamic responseJson;
    try {
      final dynamic response = await http.get(Uri.parse(url), headers: {
        'content-type': 'application/json',
        'accept': 'application/json',
      });

      responseJson = _response(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> delete(String url) async {
    dynamic responseJson;
    try {
      final dynamic response = await http.delete(Uri.parse(url), headers: {
        'content-type': 'application/json',
        'accept': 'application/json',
      });

      responseJson = _response(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  dynamic _response(http.Response response) {
    switch (response.statusCode) {
      case 204:
      case 201:
      case 200:
        final dynamic responseJson = json.decode(response.body.toString());
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:

      case 403:
        throw UnauthorisedException(response.body.toString());
      case 500:

      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}