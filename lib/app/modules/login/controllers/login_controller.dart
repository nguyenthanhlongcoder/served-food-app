import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:served_food/app/common/app_datas/get_request_url.dart';
import 'package:served_food/app/common/app_datas/user_model.dart';
import 'package:served_food/app/common/app_datas/user_repository.dart';
import 'package:served_food/app/common/http/api_provider.dart';
import 'package:served_food/app/common/providers/log_out.dart';
import 'package:served_food/app/common/providers/user_provider.dart';
import 'package:served_food/app/routes/app_routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  var isLoading = false.obs;
  TextEditingController usernameController, passwordController;
  var username = '';
  var password = '';
  UserRepository userRepository = new UserRepository();
  var user = new UserModel().obs;
  @override
  void onInit() {
    super.onInit();
    usernameController = TextEditingController();
    passwordController = TextEditingController();
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
            'email': usernameController.text,
            'password': passwordController.text
          }));
      if (response != null) {
        String id = response['id'].toString();
        String expiry = DateTime.now().add(Duration(days: 1)).toString();
        UserProvider().getUserDetail(id).then((response) async {
          if (response != null) {
            user.value = UserModel.fromJson(response);
            UserRepository().setUser(user.value);
            UserRepository().persistExpiry(expiry);
            Get.offNamedUntil(AppRoutes.MAIN, (route) => false);

            Fluttertoast.showToast(
              msg: 'Login Success',
              toastLength: Toast.LENGTH_LONG,
            );
          } else {
            Fluttertoast.showToast(
              msg: response.toString(),
              toastLength: Toast.LENGTH_LONG,
            );
          }
        });
      } else {
        LogOut().logOut();
      }
    } finally {}
  }
}
