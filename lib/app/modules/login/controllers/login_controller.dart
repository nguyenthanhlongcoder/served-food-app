import 'dart:convert';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:served_food/app/common/app_datas/get_request_url.dart';
import 'package:served_food/app/common/app_datas/user_repository.dart';
import 'package:served_food/app/common/http/api_provider.dart';
import 'package:served_food/app/routes/app_routes.dart';

class LoginController extends GetxController {
  var isLoading = false.obs;
  TextEditingController usernameController, passwordController;
  var username = '';
  var password = '';
  UserRepository userRepository = new UserRepository();
  @override
  void onInit() {
    super.onInit();
    usernameController = TextEditingController();
    passwordController = TextEditingController();

    if (userRepository.hasUser() != null) {
      userRepository.fetchExpiry().then((value) {
        String expiry = value.replaceAll('T', ' ');
        DateTime expiryDateTime =
            DateFormat("yyyy-MM-dd HH:mm:ss").parse(expiry);
        if (expiryDateTime.isAfter(DateTime.now())) {
          Get.toNamed(AppRoutes.MAIN);
          Fluttertoast.showToast(
            msg: 'Login Success',
            toastLength: Toast.LENGTH_LONG,
          );
        } else {
          userRepository.deleteAll();
        }
      });
    } else {
      userRepository.deleteAll();
    }
  }

  @override
  void dispose() {
    super.dispose();
    usernameController.dispose();
    passwordController.dispose();
  }

  void login() async {
    try {
      isLoading(true);
      var response = await new ApiProvider().post(
          GetRequestUrl.LOGIN,
          json.encode({
            'username': usernameController.text,
            'password': passwordController.text
          }));
      if (response != null) {
        print('Login Sucess: ' + response['user']['username'].toString());
        String id = response['user']['id'].toString();
        String expiry = response['expiry'];

        userRepository.persistUser(id, expiry);
        Get.toNamed(AppRoutes.MAIN);
      } else {
        print('Login Failed');
      }
    } finally {
      isLoading(false);
    }
  }
}
