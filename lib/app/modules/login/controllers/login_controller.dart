import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:served_food/app/common/app_datas/get_request_url.dart';
import 'package:served_food/app/common/app_datas/user_model.dart';
import 'package:served_food/app/common/app_datas/user_repository.dart';
import 'package:served_food/app/common/firestore_methods/user_methods.dart';
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
  var isError = false.obs;
  var dataError = ''.obs;
  UserMethods userMethods = new UserMethods();
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
    if (usernameController.text.isEmail) {
      try {
        isLoading(true);
        var response = await new ApiProvider().post(
            GetRequestUrl.LOGIN,
            json.encode({
              'email': usernameController.text,
              'password': passwordController.text
            }));
        if (response['detail'] ==
            'No active account found with the given credentials') {
          isLoading(false);
          isError(true);
          Fluttertoast.showToast(
            msg: 'Email or password is not true',
            toastLength: Toast.LENGTH_LONG,
          );
          usernameController.text = '';
          passwordController.text = '';
        }
        if (response['id'] != null) {
          isLoading(false);
          isError(false);
          String id = response['id'].toString();
          String expiry = DateTime.now().add(Duration(days: 1)).toString();
          String token = response['access'].toString();
          userRepository.persistToken(token);
          UserProvider().getUserDetail(id).then((response) async {
            if (response != null) {
              user.value = UserModel.fromJson(response);
              UserRepository().setUser(user.value);
              UserRepository().persistExpiry(expiry);
              userMethods.addUser(user.value);
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
        }
      } catch (e) {
        isLoading(false);
        isError(true);
        Fluttertoast.showToast(
          msg: e.toString(),
          toastLength: Toast.LENGTH_LONG,
        );
        usernameController.text = '';
        passwordController.text = '';
      }
    } else {
      Fluttertoast.showToast(
        msg: 'Email is not valid',
        toastLength: Toast.LENGTH_LONG,
      );
      usernameController.text = '';
      passwordController.text = '';
    }
  }
}
